HEADER = r"""
import ctypes
from libc.string cimport const_char
from libcpp cimport bool as cbool
from libc.stdlib cimport malloc, free
from cpython cimport PyObject
from . import pyStruct


# classes and static factory
from .pxdheader.ThostFtdcUserApiStruct cimport *
from .pxdheader.TraderApi cimport CTraderSpi, CTraderApi, CreateFtdcTraderApi


# wrapper Api/Spi in extension class
cdef class TraderApiWrapper:
    cdef CTraderSpi* _spi
    cdef CTraderApi* _api

    def __cinit__(self):
        # call before init
        self._spi = NULL
        self._api = NULL

    def __dealloc__(self):
        # called before being garbage collected
        self.Release()

    def Release(self):
        '''
        Release all resources.
        :return:
        '''
        if self._api is not NULL:
            self._api.RegisterSpi(NULL)
            self._api.Release()  # C++ side release, delete this API instance itself

            # do not linger wild pointers
            # set to null to signal connections is no longer present
            del self._spi
            self._api = NULL
            self._spi = NULL

    def Create(self, const_char *pszFlowPath):
        self._api = CreateFtdcTraderApi(pszFlowPath)
        if not self._api:
            raise RuntimeError("Cannot create TraderApi") # could be out of memory


    def Init(self):
         if self._api is not NULL:
            self._spi = new CTraderSpi(<PyObject*> self)

            if self._spi is not NULL:
                # register spi to api
                self._api.RegisterSpi(self._spi)

                # 初始化运行环境
                self._api.Init()
            else:
                raise MemoryError("Cannot create TraderSpi")

    def Join(self):
        # the exit signal of API thread
        cdef int result

        if self._api is not NULL:
            with nogil:
                result = self._api.Join()
            return result
        else:
            raise RuntimeError('API is not yet created')

    def GetTradingDay(self):
        cdef const_char* result
        if self._api is not NULL:
            with nogil: # nogil in method definition does nothing
                result = self._api.GetTradingDay()
            return result


    def RegisterFront(self, char* pszFrontAddress):
        if self._api is not NULL:
            self._api.RegisterFront(pszFrontAddress)


    def RegisterNameServer(self, char *pszNsAddress):
        if self._api is not NULL:
            self._api.RegisterNameServer(pszNsAddress)


    
    def RegisterFensUserInfo(self, pFensUserInfo):
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pFensUserInfo)
            self._api.RegisterFensUserInfo(<CThostFtdcFensUserInfoField*> address)

    # 订阅私有流。
    # nResumeType is an int # todo check Enum conversion
    # @param nResumeType 私有流重传方式
    #         THOST_TERT_RESTART (0):从本交易日开始重传
    #         THOST_TERT_RESUME (1):从上次收到的续传
    #         THOST_TERT_QUICK (2):只传送登录后私有流的内容
    # @remark 该方法要在Init方法前调用。若不调用则不会收到私有流的数据。
    def SubscribePrivateTopic(self, THOST_TE_RESUME_TYPE nResumeType):
        if self._api is not NULL:
            self._api.SubscribePrivateTopic(nResumeType)


    # 订阅公共流。
    # @param nResumeType 公共流重传方式
    # THOST_TERT_RESTART:从本交易日开始重传
    # THOST_TERT_RESUME:从上次收到的续传
    # THOST_TERT_QUICK:只传送登录后公共流的内容
    # @remark 该方法要在Init方法前调用。若不调用则不会收到公共流的数据。
    def SubscribePublicTopic(self, THOST_TE_RESUME_TYPE nResumeType):
        if self._api is not NULL:
            self._api.SubscribePublicTopic(nResumeType)
    
"""

BODY_TEMPLATE = '''
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof({p})
            with nogil:
                result = self._api.{method_name}(<{field}*> address, {nReq})
            return result
'''

SIGN_TEMPLATE = '    def {method_name}(self, {p}, int {nReq}):'

import os
import re


def parse_method(method_str):
    result = re.match('int (\w+)\((\w+) \*(\w+), int (\w+)\)', method_str)
    method_name = result.groups()[0]
    field = result.groups()[1]
    p = result.groups()[2]
    nRequestID = result.groups()[3]

    signature = SIGN_TEMPLATE.format(
        method_name=method_name,
        p=p,
        nReq=nRequestID
    )
    body = BODY_TEMPLATE.format(
        p=p,
        method_name=method_name,
        field=field,
        nReq=nRequestID
    )

    return signature + body


CALLBACK_TEMPLATE_1 = """
cdef extern int TraderSpi_{method_name}(self) except -1:
    self.{method_name}()
    return 0
"""

CALLBACK_TEMPLATE_2 = """
cdef extern int TraderSpi_{method_name}(self, int {name}) except -1:
    self.{method_name}({name})
    return 0
"""


