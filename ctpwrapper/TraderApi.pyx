import ctypes

from cpython cimport

PyObject
from libc.string cimport

const_char
from libcpp cimport

bool as cbool

from . import pyStruct
# classes and static factory
from .pxdheader.ThostFtdcUserApiStruct cimport *
from .pxdheader.TraderApi cimport

CTraderSpi, CTraderApi, CreateFtdcTraderApi

# wrapper Api/Spi in extension class
cdef class TraderApiWrapper:
    cdef CTraderSpi*_spi
    cdef CTraderApi*_api

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
            raise RuntimeError("Cannot create TraderApi")  # could be out of memory

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

    # 获取API的版本信息
    # @retrun 获取到的版本号
    @staticmethod
    def GetApiVersion():
        return CTraderApi.GetApiVersion()

    def GetTradingDay(self):
        cdef const_char*result
        if self._api is not NULL:
            with nogil:  # nogil in method definition does nothing
                result = self._api.GetTradingDay()
            return result

    def RegisterFront(self, char*pszFrontAddress):
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

    # 客户端认证请求
    def ReqAuthenticate(self, pReqAuthenticateField, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pReqAuthenticateField)
            with nogil:
                result = self._api.ReqAuthenticate(<CThostFtdcReqAuthenticateField*> address, nRequestID)
            return result

    # 用户登录请求
    def ReqUserLogin(self, pReqUserLoginField, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pReqUserLoginField)
            with nogil:
                result = self._api.ReqUserLogin(<CThostFtdcReqUserLoginField*> address, nRequestID)
            return result

    # 登出请求
    def ReqUserLogout(self, pUserLogout, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pUserLogout)
            with nogil:
                result = self._api.ReqUserLogout(<CThostFtdcUserLogoutField*> address, nRequestID)
            return result

    # 用户口令更新请求
    def ReqUserPasswordUpdate(self, pUserPasswordUpdate, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pUserPasswordUpdate)
            with nogil:
                result = self._api.ReqUserPasswordUpdate(<CThostFtdcUserPasswordUpdateField*> address, nRequestID)
            return result

    # 资金账户口令更新请求
    def ReqTradingAccountPasswordUpdate(self, pTradingAccountPasswordUpdate, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pTradingAccountPasswordUpdate)
            with nogil:
                result = self._api.ReqTradingAccountPasswordUpdate(
                    <CThostFtdcTradingAccountPasswordUpdateField*> address, nRequestID)
            return result

    # 登录请求2
    def ReqUserLogin2(self, pReqUserLogin, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pReqUserLogin)
            with nogil:
                result = self._api.ReqUserLogin2(<CThostFtdcReqUserLoginField*> address, nRequestID)
            return result

    # 用户口令更新请求2
    def ReqUserPasswordUpdate2(self, pUserPasswordUpdate, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pUserPasswordUpdate)
            with nogil:
                result = self._api.ReqUserPasswordUpdate2(<CThostFtdcUserPasswordUpdateField*> address, nRequestID)
            return result

    # 报单录入请求
    def ReqOrderInsert(self, pInputOrder, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pInputOrder)
            with nogil:
                result = self._api.ReqOrderInsert(<CThostFtdcInputOrderField*> address, nRequestID)
            return result

    # 预埋单录入请求
    def ReqParkedOrderInsert(self, pParkedOrder, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pParkedOrder)
            with nogil:
                result = self._api.ReqParkedOrderInsert(<CThostFtdcParkedOrderField*> address, nRequestID)
            return result

    # 预埋撤单录入请求
    def ReqParkedOrderAction(self, pParkedOrderAction, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pParkedOrderAction)
            with nogil:
                result = self._api.ReqParkedOrderAction(<CThostFtdcParkedOrderActionField*> address, nRequestID)
            return result

    # 报单操作请求
    def ReqOrderAction(self, pInputOrderAction, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pInputOrderAction)
            with nogil:
                result = self._api.ReqOrderAction(<CThostFtdcInputOrderActionField*> address, nRequestID)
            return result

    # 查询最大报单数量请求
    def ReqQueryMaxOrderVolume(self, pQueryMaxOrderVolume, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQueryMaxOrderVolume)
            with nogil:
                result = self._api.ReqQueryMaxOrderVolume(<CThostFtdcQueryMaxOrderVolumeField*> address, nRequestID)
            return result

    # 投资者结算结果确认
    def ReqSettlementInfoConfirm(self, pSettlementInfoConfirm, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pSettlementInfoConfirm)
            with nogil:
                result = self._api.ReqSettlementInfoConfirm(<CThostFtdcSettlementInfoConfirmField*> address, nRequestID)
            return result

    # 请求删除预埋单
    def ReqRemoveParkedOrder(self, pRemoveParkedOrder, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pRemoveParkedOrder)
            with nogil:
                result = self._api.ReqRemoveParkedOrder(<CThostFtdcRemoveParkedOrderField*> address, nRequestID)
            return result

    # 请求删除预埋撤单
    def ReqRemoveParkedOrderAction(self, pRemoveParkedOrderAction, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pRemoveParkedOrderAction)
            with nogil:
                result = self._api.ReqRemoveParkedOrderAction(<CThostFtdcRemoveParkedOrderActionField*> address,
                                                              nRequestID)
            return result

    # 执行宣告录入请求
    def ReqExecOrderInsert(self, pInputExecOrder, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pInputExecOrder)
            with nogil:
                result = self._api.ReqExecOrderInsert(<CThostFtdcInputExecOrderField*> address, nRequestID)
            return result

    # 执行宣告操作请求
    def ReqExecOrderAction(self, pInputExecOrderAction, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pInputExecOrderAction)
            with nogil:
                result = self._api.ReqExecOrderAction(<CThostFtdcInputExecOrderActionField*> address, nRequestID)
            return result

    # 询价录入请求
    def ReqForQuoteInsert(self, pInputForQuote, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pInputForQuote)
            with nogil:
                result = self._api.ReqForQuoteInsert(<CThostFtdcInputForQuoteField*> address, nRequestID)
            return result

    # 报价录入请求
    def ReqQuoteInsert(self, pInputQuote, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pInputQuote)
            with nogil:
                result = self._api.ReqQuoteInsert(<CThostFtdcInputQuoteField*> address, nRequestID)
            return result

    # 报价操作请求
    def ReqQuoteAction(self, pInputQuoteAction, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pInputQuoteAction)
            with nogil:
                result = self._api.ReqQuoteAction(<CThostFtdcInputQuoteActionField*> address, nRequestID)
            return result

    # 批量报单操作请求
    def ReqBatchOrderAction(self, pInputBatchOrderAction, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pInputBatchOrderAction)
            with nogil:
                result = self._api.ReqBatchOrderAction(<CThostFtdcInputBatchOrderActionField*> address, nRequestID)
            return result

    # 期权自对冲录入请求
    def ReqOptionSelfCloseInsert(self, pInputOptionSelfClose, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pInputOptionSelfClose)
            with nogil:
                result = self._api.ReqOptionSelfCloseInsert(<CThostFtdcInputOptionSelfCloseField*> address, nRequestID)
            return result

    # 期权自对冲操作请求
    def ReqOptionSelfCloseAction(self, pInputOptionSelfCloseAction, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pInputOptionSelfCloseAction)
            with nogil:
                result = self._api.ReqOptionSelfCloseAction(<CThostFtdcInputOptionSelfCloseActionField*> address,
                                                            nRequestID)
            return result

    # 申请组合录入请求
    def ReqCombActionInsert(self, pInputCombAction, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pInputCombAction)
            with nogil:
                result = self._api.ReqCombActionInsert(<CThostFtdcInputCombActionField*> address, nRequestID)
            return result

    # 请求查询报单
    def ReqQryOrder(self, pQryOrder, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryOrder)
            with nogil:
                result = self._api.ReqQryOrder(<CThostFtdcQryOrderField*> address, nRequestID)
            return result

    # 请求查询成交
    def ReqQryTrade(self, pQryTrade, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryTrade)
            with nogil:
                result = self._api.ReqQryTrade(<CThostFtdcQryTradeField*> address, nRequestID)
            return result

    # 请求查询投资者持仓
    def ReqQryInvestorPosition(self, pQryInvestorPosition, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryInvestorPosition)
            with nogil:
                result = self._api.ReqQryInvestorPosition(<CThostFtdcQryInvestorPositionField*> address, nRequestID)
            return result

    # 请求查询资金账户
    def ReqQryTradingAccount(self, pQryTradingAccount, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryTradingAccount)
            with nogil:
                result = self._api.ReqQryTradingAccount(<CThostFtdcQryTradingAccountField*> address, nRequestID)
            return result

    # 请求查询投资者
    def ReqQryInvestor(self, pQryInvestor, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryInvestor)
            with nogil:
                result = self._api.ReqQryInvestor(<CThostFtdcQryInvestorField*> address, nRequestID)
            return result

    # 请求查询交易编码
    def ReqQryTradingCode(self, pQryTradingCode, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryTradingCode)
            with nogil:
                result = self._api.ReqQryTradingCode(<CThostFtdcQryTradingCodeField*> address, nRequestID)
            return result

    # 请求查询合约保证金率
    def ReqQryInstrumentMarginRate(self, pQryInstrumentMarginRate, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryInstrumentMarginRate)
            with nogil:
                result = self._api.ReqQryInstrumentMarginRate(<CThostFtdcQryInstrumentMarginRateField*> address,
                                                              nRequestID)
            return result

    # 请求查询合约手续费率
    def ReqQryInstrumentCommissionRate(self, pQryInstrumentCommissionRate, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryInstrumentCommissionRate)
            with nogil:
                result = self._api.ReqQryInstrumentCommissionRate(<CThostFtdcQryInstrumentCommissionRateField*> address,
                                                                  nRequestID)
            return result

    # 请求查询交易所
    def ReqQryExchange(self, pQryExchange, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryExchange)
            with nogil:
                result = self._api.ReqQryExchange(<CThostFtdcQryExchangeField*> address, nRequestID)
            return result

    # 请求查询产品
    def ReqQryProduct(self, pQryProduct, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryProduct)
            with nogil:
                result = self._api.ReqQryProduct(<CThostFtdcQryProductField*> address, nRequestID)
            return result

    # 请求查询合约
    def ReqQryInstrument(self, pQryInstrument, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryInstrument)
            with nogil:
                result = self._api.ReqQryInstrument(<CThostFtdcQryInstrumentField*> address, nRequestID)
            return result

    # 请求查询行情
    def ReqQryDepthMarketData(self, pQryDepthMarketData, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryDepthMarketData)
            with nogil:
                result = self._api.ReqQryDepthMarketData(<CThostFtdcQryDepthMarketDataField*> address, nRequestID)
            return result

    # 请求查询投资者结算结果
    def ReqQrySettlementInfo(self, pQrySettlementInfo, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQrySettlementInfo)
            with nogil:
                result = self._api.ReqQrySettlementInfo(<CThostFtdcQrySettlementInfoField*> address, nRequestID)
            return result

    # 请求查询转帐银行
    def ReqQryTransferBank(self, pQryTransferBank, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryTransferBank)
            with nogil:
                result = self._api.ReqQryTransferBank(<CThostFtdcQryTransferBankField*> address, nRequestID)
            return result

    # 请求查询投资者持仓明细
    def ReqQryInvestorPositionDetail(self, pQryInvestorPositionDetail, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryInvestorPositionDetail)
            with nogil:
                result = self._api.ReqQryInvestorPositionDetail(<CThostFtdcQryInvestorPositionDetailField*> address,
                                                                nRequestID)
            return result

    # 请求查询客户通知
    def ReqQryNotice(self, pQryNotice, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryNotice)
            with nogil:
                result = self._api.ReqQryNotice(<CThostFtdcQryNoticeField*> address, nRequestID)
            return result

    # 请求查询结算信息确认
    def ReqQrySettlementInfoConfirm(self, pQrySettlementInfoConfirm, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQrySettlementInfoConfirm)
            with nogil:
                result = self._api.ReqQrySettlementInfoConfirm(<CThostFtdcQrySettlementInfoConfirmField*> address,
                                                               nRequestID)
            return result

    # 请求查询投资者持仓明细
    def ReqQryInvestorPositionCombineDetail(self, pQryInvestorPositionCombineDetail, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryInvestorPositionCombineDetail)
            with nogil:
                result = self._api.ReqQryInvestorPositionCombineDetail(
                    <CThostFtdcQryInvestorPositionCombineDetailField*> address, nRequestID)
            return result

    # 请求查询保证金监管系统经纪公司资金账户密钥
    def ReqQryCFMMCTradingAccountKey(self, pQryCFMMCTradingAccountKey, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryCFMMCTradingAccountKey)
            with nogil:
                result = self._api.ReqQryCFMMCTradingAccountKey(<CThostFtdcQryCFMMCTradingAccountKeyField*> address,
                                                                nRequestID)
            return result

    # 请求查询仓单折抵信息
    def ReqQryEWarrantOffset(self, pQryEWarrantOffset, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryEWarrantOffset)
            with nogil:
                result = self._api.ReqQryEWarrantOffset(<CThostFtdcQryEWarrantOffsetField*> address, nRequestID)
            return result

    # 请求查询投资者品种/跨品种保证金
    def ReqQryInvestorProductGroupMargin(self, pQryInvestorProductGroupMargin, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryInvestorProductGroupMargin)
            with nogil:
                result = self._api.ReqQryInvestorProductGroupMargin(
                    <CThostFtdcQryInvestorProductGroupMarginField*> address, nRequestID)
            return result

    # 请求查询交易所保证金率
    def ReqQryExchangeMarginRate(self, pQryExchangeMarginRate, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryExchangeMarginRate)
            with nogil:
                result = self._api.ReqQryExchangeMarginRate(<CThostFtdcQryExchangeMarginRateField*> address, nRequestID)
            return result

    # 请求查询交易所调整保证金率
    def ReqQryExchangeMarginRateAdjust(self, pQryExchangeMarginRateAdjust, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryExchangeMarginRateAdjust)
            with nogil:
                result = self._api.ReqQryExchangeMarginRateAdjust(<CThostFtdcQryExchangeMarginRateAdjustField*> address,
                                                                  nRequestID)
            return result

    # 请求查询汇率
    def ReqQryExchangeRate(self, pQryExchangeRate, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryExchangeRate)
            with nogil:
                result = self._api.ReqQryExchangeRate(<CThostFtdcQryExchangeRateField*> address, nRequestID)
            return result

    # 请求查询二级代理操作员银期权限
    def ReqQrySecAgentACIDMap(self, pQrySecAgentACIDMap, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQrySecAgentACIDMap)
            with nogil:
                result = self._api.ReqQrySecAgentACIDMap(<CThostFtdcQrySecAgentACIDMapField*> address, nRequestID)
            return result

    # 请求查询产品报价汇率
    def ReqQryProductExchRate(self, pQryProductExchRate, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryProductExchRate)
            with nogil:
                result = self._api.ReqQryProductExchRate(<CThostFtdcQryProductExchRateField*> address, nRequestID)
            return result

    # 请求查询产品组
    def ReqQryProductGroup(self, pQryProductGroup, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryProductGroup)
            with nogil:
                result = self._api.ReqQryProductGroup(<CThostFtdcQryProductGroupField*> address, nRequestID)
            return result

    # 请求查询做市商合约手续费率
    def ReqQryMMInstrumentCommissionRate(self, pQryMMInstrumentCommissionRate, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryMMInstrumentCommissionRate)
            with nogil:
                result = self._api.ReqQryMMInstrumentCommissionRate(
                    <CThostFtdcQryMMInstrumentCommissionRateField*> address, nRequestID)
            return result

    # 请求查询做市商期权合约手续费
    def ReqQryMMOptionInstrCommRate(self, pQryMMOptionInstrCommRate, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryMMOptionInstrCommRate)
            with nogil:
                result = self._api.ReqQryMMOptionInstrCommRate(<CThostFtdcQryMMOptionInstrCommRateField*> address,
                                                               nRequestID)
            return result

    # 请求查询报单手续费
    def ReqQryInstrumentOrderCommRate(self, pQryInstrumentOrderCommRate, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryInstrumentOrderCommRate)
            with nogil:
                result = self._api.ReqQryInstrumentOrderCommRate(<CThostFtdcQryInstrumentOrderCommRateField*> address,
                                                                 nRequestID)
            return result

    # 请求查询资金账户
    def ReqQrySecAgentTradingAccount(self, pQryTradingAccount, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryTradingAccount)
            with nogil:
                result = self._api.ReqQrySecAgentTradingAccount(<CThostFtdcQryTradingAccountField*> address, nRequestID)
            return result

    # 请求查询二级代理商资金校验模式
    def ReqQrySecAgentCheckMode(self, pQrySecAgentCheckMode, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQrySecAgentCheckMode)
            with nogil:
                result = self._api.ReqQrySecAgentCheckMode(<CThostFtdcQrySecAgentCheckModeField*> address, nRequestID)
            return result

    # 请求查询期权交易成本
    def ReqQryOptionInstrTradeCost(self, pQryOptionInstrTradeCost, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryOptionInstrTradeCost)
            with nogil:
                result = self._api.ReqQryOptionInstrTradeCost(<CThostFtdcQryOptionInstrTradeCostField*> address,
                                                              nRequestID)
            return result

    # 请求查询期权合约手续费
    def ReqQryOptionInstrCommRate(self, pQryOptionInstrCommRate, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryOptionInstrCommRate)
            with nogil:
                result = self._api.ReqQryOptionInstrCommRate(<CThostFtdcQryOptionInstrCommRateField*> address,
                                                             nRequestID)
            return result

    # 请求查询执行宣告
    def ReqQryExecOrder(self, pQryExecOrder, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryExecOrder)
            with nogil:
                result = self._api.ReqQryExecOrder(<CThostFtdcQryExecOrderField*> address, nRequestID)
            return result

    # 请求查询询价
    def ReqQryForQuote(self, pQryForQuote, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryForQuote)
            with nogil:
                result = self._api.ReqQryForQuote(<CThostFtdcQryForQuoteField*> address, nRequestID)
            return result

    # 请求查询报价
    def ReqQryQuote(self, pQryQuote, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryQuote)
            with nogil:
                result = self._api.ReqQryQuote(<CThostFtdcQryQuoteField*> address, nRequestID)
            return result

    # 请求查询期权自对冲
    def ReqQryOptionSelfClose(self, pQryOptionSelfClose, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryOptionSelfClose)
            with nogil:
                result = self._api.ReqQryOptionSelfClose(<CThostFtdcQryOptionSelfCloseField*> address, nRequestID)
            return result

    # 请求查询投资单元
    def ReqQryInvestUnit(self, pQryInvestUnit, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryInvestUnit)
            with nogil:
                result = self._api.ReqQryInvestUnit(<CThostFtdcQryInvestUnitField*> address, nRequestID)
            return result

    # 请求查询组合合约安全系数
    def ReqQryCombInstrumentGuard(self, pQryCombInstrumentGuard, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryCombInstrumentGuard)
            with nogil:
                result = self._api.ReqQryCombInstrumentGuard(<CThostFtdcQryCombInstrumentGuardField*> address,
                                                             nRequestID)
            return result

    # 请求查询申请组合
    def ReqQryCombAction(self, pQryCombAction, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryCombAction)
            with nogil:
                result = self._api.ReqQryCombAction(<CThostFtdcQryCombActionField*> address, nRequestID)
            return result

    # 请求查询转帐流水
    def ReqQryTransferSerial(self, pQryTransferSerial, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryTransferSerial)
            with nogil:
                result = self._api.ReqQryTransferSerial(<CThostFtdcQryTransferSerialField*> address, nRequestID)
            return result

    # 请求查询银期签约关系
    def ReqQryAccountregister(self, pQryAccountregister, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryAccountregister)
            with nogil:
                result = self._api.ReqQryAccountregister(<CThostFtdcQryAccountregisterField*> address, nRequestID)
            return result

    # 请求查询签约银行
    def ReqQryContractBank(self, pQryContractBank, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryContractBank)
            with nogil:
                result = self._api.ReqQryContractBank(<CThostFtdcQryContractBankField*> address, nRequestID)
            return result

    # 请求查询预埋单
    def ReqQryParkedOrder(self, pQryParkedOrder, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryParkedOrder)
            with nogil:
                result = self._api.ReqQryParkedOrder(<CThostFtdcQryParkedOrderField*> address, nRequestID)
            return result

    # 请求查询预埋撤单
    def ReqQryParkedOrderAction(self, pQryParkedOrderAction, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryParkedOrderAction)
            with nogil:
                result = self._api.ReqQryParkedOrderAction(<CThostFtdcQryParkedOrderActionField*> address, nRequestID)
            return result

    # 请求查询交易通知
    def ReqQryTradingNotice(self, pQryTradingNotice, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryTradingNotice)
            with nogil:
                result = self._api.ReqQryTradingNotice(<CThostFtdcQryTradingNoticeField*> address, nRequestID)
            return result

    # 请求查询经纪公司交易参数
    def ReqQryBrokerTradingParams(self, pQryBrokerTradingParams, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryBrokerTradingParams)
            with nogil:
                result = self._api.ReqQryBrokerTradingParams(<CThostFtdcQryBrokerTradingParamsField*> address,
                                                             nRequestID)
            return result

    # 请求查询经纪公司交易算法
    def ReqQryBrokerTradingAlgos(self, pQryBrokerTradingAlgos, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQryBrokerTradingAlgos)
            with nogil:
                result = self._api.ReqQryBrokerTradingAlgos(<CThostFtdcQryBrokerTradingAlgosField*> address, nRequestID)
            return result

    # 请求查询监控中心用户令牌
    def ReqQueryCFMMCTradingAccountToken(self, pQueryCFMMCTradingAccountToken, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pQueryCFMMCTradingAccountToken)
            with nogil:
                result = self._api.ReqQueryCFMMCTradingAccountToken(
                    <CThostFtdcQueryCFMMCTradingAccountTokenField*> address, nRequestID)
            return result

    # 期货发起银行资金转期货请求
    def ReqFromBankToFutureByFuture(self, pReqTransfer, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pReqTransfer)
            with nogil:
                result = self._api.ReqFromBankToFutureByFuture(<CThostFtdcReqTransferField*> address, nRequestID)
            return result

    # 期货发起期货资金转银行请求
    def ReqFromFutureToBankByFuture(self, pReqTransfer, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pReqTransfer)
            with nogil:
                result = self._api.ReqFromFutureToBankByFuture(<CThostFtdcReqTransferField*> address, nRequestID)
            return result

    # 期货发起查询银行余额请求
    def ReqQueryBankAccountMoneyByFuture(self, pReqQueryAccount, int nRequestID):
        cdef int result
        cdef size_t address
        if self._api is not NULL:
            address = ctypes.addressof(pReqQueryAccount)
            with nogil:
                result = self._api.ReqQueryBankAccountMoneyByFuture(<CThostFtdcReqQueryAccountField*> address,
                                                                    nRequestID)
            return result

