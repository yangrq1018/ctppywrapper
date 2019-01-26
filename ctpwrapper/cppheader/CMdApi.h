#ifndef CMDAPI_H
#define CMDAPI_H

/**
A C++ wrapping layer to forward C++ callbacks to proxy Python object.
The callbacks are declared in this file, by the implementation is provided via Cython
*/

// for GIL
#include "Python.h"
#include "pythread.h"

// include the definition of raw MdApi
#include "ThostFtdcMdApi.h"

/**
 acquire GIL before calling Python-side methods
 if func returns -1, we must have an exception on the Python side
 If anything goes run in Cython code section, it will immediate return -1 and we can check Python Exception
 Acquire the GIL before calling Cython cdefs, do not use with gil keyword to acquire GIL, if anything goes wrong,
 it may not release the GIL.
*/

#define Python_GIL(func) \
	do { \
		PyGILState_STATE gil_state = PyGILState_Ensure(); \
		if ((func) == -1) PyErr_Print();  \
		PyGILState_Release(gil_state); \
    } while (false)


// Declare callbacks here
static inline int MdSpi_OnFrontConnected(PyObject* self);
static inline int MdSpi_OnFrontDisconnected(PyObject* self, int nReason);
static inline int MdSpi_OnHeartBeatWarning(PyObject* self, int nTimeLapse);
static inline int MdSpi_OnRspUserLogin(PyObject* self, CThostFtdcRspUserLoginField *pRspUserLogin, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int MdSpi_OnRspUserLogout(PyObject* self, CThostFtdcUserLogoutField *pUserLogout, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int MdSpi_OnRspError(PyObject* self, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int MdSpi_OnRspSubMarketData(PyObject* self, CThostFtdcSpecificInstrumentField *pSpecificInstrument, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int MdSpi_OnRspUnSubMarketData(PyObject* self, CThostFtdcSpecificInstrumentField *pSpecificInstrument, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int MdSpi_OnRspSubForQuoteRsp(PyObject* self, CThostFtdcSpecificInstrumentField *pSpecificInstrument, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int MdSpi_OnRspUnSubForQuoteRsp(PyObject* self, CThostFtdcSpecificInstrumentField *pSpecificInstrument, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int MdSpi_OnRtnDepthMarketData(PyObject* self, CThostFtdcDepthMarketDataField *pDepthMarketData);
static inline int MdSpi_OnRtnForQuoteRsp(PyObject* self, CThostFtdcForQuoteRspField *pForQuoteRsp);


/**
Service Provider Interface
*/
class CMdSpi: public CThostFtdcMdSpi {
public:

    // Constructor, accept the Python-side proxy object
    CMdSpi(PyObject *obj): self(obj) {};

    virtual ~CMdSpi() {};

    // override those callbacks to call Python-side user-defined methods

    ///当客户端与交易后台建立起通信连接时（还未登录前），该方法被调用。
    virtual void OnFrontConnected() {
        Python_GIL(MdSpi_OnFrontConnected(self));
    };

    virtual void OnFrontDisconnected(int nReason) {
        Python_GIL(MdSpi_OnFrontDisconnected(self, nReason));
    };

    ///心跳超时警告。当长时间未收到报文时，该方法被调用。
    virtual void OnHeartBeatWarning(int nTimeLapse) {
        Python_GIL(MdSpi_OnHeartBeatWarning(self, nTimeLapse));
    };


    ///登录请求响应
    virtual void OnRspUserLogin(CThostFtdcRspUserLoginField *pRspUserLogin, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
        Python_GIL(MdSpi_OnRspUserLogin(self, pRspUserLogin, pRspInfo, nRequestID,  bIsLast));
    };

    ///登出请求响应
    virtual void OnRspUserLogout(CThostFtdcUserLogoutField *pUserLogout, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
        Python_GIL(MdSpi_OnRspUserLogout(self, pUserLogout, pRspInfo, nRequestID, bIsLast));
    };

    ///错误应答
    virtual void OnRspError(CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
        Python_GIL(MdSpi_OnRspError(self, pRspInfo, nRequestID, bIsLast));
    };

    ///订阅行情应答
    virtual void OnRspSubMarketData(CThostFtdcSpecificInstrumentField *pSpecificInstrument, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
        Python_GIL(MdSpi_OnRspSubMarketData(self, pSpecificInstrument, pRspInfo, nRequestID, bIsLast));
    };

    ///取消订阅行情应答
    virtual void OnRspUnSubMarketData(CThostFtdcSpecificInstrumentField *pSpecificInstrument, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
        Python_GIL(MdSpi_OnRspUnSubMarketData(self, pSpecificInstrument, pRspInfo, nRequestID, bIsLast));
    };

    ///订阅询价应答
    virtual void OnRspSubForQuoteRsp(CThostFtdcSpecificInstrumentField *pSpecificInstrument, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
        Python_GIL(MdSpi_OnRspUnSubForQuoteRsp(self, pSpecificInstrument, pRspInfo, nRequestID, bIsLast));
    };

    ///取消订阅询价应答
    virtual void OnRspUnSubForQuoteRsp(CThostFtdcSpecificInstrumentField *pSpecificInstrument, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
        Python_GIL(MdSpi_OnRspUnSubForQuoteRsp(self, pSpecificInstrument, pRspInfo, nRequestID, bIsLast));
    };

    ///深度行情通知
    virtual void OnRtnDepthMarketData(CThostFtdcDepthMarketDataField *pDepthMarketData) {
        Python_GIL(MdSpi_OnRtnDepthMarketData(self, pDepthMarketData));
    };

    ///询价通知
    virtual void OnRtnForQuoteRsp(CThostFtdcForQuoteRspField *pForQuoteRsp) {
        Python_GIL(MdSpi_OnRtnForQuoteRsp(self, pForQuoteRsp));
    };

private:
    // Pointer to Python-side proxy object
    PyObject* self;

};


#endif