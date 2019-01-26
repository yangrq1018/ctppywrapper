# Expose CTP declaration of MdApi to Cython

from cpython cimport

PyObject
from libc.string cimport

const_char
from libcpp cimport

bool as cbool

# import Cythonized data types
from .ThostFtdcUserApiStruct cimport

CThostFtdcFensUserInfoField, CThostFtdcReqUserLoginField, CThostFtdcUserLogoutField


# cdef wrapped MdSpi
cdef extern from "CMdApi.h":
    cdef cppclass CMdSpi:
        CMdSpi(PyObject *obj)


'''

https://cython.readthedocs.io/en/latest/src/userguide/external_C_code.html

You can specify nogil in a C function header or function type to declare that it is safe to call without the GIL ...
These restrictions are checked by Cython and you will get a compile error if it finds any Python interaction inside 
of a nogil code section.

The nogil function annotation declares that it is safe to call the function without the GIL. It is perfectly allowed to
 execute it while holding the GIL. The function does not in itself release the GIL if it is held by the caller.
'''

cdef extern from "ThostFtdcMdApi.h":
    cdef cppclass CMdApi "CThostFtdcMdApi":
        @ staticmethod
        const_char *GetApiVersion() nogil

        #删除接口对象本身
        void Release() nogil

        #初始化
        void Init() nogil

        #等待接口线程结束运行
        int Join() nogil

        #获取当前交易日
        const_char *GetTradingDay() nogil except +

        #注册前置机网络地址
        void RegisterFront(char *pszFrontAddress) nogil except +

        #注册名字服务器网络地址
        void RegisterNameServer(char *pszNsAddress) nogil except +

        #注册名字服务器用户信息。
        void RegisterFensUserInfo(CThostFtdcFensUserInfoField *pFensUserInfo) nogil except +

        #注册回调接口
        # Change parameter to its subclass (provided in cppheader/CMdApi)
        void RegisterSpi(CMdSpi *pSpi) nogil except +

        #订阅行情。
        int SubscribeMarketData(char *ppInstrumentID[], int nCount) nogil except +

        #退订行情。
        int UnSubscribeMarketData(char *ppInstrumentID[], int nCount) nogil except +

        #订阅询价。
        int SubscribeForQuoteRsp(char *ppInstrumentID[], int nCount) nogil except +

        #退订询价。
        int UnSubscribeForQuoteRsp(char *ppInstrumentID[], int nCount) nogil except +

        #用户登录请求
        int ReqUserLogin(CThostFtdcReqUserLoginField *pReqUserLoginField, int nRequestID) nogil except +

        #登出请求
        int ReqUserLogout(CThostFtdcUserLogoutField *pUserLogout, int nRequestID) nogil except +


# expose static factory method as a standalone function
# about nogil and exceot +
# nogil: as we are not interacting with Python in this function, we can release GIL while waiting for the
# connection, and other Python threads can run concurrenctly
# except+ instruct Cython to catch C++ exceptions and convert to corresponding Python Exceptions
# distinguish between cbool and bool, bool may refer to Python boolean object

# todo: verify that Cython release GIL around this call
cdef extern from "ThostFtdcMdApi.h" namespace "CThostFtdcMdApi":
    CMdApi*CreateFtdcMdApi(const_char *pszFlowPath, cbool bIsUsingUdp, cbool bIsMulticast) nogil except+;
