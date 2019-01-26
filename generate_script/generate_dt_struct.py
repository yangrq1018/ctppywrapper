#
# Expose c++ data type definitions to Cython
#

import os
import re
from os.path import dirname as dir

CTP_PATH = os.path.join(dir(dir(__file__)), 'ctp')

HEADER_PATH = os.path.join(CTP_PATH, "header")

# typedef header
USERAPI_DATA_FILE = os.path.join(HEADER_PATH, "ThostFtdcUserApiDataType.h")

# Structure header
USERAPI_STRUCT_FILE = os.path.join(HEADER_PATH, "ThostFtdcUserApiStruct.h")

GENERATE_PATH = os.path.join(os.path.dirname(__file__), "ctpwrapper/pxdheader")


def generate_structure(datatype_name_set):
    """
    Generate structure file
    :param datatype_dict:
    :return:
    """
    generate_file_path = os.path.join(GENERATE_PATH, "ThostFtdcUserApiStruct.pxd")

    data_struct_file = open(generate_file_path, "w", encoding='utf-8')
    data_struct_file.write("# encoding: utf-8" + "\n" * 2)

    # import data type definitions from ThostFtdcUserApiDataType
    data_struct_file.write("from .ThostFtdcUserApiDataType cimport *\n")
    data_struct_file.write("\n" * 2)

    # cdef extern from
    data_struct_file.write("cdef extern from 'ThostFtdcUserApiStruct.h':\n")

    # parse line by line
    with open(USERAPI_STRUCT_FILE, encoding='utf-8') as f:
        for line in f:
            if line.startswith("struct"):
                struct_name = re.findall("\w+", line)[1]
                # struct name
                data_struct_file.write("    cdef struct {}:\n".format(struct_name))
            else:
                result = re.findall("\w+", line)
                if result and result[0] in datatype_name_set:
                    # add a tab before the line
                    # delete the semi-colon
                    data_struct_file.write("    " + line.replace(";", ""))

    return


def generate_data_type():
    """
    Generate data type file
    :return: the set of assigned data type names
    """

    generate_file_path = os.path.join(GENERATE_PATH, "ThostFtdcUserApiDataType.pxd")

    py_const_file_path = os.path.join(os.path.dirname(__file__), 'ctpwrapper', 'pyConst.py')

    py_const_file = open(py_const_file_path, "w", encoding='utf-8')

    data_type_file = open(generate_file_path, "w", encoding='utf-8')
    data_type_file.write("# encoding: utf-8" + "\n" * 2)
    data_type_file.write("cdef extern from 'ThostFtdcUserApiDataType.h':\n")

    data_type_name_set = set()

    # #define ...
    defines = []

    # parse line by line
    with open(USERAPI_DATA_FILE, encoding='utf-8') as f:
        for line in f:
            if line.startswith('enum'):
                data_type_file.write("""
    cdef enum THOST_TE_RESUME_TYPE:
        THOST_TERT_RESTART = 0
        THOST_TERT_RESUME
        THOST_TERT_QUICK
""")

            elif line.startswith('#define'):
                result = re.findall("\S+", line)
                if len(result) > 2:
                    name = result[1]
                    value = result[2]
                    defines.append((name, value))

            elif line.startswith('typedef'):
                result = re.findall('\w+', line)

                type_name = result[1]
                assigned_name = result[2]
                data_type_name_set.add(assigned_name)

                if len(result) == 4:
                    length = result[3]
                    data_type_file.write("    ctypedef {type_name} {assigned_name}[{length}]\n".format(
                        type_name=type_name, assigned_name=assigned_name, length=length
                    ))
                else:
                    data_type_file.write("    ctypedef {type_name} {assigned_name}\n".format(
                        type_name=type_name, assigned_name=assigned_name
                    ))

    # write defines
    py_const_file.write('# encoding: utf-8\n')
    py_const_file.write("\n" * 2)
    for name, value in defines:
        py_const_file.write("{} = {}\n".format(name, value))

    return data_type_name_set


if __name__ == '__main__':
    data_type_set = generate_data_type()
    generate_structure(data_type_set)
