'''
This pyx file includes the Python-accessible class that we'll serve to the user, after
 adding another layer of Python-pure class, providing overridable functions signatures.
'''

import ctypes

from cpython cimport

PyObject
from libc.stdlib cimport

malloc, free
from libc.string cimport

const_char
from libcpp cimport

bool as cbool

from . import pyStruct
from .pxdheader.MdApi cimport

CMdSpi, CMdApi, CreateFtdcMdApi
from .pxdheader.ThostFtdcUserApiStruct cimport

(CThostFtdcFensUserInfoField, CThostFtdcReqUserLoginField,
 CThostFtdcUserLogoutField, CThostFtdcSpecificInstrumentField,
 CThostFtdcDepthMarketDataField, CThostFtdcForQuoteRspField)
from .pxdheader.ThostFtdcUserApiStruct cimport

(CThostFtdcRspUserLoginField, CThostFtdcRspInfoField)

cdef class MdApiWrapper:
    '''
    As a bridge class between Cpp ad Python, all methods of this class should accept Python objects as inputs
    (perhaps as ctypes)

    Some methods accept ctypes objects, and will take care of extracting the underlying C++ structure and pass
    to C++ side
    '''

    # pointers to C++ side API and SPI instances
    cdef CMdApi*_api
    cdef CMdSpi*_spi

    def __cinit__(self):
        self._api = NULL
        self._spi = NULL

    def __dealloc__(self):
        '''
        Called when self is reclaimed by Python Virtual Machine.
        Release the underlying C++ resources
        :return:
        '''
        self.Release()

    def Release(self):
        if self._api is not NULL:
            self._api.RegisterSpi(NULL);
            self._api.Release()  # C++ side release, delete this API instance itself

            # do not linger wild pointers
            # set to null to signal connections is no longer present
            del self._spi
            self._api = NULL
            self._spi = NULL

            # todo delete self._spi

    def Create(self, const_char *pszFlowPath, cbool bIsUsingUdp, cbool bIsMulticast):
        '''
        Set up this API/SPI proxy
        :return:
        '''

        self._api = CreateFtdcMdApi(pszFlowPath, bIsUsingUdp, bIsMulticast)

        # should have thrown an error if CreateFtdcMdApi fails, before this line
        if not self._api:
            raise RuntimeError("Cannot create MdApi")

    def Init(self):
        '''
        This class itself will serve as an SPI instance, so to construct a C++ side
        CMdSpi (proxy), we pass self to the constructor. Later, when C++ side callback is called,
        it will invoke python-side proper callback (methods that users overrides in a subclass of this class)


        Possibly: create and run the API thread
        :return:
        '''
        if self._api is not NULL:
            self._spi = new CMdSpi(<PyObject*> self)

            if self._spi is not NULL:
                # register spi to api
                self._api.RegisterSpi(self._spi)

                # 初始化运行环境
                self._api.Init()
            else:
                raise MemoryError("Cannot create MdSpi")

    def Join(self):
        """
        Wait until API thread quits.
        While waiting for API thread for responses, we should release GIL and let other
        Python threads to do work. When a response triggers a callback, the C++ implementation will
        reacquire GIL to fire the proper Python method.

        If main holds the GIL and ask to join the API thread, it will waste resources of other Python threads
        as main does nothing but waiting
        :return result: 线程退出代码
        """
        cdef int result

        # todo, why this is self._spi not self._api here
        if self._api is not NULL:
            with nogil:
                result = self._api.Join()
            return result
        else:
            raise RuntimeError("API is not yet created")

    def GetTradingDay(self):
        '''

        As the C++ side returns a C string (a char pointer), we don't need to worry about the underlying memory, as it
        is managed by the CTP proxy, In this class, we simply return it as bytes. The next layer will decode it to a Python
        string.

        This creates a Python byte string object that holds a copy of the original C string. It can be safely passed
        around in Python code, and will be garbage collected when the last reference to it goes out of scope

        While waiting for the server to return trading day, we should release GIL so that
        other Python thread can do their work
        :return result: as Python bytes object (copy)
        '''

        # A C++ type returned by self._api.getTradingDay must be kept in a cdef type
        # A PyObject should not point to that
        cdef const_char*result
        if self._api is not NULL:
            with nogil:
                result = self._api.GetTradingDay()
            # todo does Cython convert const_char to String?

            return result

    def RegisterFront(self, char *pszFrontAddress):
        '''
        No need for with nogil in this case, will return quickly
        :param pszFrontAddress: as **bytes**
        :return:
        '''
        if self._api is not NULL:
            self._api.RegisterFront(pszFrontAddress)

    def RegisterNameServer(self, char *pszNsAddress):
        '''

        :param pszNsAddress: cython should cast a string to a char*
        :return:
        '''
        if self._api is not NULL:
            self._api.RegisterNameServer(pszNsAddress)

    def RegisterFensUserInfo(self, pFensUserInfo):
        '''
        The caller passes in a ctypes instance, cast it to struct pointer and feed to
        C++ method
        :param pFensUserInfo: ctypes Object
        :return:
        '''
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pFensUserInfo)
            # cast address to a pointer to struct CThostFensUserInfoField
            self._api.RegisterFensUserInfo(<CThostFtdcFensUserInfoField*> address)

    def SubscribeMarketData(self, ppInstrumentID):
        '''
        The count is derived from ppInstrumentID list, no integer is needed
        :param ppInstrumentID: A list of **bytes**

        Release the malloc memory in finally because we don't need it after the
        API returns result

        A PyString can be safely assigned to a char*.

        https://cython.readthedocs.io/en/latest/src/tutorial/strings.html

        From bytes to string
        It is very easy to pass byte strings between C code and Python. When receiving a byte string from a C library,
        you can let Cython convert it into a Python byte string by simply assigning it to a Python variable


        This creates a Python byte string object that holds a copy of the original C string.
        It can be safely passed around in Python code, and will be garbage collected when the last reference to it goes out of scope.
        From string to bytes
        "This is a very fast operation after which other_c_string points to the byte string buffer of the Python string
        itself. It is tied to the life time of the Python string. When the Python string is garbage collected, the
        pointer becomes invalid. It is therefore important to keep a reference to the Python string as long as the
        char* is in use."
        :return:
        '''
        cdef size_t count
        cdef int result
        cdef char** InstrumentIDs

        if self._spi is not NULL:
            count = len(ppInstrumentID)
            # malloc a list of char pointers
            InstrumentIDs = <char **> malloc(sizeof(char*) * count)

            try:
                for i in range(0, count):
                    # let every pointer points to a python string
                    InstrumentIDs[i] = ppInstrumentID[i]

                # call cpp side subscribe method
                # release GIl as this is a slow function
                with nogil:
                    result = self._api.SubscribeMarketData(InstrumentIDs, <int> count)
            finally:
                free(InstrumentIDs)
            return result

    def UnSubscribeMarketData(self, ppInstrumentID):
        '''

        :param ppInstrumentID: A list of **bytes**
        :return:
        '''
        cdef size_t count
        cdef int result
        cdef char** InstrumentIDs

        if self._api is not NULL:
            count = len(ppInstrumentID)
            InstrumentIDs = <char **> malloc(sizeof(char*) * count)
            try:
                for i in range(0, count):
                    InstrumentIDs[i] = ppInstrumentID[i]

                with nogil:
                    result = self._api.UnSubscribeMarketData(InstrumentIDs, <int> count)
            finally:
                free(InstrumentIDs)
            return result

    def SubscribeForQuoteRsp(self, ppInstrumentID):
        """

        :param ppInstrumentID: list of bytes
        :return:
        """

        cdef size_t count
        cdef int result
        cdef char** InstrumentIDs

        if self._api is not NULL:
            count = len(ppInstrumentID)
            InstrumentIDs = <char **> malloc(sizeof(char*) * count)
            try:
                for i in range(0, count):
                    InstrumentIDs[i] = ppInstrumentID[i]
                with nogil:
                    result = self._api.SubscribeForQuoteRsp(InstrumentIDs, <int> count)

            finally:
                free(InstrumentIDs)
            return result

    def UnSubscribeForQuoteRsp(self, ppInstrumentID):
        '''

        :param ppInstrumentID:
        :return:
        '''
        cdef size_t count
        cdef int result
        cdef char** InstrumentIDs

        if self._api is not NULL:
            count = len(ppInstrumentID)
            InstrumentIDs = <char **> malloc(sizeof(char*) * count)
            try:
                for i in range(0, count):
                    InstrumentIDs[i] = ppInstrumentID[i]
                with nogil:
                    result = self._api.UnSubscribeForQuoteRsp(InstrumentIDs, <int> count)

            finally:
                free(InstrumentIDs)
            return result

    def ReqUserLogin(self, pReqUserLogin, int nRequestID):
        '''
        用户登录请求
        :param pReqUserLoginField: ctypes
        :param nRequestID:
        :return:
        '''

        cdef size_t address
        cdef int result

        if self._api is not NULL:
            address = ctypes.addressof(pReqUserLogin)
            # will wait
            with nogil:
                result = self._api.ReqUserLogin(<CThostFtdcReqUserLoginField*> address, nRequestID)
            # C int to Py int is managed by Cython
            # todo check cast to PyObject
            return result

    def ReqUserLogout(self, pUserLogout, int nRequestID):
        '''
        登出请求
        :param pUserLogout:
        :param nRequestID:
        :return:
        '''
        cdef size_t address
        cdef int result
        if self._api is not NULL:
            address = ctypes.addressof(pUserLogout)

            with nogil:
                result = self._api.ReqUserLogout(<CThostFtdcUserLogoutField*> address, nRequestID)
            return result

