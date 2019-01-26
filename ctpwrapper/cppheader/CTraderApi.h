
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


static inline int TraderSpi_OnFrontConnected(PyObject* self);
static inline int TraderSpi_OnFrontDisconnected(PyObject* self, int nReason);
static inline int TraderSpi_OnHeartBeatWarning(PyObject* self, int nTimeLapse);
static inline int TraderSpi_OnRspAuthenticate(PyObject* self, CThostFtdcRspAuthenticateField *pRspAuthenticateField, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspUserLogin(PyObject* self, CThostFtdcRspUserLoginField *pRspUserLogin, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspUserLogout(PyObject* self, CThostFtdcUserLogoutField *pUserLogout, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspUserPasswordUpdate(PyObject* self, CThostFtdcUserPasswordUpdateField *pUserPasswordUpdate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspTradingAccountPasswordUpdate(PyObject* self, CThostFtdcTradingAccountPasswordUpdateField *pTradingAccountPasswordUpdate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspOrderInsert(PyObject* self, CThostFtdcInputOrderField *pInputOrder, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspParkedOrderInsert(PyObject* self, CThostFtdcParkedOrderField *pParkedOrder, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspParkedOrderAction(PyObject* self, CThostFtdcParkedOrderActionField *pParkedOrderAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspOrderAction(PyObject* self, CThostFtdcInputOrderActionField *pInputOrderAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQueryMaxOrderVolume(PyObject* self, CThostFtdcQueryMaxOrderVolumeField *pQueryMaxOrderVolume, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspSettlementInfoConfirm(PyObject* self, CThostFtdcSettlementInfoConfirmField *pSettlementInfoConfirm, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspRemoveParkedOrder(PyObject* self, CThostFtdcRemoveParkedOrderField *pRemoveParkedOrder, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspRemoveParkedOrderAction(PyObject* self, CThostFtdcRemoveParkedOrderActionField *pRemoveParkedOrderAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspExecOrderInsert(PyObject* self, CThostFtdcInputExecOrderField *pInputExecOrder, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspExecOrderAction(PyObject* self, CThostFtdcInputExecOrderActionField *pInputExecOrderAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspForQuoteInsert(PyObject* self, CThostFtdcInputForQuoteField *pInputForQuote, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQuoteInsert(PyObject* self, CThostFtdcInputQuoteField *pInputQuote, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQuoteAction(PyObject* self, CThostFtdcInputQuoteActionField *pInputQuoteAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspBatchOrderAction(PyObject* self, CThostFtdcInputBatchOrderActionField *pInputBatchOrderAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspOptionSelfCloseInsert(PyObject* self, CThostFtdcInputOptionSelfCloseField *pInputOptionSelfClose, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspOptionSelfCloseAction(PyObject* self, CThostFtdcInputOptionSelfCloseActionField *pInputOptionSelfCloseAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspCombActionInsert(PyObject* self, CThostFtdcInputCombActionField *pInputCombAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryOrder(PyObject* self, CThostFtdcOrderField *pOrder, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryTrade(PyObject* self, CThostFtdcTradeField *pTrade, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryInvestorPosition(PyObject* self, CThostFtdcInvestorPositionField *pInvestorPosition, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryTradingAccount(PyObject* self, CThostFtdcTradingAccountField *pTradingAccount, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryInvestor(PyObject* self, CThostFtdcInvestorField *pInvestor, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryTradingCode(PyObject* self, CThostFtdcTradingCodeField *pTradingCode, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryInstrumentMarginRate(PyObject* self, CThostFtdcInstrumentMarginRateField *pInstrumentMarginRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryInstrumentCommissionRate(PyObject* self, CThostFtdcInstrumentCommissionRateField *pInstrumentCommissionRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryExchange(PyObject* self, CThostFtdcExchangeField *pExchange, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryProduct(PyObject* self, CThostFtdcProductField *pProduct, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryInstrument(PyObject* self, CThostFtdcInstrumentField *pInstrument, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryDepthMarketData(PyObject* self, CThostFtdcDepthMarketDataField *pDepthMarketData, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQrySettlementInfo(PyObject* self, CThostFtdcSettlementInfoField *pSettlementInfo, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryTransferBank(PyObject* self, CThostFtdcTransferBankField *pTransferBank, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryInvestorPositionDetail(PyObject* self, CThostFtdcInvestorPositionDetailField *pInvestorPositionDetail, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryNotice(PyObject* self, CThostFtdcNoticeField *pNotice, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQrySettlementInfoConfirm(PyObject* self, CThostFtdcSettlementInfoConfirmField *pSettlementInfoConfirm, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryInvestorPositionCombineDetail(PyObject* self, CThostFtdcInvestorPositionCombineDetailField *pInvestorPositionCombineDetail, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryCFMMCTradingAccountKey(PyObject* self, CThostFtdcCFMMCTradingAccountKeyField *pCFMMCTradingAccountKey, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryEWarrantOffset(PyObject* self, CThostFtdcEWarrantOffsetField *pEWarrantOffset, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryInvestorProductGroupMargin(PyObject* self, CThostFtdcInvestorProductGroupMarginField *pInvestorProductGroupMargin, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryExchangeMarginRate(PyObject* self, CThostFtdcExchangeMarginRateField *pExchangeMarginRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryExchangeMarginRateAdjust(PyObject* self, CThostFtdcExchangeMarginRateAdjustField *pExchangeMarginRateAdjust, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryExchangeRate(PyObject* self, CThostFtdcExchangeRateField *pExchangeRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQrySecAgentACIDMap(PyObject* self, CThostFtdcSecAgentACIDMapField *pSecAgentACIDMap, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryProductExchRate(PyObject* self, CThostFtdcProductExchRateField *pProductExchRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryProductGroup(PyObject* self, CThostFtdcProductGroupField *pProductGroup, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryMMInstrumentCommissionRate(PyObject* self, CThostFtdcMMInstrumentCommissionRateField *pMMInstrumentCommissionRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryMMOptionInstrCommRate(PyObject* self, CThostFtdcMMOptionInstrCommRateField *pMMOptionInstrCommRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryInstrumentOrderCommRate(PyObject* self, CThostFtdcInstrumentOrderCommRateField *pInstrumentOrderCommRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQrySecAgentTradingAccount(PyObject* self, CThostFtdcTradingAccountField *pTradingAccount, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQrySecAgentCheckMode(PyObject* self, CThostFtdcSecAgentCheckModeField *pSecAgentCheckMode, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryOptionInstrTradeCost(PyObject* self, CThostFtdcOptionInstrTradeCostField *pOptionInstrTradeCost, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryOptionInstrCommRate(PyObject* self, CThostFtdcOptionInstrCommRateField *pOptionInstrCommRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryExecOrder(PyObject* self, CThostFtdcExecOrderField *pExecOrder, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryForQuote(PyObject* self, CThostFtdcForQuoteField *pForQuote, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryQuote(PyObject* self, CThostFtdcQuoteField *pQuote, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryOptionSelfClose(PyObject* self, CThostFtdcOptionSelfCloseField *pOptionSelfClose, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryInvestUnit(PyObject* self, CThostFtdcInvestUnitField *pInvestUnit, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryCombInstrumentGuard(PyObject* self, CThostFtdcCombInstrumentGuardField *pCombInstrumentGuard, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryCombAction(PyObject* self, CThostFtdcCombActionField *pCombAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryTransferSerial(PyObject* self, CThostFtdcTransferSerialField *pTransferSerial, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryAccountregister(PyObject* self, CThostFtdcAccountregisterField *pAccountregister, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspError(PyObject* self, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRtnOrder(PyObject* self, CThostFtdcOrderField *pOrder);
static inline int TraderSpi_OnRtnTrade(PyObject* self, CThostFtdcTradeField *pTrade);
static inline int TraderSpi_OnErrRtnOrderInsert(PyObject* self, CThostFtdcInputOrderField *pInputOrder, CThostFtdcRspInfoField *pRspInfo);
static inline int TraderSpi_OnErrRtnOrderAction(PyObject* self, CThostFtdcOrderActionField *pOrderAction, CThostFtdcRspInfoField *pRspInfo);
static inline int TraderSpi_OnRtnInstrumentStatus(PyObject* self, CThostFtdcInstrumentStatusField *pInstrumentStatus);
static inline int TraderSpi_OnRtnBulletin(PyObject* self, CThostFtdcBulletinField *pBulletin);
static inline int TraderSpi_OnRtnTradingNotice(PyObject* self, CThostFtdcTradingNoticeInfoField *pTradingNoticeInfo);
static inline int TraderSpi_OnRtnErrorConditionalOrder(PyObject* self, CThostFtdcErrorConditionalOrderField *pErrorConditionalOrder);
static inline int TraderSpi_OnRtnExecOrder(PyObject* self, CThostFtdcExecOrderField *pExecOrder);
static inline int TraderSpi_OnErrRtnExecOrderInsert(PyObject* self, CThostFtdcInputExecOrderField *pInputExecOrder, CThostFtdcRspInfoField *pRspInfo);
static inline int TraderSpi_OnErrRtnExecOrderAction(PyObject* self, CThostFtdcExecOrderActionField *pExecOrderAction, CThostFtdcRspInfoField *pRspInfo);
static inline int TraderSpi_OnErrRtnForQuoteInsert(PyObject* self, CThostFtdcInputForQuoteField *pInputForQuote, CThostFtdcRspInfoField *pRspInfo);
static inline int TraderSpi_OnRtnQuote(PyObject* self, CThostFtdcQuoteField *pQuote);
static inline int TraderSpi_OnErrRtnQuoteInsert(PyObject* self, CThostFtdcInputQuoteField *pInputQuote, CThostFtdcRspInfoField *pRspInfo);
static inline int TraderSpi_OnErrRtnQuoteAction(PyObject* self, CThostFtdcQuoteActionField *pQuoteAction, CThostFtdcRspInfoField *pRspInfo);
static inline int TraderSpi_OnRtnForQuoteRsp(PyObject* self, CThostFtdcForQuoteRspField *pForQuoteRsp);
static inline int TraderSpi_OnRtnCFMMCTradingAccountToken(PyObject* self, CThostFtdcCFMMCTradingAccountTokenField *pCFMMCTradingAccountToken);
static inline int TraderSpi_OnErrRtnBatchOrderAction(PyObject* self, CThostFtdcBatchOrderActionField *pBatchOrderAction, CThostFtdcRspInfoField *pRspInfo);
static inline int TraderSpi_OnRtnOptionSelfClose(PyObject* self, CThostFtdcOptionSelfCloseField *pOptionSelfClose);
static inline int TraderSpi_OnErrRtnOptionSelfCloseInsert(PyObject* self, CThostFtdcInputOptionSelfCloseField *pInputOptionSelfClose, CThostFtdcRspInfoField *pRspInfo);
static inline int TraderSpi_OnErrRtnOptionSelfCloseAction(PyObject* self, CThostFtdcOptionSelfCloseActionField *pOptionSelfCloseAction, CThostFtdcRspInfoField *pRspInfo);
static inline int TraderSpi_OnRtnCombAction(PyObject* self, CThostFtdcCombActionField *pCombAction);
static inline int TraderSpi_OnErrRtnCombActionInsert(PyObject* self, CThostFtdcInputCombActionField *pInputCombAction, CThostFtdcRspInfoField *pRspInfo);
static inline int TraderSpi_OnRspQryContractBank(PyObject* self, CThostFtdcContractBankField *pContractBank, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryParkedOrder(PyObject* self, CThostFtdcParkedOrderField *pParkedOrder, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryParkedOrderAction(PyObject* self, CThostFtdcParkedOrderActionField *pParkedOrderAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryTradingNotice(PyObject* self, CThostFtdcTradingNoticeField *pTradingNotice, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryBrokerTradingParams(PyObject* self, CThostFtdcBrokerTradingParamsField *pBrokerTradingParams, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQryBrokerTradingAlgos(PyObject* self, CThostFtdcBrokerTradingAlgosField *pBrokerTradingAlgos, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQueryCFMMCTradingAccountToken(PyObject* self, CThostFtdcQueryCFMMCTradingAccountTokenField *pQueryCFMMCTradingAccountToken, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRtnFromBankToFutureByBank(PyObject* self, CThostFtdcRspTransferField *pRspTransfer);
static inline int TraderSpi_OnRtnFromFutureToBankByBank(PyObject* self, CThostFtdcRspTransferField *pRspTransfer);
static inline int TraderSpi_OnRtnRepealFromBankToFutureByBank(PyObject* self, CThostFtdcRspRepealField *pRspRepeal);
static inline int TraderSpi_OnRtnRepealFromFutureToBankByBank(PyObject* self, CThostFtdcRspRepealField *pRspRepeal);
static inline int TraderSpi_OnRtnFromBankToFutureByFuture(PyObject* self, CThostFtdcRspTransferField *pRspTransfer);
static inline int TraderSpi_OnRtnFromFutureToBankByFuture(PyObject* self, CThostFtdcRspTransferField *pRspTransfer);
static inline int TraderSpi_OnRtnRepealFromBankToFutureByFutureManual(PyObject* self, CThostFtdcRspRepealField *pRspRepeal);
static inline int TraderSpi_OnRtnRepealFromFutureToBankByFutureManual(PyObject* self, CThostFtdcRspRepealField *pRspRepeal);
static inline int TraderSpi_OnRtnQueryBankBalanceByFuture(PyObject* self, CThostFtdcNotifyQueryAccountField *pNotifyQueryAccount);
static inline int TraderSpi_OnErrRtnBankToFutureByFuture(PyObject* self, CThostFtdcReqTransferField *pReqTransfer, CThostFtdcRspInfoField *pRspInfo);
static inline int TraderSpi_OnErrRtnFutureToBankByFuture(PyObject* self, CThostFtdcReqTransferField *pReqTransfer, CThostFtdcRspInfoField *pRspInfo);
static inline int TraderSpi_OnErrRtnRepealBankToFutureByFutureManual(PyObject* self, CThostFtdcReqRepealField *pReqRepeal, CThostFtdcRspInfoField *pRspInfo);
static inline int TraderSpi_OnErrRtnRepealFutureToBankByFutureManual(PyObject* self, CThostFtdcReqRepealField *pReqRepeal, CThostFtdcRspInfoField *pRspInfo);
static inline int TraderSpi_OnErrRtnQueryBankBalanceByFuture(PyObject* self, CThostFtdcReqQueryAccountField *pReqQueryAccount, CThostFtdcRspInfoField *pRspInfo);
static inline int TraderSpi_OnRtnRepealFromBankToFutureByFuture(PyObject* self, CThostFtdcRspRepealField *pRspRepeal);
static inline int TraderSpi_OnRtnRepealFromFutureToBankByFuture(PyObject* self, CThostFtdcRspRepealField *pRspRepeal);
static inline int TraderSpi_OnRspFromBankToFutureByFuture(PyObject* self, CThostFtdcReqTransferField *pReqTransfer, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspFromFutureToBankByFuture(PyObject* self, CThostFtdcReqTransferField *pReqTransfer, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRspQueryBankAccountMoneyByFuture(PyObject* self, CThostFtdcReqQueryAccountField *pReqQueryAccount, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast);
static inline int TraderSpi_OnRtnOpenAccountByBank(PyObject* self, CThostFtdcOpenAccountField *pOpenAccount);
static inline int TraderSpi_OnRtnCancelAccountByBank(PyObject* self, CThostFtdcCancelAccountField *pCancelAccount);
static inline int TraderSpi_OnRtnChangeAccountByBank(PyObject* self, CThostFtdcChangeAccountField *pChangeAccount);



class CTraderSpi: public CThostFtdcTraderSpi {
public:
    // constructor
    CTraderSpi(PyObject *obj): self(obj) {};
    
    virtual ~CTraderSpi() {};

    ///当客户端与交易后台建立起通信连接时（还未登录前），该方法被调用。
    virtual void OnFrontConnected() {
       Python_GIL(TraderSpi_OnFrontConnected(self));
    }

    ///当客户端与交易后台通信连接断开时，该方法被调用。当发生这个情况后，API会自动重新连接，客户端可不做处理。
    ///@param nReason 错误原因
    ///        0x1001 网络读失败
    ///        0x1002 网络写失败
    ///        0x2001 接收心跳超时
    ///        0x2002 发送心跳失败
    ///        0x2003 收到错误报文
    virtual void OnFrontDisconnected(int nReason) {
       Python_GIL(TraderSpi_OnFrontDisconnected(self, nReason));
    }

    ///心跳超时警告。当长时间未收到报文时，该方法被调用。
    ///@param nTimeLapse 距离上次接收报文的时间
    virtual void OnHeartBeatWarning(int nTimeLapse) {
       Python_GIL(TraderSpi_OnHeartBeatWarning(self, nTimeLapse));
    }

    ///客户端认证响应
    virtual void OnRspAuthenticate(CThostFtdcRspAuthenticateField *pRspAuthenticateField, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspAuthenticate(self, pRspAuthenticateField, pRspInfo, nRequestID, bIsLast));
    }

    ///登录请求响应
    virtual void OnRspUserLogin(CThostFtdcRspUserLoginField *pRspUserLogin, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspUserLogin(self, pRspUserLogin, pRspInfo, nRequestID, bIsLast));
    }

    ///登出请求响应
    virtual void OnRspUserLogout(CThostFtdcUserLogoutField *pUserLogout, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspUserLogout(self, pUserLogout, pRspInfo, nRequestID, bIsLast));
    }

    ///用户口令更新请求响应
    virtual void OnRspUserPasswordUpdate(CThostFtdcUserPasswordUpdateField *pUserPasswordUpdate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspUserPasswordUpdate(self, pUserPasswordUpdate, pRspInfo, nRequestID, bIsLast));
    }

    ///资金账户口令更新请求响应
    virtual void OnRspTradingAccountPasswordUpdate(CThostFtdcTradingAccountPasswordUpdateField *pTradingAccountPasswordUpdate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspTradingAccountPasswordUpdate(self, pTradingAccountPasswordUpdate, pRspInfo, nRequestID, bIsLast));
    }

    ///报单录入请求响应
    virtual void OnRspOrderInsert(CThostFtdcInputOrderField *pInputOrder, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspOrderInsert(self, pInputOrder, pRspInfo, nRequestID, bIsLast));
    }

    ///预埋单录入请求响应
    virtual void OnRspParkedOrderInsert(CThostFtdcParkedOrderField *pParkedOrder, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspParkedOrderInsert(self, pParkedOrder, pRspInfo, nRequestID, bIsLast));
    }

    ///预埋撤单录入请求响应
    virtual void OnRspParkedOrderAction(CThostFtdcParkedOrderActionField *pParkedOrderAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspParkedOrderAction(self, pParkedOrderAction, pRspInfo, nRequestID, bIsLast));
    }

    ///报单操作请求响应
    virtual void OnRspOrderAction(CThostFtdcInputOrderActionField *pInputOrderAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspOrderAction(self, pInputOrderAction, pRspInfo, nRequestID, bIsLast));
    }

    ///查询最大报单数量响应
    virtual void OnRspQueryMaxOrderVolume(CThostFtdcQueryMaxOrderVolumeField *pQueryMaxOrderVolume, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQueryMaxOrderVolume(self, pQueryMaxOrderVolume, pRspInfo, nRequestID, bIsLast));
    }

    ///投资者结算结果确认响应
    virtual void OnRspSettlementInfoConfirm(CThostFtdcSettlementInfoConfirmField *pSettlementInfoConfirm, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspSettlementInfoConfirm(self, pSettlementInfoConfirm, pRspInfo, nRequestID, bIsLast));
    }

    ///删除预埋单响应
    virtual void OnRspRemoveParkedOrder(CThostFtdcRemoveParkedOrderField *pRemoveParkedOrder, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspRemoveParkedOrder(self, pRemoveParkedOrder, pRspInfo, nRequestID, bIsLast));
    }

    ///删除预埋撤单响应
    virtual void OnRspRemoveParkedOrderAction(CThostFtdcRemoveParkedOrderActionField *pRemoveParkedOrderAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspRemoveParkedOrderAction(self, pRemoveParkedOrderAction, pRspInfo, nRequestID, bIsLast));
    }

    ///执行宣告录入请求响应
    virtual void OnRspExecOrderInsert(CThostFtdcInputExecOrderField *pInputExecOrder, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspExecOrderInsert(self, pInputExecOrder, pRspInfo, nRequestID, bIsLast));
    }

    ///执行宣告操作请求响应
    virtual void OnRspExecOrderAction(CThostFtdcInputExecOrderActionField *pInputExecOrderAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspExecOrderAction(self, pInputExecOrderAction, pRspInfo, nRequestID, bIsLast));
    }

    ///询价录入请求响应
    virtual void OnRspForQuoteInsert(CThostFtdcInputForQuoteField *pInputForQuote, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspForQuoteInsert(self, pInputForQuote, pRspInfo, nRequestID, bIsLast));
    }

    ///报价录入请求响应
    virtual void OnRspQuoteInsert(CThostFtdcInputQuoteField *pInputQuote, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQuoteInsert(self, pInputQuote, pRspInfo, nRequestID, bIsLast));
    }

    ///报价操作请求响应
    virtual void OnRspQuoteAction(CThostFtdcInputQuoteActionField *pInputQuoteAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQuoteAction(self, pInputQuoteAction, pRspInfo, nRequestID, bIsLast));
    }

    ///批量报单操作请求响应
    virtual void OnRspBatchOrderAction(CThostFtdcInputBatchOrderActionField *pInputBatchOrderAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspBatchOrderAction(self, pInputBatchOrderAction, pRspInfo, nRequestID, bIsLast));
    }

    ///期权自对冲录入请求响应
    virtual void OnRspOptionSelfCloseInsert(CThostFtdcInputOptionSelfCloseField *pInputOptionSelfClose, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspOptionSelfCloseInsert(self, pInputOptionSelfClose, pRspInfo, nRequestID, bIsLast));
    }

    ///期权自对冲操作请求响应
    virtual void OnRspOptionSelfCloseAction(CThostFtdcInputOptionSelfCloseActionField *pInputOptionSelfCloseAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspOptionSelfCloseAction(self, pInputOptionSelfCloseAction, pRspInfo, nRequestID, bIsLast));
    }

    ///申请组合录入请求响应
    virtual void OnRspCombActionInsert(CThostFtdcInputCombActionField *pInputCombAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspCombActionInsert(self, pInputCombAction, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询报单响应
    virtual void OnRspQryOrder(CThostFtdcOrderField *pOrder, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryOrder(self, pOrder, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询成交响应
    virtual void OnRspQryTrade(CThostFtdcTradeField *pTrade, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryTrade(self, pTrade, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询投资者持仓响应
    virtual void OnRspQryInvestorPosition(CThostFtdcInvestorPositionField *pInvestorPosition, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryInvestorPosition(self, pInvestorPosition, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询资金账户响应
    virtual void OnRspQryTradingAccount(CThostFtdcTradingAccountField *pTradingAccount, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryTradingAccount(self, pTradingAccount, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询投资者响应
    virtual void OnRspQryInvestor(CThostFtdcInvestorField *pInvestor, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryInvestor(self, pInvestor, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询交易编码响应
    virtual void OnRspQryTradingCode(CThostFtdcTradingCodeField *pTradingCode, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryTradingCode(self, pTradingCode, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询合约保证金率响应
    virtual void OnRspQryInstrumentMarginRate(CThostFtdcInstrumentMarginRateField *pInstrumentMarginRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryInstrumentMarginRate(self, pInstrumentMarginRate, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询合约手续费率响应
    virtual void OnRspQryInstrumentCommissionRate(CThostFtdcInstrumentCommissionRateField *pInstrumentCommissionRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryInstrumentCommissionRate(self, pInstrumentCommissionRate, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询交易所响应
    virtual void OnRspQryExchange(CThostFtdcExchangeField *pExchange, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryExchange(self, pExchange, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询产品响应
    virtual void OnRspQryProduct(CThostFtdcProductField *pProduct, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryProduct(self, pProduct, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询合约响应
    virtual void OnRspQryInstrument(CThostFtdcInstrumentField *pInstrument, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryInstrument(self, pInstrument, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询行情响应
    virtual void OnRspQryDepthMarketData(CThostFtdcDepthMarketDataField *pDepthMarketData, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryDepthMarketData(self, pDepthMarketData, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询投资者结算结果响应
    virtual void OnRspQrySettlementInfo(CThostFtdcSettlementInfoField *pSettlementInfo, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQrySettlementInfo(self, pSettlementInfo, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询转帐银行响应
    virtual void OnRspQryTransferBank(CThostFtdcTransferBankField *pTransferBank, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryTransferBank(self, pTransferBank, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询投资者持仓明细响应
    virtual void OnRspQryInvestorPositionDetail(CThostFtdcInvestorPositionDetailField *pInvestorPositionDetail, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryInvestorPositionDetail(self, pInvestorPositionDetail, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询客户通知响应
    virtual void OnRspQryNotice(CThostFtdcNoticeField *pNotice, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryNotice(self, pNotice, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询结算信息确认响应
    virtual void OnRspQrySettlementInfoConfirm(CThostFtdcSettlementInfoConfirmField *pSettlementInfoConfirm, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQrySettlementInfoConfirm(self, pSettlementInfoConfirm, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询投资者持仓明细响应
    virtual void OnRspQryInvestorPositionCombineDetail(CThostFtdcInvestorPositionCombineDetailField *pInvestorPositionCombineDetail, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryInvestorPositionCombineDetail(self, pInvestorPositionCombineDetail, pRspInfo, nRequestID, bIsLast));
    }

    ///查询保证金监管系统经纪公司资金账户密钥响应
    virtual void OnRspQryCFMMCTradingAccountKey(CThostFtdcCFMMCTradingAccountKeyField *pCFMMCTradingAccountKey, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryCFMMCTradingAccountKey(self, pCFMMCTradingAccountKey, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询仓单折抵信息响应
    virtual void OnRspQryEWarrantOffset(CThostFtdcEWarrantOffsetField *pEWarrantOffset, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryEWarrantOffset(self, pEWarrantOffset, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询投资者品种/跨品种保证金响应
    virtual void OnRspQryInvestorProductGroupMargin(CThostFtdcInvestorProductGroupMarginField *pInvestorProductGroupMargin, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryInvestorProductGroupMargin(self, pInvestorProductGroupMargin, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询交易所保证金率响应
    virtual void OnRspQryExchangeMarginRate(CThostFtdcExchangeMarginRateField *pExchangeMarginRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryExchangeMarginRate(self, pExchangeMarginRate, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询交易所调整保证金率响应
    virtual void OnRspQryExchangeMarginRateAdjust(CThostFtdcExchangeMarginRateAdjustField *pExchangeMarginRateAdjust, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryExchangeMarginRateAdjust(self, pExchangeMarginRateAdjust, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询汇率响应
    virtual void OnRspQryExchangeRate(CThostFtdcExchangeRateField *pExchangeRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryExchangeRate(self, pExchangeRate, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询二级代理操作员银期权限响应
    virtual void OnRspQrySecAgentACIDMap(CThostFtdcSecAgentACIDMapField *pSecAgentACIDMap, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQrySecAgentACIDMap(self, pSecAgentACIDMap, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询产品报价汇率
    virtual void OnRspQryProductExchRate(CThostFtdcProductExchRateField *pProductExchRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryProductExchRate(self, pProductExchRate, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询产品组
    virtual void OnRspQryProductGroup(CThostFtdcProductGroupField *pProductGroup, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryProductGroup(self, pProductGroup, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询做市商合约手续费率响应
    virtual void OnRspQryMMInstrumentCommissionRate(CThostFtdcMMInstrumentCommissionRateField *pMMInstrumentCommissionRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryMMInstrumentCommissionRate(self, pMMInstrumentCommissionRate, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询做市商期权合约手续费响应
    virtual void OnRspQryMMOptionInstrCommRate(CThostFtdcMMOptionInstrCommRateField *pMMOptionInstrCommRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryMMOptionInstrCommRate(self, pMMOptionInstrCommRate, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询报单手续费响应
    virtual void OnRspQryInstrumentOrderCommRate(CThostFtdcInstrumentOrderCommRateField *pInstrumentOrderCommRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryInstrumentOrderCommRate(self, pInstrumentOrderCommRate, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询资金账户响应
    virtual void OnRspQrySecAgentTradingAccount(CThostFtdcTradingAccountField *pTradingAccount, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQrySecAgentTradingAccount(self, pTradingAccount, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询二级代理商资金校验模式响应
    virtual void OnRspQrySecAgentCheckMode(CThostFtdcSecAgentCheckModeField *pSecAgentCheckMode, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQrySecAgentCheckMode(self, pSecAgentCheckMode, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询期权交易成本响应
    virtual void OnRspQryOptionInstrTradeCost(CThostFtdcOptionInstrTradeCostField *pOptionInstrTradeCost, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryOptionInstrTradeCost(self, pOptionInstrTradeCost, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询期权合约手续费响应
    virtual void OnRspQryOptionInstrCommRate(CThostFtdcOptionInstrCommRateField *pOptionInstrCommRate, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryOptionInstrCommRate(self, pOptionInstrCommRate, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询执行宣告响应
    virtual void OnRspQryExecOrder(CThostFtdcExecOrderField *pExecOrder, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryExecOrder(self, pExecOrder, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询询价响应
    virtual void OnRspQryForQuote(CThostFtdcForQuoteField *pForQuote, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryForQuote(self, pForQuote, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询报价响应
    virtual void OnRspQryQuote(CThostFtdcQuoteField *pQuote, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryQuote(self, pQuote, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询期权自对冲响应
    virtual void OnRspQryOptionSelfClose(CThostFtdcOptionSelfCloseField *pOptionSelfClose, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryOptionSelfClose(self, pOptionSelfClose, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询投资单元响应
    virtual void OnRspQryInvestUnit(CThostFtdcInvestUnitField *pInvestUnit, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryInvestUnit(self, pInvestUnit, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询组合合约安全系数响应
    virtual void OnRspQryCombInstrumentGuard(CThostFtdcCombInstrumentGuardField *pCombInstrumentGuard, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryCombInstrumentGuard(self, pCombInstrumentGuard, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询申请组合响应
    virtual void OnRspQryCombAction(CThostFtdcCombActionField *pCombAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryCombAction(self, pCombAction, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询转帐流水响应
    virtual void OnRspQryTransferSerial(CThostFtdcTransferSerialField *pTransferSerial, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryTransferSerial(self, pTransferSerial, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询银期签约关系响应
    virtual void OnRspQryAccountregister(CThostFtdcAccountregisterField *pAccountregister, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryAccountregister(self, pAccountregister, pRspInfo, nRequestID, bIsLast));
    }

    ///错误应答
    virtual void OnRspError(CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspError(self, pRspInfo, nRequestID, bIsLast));
    }

    ///报单通知
    virtual void OnRtnOrder(CThostFtdcOrderField *pOrder) {
       Python_GIL(TraderSpi_OnRtnOrder(self, pOrder));
    }

    ///成交通知
    virtual void OnRtnTrade(CThostFtdcTradeField *pTrade) {
       Python_GIL(TraderSpi_OnRtnTrade(self, pTrade));
    }

    ///报单录入错误回报
    virtual void OnErrRtnOrderInsert(CThostFtdcInputOrderField *pInputOrder, CThostFtdcRspInfoField *pRspInfo) {
       Python_GIL(TraderSpi_OnErrRtnOrderInsert(self, pInputOrder, pRspInfo));
    }

    ///报单操作错误回报
    virtual void OnErrRtnOrderAction(CThostFtdcOrderActionField *pOrderAction, CThostFtdcRspInfoField *pRspInfo) {
       Python_GIL(TraderSpi_OnErrRtnOrderAction(self, pOrderAction, pRspInfo));
    }

    ///合约交易状态通知
    virtual void OnRtnInstrumentStatus(CThostFtdcInstrumentStatusField *pInstrumentStatus) {
       Python_GIL(TraderSpi_OnRtnInstrumentStatus(self, pInstrumentStatus));
    }

    ///交易所公告通知
    virtual void OnRtnBulletin(CThostFtdcBulletinField *pBulletin) {
       Python_GIL(TraderSpi_OnRtnBulletin(self, pBulletin));
    }

    ///交易通知
    virtual void OnRtnTradingNotice(CThostFtdcTradingNoticeInfoField *pTradingNoticeInfo) {
       Python_GIL(TraderSpi_OnRtnTradingNotice(self, pTradingNoticeInfo));
    }

    ///提示条件单校验错误
    virtual void OnRtnErrorConditionalOrder(CThostFtdcErrorConditionalOrderField *pErrorConditionalOrder) {
       Python_GIL(TraderSpi_OnRtnErrorConditionalOrder(self, pErrorConditionalOrder));
    }

    ///执行宣告通知
    virtual void OnRtnExecOrder(CThostFtdcExecOrderField *pExecOrder) {
       Python_GIL(TraderSpi_OnRtnExecOrder(self, pExecOrder));
    }

    ///执行宣告录入错误回报
    virtual void OnErrRtnExecOrderInsert(CThostFtdcInputExecOrderField *pInputExecOrder, CThostFtdcRspInfoField *pRspInfo) {
       Python_GIL(TraderSpi_OnErrRtnExecOrderInsert(self, pInputExecOrder, pRspInfo));
    }

    ///执行宣告操作错误回报
    virtual void OnErrRtnExecOrderAction(CThostFtdcExecOrderActionField *pExecOrderAction, CThostFtdcRspInfoField *pRspInfo) {
       Python_GIL(TraderSpi_OnErrRtnExecOrderAction(self, pExecOrderAction, pRspInfo));
    }

    ///询价录入错误回报
    virtual void OnErrRtnForQuoteInsert(CThostFtdcInputForQuoteField *pInputForQuote, CThostFtdcRspInfoField *pRspInfo) {
       Python_GIL(TraderSpi_OnErrRtnForQuoteInsert(self, pInputForQuote, pRspInfo));
    }

    ///报价通知
    virtual void OnRtnQuote(CThostFtdcQuoteField *pQuote) {
       Python_GIL(TraderSpi_OnRtnQuote(self, pQuote));
    }

    ///报价录入错误回报
    virtual void OnErrRtnQuoteInsert(CThostFtdcInputQuoteField *pInputQuote, CThostFtdcRspInfoField *pRspInfo) {
       Python_GIL(TraderSpi_OnErrRtnQuoteInsert(self, pInputQuote, pRspInfo));
    }

    ///报价操作错误回报
    virtual void OnErrRtnQuoteAction(CThostFtdcQuoteActionField *pQuoteAction, CThostFtdcRspInfoField *pRspInfo) {
       Python_GIL(TraderSpi_OnErrRtnQuoteAction(self, pQuoteAction, pRspInfo));
    }

    ///询价通知
    virtual void OnRtnForQuoteRsp(CThostFtdcForQuoteRspField *pForQuoteRsp) {
       Python_GIL(TraderSpi_OnRtnForQuoteRsp(self, pForQuoteRsp));
    }

    ///保证金监控中心用户令牌
    virtual void OnRtnCFMMCTradingAccountToken(CThostFtdcCFMMCTradingAccountTokenField *pCFMMCTradingAccountToken) {
       Python_GIL(TraderSpi_OnRtnCFMMCTradingAccountToken(self, pCFMMCTradingAccountToken));
    }

    ///批量报单操作错误回报
    virtual void OnErrRtnBatchOrderAction(CThostFtdcBatchOrderActionField *pBatchOrderAction, CThostFtdcRspInfoField *pRspInfo) {
       Python_GIL(TraderSpi_OnErrRtnBatchOrderAction(self, pBatchOrderAction, pRspInfo));
    }

    ///期权自对冲通知
    virtual void OnRtnOptionSelfClose(CThostFtdcOptionSelfCloseField *pOptionSelfClose) {
       Python_GIL(TraderSpi_OnRtnOptionSelfClose(self, pOptionSelfClose));
    }

    ///期权自对冲录入错误回报
    virtual void OnErrRtnOptionSelfCloseInsert(CThostFtdcInputOptionSelfCloseField *pInputOptionSelfClose, CThostFtdcRspInfoField *pRspInfo) {
       Python_GIL(TraderSpi_OnErrRtnOptionSelfCloseInsert(self, pInputOptionSelfClose, pRspInfo));
    }

    ///期权自对冲操作错误回报
    virtual void OnErrRtnOptionSelfCloseAction(CThostFtdcOptionSelfCloseActionField *pOptionSelfCloseAction, CThostFtdcRspInfoField *pRspInfo) {
       Python_GIL(TraderSpi_OnErrRtnOptionSelfCloseAction(self, pOptionSelfCloseAction, pRspInfo));
    }

    ///申请组合通知
    virtual void OnRtnCombAction(CThostFtdcCombActionField *pCombAction) {
       Python_GIL(TraderSpi_OnRtnCombAction(self, pCombAction));
    }

    ///申请组合录入错误回报
    virtual void OnErrRtnCombActionInsert(CThostFtdcInputCombActionField *pInputCombAction, CThostFtdcRspInfoField *pRspInfo) {
       Python_GIL(TraderSpi_OnErrRtnCombActionInsert(self, pInputCombAction, pRspInfo));
    }

    ///请求查询签约银行响应
    virtual void OnRspQryContractBank(CThostFtdcContractBankField *pContractBank, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryContractBank(self, pContractBank, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询预埋单响应
    virtual void OnRspQryParkedOrder(CThostFtdcParkedOrderField *pParkedOrder, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryParkedOrder(self, pParkedOrder, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询预埋撤单响应
    virtual void OnRspQryParkedOrderAction(CThostFtdcParkedOrderActionField *pParkedOrderAction, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryParkedOrderAction(self, pParkedOrderAction, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询交易通知响应
    virtual void OnRspQryTradingNotice(CThostFtdcTradingNoticeField *pTradingNotice, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryTradingNotice(self, pTradingNotice, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询经纪公司交易参数响应
    virtual void OnRspQryBrokerTradingParams(CThostFtdcBrokerTradingParamsField *pBrokerTradingParams, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryBrokerTradingParams(self, pBrokerTradingParams, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询经纪公司交易算法响应
    virtual void OnRspQryBrokerTradingAlgos(CThostFtdcBrokerTradingAlgosField *pBrokerTradingAlgos, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQryBrokerTradingAlgos(self, pBrokerTradingAlgos, pRspInfo, nRequestID, bIsLast));
    }

    ///请求查询监控中心用户令牌
    virtual void OnRspQueryCFMMCTradingAccountToken(CThostFtdcQueryCFMMCTradingAccountTokenField *pQueryCFMMCTradingAccountToken, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQueryCFMMCTradingAccountToken(self, pQueryCFMMCTradingAccountToken, pRspInfo, nRequestID, bIsLast));
    }

    ///银行发起银行资金转期货通知
    virtual void OnRtnFromBankToFutureByBank(CThostFtdcRspTransferField *pRspTransfer) {
       Python_GIL(TraderSpi_OnRtnFromBankToFutureByBank(self, pRspTransfer));
    }

    ///银行发起期货资金转银行通知
    virtual void OnRtnFromFutureToBankByBank(CThostFtdcRspTransferField *pRspTransfer) {
       Python_GIL(TraderSpi_OnRtnFromFutureToBankByBank(self, pRspTransfer));
    }

    ///银行发起冲正银行转期货通知
    virtual void OnRtnRepealFromBankToFutureByBank(CThostFtdcRspRepealField *pRspRepeal) {
       Python_GIL(TraderSpi_OnRtnRepealFromBankToFutureByBank(self, pRspRepeal));
    }

    ///银行发起冲正期货转银行通知
    virtual void OnRtnRepealFromFutureToBankByBank(CThostFtdcRspRepealField *pRspRepeal) {
       Python_GIL(TraderSpi_OnRtnRepealFromFutureToBankByBank(self, pRspRepeal));
    }

    ///期货发起银行资金转期货通知
    virtual void OnRtnFromBankToFutureByFuture(CThostFtdcRspTransferField *pRspTransfer) {
       Python_GIL(TraderSpi_OnRtnFromBankToFutureByFuture(self, pRspTransfer));
    }

    ///期货发起期货资金转银行通知
    virtual void OnRtnFromFutureToBankByFuture(CThostFtdcRspTransferField *pRspTransfer) {
       Python_GIL(TraderSpi_OnRtnFromFutureToBankByFuture(self, pRspTransfer));
    }

    ///系统运行时期货端手工发起冲正银行转期货请求，银行处理完毕后报盘发回的通知
    virtual void OnRtnRepealFromBankToFutureByFutureManual(CThostFtdcRspRepealField *pRspRepeal) {
       Python_GIL(TraderSpi_OnRtnRepealFromBankToFutureByFutureManual(self, pRspRepeal));
    }

    ///系统运行时期货端手工发起冲正期货转银行请求，银行处理完毕后报盘发回的通知
    virtual void OnRtnRepealFromFutureToBankByFutureManual(CThostFtdcRspRepealField *pRspRepeal) {
       Python_GIL(TraderSpi_OnRtnRepealFromFutureToBankByFutureManual(self, pRspRepeal));
    }

    ///期货发起查询银行余额通知
    virtual void OnRtnQueryBankBalanceByFuture(CThostFtdcNotifyQueryAccountField *pNotifyQueryAccount) {
       Python_GIL(TraderSpi_OnRtnQueryBankBalanceByFuture(self, pNotifyQueryAccount));
    }

    ///期货发起银行资金转期货错误回报
    virtual void OnErrRtnBankToFutureByFuture(CThostFtdcReqTransferField *pReqTransfer, CThostFtdcRspInfoField *pRspInfo) {
       Python_GIL(TraderSpi_OnErrRtnBankToFutureByFuture(self, pReqTransfer, pRspInfo));
    }

    ///期货发起期货资金转银行错误回报
    virtual void OnErrRtnFutureToBankByFuture(CThostFtdcReqTransferField *pReqTransfer, CThostFtdcRspInfoField *pRspInfo) {
       Python_GIL(TraderSpi_OnErrRtnFutureToBankByFuture(self, pReqTransfer, pRspInfo));
    }

    ///系统运行时期货端手工发起冲正银行转期货错误回报
    virtual void OnErrRtnRepealBankToFutureByFutureManual(CThostFtdcReqRepealField *pReqRepeal, CThostFtdcRspInfoField *pRspInfo) {
       Python_GIL(TraderSpi_OnErrRtnRepealBankToFutureByFutureManual(self, pReqRepeal, pRspInfo));
    }

    ///系统运行时期货端手工发起冲正期货转银行错误回报
    virtual void OnErrRtnRepealFutureToBankByFutureManual(CThostFtdcReqRepealField *pReqRepeal, CThostFtdcRspInfoField *pRspInfo) {
       Python_GIL(TraderSpi_OnErrRtnRepealFutureToBankByFutureManual(self, pReqRepeal, pRspInfo));
    }

    ///期货发起查询银行余额错误回报
    virtual void OnErrRtnQueryBankBalanceByFuture(CThostFtdcReqQueryAccountField *pReqQueryAccount, CThostFtdcRspInfoField *pRspInfo) {
       Python_GIL(TraderSpi_OnErrRtnQueryBankBalanceByFuture(self, pReqQueryAccount, pRspInfo));
    }

    ///期货发起冲正银行转期货请求，银行处理完毕后报盘发回的通知
    virtual void OnRtnRepealFromBankToFutureByFuture(CThostFtdcRspRepealField *pRspRepeal) {
       Python_GIL(TraderSpi_OnRtnRepealFromBankToFutureByFuture(self, pRspRepeal));
    }

    ///期货发起冲正期货转银行请求，银行处理完毕后报盘发回的通知
    virtual void OnRtnRepealFromFutureToBankByFuture(CThostFtdcRspRepealField *pRspRepeal) {
       Python_GIL(TraderSpi_OnRtnRepealFromFutureToBankByFuture(self, pRspRepeal));
    }

    ///期货发起银行资金转期货应答
    virtual void OnRspFromBankToFutureByFuture(CThostFtdcReqTransferField *pReqTransfer, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspFromBankToFutureByFuture(self, pReqTransfer, pRspInfo, nRequestID, bIsLast));
    }

    ///期货发起期货资金转银行应答
    virtual void OnRspFromFutureToBankByFuture(CThostFtdcReqTransferField *pReqTransfer, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspFromFutureToBankByFuture(self, pReqTransfer, pRspInfo, nRequestID, bIsLast));
    }

    ///期货发起查询银行余额应答
    virtual void OnRspQueryBankAccountMoneyByFuture(CThostFtdcReqQueryAccountField *pReqQueryAccount, CThostFtdcRspInfoField *pRspInfo, int nRequestID, bool bIsLast) {
       Python_GIL(TraderSpi_OnRspQueryBankAccountMoneyByFuture(self, pReqQueryAccount, pRspInfo, nRequestID, bIsLast));
    }

    ///银行发起银期开户通知
    virtual void OnRtnOpenAccountByBank(CThostFtdcOpenAccountField *pOpenAccount) {
       Python_GIL(TraderSpi_OnRtnOpenAccountByBank(self, pOpenAccount));
    }

    ///银行发起银期销户通知
    virtual void OnRtnCancelAccountByBank(CThostFtdcCancelAccountField *pCancelAccount) {
       Python_GIL(TraderSpi_OnRtnCancelAccountByBank(self, pCancelAccount));
    }

    ///银行发起变更银行账号通知
    virtual void OnRtnChangeAccountByBank(CThostFtdcChangeAccountField *pChangeAccount) {
       Python_GIL(TraderSpi_OnRtnChangeAccountByBank(self, pChangeAccount));
    }


private:
    PyObject* self;

};
    
#endif /* CTRADERAPI_H */
