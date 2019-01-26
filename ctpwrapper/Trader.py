# Interface exposed to users

from .TraderApi import TraderApiWrapper


class TraderApiPy(TraderApiWrapper):

    # 创建TraderApi
    # @param pszFlowPath 存贮订阅信息文件的目录，默认为当前目录
    # @return 创建出的UserApi
    def Create(self, pszFlowPath: str = ""):
        super().Create(pszFlowPath.encode())

    def Init(self):
        super().Init()

    def Join(self):
        return super().Join()

    # 获取API的版本信息
    # @retrun 获取到的版本号
    @staticmethod
    def GetApiVersion():
        return TraderApiWrapper.GetApiVersion().decode()

    def GetTradingDay(self):
        return super().GetTradingDay().decode()

    def RegisterFront(self, pszFrontAddress: str):
        super().RegisterFront(pszFrontAddress.encode())

    def RegisterNameServer(self, pszNsAddress: str):
        super().RegisterNameServer(pszNsAddress.encode())

    def RegisterFensUserInfo(self, pFensUserInfo):
        super().RegisterFensUserInfo(pFensUserInfo)

    # 订阅私有流。
    # nResumeType is an int # todo check Enum conversion
    # @param nResumeType 私有流重传方式
    #         THOST_TERT_RESTART (0):从本交易日开始重传
    #         THOST_TERT_RESUME (1):从上次收到的续传
    #         THOST_TERT_QUICK (2):只传送登录后私有流的内容
    # @remark 该方法要在Init方法前调用。若不调用则不会收到私有流的数据。
    def SubscribePrivateTopic(self, nResumeType: int):
        super().SubscribePrivateTopic(nResumeType)

    # 订阅公共流。
    # @param nResumeType 公共流重传方式
    # THOST_TERT_RESTART:从本交易日开始重传
    # THOST_TERT_RESUME:从上次收到的续传
    # THOST_TERT_QUICK:只传送登录后公共流的内容
    # @remark 该方法要在Init方法前调用。若不调用则不会收到公共流的数据。
    def SubscribePublicTopic(self, nResumeType: int):
        super().SubscribePublicTopic(nResumeType)

    # 客户端认证请求

    def ReqAuthenticate(self, pReqAuthenticateField, nRequestID: int):
        return super().ReqAuthenticate(pReqAuthenticateField, nRequestID)

    # 用户登录请求

    def ReqUserLogin(self, pReqUserLoginField, nRequestID: int):
        return super().ReqUserLogin(pReqUserLoginField, nRequestID)

    # 登出请求

    def ReqUserLogout(self, pUserLogout, nRequestID: int):
        return super().ReqUserLogout(pUserLogout, nRequestID)

    # 用户口令更新请求

    def ReqUserPasswordUpdate(self, pUserPasswordUpdate, nRequestID: int):
        return super().ReqUserPasswordUpdate(pUserPasswordUpdate, nRequestID)

    # 资金账户口令更新请求

    def ReqTradingAccountPasswordUpdate(self, pTradingAccountPasswordUpdate, nRequestID: int):
        return super().ReqTradingAccountPasswordUpdate(pTradingAccountPasswordUpdate, nRequestID)

    # 登录请求2

    def ReqUserLogin2(self, pReqUserLogin, nRequestID: int):
        return super().ReqUserLogin2(pReqUserLogin, nRequestID)

    # 用户口令更新请求2

    def ReqUserPasswordUpdate2(self, pUserPasswordUpdate, nRequestID: int):
        return super().ReqUserPasswordUpdate2(pUserPasswordUpdate, nRequestID)

    # 报单录入请求

    def ReqOrderInsert(self, pInputOrder, nRequestID: int):
        return super().ReqOrderInsert(pInputOrder, nRequestID)

    # 预埋单录入请求

    def ReqParkedOrderInsert(self, pParkedOrder, nRequestID: int):
        return super().ReqParkedOrderInsert(pParkedOrder, nRequestID)

    # 预埋撤单录入请求

    def ReqParkedOrderAction(self, pParkedOrderAction, nRequestID: int):
        return super().ReqParkedOrderAction(pParkedOrderAction, nRequestID)

    # 报单操作请求

    def ReqOrderAction(self, pInputOrderAction, nRequestID: int):
        return super().ReqOrderAction(pInputOrderAction, nRequestID)

    # 查询最大报单数量请求

    def ReqQueryMaxOrderVolume(self, pQueryMaxOrderVolume, nRequestID: int):
        return super().ReqQueryMaxOrderVolume(pQueryMaxOrderVolume, nRequestID)

    # 投资者结算结果确认

    def ReqSettlementInfoConfirm(self, pSettlementInfoConfirm, nRequestID: int):
        return super().ReqSettlementInfoConfirm(pSettlementInfoConfirm, nRequestID)

    # 请求删除预埋单

    def ReqRemoveParkedOrder(self, pRemoveParkedOrder, nRequestID: int):
        return super().ReqRemoveParkedOrder(pRemoveParkedOrder, nRequestID)

    # 请求删除预埋撤单

    def ReqRemoveParkedOrderAction(self, pRemoveParkedOrderAction, nRequestID: int):
        return super().ReqRemoveParkedOrderAction(pRemoveParkedOrderAction, nRequestID)

    # 执行宣告录入请求

    def ReqExecOrderInsert(self, pInputExecOrder, nRequestID: int):
        return super().ReqExecOrderInsert(pInputExecOrder, nRequestID)

    # 执行宣告操作请求

    def ReqExecOrderAction(self, pInputExecOrderAction, nRequestID: int):
        return super().ReqExecOrderAction(pInputExecOrderAction, nRequestID)

    # 询价录入请求

    def ReqForQuoteInsert(self, pInputForQuote, nRequestID: int):
        return super().ReqForQuoteInsert(pInputForQuote, nRequestID)

    # 报价录入请求

    def ReqQuoteInsert(self, pInputQuote, nRequestID: int):
        return super().ReqQuoteInsert(pInputQuote, nRequestID)

    # 报价操作请求

    def ReqQuoteAction(self, pInputQuoteAction, nRequestID: int):
        return super().ReqQuoteAction(pInputQuoteAction, nRequestID)

    # 批量报单操作请求

    def ReqBatchOrderAction(self, pInputBatchOrderAction, nRequestID: int):
        return super().ReqBatchOrderAction(pInputBatchOrderAction, nRequestID)

    # 期权自对冲录入请求

    def ReqOptionSelfCloseInsert(self, pInputOptionSelfClose, nRequestID: int):
        return super().ReqOptionSelfCloseInsert(pInputOptionSelfClose, nRequestID)

    # 期权自对冲操作请求

    def ReqOptionSelfCloseAction(self, pInputOptionSelfCloseAction, nRequestID: int):
        return super().ReqOptionSelfCloseAction(pInputOptionSelfCloseAction, nRequestID)

    # 申请组合录入请求

    def ReqCombActionInsert(self, pInputCombAction, nRequestID: int):
        return super().ReqCombActionInsert(pInputCombAction, nRequestID)

    # 请求查询报单

    def ReqQryOrder(self, pQryOrder, nRequestID: int):
        return super().ReqQryOrder(pQryOrder, nRequestID)

    # 请求查询成交

    def ReqQryTrade(self, pQryTrade, nRequestID: int):
        return super().ReqQryTrade(pQryTrade, nRequestID)

    # 请求查询投资者持仓

    def ReqQryInvestorPosition(self, pQryInvestorPosition, nRequestID: int):
        return super().ReqQryInvestorPosition(pQryInvestorPosition, nRequestID)

    # 请求查询资金账户

    def ReqQryTradingAccount(self, pQryTradingAccount, nRequestID: int):
        return super().ReqQryTradingAccount(pQryTradingAccount, nRequestID)

    # 请求查询投资者

    def ReqQryInvestor(self, pQryInvestor, nRequestID: int):
        return super().ReqQryInvestor(pQryInvestor, nRequestID)

    # 请求查询交易编码

    def ReqQryTradingCode(self, pQryTradingCode, nRequestID: int):
        return super().ReqQryTradingCode(pQryTradingCode, nRequestID)

    # 请求查询合约保证金率

    def ReqQryInstrumentMarginRate(self, pQryInstrumentMarginRate, nRequestID: int):
        return super().ReqQryInstrumentMarginRate(pQryInstrumentMarginRate, nRequestID)

    # 请求查询合约手续费率

    def ReqQryInstrumentCommissionRate(self, pQryInstrumentCommissionRate, nRequestID: int):
        return super().ReqQryInstrumentCommissionRate(pQryInstrumentCommissionRate, nRequestID)

    # 请求查询交易所

    def ReqQryExchange(self, pQryExchange, nRequestID: int):
        return super().ReqQryExchange(pQryExchange, nRequestID)

    # 请求查询产品

    def ReqQryProduct(self, pQryProduct, nRequestID: int):
        return super().ReqQryProduct(pQryProduct, nRequestID)

    # 请求查询合约

    def ReqQryInstrument(self, pQryInstrument, nRequestID: int):
        return super().ReqQryInstrument(pQryInstrument, nRequestID)

    # 请求查询行情

    def ReqQryDepthMarketData(self, pQryDepthMarketData, nRequestID: int):
        return super().ReqQryDepthMarketData(pQryDepthMarketData, nRequestID)

    # 请求查询投资者结算结果

    def ReqQrySettlementInfo(self, pQrySettlementInfo, nRequestID: int):
        return super().ReqQrySettlementInfo(pQrySettlementInfo, nRequestID)

    # 请求查询转帐银行

    def ReqQryTransferBank(self, pQryTransferBank, nRequestID: int):
        return super().ReqQryTransferBank(pQryTransferBank, nRequestID)

    # 请求查询投资者持仓明细

    def ReqQryInvestorPositionDetail(self, pQryInvestorPositionDetail, nRequestID: int):
        return super().ReqQryInvestorPositionDetail(pQryInvestorPositionDetail, nRequestID)

    # 请求查询客户通知

    def ReqQryNotice(self, pQryNotice, nRequestID: int):
        return super().ReqQryNotice(pQryNotice, nRequestID)

    # 请求查询结算信息确认

    def ReqQrySettlementInfoConfirm(self, pQrySettlementInfoConfirm, nRequestID: int):
        return super().ReqQrySettlementInfoConfirm(pQrySettlementInfoConfirm, nRequestID)

    # 请求查询投资者持仓明细

    def ReqQryInvestorPositionCombineDetail(self, pQryInvestorPositionCombineDetail, nRequestID: int):
        return super().ReqQryInvestorPositionCombineDetail(pQryInvestorPositionCombineDetail, nRequestID)

    # 请求查询保证金监管系统经纪公司资金账户密钥

    def ReqQryCFMMCTradingAccountKey(self, pQryCFMMCTradingAccountKey, nRequestID: int):
        return super().ReqQryCFMMCTradingAccountKey(pQryCFMMCTradingAccountKey, nRequestID)

    # 请求查询仓单折抵信息

    def ReqQryEWarrantOffset(self, pQryEWarrantOffset, nRequestID: int):
        return super().ReqQryEWarrantOffset(pQryEWarrantOffset, nRequestID)

    # 请求查询投资者品种/跨品种保证金

    def ReqQryInvestorProductGroupMargin(self, pQryInvestorProductGroupMargin, nRequestID: int):
        return super().ReqQryInvestorProductGroupMargin(pQryInvestorProductGroupMargin, nRequestID)

    # 请求查询交易所保证金率

    def ReqQryExchangeMarginRate(self, pQryExchangeMarginRate, nRequestID: int):
        return super().ReqQryExchangeMarginRate(pQryExchangeMarginRate, nRequestID)

    # 请求查询交易所调整保证金率

    def ReqQryExchangeMarginRateAdjust(self, pQryExchangeMarginRateAdjust, nRequestID: int):
        return super().ReqQryExchangeMarginRateAdjust(pQryExchangeMarginRateAdjust, nRequestID)

    # 请求查询汇率

    def ReqQryExchangeRate(self, pQryExchangeRate, nRequestID: int):
        return super().ReqQryExchangeRate(pQryExchangeRate, nRequestID)

    # 请求查询二级代理操作员银期权限

    def ReqQrySecAgentACIDMap(self, pQrySecAgentACIDMap, nRequestID: int):
        return super().ReqQrySecAgentACIDMap(pQrySecAgentACIDMap, nRequestID)

    # 请求查询产品报价汇率

    def ReqQryProductExchRate(self, pQryProductExchRate, nRequestID: int):
        return super().ReqQryProductExchRate(pQryProductExchRate, nRequestID)

    # 请求查询产品组

    def ReqQryProductGroup(self, pQryProductGroup, nRequestID: int):
        return super().ReqQryProductGroup(pQryProductGroup, nRequestID)

    # 请求查询做市商合约手续费率

    def ReqQryMMInstrumentCommissionRate(self, pQryMMInstrumentCommissionRate, nRequestID: int):
        return super().ReqQryMMInstrumentCommissionRate(pQryMMInstrumentCommissionRate, nRequestID)

    # 请求查询做市商期权合约手续费

    def ReqQryMMOptionInstrCommRate(self, pQryMMOptionInstrCommRate, nRequestID: int):
        return super().ReqQryMMOptionInstrCommRate(pQryMMOptionInstrCommRate, nRequestID)

    # 请求查询报单手续费

    def ReqQryInstrumentOrderCommRate(self, pQryInstrumentOrderCommRate, nRequestID: int):
        return super().ReqQryInstrumentOrderCommRate(pQryInstrumentOrderCommRate, nRequestID)

    # 请求查询资金账户

    def ReqQrySecAgentTradingAccount(self, pQryTradingAccount, nRequestID: int):
        return super().ReqQrySecAgentTradingAccount(pQryTradingAccount, nRequestID)

    # 请求查询二级代理商资金校验模式

    def ReqQrySecAgentCheckMode(self, pQrySecAgentCheckMode, nRequestID: int):
        return super().ReqQrySecAgentCheckMode(pQrySecAgentCheckMode, nRequestID)

    # 请求查询期权交易成本

    def ReqQryOptionInstrTradeCost(self, pQryOptionInstrTradeCost, nRequestID: int):
        return super().ReqQryOptionInstrTradeCost(pQryOptionInstrTradeCost, nRequestID)

    # 请求查询期权合约手续费

    def ReqQryOptionInstrCommRate(self, pQryOptionInstrCommRate, nRequestID: int):
        return super().ReqQryOptionInstrCommRate(pQryOptionInstrCommRate, nRequestID)

    # 请求查询执行宣告

    def ReqQryExecOrder(self, pQryExecOrder, nRequestID: int):
        return super().ReqQryExecOrder(pQryExecOrder, nRequestID)

    # 请求查询询价

    def ReqQryForQuote(self, pQryForQuote, nRequestID: int):
        return super().ReqQryForQuote(pQryForQuote, nRequestID)

    # 请求查询报价

    def ReqQryQuote(self, pQryQuote, nRequestID: int):
        return super().ReqQryQuote(pQryQuote, nRequestID)

    # 请求查询期权自对冲

    def ReqQryOptionSelfClose(self, pQryOptionSelfClose, nRequestID: int):
        return super().ReqQryOptionSelfClose(pQryOptionSelfClose, nRequestID)

    # 请求查询投资单元

    def ReqQryInvestUnit(self, pQryInvestUnit, nRequestID: int):
        return super().ReqQryInvestUnit(pQryInvestUnit, nRequestID)

    # 请求查询组合合约安全系数

    def ReqQryCombInstrumentGuard(self, pQryCombInstrumentGuard, nRequestID: int):
        return super().ReqQryCombInstrumentGuard(pQryCombInstrumentGuard, nRequestID)

    # 请求查询申请组合

    def ReqQryCombAction(self, pQryCombAction, nRequestID: int):
        return super().ReqQryCombAction(pQryCombAction, nRequestID)

    # 请求查询转帐流水

    def ReqQryTransferSerial(self, pQryTransferSerial, nRequestID: int):
        return super().ReqQryTransferSerial(pQryTransferSerial, nRequestID)

    # 请求查询银期签约关系

    def ReqQryAccountregister(self, pQryAccountregister, nRequestID: int):
        return super().ReqQryAccountregister(pQryAccountregister, nRequestID)

    # 请求查询签约银行

    def ReqQryContractBank(self, pQryContractBank, nRequestID: int):
        return super().ReqQryContractBank(pQryContractBank, nRequestID)

    # 请求查询预埋单

    def ReqQryParkedOrder(self, pQryParkedOrder, nRequestID: int):
        return super().ReqQryParkedOrder(pQryParkedOrder, nRequestID)

    # 请求查询预埋撤单

    def ReqQryParkedOrderAction(self, pQryParkedOrderAction, nRequestID: int):
        return super().ReqQryParkedOrderAction(pQryParkedOrderAction, nRequestID)

    # 请求查询交易通知

    def ReqQryTradingNotice(self, pQryTradingNotice, nRequestID: int):
        return super().ReqQryTradingNotice(pQryTradingNotice, nRequestID)

    # 请求查询经纪公司交易参数

    def ReqQryBrokerTradingParams(self, pQryBrokerTradingParams, nRequestID: int):
        return super().ReqQryBrokerTradingParams(pQryBrokerTradingParams, nRequestID)

    # 请求查询经纪公司交易算法

    def ReqQryBrokerTradingAlgos(self, pQryBrokerTradingAlgos, nRequestID: int):
        return super().ReqQryBrokerTradingAlgos(pQryBrokerTradingAlgos, nRequestID)

    # 请求查询监控中心用户令牌

    def ReqQueryCFMMCTradingAccountToken(self, pQueryCFMMCTradingAccountToken, nRequestID: int):
        return super().ReqQueryCFMMCTradingAccountToken(pQueryCFMMCTradingAccountToken, nRequestID)

    # 期货发起银行资金转期货请求

    def ReqFromBankToFutureByFuture(self, pReqTransfer, nRequestID: int):
        return super().ReqFromBankToFutureByFuture(pReqTransfer, nRequestID)

    # 期货发起期货资金转银行请求

    def ReqFromFutureToBankByFuture(self, pReqTransfer, nRequestID: int):
        return super().ReqFromFutureToBankByFuture(pReqTransfer, nRequestID)

    # 期货发起查询银行余额请求

    def ReqQueryBankAccountMoneyByFuture(self, pReqQueryAccount, nRequestID: int):
        return super().ReqQueryBankAccountMoneyByFuture(pReqQueryAccount, nRequestID)

    # 回调函数

    # 当客户端与交易后台建立起通信连接时（还未登录前），该方法被调用。
    def OnFrontConnected(self):
        pass

    # 当客户端与交易后台通信连接断开时，该方法被调用。当发生这个情况后，API会自动重新连接，客户端可不做处理。
    # @param nReason 错误原因
    #        0x1001 网络读失败
    #        0x1002 网络写失败
    #        0x2001 接收心跳超时
    #        0x2002 发送心跳失败
    #        0x2003 收到错误报文
    def OnFrontDisconnected(self, nReason):
        pass

    # 心跳超时警告。当长时间未收到报文时，该方法被调用。
    # @param nTimeLapse 距离上次接收报文的时间
    def OnHeartBeatWarning(self, nTimeLapse):
        pass

    # 客户端认证响应
    def OnRspAuthenticate(self, pRspAuthenticateField, pRspInfo, nRequestID, bIsLast):
        pass

    # 登录请求响应
    def OnRspUserLogin(self, pRspUserLogin, pRspInfo, nRequestID, bIsLast):
        pass

    # 登出请求响应
    def OnRspUserLogout(self, pUserLogout, pRspInfo, nRequestID, bIsLast):
        pass

    # 用户口令更新请求响应
    def OnRspUserPasswordUpdate(self, pUserPasswordUpdate, pRspInfo, nRequestID, bIsLast):
        pass

    # 资金账户口令更新请求响应
    def OnRspTradingAccountPasswordUpdate(self, pTradingAccountPasswordUpdate, pRspInfo, nRequestID, bIsLast):
        pass

    # 报单录入请求响应
    def OnRspOrderInsert(self, pInputOrder, pRspInfo, nRequestID, bIsLast):
        pass

    # 预埋单录入请求响应
    def OnRspParkedOrderInsert(self, pParkedOrder, pRspInfo, nRequestID, bIsLast):
        pass

    # 预埋撤单录入请求响应
    def OnRspParkedOrderAction(self, pParkedOrderAction, pRspInfo, nRequestID, bIsLast):
        pass

    # 报单操作请求响应
    def OnRspOrderAction(self, pInputOrderAction, pRspInfo, nRequestID, bIsLast):
        pass

    # 查询最大报单数量响应
    def OnRspQueryMaxOrderVolume(self, pQueryMaxOrderVolume, pRspInfo, nRequestID, bIsLast):
        pass

    # 投资者结算结果确认响应
    def OnRspSettlementInfoConfirm(self, pSettlementInfoConfirm, pRspInfo, nRequestID, bIsLast):
        pass

    # 删除预埋单响应
    def OnRspRemoveParkedOrder(self, pRemoveParkedOrder, pRspInfo, nRequestID, bIsLast):
        pass

    # 删除预埋撤单响应
    def OnRspRemoveParkedOrderAction(self, pRemoveParkedOrderAction, pRspInfo, nRequestID, bIsLast):
        pass

    # 执行宣告录入请求响应
    def OnRspExecOrderInsert(self, pInputExecOrder, pRspInfo, nRequestID, bIsLast):
        pass

    # 执行宣告操作请求响应
    def OnRspExecOrderAction(self, pInputExecOrderAction, pRspInfo, nRequestID, bIsLast):
        pass

    # 询价录入请求响应
    def OnRspForQuoteInsert(self, pInputForQuote, pRspInfo, nRequestID, bIsLast):
        pass

    # 报价录入请求响应
    def OnRspQuoteInsert(self, pInputQuote, pRspInfo, nRequestID, bIsLast):
        pass

    # 报价操作请求响应
    def OnRspQuoteAction(self, pInputQuoteAction, pRspInfo, nRequestID, bIsLast):
        pass

    # 批量报单操作请求响应
    def OnRspBatchOrderAction(self, pInputBatchOrderAction, pRspInfo, nRequestID, bIsLast):
        pass

    # 期权自对冲录入请求响应
    def OnRspOptionSelfCloseInsert(self, pInputOptionSelfClose, pRspInfo, nRequestID, bIsLast):
        pass

    # 期权自对冲操作请求响应
    def OnRspOptionSelfCloseAction(self, pInputOptionSelfCloseAction, pRspInfo, nRequestID, bIsLast):
        pass

    # 申请组合录入请求响应
    def OnRspCombActionInsert(self, pInputCombAction, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询报单响应
    def OnRspQryOrder(self, pOrder, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询成交响应
    def OnRspQryTrade(self, pTrade, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询投资者持仓响应
    def OnRspQryInvestorPosition(self, pInvestorPosition, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询资金账户响应
    def OnRspQryTradingAccount(self, pTradingAccount, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询投资者持仓响应
    def OnRspQryInvestor(self, pInvestor, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询交易编码响应
    def OnRspQryTradingCode(self, pTradingCode, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询合约保证金率响应
    def OnRspQryInstrumentMarginRate(self, pInstrumentMarginRate, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询合约手续费率响应
    def OnRspQryInstrumentCommissionRate(self, pInstrumentCommissionRate, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询交易所响应
    def OnRspQryExchange(self, pExchange, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询产品响应
    def OnRspQryProduct(self, pProduct, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询合约保证金率响应
    def OnRspQryInstrument(self, pInstrument, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询行情响应
    def OnRspQryDepthMarketData(self, pDepthMarketData, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询投资者结算结果响应
    def OnRspQrySettlementInfo(self, pSettlementInfo, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询转帐银行响应
    def OnRspQryTransferBank(self, pTransferBank, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询投资者持仓明细响应
    def OnRspQryInvestorPositionDetail(self, pInvestorPositionDetail, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询客户通知响应
    def OnRspQryNotice(self, pNotice, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询结算信息确认响应
    def OnRspQrySettlementInfoConfirm(self, pSettlementInfoConfirm, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询投资者持仓明细响应
    def OnRspQryInvestorPositionCombineDetail(self, pInvestorPositionCombineDetail, pRspInfo, nRequestID, bIsLast):
        pass

    # 查询保证金监管系统经纪公司资金账户密钥响应
    def OnRspQryCFMMCTradingAccountKey(self, pCFMMCTradingAccountKey, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询仓单折抵信息响应
    def OnRspQryEWarrantOffset(self, pEWarrantOffset, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询投资者品种/跨品种保证金响应
    def OnRspQryInvestorProductGroupMargin(self, pInvestorProductGroupMargin, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询交易所保证金率响应
    def OnRspQryExchangeMarginRate(self, pExchangeMarginRate, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询交易所调整保证金率响应
    def OnRspQryExchangeMarginRateAdjust(self, pExchangeMarginRateAdjust, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询汇率响应
    def OnRspQryExchangeRate(self, pExchangeRate, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询二级代理操作员银期权限响应
    def OnRspQrySecAgentACIDMap(self, pSecAgentACIDMap, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询产品报价汇率
    def OnRspQryProductExchRate(self, pProductExchRate, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询产品组
    def OnRspQryProductGroup(self, pProductGroup, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询做市商合约手续费率响应
    def OnRspQryMMInstrumentCommissionRate(self, pMMInstrumentCommissionRate, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询做市商期权合约手续费响应
    def OnRspQryMMOptionInstrCommRate(self, pMMOptionInstrCommRate, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询报单手续费响应
    def OnRspQryInstrumentOrderCommRate(self, pInstrumentOrderCommRate, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询资金账户响应
    def OnRspQrySecAgentTradingAccount(self, pTradingAccount, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询二级代理商资金校验模式响应
    def OnRspQrySecAgentCheckMode(self, pSecAgentCheckMode, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询期权交易成本响应
    def OnRspQryOptionInstrTradeCost(self, pOptionInstrTradeCost, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询期权合约手续费响应
    def OnRspQryOptionInstrCommRate(self, pOptionInstrCommRate, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询执行宣告响应
    def OnRspQryExecOrder(self, pExecOrder, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询询价响应
    def OnRspQryForQuote(self, pForQuote, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询报价响应
    def OnRspQryQuote(self, pQuote, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询期权自对冲响应
    def OnRspQryOptionSelfClose(self, pOptionSelfClose, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询投资单元响应
    def OnRspQryInvestUnit(self, pInvestUnit, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询组合合约安全系数响应
    def OnRspQryCombInstrumentGuard(self, pCombInstrumentGuard, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询申请组合响应
    def OnRspQryCombAction(self, pCombAction, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询转帐流水响应
    def OnRspQryTransferSerial(self, pTransferSerial, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询银期签约关系响应
    def OnRspQryAccountregister(self, pAccountregister, pRspInfo, nRequestID, bIsLast):
        pass

    # 错误应答
    def OnRspError(self, pRspInfo, nRequestID, bIsLast):
        pass

    # 报单通知
    def OnRtnOrder(self, pOrder):
        pass

    # 成交通知
    def OnRtnTrade(self, pTrade):
        pass

    # 报单录入错误回报
    def OnErrRtnOrderInsert(self, pInputOrder, pRspInfo):
        pass

    # 报单操作错误回报
    def OnErrRtnOrderAction(self, pOrderAction, pRspInfo):
        pass

    # 合约交易状态通知
    def OnRtnInstrumentStatus(self, pInstrumentStatus):
        pass

    # 交易所公告通知
    def OnRtnBulletin(self, pBulletin):
        pass

    # 交易通知
    def OnRtnTradingNotice(self, pTradingNoticeInfo):
        pass

    # 提示条件单校验错误
    def OnRtnErrorConditionalOrder(self, pErrorConditionalOrder):
        pass

    # 执行宣告通知
    def OnRtnExecOrder(self, pExecOrder):
        pass

    # 执行宣告录入错误回报
    def OnErrRtnExecOrderInsert(self, pInputExecOrder, pRspInfo):
        pass

    # 执行宣告操作错误回报
    def OnErrRtnExecOrderAction(self, pExecOrderAction, pRspInfo):
        pass

    # 询价录入错误回报
    def OnErrRtnForQuoteInsert(self, pInputForQuote, pRspInfo):
        pass

    # 报价通知
    def OnRtnQuote(self, pQuote):
        pass

    # 报价录入错误回报
    def OnErrRtnQuoteInsert(self, pInputQuote, pRspInfo):
        pass

    # 报价操作错误回报
    def OnErrRtnQuoteAction(self, pQuoteAction, pRspInfo):
        pass

    # 询价通知
    def OnRtnForQuoteRsp(self, pForQuoteRsp):
        pass

    # 保证金监控中心用户令牌
    def OnRtnCFMMCTradingAccountToken(self, pCFMMCTradingAccountToken):
        pass

    # 批量报单操作错误回报
    def OnErrRtnBatchOrderAction(self, pBatchOrderAction, pRspInfo):
        pass

    # 期权自对冲通知
    def OnRtnOptionSelfClose(self, pOptionSelfClose):
        pass

    # 期权自对冲录入错误回报
    def OnErrRtnOptionSelfCloseInsert(self, pInputOptionSelfClose, pRspInfo):
        pass

    # 期权自对冲操作错误回报
    def OnErrRtnOptionSelfCloseAction(self, pOptionSelfCloseAction, pRspInfo):
        pass

    # 申请组合通知
    def OnRtnCombAction(self, pCombAction):
        pass

    # 申请组合录入错误回报
    def OnErrRtnCombActionInsert(self, pInputCombAction, pRspInfo):
        pass

    # 请求查询签约银行响应
    def OnRspQryContractBank(self, pContractBank, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询预埋单响应
    def OnRspQryParkedOrder(self, pParkedOrder, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询预埋撤单响应
    def OnRspQryParkedOrderAction(self, pParkedOrderAction, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询交易通知响应
    def OnRspQryTradingNotice(self, pTradingNotice, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询经纪公司交易参数响应
    def OnRspQryBrokerTradingParams(self, pBrokerTradingParams, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询经纪公司交易算法响应
    def OnRspQryBrokerTradingAlgos(self, pBrokerTradingAlgos, pRspInfo, nRequestID, bIsLast):
        pass

    # 请求查询监控中心用户令牌
    def OnRspQueryCFMMCTradingAccountToken(self, pQueryCFMMCTradingAccountToken, pRspInfo, nRequestID, bIsLast):
        pass

    # 银行发起银行资金转期货通知
    def OnRtnFromBankToFutureByBank(self, pRspTransfer):
        pass

    # 银行发起期货资金转银行通知
    def OnRtnFromFutureToBankByBank(self, pRspTransfer):
        pass

    # 银行发起冲正银行转期货通知
    def OnRtnRepealFromBankToFutureByBank(self, pRspRepeal):
        pass

    # 银行发起冲正期货转银行通知
    def OnRtnRepealFromFutureToBankByBank(self, pRspRepeal):
        pass

    # 期货发起银行资金转期货通知
    def OnRtnFromBankToFutureByFuture(self, pRspTransfer):
        pass

    # 期货发起期货资金转银行通知
    def OnRtnFromFutureToBankByFuture(self, pRspTransfer):
        pass

    # 系统运行时期货端手工发起冲正银行转期货请求，银行处理完毕后报盘发回的通知
    def OnRtnRepealFromBankToFutureByFutureManual(self, pRspRepeal):
        pass

    # 系统运行时期货端手工发起冲正期货转银行请求，银行处理完毕后报盘发回的通知
    def OnRtnRepealFromFutureToBankByFutureManual(self, pRspRepeal):
        pass

    # 期货发起查询银行余额通知
    def OnRtnQueryBankBalanceByFuture(self, pNotifyQueryAccount):
        pass

    # 期货发起银行资金转期货错误回报
    def OnErrRtnBankToFutureByFuture(self, pReqTransfer, pRspInfo):
        pass

    # 期货发起期货资金转银行错误回报
    def OnErrRtnFutureToBankByFuture(self, pReqTransfer, pRspInfo):
        pass

    # 系统运行时期货端手工发起冲正银行转期货错误回报
    def OnErrRtnRepealBankToFutureByFutureManual(self, pReqRepeal, pRspInfo):
        pass

    # 系统运行时期货端手工发起冲正期货转银行错误回报
    def OnErrRtnRepealFutureToBankByFutureManual(self, pReqRepeal, pRspInfo):
        pass

    # 期货发起查询银行余额错误回报
    def OnErrRtnQueryBankBalanceByFuture(self, pReqQueryAccount, pRspInfo):
        pass

    # 系统运行时期货端手工发起冲正银行转期货请求，银行处理完毕后报盘发回的通知
    def OnRtnRepealFromBankToFutureByFuture(self, pRspRepeal):
        pass

    # 系统运行时期货端手工发起冲正期货转银行请求，银行处理完毕后报盘发回的通知
    def OnRtnRepealFromFutureToBankByFuture(self, pRspRepeal):
        pass

    # 期货发起银行资金转期货应答
    def OnRspFromBankToFutureByFuture(self, pReqTransfer, pRspInfo, nRequestID, bIsLast):
        pass

    # 期货发起期货资金转银行应答
    def OnRspFromFutureToBankByFuture(self, pReqTransfer, pRspInfo, nRequestID, bIsLast):
        pass

    # 期货发起查询银行余额应答
    def OnRspQueryBankAccountMoneyByFuture(self, pReqQueryAccount, pRspInfo, nRequestID, bIsLast):
        pass

    # 银行发起银期开户通知
    def OnRtnOpenAccountByBank(self, pOpenAccount):
        pass

    # 银行发起银期销户通知
    def OnRtnCancelAccountByBank(self, pCancelAccount):
        pass

    # 银行发起变更银行账号通知
    def OnRtnChangeAccountByBank(self, pChangeAccount):
        pass