# callbacks
cdef extern int TraderSpi_OnFrontConnected(self) except -1:
    self.OnFrontConnected()
    return 0

cdef extern int TraderSpi_OnFrontDisconnected(self, int nReason) except -1:
    self.OnFrontDisconnected(nReason)
    return 0

cdef extern int TraderSpi_OnHeartBeatWarning(self, int nTimeLapse) except -1:
    self.OnHeartBeatWarning(nTimeLapse)
    return 0

cdef extern int TraderSpi_OnRspAuthenticate(self, CThostFtdcRspAuthenticateField *pRspAuthenticateField,
                                            CThostFtdcRspInfoField *pRspInfo, int nRequestID, cbool bIsLast) except -1:
    self.OnRspAuthenticate(
        None if pRspAuthenticateField is NULL else pyStruct.RspAuthenticateField.from_address(
            <size_t> pRspAuthenticateField),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspUserLogin(self, CThostFtdcRspUserLoginField *pRspUserLogin,
                                         CThostFtdcRspInfoField *pRspInfo, int nRequestID, cbool bIsLast) except -1:
    self.OnRspUserLogin(
        None if pRspUserLogin is NULL else pyStruct.RspUserLoginField.from_address(<size_t> pRspUserLogin),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspUserLogout(self, CThostFtdcUserLogoutField *pUserLogout,
                                          CThostFtdcRspInfoField *pRspInfo, int nRequestID, cbool bIsLast) except -1:
    self.OnRspUserLogout(
        None if pUserLogout is NULL else pyStruct.UserLogoutField.from_address(<size_t> pUserLogout),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspUserPasswordUpdate(self, CThostFtdcUserPasswordUpdateField *pUserPasswordUpdate,
                                                  CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                  cbool bIsLast) except -1:
    self.OnRspUserPasswordUpdate(
        None if pUserPasswordUpdate is NULL else pyStruct.UserPasswordUpdateField.from_address(
            <size_t> pUserPasswordUpdate),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspTradingAccountPasswordUpdate(self,
                                                            CThostFtdcTradingAccountPasswordUpdateField *pTradingAccountPasswordUpdate,
                                                            CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                            cbool bIsLast) except -1:
    self.OnRspTradingAccountPasswordUpdate(
        None if pTradingAccountPasswordUpdate is NULL else pyStruct.TradingAccountPasswordUpdateField.from_address(
            <size_t> pTradingAccountPasswordUpdate),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspOrderInsert(self, CThostFtdcInputOrderField *pInputOrder,
                                           CThostFtdcRspInfoField *pRspInfo, int nRequestID, cbool bIsLast) except -1:
    self.OnRspOrderInsert(
        None if pInputOrder is NULL else pyStruct.InputOrderField.from_address(<size_t> pInputOrder),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspParkedOrderInsert(self, CThostFtdcParkedOrderField *pParkedOrder,
                                                 CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                 cbool bIsLast) except -1:
    self.OnRspParkedOrderInsert(
        None if pParkedOrder is NULL else pyStruct.ParkedOrderField.from_address(<size_t> pParkedOrder),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspParkedOrderAction(self, CThostFtdcParkedOrderActionField *pParkedOrderAction,
                                                 CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                 cbool bIsLast) except -1:
    self.OnRspParkedOrderAction(
        None if pParkedOrderAction is NULL else pyStruct.ParkedOrderActionField.from_address(
            <size_t> pParkedOrderAction),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspOrderAction(self, CThostFtdcInputOrderActionField *pInputOrderAction,
                                           CThostFtdcRspInfoField *pRspInfo, int nRequestID, cbool bIsLast) except -1:
    self.OnRspOrderAction(
        None if pInputOrderAction is NULL else pyStruct.InputOrderActionField.from_address(<size_t> pInputOrderAction),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQueryMaxOrderVolume(self, CThostFtdcQueryMaxOrderVolumeField *pQueryMaxOrderVolume,
                                                   CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                   cbool bIsLast) except -1:
    self.OnRspQueryMaxOrderVolume(
        None if pQueryMaxOrderVolume is NULL else pyStruct.QueryMaxOrderVolumeField.from_address(
            <size_t> pQueryMaxOrderVolume),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspSettlementInfoConfirm(self, CThostFtdcSettlementInfoConfirmField *pSettlementInfoConfirm,
                                                     CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                     cbool bIsLast) except -1:
    self.OnRspSettlementInfoConfirm(
        None if pSettlementInfoConfirm is NULL else pyStruct.SettlementInfoConfirmField.from_address(
            <size_t> pSettlementInfoConfirm),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspRemoveParkedOrder(self, CThostFtdcRemoveParkedOrderField *pRemoveParkedOrder,
                                                 CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                 cbool bIsLast) except -1:
    self.OnRspRemoveParkedOrder(
        None if pRemoveParkedOrder is NULL else pyStruct.RemoveParkedOrderField.from_address(
            <size_t> pRemoveParkedOrder),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspRemoveParkedOrderAction(self,
                                                       CThostFtdcRemoveParkedOrderActionField *pRemoveParkedOrderAction,
                                                       CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                       cbool bIsLast) except -1:
    self.OnRspRemoveParkedOrderAction(
        None if pRemoveParkedOrderAction is NULL else pyStruct.RemoveParkedOrderActionField.from_address(
            <size_t> pRemoveParkedOrderAction),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspExecOrderInsert(self, CThostFtdcInputExecOrderField *pInputExecOrder,
                                               CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                               cbool bIsLast) except -1:
    self.OnRspExecOrderInsert(
        None if pInputExecOrder is NULL else pyStruct.InputExecOrderField.from_address(<size_t> pInputExecOrder),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspExecOrderAction(self, CThostFtdcInputExecOrderActionField *pInputExecOrderAction,
                                               CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                               cbool bIsLast) except -1:
    self.OnRspExecOrderAction(
        None if pInputExecOrderAction is NULL else pyStruct.InputExecOrderActionField.from_address(
            <size_t> pInputExecOrderAction),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspForQuoteInsert(self, CThostFtdcInputForQuoteField *pInputForQuote,
                                              CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                              cbool bIsLast) except -1:
    self.OnRspForQuoteInsert(
        None if pInputForQuote is NULL else pyStruct.InputForQuoteField.from_address(<size_t> pInputForQuote),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQuoteInsert(self, CThostFtdcInputQuoteField *pInputQuote,
                                           CThostFtdcRspInfoField *pRspInfo, int nRequestID, cbool bIsLast) except -1:
    self.OnRspQuoteInsert(
        None if pInputQuote is NULL else pyStruct.InputQuoteField.from_address(<size_t> pInputQuote),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQuoteAction(self, CThostFtdcInputQuoteActionField *pInputQuoteAction,
                                           CThostFtdcRspInfoField *pRspInfo, int nRequestID, cbool bIsLast) except -1:
    self.OnRspQuoteAction(
        None if pInputQuoteAction is NULL else pyStruct.InputQuoteActionField.from_address(<size_t> pInputQuoteAction),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspBatchOrderAction(self, CThostFtdcInputBatchOrderActionField *pInputBatchOrderAction,
                                                CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                cbool bIsLast) except -1:
    self.OnRspBatchOrderAction(
        None if pInputBatchOrderAction is NULL else pyStruct.InputBatchOrderActionField.from_address(
            <size_t> pInputBatchOrderAction),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspOptionSelfCloseInsert(self, CThostFtdcInputOptionSelfCloseField *pInputOptionSelfClose,
                                                     CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                     cbool bIsLast) except -1:
    self.OnRspOptionSelfCloseInsert(
        None if pInputOptionSelfClose is NULL else pyStruct.InputOptionSelfCloseField.from_address(
            <size_t> pInputOptionSelfClose),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspOptionSelfCloseAction(self,
                                                     CThostFtdcInputOptionSelfCloseActionField *pInputOptionSelfCloseAction,
                                                     CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                     cbool bIsLast) except -1:
    self.OnRspOptionSelfCloseAction(
        None if pInputOptionSelfCloseAction is NULL else pyStruct.InputOptionSelfCloseActionField.from_address(
            <size_t> pInputOptionSelfCloseAction),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspCombActionInsert(self, CThostFtdcInputCombActionField *pInputCombAction,
                                                CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                cbool bIsLast) except -1:
    self.OnRspCombActionInsert(
        None if pInputCombAction is NULL else pyStruct.InputCombActionField.from_address(<size_t> pInputCombAction),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryOrder(self, CThostFtdcOrderField *pOrder, CThostFtdcRspInfoField *pRspInfo,
                                        int nRequestID, cbool bIsLast) except -1:
    self.OnRspQryOrder(
        None if pOrder is NULL else pyStruct.OrderField.from_address(<size_t> pOrder),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryTrade(self, CThostFtdcTradeField *pTrade, CThostFtdcRspInfoField *pRspInfo,
                                        int nRequestID, cbool bIsLast) except -1:
    self.OnRspQryTrade(
        None if pTrade is NULL else pyStruct.TradeField.from_address(<size_t> pTrade),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryInvestorPosition(self, CThostFtdcInvestorPositionField *pInvestorPosition,
                                                   CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                   cbool bIsLast) except -1:
    self.OnRspQryInvestorPosition(
        None if pInvestorPosition is NULL else pyStruct.InvestorPositionField.from_address(<size_t> pInvestorPosition),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryTradingAccount(self, CThostFtdcTradingAccountField *pTradingAccount,
                                                 CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                 cbool bIsLast) except -1:
    self.OnRspQryTradingAccount(
        None if pTradingAccount is NULL else pyStruct.TradingAccountField.from_address(<size_t> pTradingAccount),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryInvestor(self, CThostFtdcInvestorField *pInvestor, CThostFtdcRspInfoField *pRspInfo,
                                           int nRequestID, cbool bIsLast) except -1:
    self.OnRspQryInvestor(
        None if pInvestor is NULL else pyStruct.InvestorField.from_address(<size_t> pInvestor),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryTradingCode(self, CThostFtdcTradingCodeField *pTradingCode,
                                              CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                              cbool bIsLast) except -1:
    self.OnRspQryTradingCode(
        None if pTradingCode is NULL else pyStruct.TradingCodeField.from_address(<size_t> pTradingCode),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryInstrumentMarginRate(self, CThostFtdcInstrumentMarginRateField *pInstrumentMarginRate,
                                                       CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                       cbool bIsLast) except -1:
    self.OnRspQryInstrumentMarginRate(
        None if pInstrumentMarginRate is NULL else pyStruct.InstrumentMarginRateField.from_address(
            <size_t> pInstrumentMarginRate),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryInstrumentCommissionRate(self,
                                                           CThostFtdcInstrumentCommissionRateField *pInstrumentCommissionRate,
                                                           CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                           cbool bIsLast) except -1:
    self.OnRspQryInstrumentCommissionRate(
        None if pInstrumentCommissionRate is NULL else pyStruct.InstrumentCommissionRateField.from_address(
            <size_t> pInstrumentCommissionRate),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryExchange(self, CThostFtdcExchangeField *pExchange, CThostFtdcRspInfoField *pRspInfo,
                                           int nRequestID, cbool bIsLast) except -1:
    self.OnRspQryExchange(
        None if pExchange is NULL else pyStruct.ExchangeField.from_address(<size_t> pExchange),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryProduct(self, CThostFtdcProductField *pProduct, CThostFtdcRspInfoField *pRspInfo,
                                          int nRequestID, cbool bIsLast) except -1:
    self.OnRspQryProduct(
        None if pProduct is NULL else pyStruct.ProductField.from_address(<size_t> pProduct),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryInstrument(self, CThostFtdcInstrumentField *pInstrument,
                                             CThostFtdcRspInfoField *pRspInfo, int nRequestID, cbool bIsLast) except -1:
    self.OnRspQryInstrument(
        None if pInstrument is NULL else pyStruct.InstrumentField.from_address(<size_t> pInstrument),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryDepthMarketData(self, CThostFtdcDepthMarketDataField *pDepthMarketData,
                                                  CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                  cbool bIsLast) except -1:
    self.OnRspQryDepthMarketData(
        None if pDepthMarketData is NULL else pyStruct.DepthMarketDataField.from_address(<size_t> pDepthMarketData),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQrySettlementInfo(self, CThostFtdcSettlementInfoField *pSettlementInfo,
                                                 CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                 cbool bIsLast) except -1:
    self.OnRspQrySettlementInfo(
        None if pSettlementInfo is NULL else pyStruct.SettlementInfoField.from_address(<size_t> pSettlementInfo),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryTransferBank(self, CThostFtdcTransferBankField *pTransferBank,
                                               CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                               cbool bIsLast) except -1:
    self.OnRspQryTransferBank(
        None if pTransferBank is NULL else pyStruct.TransferBankField.from_address(<size_t> pTransferBank),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryInvestorPositionDetail(self,
                                                         CThostFtdcInvestorPositionDetailField *pInvestorPositionDetail,
                                                         CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                         cbool bIsLast) except -1:
    self.OnRspQryInvestorPositionDetail(
        None if pInvestorPositionDetail is NULL else pyStruct.InvestorPositionDetailField.from_address(
            <size_t> pInvestorPositionDetail),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryNotice(self, CThostFtdcNoticeField *pNotice, CThostFtdcRspInfoField *pRspInfo,
                                         int nRequestID, cbool bIsLast) except -1:
    self.OnRspQryNotice(
        None if pNotice is NULL else pyStruct.NoticeField.from_address(<size_t> pNotice),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQrySettlementInfoConfirm(self,
                                                        CThostFtdcSettlementInfoConfirmField *pSettlementInfoConfirm,
                                                        CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                        cbool bIsLast) except -1:
    self.OnRspQrySettlementInfoConfirm(
        None if pSettlementInfoConfirm is NULL else pyStruct.SettlementInfoConfirmField.from_address(
            <size_t> pSettlementInfoConfirm),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryInvestorPositionCombineDetail(self,
                                                                CThostFtdcInvestorPositionCombineDetailField *pInvestorPositionCombineDetail,
                                                                CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                                cbool bIsLast) except -1:
    self.OnRspQryInvestorPositionCombineDetail(
        None if pInvestorPositionCombineDetail is NULL else pyStruct.InvestorPositionCombineDetailField.from_address(
            <size_t> pInvestorPositionCombineDetail),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryCFMMCTradingAccountKey(self,
                                                         CThostFtdcCFMMCTradingAccountKeyField *pCFMMCTradingAccountKey,
                                                         CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                         cbool bIsLast) except -1:
    self.OnRspQryCFMMCTradingAccountKey(
        None if pCFMMCTradingAccountKey is NULL else pyStruct.CFMMCTradingAccountKeyField.from_address(
            <size_t> pCFMMCTradingAccountKey),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryEWarrantOffset(self, CThostFtdcEWarrantOffsetField *pEWarrantOffset,
                                                 CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                 cbool bIsLast) except -1:
    self.OnRspQryEWarrantOffset(
        None if pEWarrantOffset is NULL else pyStruct.EWarrantOffsetField.from_address(<size_t> pEWarrantOffset),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryInvestorProductGroupMargin(self,
                                                             CThostFtdcInvestorProductGroupMarginField *pInvestorProductGroupMargin,
                                                             CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                             cbool bIsLast) except -1:
    self.OnRspQryInvestorProductGroupMargin(
        None if pInvestorProductGroupMargin is NULL else pyStruct.InvestorProductGroupMarginField.from_address(
            <size_t> pInvestorProductGroupMargin),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryExchangeMarginRate(self, CThostFtdcExchangeMarginRateField *pExchangeMarginRate,
                                                     CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                     cbool bIsLast) except -1:
    self.OnRspQryExchangeMarginRate(
        None if pExchangeMarginRate is NULL else pyStruct.ExchangeMarginRateField.from_address(
            <size_t> pExchangeMarginRate),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryExchangeMarginRateAdjust(self,
                                                           CThostFtdcExchangeMarginRateAdjustField *pExchangeMarginRateAdjust,
                                                           CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                           cbool bIsLast) except -1:
    self.OnRspQryExchangeMarginRateAdjust(
        None if pExchangeMarginRateAdjust is NULL else pyStruct.ExchangeMarginRateAdjustField.from_address(
            <size_t> pExchangeMarginRateAdjust),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryExchangeRate(self, CThostFtdcExchangeRateField *pExchangeRate,
                                               CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                               cbool bIsLast) except -1:
    self.OnRspQryExchangeRate(
        None if pExchangeRate is NULL else pyStruct.ExchangeRateField.from_address(<size_t> pExchangeRate),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQrySecAgentACIDMap(self, CThostFtdcSecAgentACIDMapField *pSecAgentACIDMap,
                                                  CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                  cbool bIsLast) except -1:
    self.OnRspQrySecAgentACIDMap(
        None if pSecAgentACIDMap is NULL else pyStruct.SecAgentACIDMapField.from_address(<size_t> pSecAgentACIDMap),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryProductExchRate(self, CThostFtdcProductExchRateField *pProductExchRate,
                                                  CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                  cbool bIsLast) except -1:
    self.OnRspQryProductExchRate(
        None if pProductExchRate is NULL else pyStruct.ProductExchRateField.from_address(<size_t> pProductExchRate),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryProductGroup(self, CThostFtdcProductGroupField *pProductGroup,
                                               CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                               cbool bIsLast) except -1:
    self.OnRspQryProductGroup(
        None if pProductGroup is NULL else pyStruct.ProductGroupField.from_address(<size_t> pProductGroup),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryMMInstrumentCommissionRate(self,
                                                             CThostFtdcMMInstrumentCommissionRateField *pMMInstrumentCommissionRate,
                                                             CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                             cbool bIsLast) except -1:
    self.OnRspQryMMInstrumentCommissionRate(
        None if pMMInstrumentCommissionRate is NULL else pyStruct.MMInstrumentCommissionRateField.from_address(
            <size_t> pMMInstrumentCommissionRate),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryMMOptionInstrCommRate(self,
                                                        CThostFtdcMMOptionInstrCommRateField *pMMOptionInstrCommRate,
                                                        CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                        cbool bIsLast) except -1:
    self.OnRspQryMMOptionInstrCommRate(
        None if pMMOptionInstrCommRate is NULL else pyStruct.MMOptionInstrCommRateField.from_address(
            <size_t> pMMOptionInstrCommRate),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryInstrumentOrderCommRate(self,
                                                          CThostFtdcInstrumentOrderCommRateField *pInstrumentOrderCommRate,
                                                          CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                          cbool bIsLast) except -1:
    self.OnRspQryInstrumentOrderCommRate(
        None if pInstrumentOrderCommRate is NULL else pyStruct.InstrumentOrderCommRateField.from_address(
            <size_t> pInstrumentOrderCommRate),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQrySecAgentTradingAccount(self, CThostFtdcTradingAccountField *pTradingAccount,
                                                         CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                         cbool bIsLast) except -1:
    self.OnRspQrySecAgentTradingAccount(
        None if pTradingAccount is NULL else pyStruct.TradingAccountField.from_address(<size_t> pTradingAccount),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQrySecAgentCheckMode(self, CThostFtdcSecAgentCheckModeField *pSecAgentCheckMode,
                                                    CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                    cbool bIsLast) except -1:
    self.OnRspQrySecAgentCheckMode(
        None if pSecAgentCheckMode is NULL else pyStruct.SecAgentCheckModeField.from_address(
            <size_t> pSecAgentCheckMode),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryOptionInstrTradeCost(self, CThostFtdcOptionInstrTradeCostField *pOptionInstrTradeCost,
                                                       CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                       cbool bIsLast) except -1:
    self.OnRspQryOptionInstrTradeCost(
        None if pOptionInstrTradeCost is NULL else pyStruct.OptionInstrTradeCostField.from_address(
            <size_t> pOptionInstrTradeCost),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryOptionInstrCommRate(self, CThostFtdcOptionInstrCommRateField *pOptionInstrCommRate,
                                                      CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                      cbool bIsLast) except -1:
    self.OnRspQryOptionInstrCommRate(
        None if pOptionInstrCommRate is NULL else pyStruct.OptionInstrCommRateField.from_address(
            <size_t> pOptionInstrCommRate),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryExecOrder(self, CThostFtdcExecOrderField *pExecOrder,
                                            CThostFtdcRspInfoField *pRspInfo, int nRequestID, cbool bIsLast) except -1:
    self.OnRspQryExecOrder(
        None if pExecOrder is NULL else pyStruct.ExecOrderField.from_address(<size_t> pExecOrder),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryForQuote(self, CThostFtdcForQuoteField *pForQuote, CThostFtdcRspInfoField *pRspInfo,
                                           int nRequestID, cbool bIsLast) except -1:
    self.OnRspQryForQuote(
        None if pForQuote is NULL else pyStruct.ForQuoteField.from_address(<size_t> pForQuote),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryQuote(self, CThostFtdcQuoteField *pQuote, CThostFtdcRspInfoField *pRspInfo,
                                        int nRequestID, cbool bIsLast) except -1:
    self.OnRspQryQuote(
        None if pQuote is NULL else pyStruct.QuoteField.from_address(<size_t> pQuote),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryOptionSelfClose(self, CThostFtdcOptionSelfCloseField *pOptionSelfClose,
                                                  CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                  cbool bIsLast) except -1:
    self.OnRspQryOptionSelfClose(
        None if pOptionSelfClose is NULL else pyStruct.OptionSelfCloseField.from_address(<size_t> pOptionSelfClose),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryInvestUnit(self, CThostFtdcInvestUnitField *pInvestUnit,
                                             CThostFtdcRspInfoField *pRspInfo, int nRequestID, cbool bIsLast) except -1:
    self.OnRspQryInvestUnit(
        None if pInvestUnit is NULL else pyStruct.InvestUnitField.from_address(<size_t> pInvestUnit),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryCombInstrumentGuard(self, CThostFtdcCombInstrumentGuardField *pCombInstrumentGuard,
                                                      CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                      cbool bIsLast) except -1:
    self.OnRspQryCombInstrumentGuard(
        None if pCombInstrumentGuard is NULL else pyStruct.CombInstrumentGuardField.from_address(
            <size_t> pCombInstrumentGuard),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryCombAction(self, CThostFtdcCombActionField *pCombAction,
                                             CThostFtdcRspInfoField *pRspInfo, int nRequestID, cbool bIsLast) except -1:
    self.OnRspQryCombAction(
        None if pCombAction is NULL else pyStruct.CombActionField.from_address(<size_t> pCombAction),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryTransferSerial(self, CThostFtdcTransferSerialField *pTransferSerial,
                                                 CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                 cbool bIsLast) except -1:
    self.OnRspQryTransferSerial(
        None if pTransferSerial is NULL else pyStruct.TransferSerialField.from_address(<size_t> pTransferSerial),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryAccountregister(self, CThostFtdcAccountregisterField *pAccountregister,
                                                  CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                  cbool bIsLast) except -1:
    self.OnRspQryAccountregister(
        None if pAccountregister is NULL else pyStruct.AccountregisterField.from_address(<size_t> pAccountregister),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspError(self, CThostFtdcRspInfoField *pRspInfo, int nRequestID, cbool bIsLast) except -1:
    self.OnRspError(
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRtnOrder(self, CThostFtdcOrderField *pOrder) except -1:
    self.OnRtnOrder(
        None if pOrder is NULL else pyStruct.OrderField.from_address(<size_t> pOrder)
    )
    return 0

cdef extern int TraderSpi_OnRtnTrade(self, CThostFtdcTradeField *pTrade) except -1:
    self.OnRtnTrade(
        None if pTrade is NULL else pyStruct.TradeField.from_address(<size_t> pTrade)
    )
    return 0

cdef extern int TraderSpi_OnErrRtnOrderInsert(self, CThostFtdcInputOrderField *pInputOrder,
                                              CThostFtdcRspInfoField *pRspInfo) except -1:
    self.OnErrRtnOrderInsert(
        None if pInputOrder is NULL else pyStruct.InputOrderField.from_address(<size_t> pInputOrder),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo)
    )
    return 0

cdef extern int TraderSpi_OnErrRtnOrderAction(self, CThostFtdcOrderActionField *pOrderAction,
                                              CThostFtdcRspInfoField *pRspInfo) except -1:
    self.OnErrRtnOrderAction(
        None if pOrderAction is NULL else pyStruct.OrderActionField.from_address(<size_t> pOrderAction),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo)
    )
    return 0

cdef extern int TraderSpi_OnRtnInstrumentStatus(self, CThostFtdcInstrumentStatusField *pInstrumentStatus) except -1:
    self.OnRtnInstrumentStatus(
        None if pInstrumentStatus is NULL else pyStruct.InstrumentStatusField.from_address(<size_t> pInstrumentStatus)
    )
    return 0

cdef extern int TraderSpi_OnRtnBulletin(self, CThostFtdcBulletinField *pBulletin) except -1:
    self.OnRtnBulletin(
        None if pBulletin is NULL else pyStruct.BulletinField.from_address(<size_t> pBulletin)
    )
    return 0

cdef extern int TraderSpi_OnRtnTradingNotice(self, CThostFtdcTradingNoticeInfoField *pTradingNoticeInfo) except -1:
    self.OnRtnTradingNotice(
        None if pTradingNoticeInfo is NULL else pyStruct.TradingNoticeInfoField.from_address(
            <size_t> pTradingNoticeInfo)
    )
    return 0

cdef extern int TraderSpi_OnRtnErrorConditionalOrder(self,
                                                     CThostFtdcErrorConditionalOrderField *pErrorConditionalOrder) except -1:
    self.OnRtnErrorConditionalOrder(
        None if pErrorConditionalOrder is NULL else pyStruct.ErrorConditionalOrderField.from_address(
            <size_t> pErrorConditionalOrder)
    )
    return 0

cdef extern int TraderSpi_OnRtnExecOrder(self, CThostFtdcExecOrderField *pExecOrder) except -1:
    self.OnRtnExecOrder(
        None if pExecOrder is NULL else pyStruct.ExecOrderField.from_address(<size_t> pExecOrder)
    )
    return 0

cdef extern int TraderSpi_OnErrRtnExecOrderInsert(self, CThostFtdcInputExecOrderField *pInputExecOrder,
                                                  CThostFtdcRspInfoField *pRspInfo) except -1:
    self.OnErrRtnExecOrderInsert(
        None if pInputExecOrder is NULL else pyStruct.InputExecOrderField.from_address(<size_t> pInputExecOrder),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo)
    )
    return 0

cdef extern int TraderSpi_OnErrRtnExecOrderAction(self, CThostFtdcExecOrderActionField *pExecOrderAction,
                                                  CThostFtdcRspInfoField *pRspInfo) except -1:
    self.OnErrRtnExecOrderAction(
        None if pExecOrderAction is NULL else pyStruct.ExecOrderActionField.from_address(<size_t> pExecOrderAction),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo)
    )
    return 0

cdef extern int TraderSpi_OnErrRtnForQuoteInsert(self, CThostFtdcInputForQuoteField *pInputForQuote,
                                                 CThostFtdcRspInfoField *pRspInfo) except -1:
    self.OnErrRtnForQuoteInsert(
        None if pInputForQuote is NULL else pyStruct.InputForQuoteField.from_address(<size_t> pInputForQuote),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo)
    )
    return 0

cdef extern int TraderSpi_OnRtnQuote(self, CThostFtdcQuoteField *pQuote) except -1:
    self.OnRtnQuote(
        None if pQuote is NULL else pyStruct.QuoteField.from_address(<size_t> pQuote)
    )
    return 0

cdef extern int TraderSpi_OnErrRtnQuoteInsert(self, CThostFtdcInputQuoteField *pInputQuote,
                                              CThostFtdcRspInfoField *pRspInfo) except -1:
    self.OnErrRtnQuoteInsert(
        None if pInputQuote is NULL else pyStruct.InputQuoteField.from_address(<size_t> pInputQuote),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo)
    )
    return 0

cdef extern int TraderSpi_OnErrRtnQuoteAction(self, CThostFtdcQuoteActionField *pQuoteAction,
                                              CThostFtdcRspInfoField *pRspInfo) except -1:
    self.OnErrRtnQuoteAction(
        None if pQuoteAction is NULL else pyStruct.QuoteActionField.from_address(<size_t> pQuoteAction),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo)
    )
    return 0

cdef extern int TraderSpi_OnRtnForQuoteRsp(self, CThostFtdcForQuoteRspField *pForQuoteRsp) except -1:
    self.OnRtnForQuoteRsp(
        None if pForQuoteRsp is NULL else pyStruct.ForQuoteRspField.from_address(<size_t> pForQuoteRsp)
    )
    return 0

cdef extern int TraderSpi_OnRtnCFMMCTradingAccountToken(self,
                                                        CThostFtdcCFMMCTradingAccountTokenField *pCFMMCTradingAccountToken) except -1:
    self.OnRtnCFMMCTradingAccountToken(
        None if pCFMMCTradingAccountToken is NULL else pyStruct.CFMMCTradingAccountTokenField.from_address(
            <size_t> pCFMMCTradingAccountToken)
    )
    return 0

cdef extern int TraderSpi_OnErrRtnBatchOrderAction(self, CThostFtdcBatchOrderActionField *pBatchOrderAction,
                                                   CThostFtdcRspInfoField *pRspInfo) except -1:
    self.OnErrRtnBatchOrderAction(
        None if pBatchOrderAction is NULL else pyStruct.BatchOrderActionField.from_address(<size_t> pBatchOrderAction),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo)
    )
    return 0

cdef extern int TraderSpi_OnRtnOptionSelfClose(self, CThostFtdcOptionSelfCloseField *pOptionSelfClose) except -1:
    self.OnRtnOptionSelfClose(
        None if pOptionSelfClose is NULL else pyStruct.OptionSelfCloseField.from_address(<size_t> pOptionSelfClose)
    )
    return 0

cdef extern int TraderSpi_OnErrRtnOptionSelfCloseInsert(self,
                                                        CThostFtdcInputOptionSelfCloseField *pInputOptionSelfClose,
                                                        CThostFtdcRspInfoField *pRspInfo) except -1:
    self.OnErrRtnOptionSelfCloseInsert(
        None if pInputOptionSelfClose is NULL else pyStruct.InputOptionSelfCloseField.from_address(
            <size_t> pInputOptionSelfClose),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo)
    )
    return 0

cdef extern int TraderSpi_OnErrRtnOptionSelfCloseAction(self,
                                                        CThostFtdcOptionSelfCloseActionField *pOptionSelfCloseAction,
                                                        CThostFtdcRspInfoField *pRspInfo) except -1:
    self.OnErrRtnOptionSelfCloseAction(
        None if pOptionSelfCloseAction is NULL else pyStruct.OptionSelfCloseActionField.from_address(
            <size_t> pOptionSelfCloseAction),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo)
    )
    return 0

cdef extern int TraderSpi_OnRtnCombAction(self, CThostFtdcCombActionField *pCombAction) except -1:
    self.OnRtnCombAction(
        None if pCombAction is NULL else pyStruct.CombActionField.from_address(<size_t> pCombAction)
    )
    return 0

cdef extern int TraderSpi_OnErrRtnCombActionInsert(self, CThostFtdcInputCombActionField *pInputCombAction,
                                                   CThostFtdcRspInfoField *pRspInfo) except -1:
    self.OnErrRtnCombActionInsert(
        None if pInputCombAction is NULL else pyStruct.InputCombActionField.from_address(<size_t> pInputCombAction),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo)
    )
    return 0

cdef extern int TraderSpi_OnRspQryContractBank(self, CThostFtdcContractBankField *pContractBank,
                                               CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                               cbool bIsLast) except -1:
    self.OnRspQryContractBank(
        None if pContractBank is NULL else pyStruct.ContractBankField.from_address(<size_t> pContractBank),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryParkedOrder(self, CThostFtdcParkedOrderField *pParkedOrder,
                                              CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                              cbool bIsLast) except -1:
    self.OnRspQryParkedOrder(
        None if pParkedOrder is NULL else pyStruct.ParkedOrderField.from_address(<size_t> pParkedOrder),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryParkedOrderAction(self, CThostFtdcParkedOrderActionField *pParkedOrderAction,
                                                    CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                    cbool bIsLast) except -1:
    self.OnRspQryParkedOrderAction(
        None if pParkedOrderAction is NULL else pyStruct.ParkedOrderActionField.from_address(
            <size_t> pParkedOrderAction),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryTradingNotice(self, CThostFtdcTradingNoticeField *pTradingNotice,
                                                CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                cbool bIsLast) except -1:
    self.OnRspQryTradingNotice(
        None if pTradingNotice is NULL else pyStruct.TradingNoticeField.from_address(<size_t> pTradingNotice),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryBrokerTradingParams(self, CThostFtdcBrokerTradingParamsField *pBrokerTradingParams,
                                                      CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                      cbool bIsLast) except -1:
    self.OnRspQryBrokerTradingParams(
        None if pBrokerTradingParams is NULL else pyStruct.BrokerTradingParamsField.from_address(
            <size_t> pBrokerTradingParams),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQryBrokerTradingAlgos(self, CThostFtdcBrokerTradingAlgosField *pBrokerTradingAlgos,
                                                     CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                     cbool bIsLast) except -1:
    self.OnRspQryBrokerTradingAlgos(
        None if pBrokerTradingAlgos is NULL else pyStruct.BrokerTradingAlgosField.from_address(
            <size_t> pBrokerTradingAlgos),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQueryCFMMCTradingAccountToken(self,
                                                             CThostFtdcQueryCFMMCTradingAccountTokenField *pQueryCFMMCTradingAccountToken,
                                                             CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                             cbool bIsLast) except -1:
    self.OnRspQueryCFMMCTradingAccountToken(
        None if pQueryCFMMCTradingAccountToken is NULL else pyStruct.QueryCFMMCTradingAccountTokenField.from_address(
            <size_t> pQueryCFMMCTradingAccountToken),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRtnFromBankToFutureByBank(self, CThostFtdcRspTransferField *pRspTransfer) except -1:
    self.OnRtnFromBankToFutureByBank(
        None if pRspTransfer is NULL else pyStruct.RspTransferField.from_address(<size_t> pRspTransfer)
    )
    return 0

cdef extern int TraderSpi_OnRtnFromFutureToBankByBank(self, CThostFtdcRspTransferField *pRspTransfer) except -1:
    self.OnRtnFromFutureToBankByBank(
        None if pRspTransfer is NULL else pyStruct.RspTransferField.from_address(<size_t> pRspTransfer)
    )
    return 0

cdef extern int TraderSpi_OnRtnRepealFromBankToFutureByBank(self, CThostFtdcRspRepealField *pRspRepeal) except -1:
    self.OnRtnRepealFromBankToFutureByBank(
        None if pRspRepeal is NULL else pyStruct.RspRepealField.from_address(<size_t> pRspRepeal)
    )
    return 0

cdef extern int TraderSpi_OnRtnRepealFromFutureToBankByBank(self, CThostFtdcRspRepealField *pRspRepeal) except -1:
    self.OnRtnRepealFromFutureToBankByBank(
        None if pRspRepeal is NULL else pyStruct.RspRepealField.from_address(<size_t> pRspRepeal)
    )
    return 0

cdef extern int TraderSpi_OnRtnFromBankToFutureByFuture(self, CThostFtdcRspTransferField *pRspTransfer) except -1:
    self.OnRtnFromBankToFutureByFuture(
        None if pRspTransfer is NULL else pyStruct.RspTransferField.from_address(<size_t> pRspTransfer)
    )
    return 0

cdef extern int TraderSpi_OnRtnFromFutureToBankByFuture(self, CThostFtdcRspTransferField *pRspTransfer) except -1:
    self.OnRtnFromFutureToBankByFuture(
        None if pRspTransfer is NULL else pyStruct.RspTransferField.from_address(<size_t> pRspTransfer)
    )
    return 0

cdef extern int TraderSpi_OnRtnRepealFromBankToFutureByFutureManual(self,
                                                                    CThostFtdcRspRepealField *pRspRepeal) except -1:
    self.OnRtnRepealFromBankToFutureByFutureManual(
        None if pRspRepeal is NULL else pyStruct.RspRepealField.from_address(<size_t> pRspRepeal)
    )
    return 0

cdef extern int TraderSpi_OnRtnRepealFromFutureToBankByFutureManual(self,
                                                                    CThostFtdcRspRepealField *pRspRepeal) except -1:
    self.OnRtnRepealFromFutureToBankByFutureManual(
        None if pRspRepeal is NULL else pyStruct.RspRepealField.from_address(<size_t> pRspRepeal)
    )
    return 0

cdef extern int TraderSpi_OnRtnQueryBankBalanceByFuture(self,
                                                        CThostFtdcNotifyQueryAccountField *pNotifyQueryAccount) except -1:
    self.OnRtnQueryBankBalanceByFuture(
        None if pNotifyQueryAccount is NULL else pyStruct.NotifyQueryAccountField.from_address(
            <size_t> pNotifyQueryAccount)
    )
    return 0

cdef extern int TraderSpi_OnErrRtnBankToFutureByFuture(self, CThostFtdcReqTransferField *pReqTransfer,
                                                       CThostFtdcRspInfoField *pRspInfo) except -1:
    self.OnErrRtnBankToFutureByFuture(
        None if pReqTransfer is NULL else pyStruct.ReqTransferField.from_address(<size_t> pReqTransfer),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo)
    )
    return 0

cdef extern int TraderSpi_OnErrRtnFutureToBankByFuture(self, CThostFtdcReqTransferField *pReqTransfer,
                                                       CThostFtdcRspInfoField *pRspInfo) except -1:
    self.OnErrRtnFutureToBankByFuture(
        None if pReqTransfer is NULL else pyStruct.ReqTransferField.from_address(<size_t> pReqTransfer),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo)
    )
    return 0

cdef extern int TraderSpi_OnErrRtnRepealBankToFutureByFutureManual(self, CThostFtdcReqRepealField *pReqRepeal,
                                                                   CThostFtdcRspInfoField *pRspInfo) except -1:
    self.OnErrRtnRepealBankToFutureByFutureManual(
        None if pReqRepeal is NULL else pyStruct.ReqRepealField.from_address(<size_t> pReqRepeal),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo)
    )
    return 0

cdef extern int TraderSpi_OnErrRtnRepealFutureToBankByFutureManual(self, CThostFtdcReqRepealField *pReqRepeal,
                                                                   CThostFtdcRspInfoField *pRspInfo) except -1:
    self.OnErrRtnRepealFutureToBankByFutureManual(
        None if pReqRepeal is NULL else pyStruct.ReqRepealField.from_address(<size_t> pReqRepeal),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo)
    )
    return 0

cdef extern int TraderSpi_OnErrRtnQueryBankBalanceByFuture(self, CThostFtdcReqQueryAccountField *pReqQueryAccount,
                                                           CThostFtdcRspInfoField *pRspInfo) except -1:
    self.OnErrRtnQueryBankBalanceByFuture(
        None if pReqQueryAccount is NULL else pyStruct.ReqQueryAccountField.from_address(<size_t> pReqQueryAccount),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo)
    )
    return 0

cdef extern int TraderSpi_OnRtnRepealFromBankToFutureByFuture(self, CThostFtdcRspRepealField *pRspRepeal) except -1:
    self.OnRtnRepealFromBankToFutureByFuture(
        None if pRspRepeal is NULL else pyStruct.RspRepealField.from_address(<size_t> pRspRepeal)
    )
    return 0

cdef extern int TraderSpi_OnRtnRepealFromFutureToBankByFuture(self, CThostFtdcRspRepealField *pRspRepeal) except -1:
    self.OnRtnRepealFromFutureToBankByFuture(
        None if pRspRepeal is NULL else pyStruct.RspRepealField.from_address(<size_t> pRspRepeal)
    )
    return 0

cdef extern int TraderSpi_OnRspFromBankToFutureByFuture(self, CThostFtdcReqTransferField *pReqTransfer,
                                                        CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                        cbool bIsLast) except -1:
    self.OnRspFromBankToFutureByFuture(
        None if pReqTransfer is NULL else pyStruct.ReqTransferField.from_address(<size_t> pReqTransfer),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspFromFutureToBankByFuture(self, CThostFtdcReqTransferField *pReqTransfer,
                                                        CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                        cbool bIsLast) except -1:
    self.OnRspFromFutureToBankByFuture(
        None if pReqTransfer is NULL else pyStruct.ReqTransferField.from_address(<size_t> pReqTransfer),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRspQueryBankAccountMoneyByFuture(self, CThostFtdcReqQueryAccountField *pReqQueryAccount,
                                                             CThostFtdcRspInfoField *pRspInfo, int nRequestID,
                                                             cbool bIsLast) except -1:
    self.OnRspQueryBankAccountMoneyByFuture(
        None if pReqQueryAccount is NULL else pyStruct.ReqQueryAccountField.from_address(<size_t> pReqQueryAccount),
        None if pRspInfo is NULL else pyStruct.RspInfoField.from_address(<size_t> pRspInfo),
        nRequestID,
        bIsLast
    )
    return 0

cdef extern int TraderSpi_OnRtnOpenAccountByBank(self, CThostFtdcOpenAccountField *pOpenAccount) except -1:
    self.OnRtnOpenAccountByBank(
        None if pOpenAccount is NULL else pyStruct.OpenAccountField.from_address(<size_t> pOpenAccount)
    )
    return 0

cdef extern int TraderSpi_OnRtnCancelAccountByBank(self, CThostFtdcCancelAccountField *pCancelAccount) except -1:
    self.OnRtnCancelAccountByBank(
        None if pCancelAccount is NULL else pyStruct.CancelAccountField.from_address(<size_t> pCancelAccount)
    )
    return 0

cdef extern int TraderSpi_OnRtnChangeAccountByBank(self, CThostFtdcChangeAccountField *pChangeAccount) except -1:
    self.OnRtnChangeAccountByBank(
        None if pChangeAccount is NULL else pyStruct.ChangeAccountField.from_address(<size_t> pChangeAccount)
    )
    return 0
