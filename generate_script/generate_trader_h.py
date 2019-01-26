import linecache
import os
import re

BASE_DIR = os.path.dirname(__file__)

API_DECLARATION_PATH = os.path.join(BASE_DIR, 'ctp/header/ThostFtdcTraderApi.h')
GENERATE_PATH = os.path.join(BASE_DIR, 'ctpwrapper/cppheader/CTraderApi.h')


def parse_func_sign(func_sign):
    '''
    Parse the function signature from CTP API header
    :param func_sign:
    :return: str, the body of new function
    '''
    func_sign = func_sign[:-1]  # remove ';'
    result = re.match(r'virtual void (\w+)\((.*)\)', func_sign)
    func_name = result.groups()[0]
    if result.groups()[1] == '':
        param_names = ''
        proto_param_names = ''
    else:
        params = result.groups()[1].split(',')
        params = [item.strip() for item in params]
        params = [tuple(item.split(' ')) for item in params]
        param_names = [item[1].replace('*', '') for item in params]
        param_names = ', ' + ', '.join(param_names)
        proto_param_names = ', ' + ', '.join([' '.join(item) for item in params])

    # to be insert between {}
    func_body = '       Python_GIL(TraderSpi_{func_name}(self{params}));\n'.format(
        func_name=func_name, params=param_names)

    # protos
    proto = 'static inline int TraderSpi_{func_name}(PyObject* self{params});\n'.format(
        func_name=func_name, params=proto_param_names
    )

    # new function whole definition
    new_func = '    ' + func_sign.replace('{}', '{\n' + func_body + '    }\n')
    return new_func, proto


def generate_trader_api_h():
    API_DECLARATION_FILE = open(API_DECLARATION_PATH, encoding='utf-8')
    GENERATE_FILE = open(GENERATE_PATH, 'w', encoding='utf-8')

    # before
    GENERATE_FILE.write(r"""
#ifndef CTRADERAPI_H
#define CTRADERAPI_H

#include "Python.h"
#include "pythread.h"

#include "ThostFtdcTraderApi.h"


static inline int TraderSpi_OnFrontConnected(PyObject* self);

#define Python_GIL(func) \
    do { \
        PyGILState_STATE gil_state = PyGILState_Ensure(); \
        if ((func) == -1) PyErr_Print();  \
        PyGILState_Release(gil_state); \
    } while (false)
""" + '\n' * 2)

    # callbacks
    on_func_sign = False
    accumulator = ""

    methods = []
    static_protos = []
    doc_line = ''

    for line_no, line in enumerate(API_DECLARATION_FILE):

        doc_line_no = line_no

        # encounter a new method to override
        if line.strip().startswith("virtual void"):
            # extract all doc lines associated with this method
            doc_line = linecache.getline(API_DECLARATION_PATH, doc_line_no)
            trace_back = doc_line_no - 1
            while linecache.getline(API_DECLARATION_PATH, trace_back).strip().startswith('///'):
                doc_line = linecache.getline(API_DECLARATION_PATH, trace_back) + doc_line
                trace_back -= 1

            on_func_sign = True
            accumulator = ''
            accumulator += line.strip()

        elif line == '\n' or line == '};\n':
            if on_func_sign:
                on_func_sign = False

                # we have found an entire func sign
                new_func, protos = parse_func_sign(accumulator)

                methods.append({
                    'method_body': new_func,
                    'doc_line': doc_line
                })

                static_protos.append(protos)

        elif line.startswith('class TRADER_API'):
            # hit API class, break
            break

        elif on_func_sign:
            accumulator += ' ' + line.strip()

    # static inline prototypes
    GENERATE_FILE.write(''.join(static_protos) + '\n' * 2)

    # class header
    GENERATE_FILE.write('''
class CTraderSpi: public CThostFtdcTraderSpi {
public:
    // constructor
    CTraderSpi(PyObject *obj): self(obj) {};
    
    virtual ~CTraderSpi() {};

''')

    # class body
    for method in methods:
        GENERATE_FILE.write(method['doc_line'])
        GENERATE_FILE.write(method['method_body'])
        GENERATE_FILE.write('\n')

    # after
    GENERATE_FILE.write('''
private:
    PyObject* self;

};
    
#endif /* CTRADERAPI_H */
''')

    API_DECLARATION_FILE.close()
    GENERATE_FILE.close()


if __name__ == '__main__':
    generate_trader_api_h()
