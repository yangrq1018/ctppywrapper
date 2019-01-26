'''
Generate the definition of Python classes for structures, with the help of ctypes module
'''

import linecache
import os
import re
from collections import OrderedDict
from os.path import dirname as dir

CTP_PATH = os.path.join(dir(dir(__file__)), 'ctp')
HEADER_PATH = os.path.join(CTP_PATH, "header")
USERAPI_DATA_FILE = os.path.join(HEADER_PATH, "ThostFtdcUserApiDataType.h")
USERAPI_STRUCT_FILE = os.path.join(HEADER_PATH, "ThostFtdcUserApiStruct.h")
GENERATE_FILE = os.path.join(os.path.dirname(__file__), 'ctpwrapper/pyStruct.py')


class Parse:
    def __init__(self, type_file, struct_file):
        """

        Store structure info in an ordered dict so that when we rewrite the
        class definition in Python, we have the same order of structs, and the
        same order of fields in each struct.
        :param type_file:
        :param struct_file:
        """
        self.type_file = type_file
        self.struc_file = struct_file

        # data type name -> python type mapping
        self.data_type = OrderedDict()
        self.struct = OrderedDict()  # will use key to iterate
        self.struct_doc = dict()

    def parse_data_type(self):
        """

        Array type has char array only: model as string
        Char type is single-char string in Python
        Double, int, and short is represented similarly

        There are only four primitive types {'char', 'double', 'int', 'short'}
        Parse UserApiDataType.h
        :return:
        """
        with open(self.type_file, encoding='utf-8') as f:
            for line in f:
                if line.startswith("typedef"):
                    result = re.findall("\w+", line)
                    type_name = result[1]
                    name = result[2]

                    if len(result) == 4 and type_name == 'char':  # array, char only, check is optional
                        self.data_type[name] = {
                            'type': "str",
                            'length': int(result[3])
                        }
                    elif type_name == 'char':  # single char, represent as string in Python
                        self.data_type[name] = {
                            'type': 'str'
                        }
                    else:
                        self.data_type[name] = {
                            'type': type_name  # double, int, short
                        }

    def parse_struct(self):
        """
        Parse UserApiStruct.h

        In linecache, line is 1-indexed, so doc_line always store the lineno
        of the last line
        :return:
        """
        self.parse_data_type()

        with open(self.struc_file, encoding="utf-8") as f:
            for index, line in enumerate(f):  # enumerate lines

                # cache last doc line
                doc_line = index

                if line.startswith('struct'):
                    result = re.findall("\w+", line)
                    name = result[1]  # struct name
                    self.struct[name] = OrderedDict()  # field order

                    # struct doc
                    struct_doc = linecache.getline(self.struc_file, doc_line)
                    struct_doc = struct_doc.strip().replace("///", "")
                    self.struct_doc[name] = struct_doc

                if line.strip().startswith("TThostFtdc"):
                    result = re.findall("\w+", line)
                    type_name = result[0]
                    member_name = result[1]

                    struct_dict = self.struct[name]  # get the member of this struct
                    # look up python type
                    struct_dict[member_name] = {'field_type': self.data_type[type_name]}

                    # doc for this member
                    member_doc = linecache.getline(self.struc_file, doc_line)
                    member_doc = member_doc.strip().replace("///", "")
                    struct_dict[member_name]['field_doc'] = member_doc


def generate_struct(struct, struct_doc, py_file):
    '''
    Generate class definition for each structure
    :param struct: dict of member and type info
    :param struct_doc: dict of doc of structure itself
    :param py_file:
    :return:
    '''

    for item in struct:
        # write class header
        class_name = item.replace("CThostFtdc", "")
        py_file.write("\n\nclass {class_name}(Base):\n".format(class_name=class_name))

        # write struct doc
        py_file.write('    """' + struct_doc[item] + '"""\n')

        struct_dict = struct[item]

        # write fields
        py_file.write(" " * 4 + "_fields_ = [\n")

        # OrderedDict has no iteritem method
        for field_name in struct_dict:
            field_data = struct_dict[field_name]
            field_type = field_data['field_type']
            field_doc = field_data['field_doc']

            if field_type['type'] == "double":
                type_info = "ctypes.c_double"
            elif field_type['type'] == "short":
                type_info = "ctypes.c_short"
            elif field_type['type'] == "int":
                type_info = "ctypes.c_int"
            elif field_type['type'] == "str":
                if "length" not in field_type:
                    type_info = "ctypes.c_char"
                else:
                    type_info = "ctypes.c_char * {}".format(field_type['length'])

            py_file.write(" " * 8)  # double tab
            py_file.write("('{field_name}', {type_info}),  # {field_doc}\n".format(
                field_name=field_name,
                type_info=type_info,
                field_doc=field_doc
            ))
        py_file.write("    ]\n\n")

        # write constructor
        params = []
        for field_name in struct_dict:
            field_data = struct_dict[field_name]
            field_type = field_data['field_type']
            if field_type['type'] == 'double':
                default = '0.0'
            elif field_type['type'] in ('int', 'short'):
                default = '0'
            else:
                default = "''"  # an empty string
            param = "{param_name}={default}".format(param_name=field_name, default=default)
            params.append(param)

        py_file.write("    def __init__(self, {}):\n".format(', '.join(params)))
        py_file.write("        super().__init__()\n")
        # init each field

        for field_name in struct_dict:
            field_data = struct_dict[field_name]
            field_type = field_data['field_type']
            if field_type['type'] == 'double':
                py_file.write("        self.{} = float({})\n".format(
                    field_name, field_name
                ))
            elif field_type['type'] in ('int', 'short'):
                py_file.write("        self.{} = int({})\n".format(field_name, field_name))
            else:
                # use method of self to cast arguments to bytes, if not
                # todo, verify this
                py_file.write("        self.{} = self._to_bytes({})\n".format(
                    field_name, field_name
                ))


def generate_interface():
    '''
    Generate the actual file
    :return:
    '''
    parse = Parse(USERAPI_DATA_FILE, USERAPI_STRUCT_FILE)
    parse.parse_struct()  # parse both struct and data files

    # write headers
    py_file = open(GENERATE_FILE, "w", encoding="utf-8")

    py_file.write("# encoding=utf-8\n")
    py_file.write("# Convention: remove CThostFtdc to indicate this is a python class\n")
    py_file.write("import ctypes\n")
    py_file.write("from .base import Base\n")
    py_file.write("\n" * 2)

    # start of class definition

    generate_struct(parse.struct, parse.struct_doc, py_file)


if __name__ == "__main__":
    generate_interface()