# callbacks
"""
self is implicitly PyObject*
Because inside Python, every function returns a PyObject*, if something else is retrurned, we know an exception is
thrown and check the flag. However, in cdef functions, anything could be returned, so we need a way to let the caller
 know an exception happens. We achieve this adding `except -1` to the function signature.

See https://cython.readthedocs.io/en/latest/src/userguide/language_basics.html for details

If you don’t do anything special, a function declared with cdef that does not return a Python object has no way of 
reporting Python exceptions to its caller. If an exception is detected in such a function, a warning message is printed 
and the exception is ignored.

The extern keyword is NOT redundant

If you don't add an extern keyword, Cython will add a static keyword to the generated CPP file and the definition
here is restricted to the translation unit

By default, C functions and variables declared at the module level are local to the module (i.e. they have the C static
 storage class). They can also be declared extern to specify that they are defined elsewhere, for example
 
A C function that is to be used as a callback from C code that is executed without the GIL needs to acquire the GIL 
before it can manipulate Python objects. This can be done by specifying with gil in the function header:

https://cython.readthedocs.io/en/latest/src/userguide/external_C_code.html

GIL
A C function that is to be used as a callback from C code that is executed without the GIL needs to acquire the GIL
 before it can manipulate Python objects. This can be done by specifying with gil in the function header


Here we are defining the callbacks in C, they are called without GIL in hand, so the function body should ensure
the GIL is acquired, we add with GIL

The extern keyword here must be set, or Cython will generate a static C function, the G++ linker cannot find the
function definition
"""
cdef extern int MdSpi_OnFrontConnected(self) except -1:
    '''
    It is totally possible that the user did something illegal in the body of the call.
    So we signal -1 as an exception has occurred and Python can propagate it correctly
    :param self: If everything is fine, we will reach the return statement and 0 is returned
    :return: 
    '''
    self.OnFrontConnected()  # call the onFrontConnected attribute of Python object
    return 0