def generate_static_callbacks():
    '''
    Produce static inline callbacks

    :return:
    '''

    callbacks = []

    CTRADERAPI_H_FILE_PATH = os.path.join(os.path.dirname(__file__), 'ctpwrapper/cppheader/CTraderApi.h')
    FILE = open(CTRADERAPI_H_FILE_PATH, encoding='utf-8')
    # read to the right line
    line = FILE.readline()
    while not line.strip().startswith('} while (false)'):
        line = FILE.readline()
    FILE.readline()
    FILE.readline()

    for line in FILE:
        if line.startswith('static inline'):
            # manual
            result = re.match(r'static inline int TraderSpi_(\w+)\(PyObject\* self\);', line)
            if result:
                method_str_out = CALLBACK_TEMPLATE_1.format(method_name=result.groups()[0])
                callbacks.append(method_str_out)
                continue

            # manual
            result = re.match(r'static inline int TraderSpi_(\w+)\(PyObject\* self, int (\w+)\);', line)
            if result:
                method_str_out = CALLBACK_TEMPLATE_2.format(method_name=result.groups()[0], name=result.groups()[1])
                callbacks.append(method_str_out)
                continue

            # automatic assembly
            result = re.match(r'static inline int TraderSpi_(\w+)\(PyObject\* self, (.*)\);', line)
            if result:
                method_name = result.groups()[0]
                param_list = result.groups()[1].split(', ')
                method_str_out = assembly_callback(method_name, *(parse_param_list(param_list)))
                callbacks.append(method_str_out)
                continue

    return callbacks


PY_STRUCT_FROM_ADDRESS = 'None if pTradingAccount is NULL else ApiStructure.TradingAccountField.from_address(<size_t> pTradingAccount)'

TEMPLATE_CALLBACK = '''
cdef extern int TraderSpi_{method_name}(self, {p_params}{nReq}{bIsLast}) except -1:
    self.{method_name}(
{py_from_address}{nReqCall}{bIsLastCall}
    )
    return 0
'''


def parse_param_list(param_list):
    # split as a list of (type, name) tuples
    param_list = [tuple(item.split(' ')) for item in param_list]

    param_list_out = []
    nReq = None
    bIsLast = None

    for type_, name in param_list:
        if type_ == 'int':
            nReq = {'type': 'int', 'name': 'nRequestID'}
        elif type_ == 'bool':
            bIsLast = {'type': 'cbool', 'name': 'bIsLast'}
        else:
            param_list_out.append({'type': type_, 'name': name})
    return (param_list_out, nReq, bIsLast)


def assembly_callback(method_name, param_list, nReq, bIsLast):
    p_params = [item['type'] + ' ' + item['name'] for item in param_list]
    p_params = ', '.join(p_params)

    # None if pInputQuote is NULL else ApiStructure.InputQuoteField.from_address(<size_t> pInputQuote)
    TEMP_FORM_ADDR = '\t\tNone if {name} is NULL else pyStruct.{py_struct_type}.from_address(<size_t> {name})'
    py_from_address = [TEMP_FORM_ADDR.format(
        name=item['name'].replace('*', ''),
        py_struct_type=item['type'].replace('CThostFtdc', '')
    ) for item in param_list]

    result = TEMPLATE_CALLBACK.format(
        method_name=method_name,
        p_params=p_params,
        py_from_address=',\n'.join(py_from_address),
        nReq='' if nReq is None else ', ' + nReq['type'] + ' ' + nReq['name'],
        bIsLast='' if bIsLast is None else ', ' + bIsLast['type'] + ' ' + bIsLast['name'],
        nReqCall='' if nReq is None else ',\n\t\t' + nReq['name'],
        bIsLastCall='' if bIsLast is None else ',\n\t\t' + bIsLast['name']  # call py with name only
    )
    return result


def generate():
    SOURCE_FILE_PATH = GENERATE_FILE_PATH = os.path.join(os.path.dirname(__file__),
                                                         'ctpwrapper/pxdheader/TraderApi.pxd')
    SOURCE_FILE = open(SOURCE_FILE_PATH, encoding='utf-8')

    GENERATE_FILE_PATH = os.path.join(os.path.dirname(__file__), 'ctpwrapper/TraderApi.pyx')
    GENERATE_FILE = open(GENERATE_FILE_PATH, 'w', encoding='utf-8')
    GENERATE_FILE.write(HEADER)

    # read to the right line
    line = SOURCE_FILE.readline()
    while not line.strip().startswith('# 客户端认证请求'):
        line = SOURCE_FILE.readline()

    methods = []
    line_doc = '\t# 客户端认证请求\n'
    # int ReqAuthenticate(CThostFtdcReqAuthenticateField *pReqAuthenticateField, int nRequestID) nogil except +
    for line in SOURCE_FILE:
        if line.strip().startswith('#'):
            line_doc = '\t' + line.strip() + '\n'  # for later user
        if line.strip().startswith('int Req'):
            method_str = parse_method(line.strip())
            methods.append({
                'method_str': method_str,
                'method_doc': line_doc
            })

    for method_dict in methods:
        GENERATE_FILE.write(method_dict['method_doc'])
        GENERATE_FILE.write(method_dict['method_str'])
        GENERATE_FILE.write('\n')

    # static callbacks
    GENERATE_FILE.write('# callbacks')
    for c in generate_static_callbacks():
        GENERATE_FILE.write(c)

    GENERATE_FILE.close()


if __name__ == '__main__':
    generate()