cdef extern int MdSpi_OnFrontDisconnected(self, int nReason) except -1:
    self.OnFrontDisconnected(nReason)
    return 0

cdef extern int MdSpi_OnHeartBeatWarning(self, int nTimeLapse) except -1:
    '''
    This function is invoked if no messages have been received for a
    preset period of time. To inform client that the connection is alive.
    :param self: 
    :param nTimeLapse: 
    :return: 
    '''
    self.OnHeartBeatWarning(nTimeLapse)
    print("Heart beat warning")
    return 0

# note the cbool here
cdef extern int MdSpi_OnRspUserLogin(self, CThostFtdcRspUserLoginField *pRspUserLogin, CThostFtdcRspInfoField *pRspInfo,
                                     int nRequestID, cbool bIsLast) except -1:
    '''
    Convert parameters (C++) to corresponding Python objects
    :param self: 
    :param pRspUserLogin: 
    :param pRspInfo: 
    :param nRequestID: 
    :param bIsLast: 
    :return: 
    '''

    # Translation
    if pRspUserLogin is NULL:
        user_login = None  # Python object
    else:
        # cast pointer to address and instantiate ctypes objects from it
        # todo check with pyStruct.py
        user_login = pyStruct.RspUserLoginField.from_address(<size_t> pRspUserLogin)

    if pRspInfo is NULL:
        rsp_info = None
    else:
        # todo check with pyStruct.py
        rsp_info = pyStruct.RspInfoField.from_address(<size_t> pRspInfo)

    # the last two primitive types can be safely passed to Python
    self.OnRspUserLogin(user_login, rsp_info, nRequestID, bIsLast)
    return 0

cdef extern int MdSpi_OnRspUserLogout(self, CThostFtdcUserLogoutField *pUserLogout,
                                      CThostFtdcRspInfoField *pRspInfo, int nRequestID, cbool bIsLast) except -1:
    if pUserLogout is NULL:
        user_logout = None
    else:
        # from address accepts an integer
        user_logout = pyStruct.UserLogoutField.from_address(<size_t> pUserLogout)

    if pRspInfo is NULL:
        rsp_info = None
    else:
        rsp_info = pyStruct.RspInfoField.from_address(<size_t> pRspInfo)

    self.OnRspUserLogout(user_logout, rsp_info, nRequestID, bIsLast)
    return 0

cdef extern int MdSpi_OnRspError(self, CThostFtdcRspInfoField *pRspInfo, int nRequestID, cbool bIsLast) except -1:
    if pRspInfo is NULL:
        rsp_info = None
    else:
        rsp_info = pyStruct.RspInfoField.from_address(<size_t> pRspInfo)

    self.OnRspError(rsp_info, nRequestID, bIsLast)
    return 0

cdef extern int MdSpi_OnRspSubMarketData(self, CThostFtdcSpecificInstrumentField *pSpecificInstrument,
                                         CThostFtdcRspInfoField *pRspInfo, int nRequestID, cbool bIsLast) except -1:
    if pSpecificInstrument is NULL:
        instrument = None
    else:
        instrument = pyStruct.SpecificInstrumentField.from_address(<size_t> pSpecificInstrument)

    if pRspInfo is NULL:
        rsp_info = None
    else:
        rsp_info = pyStruct.RspInfoField.from_address(<size_t> pRspInfo)

    self.OnRspSubMarketData(instrument, rsp_info, nRequestID, bIsLast)
    return 0

cdef extern int MdSpi_OnRspUnSubMarketData(self, CThostFtdcSpecificInstrumentField *pSpecificInstrument,
                                           CThostFtdcRspInfoField *pRspInfo, int nRequestID, cbool bIsLast) except -1:
    if pSpecificInstrument is NULL:
        instrument = None
    else:
        instrument = pyStruct.SpecificInstrumentField.from_address(<size_t> pSpecificInstrument)

    if pRspInfo is NULL:
        rsp_info = None
    else:
        rsp_info = pyStruct.RspInfoField.from_address(<size_t> pRspInfo)

    self.OnRspUnSubMarketData(instrument, rsp_info, nRequestID, bIsLast)

    return 0

cdef extern int MdSpi_OnRspSubForQuoteRsp(self, CThostFtdcSpecificInstrumentField *pSpecificInstrument,
                                          CThostFtdcRspInfoField *pRspInfo, int nRequestID, cbool bIsLast) except -1:
    if pSpecificInstrument is NULL:
        instrument = None
    else:
        instrument = pyStruct.SpecificInstrumentField.from_address(<size_t> pSpecificInstrument)

    if pRspInfo is NULL:
        rsp_info = None
    else:
        rsp_info = pyStruct.RspInfoField.from_address(<size_t> pRspInfo)

    self.OnRspSubForQuoteRsp(instrument, rsp_info, nRequestID, bIsLast)
    return 0

cdef extern int MdSpi_OnRspUnSubForQuoteRsp(self, CThostFtdcSpecificInstrumentField *pSpecificInstrument,
                                            CThostFtdcRspInfoField *pRspInfo, int nRequestID, cbool bIsLast) except -1:
    if pSpecificInstrument is NULL:
        instrument = None
    else:
        instrument = pyStruct.SpecificInstrumentField.from_address(<size_t> pSpecificInstrument)

    if pRspInfo is NULL:
        rsp_info = None
    else:
        rsp_info = pyStruct.RspInfoField.from_address(<size_t> pRspInfo)

    self.OnRspUnSubForQuoteRsp(instrument, rsp_info, nRequestID, bIsLast)
    return 0

cdef extern int MdSpi_OnRtnDepthMarketData(self, CThostFtdcDepthMarketDataField *pDepthMarketData) except -1:
    if pDepthMarketData is NULL:
        depth_market = None
    else:
        depth_market = pyStruct.DepthMarketDataField.from_address(<size_t> pDepthMarketData)

    self.OnRtnDepthMarketData(depth_market)
    return 0

cdef extern int MdSpi_OnRtnForQuoteRsp(self, CThostFtdcForQuoteRspField *pForQuoteRsp) except -1:
    if pForQuoteRsp is NULL:
        quote_rsp = None
    else:
        quote_rsp = pyStruct.ForQuoteRspField.from_address(<size_t> pForQuoteRsp)
    self.OnRtnForQuoteRsp(quote_rsp)
    return 0
