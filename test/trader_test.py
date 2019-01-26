import sys

sys.path.insert(0, '/home/parallels/PycharmProjects/ctpwrapper/build/lib.linux-x86_64-3.5')

from ctpwrapper import TraderApiPy
from ctpwrapper import pyStruct as ApiStructure


class Trader(TraderApiPy):

    def __init__(self, broker_id, investor_id, password, request_id=1):
        self.request_id = request_id
        self.broker_id = broker_id.encode()
        self.investor_id = investor_id.encode()
        self.password = password.encode()

    def OnRspError(self, pRspInfo, nRequestID, bIsLast):

        self.ErrorRspInfo(pRspInfo, nRequestID)

    def ErrorRspInfo(self, info, request_id):
        """
        :param info:
        :return:
        """
        if info.ErrorID != 0:
            print('request_id=%s ErrorID=%d, ErrorMsg=%s',
                  request_id, info.ErrorID, info.ErrorMsg.decode('gbk'))
        return info.ErrorID != 0

    def OnHeartBeatWarning(self, nTimeLapse):
        """心跳超时警告。当长时间未收到报文时，该方法被调用。
        @param nTimeLapse 距离上次接收报文的时间
        """
        print("on OnHeartBeatWarning time: ", nTimeLapse)

    def OnFrontDisconnected(self, nReason):
        print("on FrontDisConnected disconnected", nReason)

    def OnFrontConnected(self):

        req = ApiStructure.ReqUserLoginField(BrokerID=self.broker_id,
                                             UserID=self.investor_id,
                                             Password=self.password)
        print(self.request_id + 1)
        self.ReqUserLogin(req, self.request_id + 1)
        print("trader on front connection")

    def OnRspUserLogin(self, pRspUserLogin, pRspInfo, nRequestID, bIsLast):

        if pRspInfo.ErrorID != 0:
            print("Md OnRspUserLogin failed error_id=%s msg:%s",
                  pRspInfo.ErrorID, pRspInfo.ErrorMsg.decode('gbk'))
        else:
            print("Md user login successfully")
            # print("ID: ", nRequestID)

            print(pRspUserLogin, pRspInfo)

            # inv = ApiStructure.QryInvestorField(BrokerID=self.broker_id, InvestorID=self.investor_id)

            # self.ReqQryInvestor(inv, self.inc_request_id())
            # req = ApiStructure.SettlementInfoConfirmField.from_dict({"BrokerID": self.broker_id,
            #                                                          "InvestorID": self.investor_id})
            #
            # self.ReqSettlementInfoConfirm(req, self.inc_request_id())

            # ip = ApiStructure.QryInvestorPositionField.from_dict({
            #     "BrokerID": self.broker_id,
            #     "InvestorID": self.investor_id
            # })
            # print(self.ReqQryInvestorPosition(ip, self.inc_request_id()))

            # tq = ApiStructure.QryTradingAccountField.from_dict({'BrokerID': self.broker_id, 'InvestorID': self.investor_id})
            # print(self.ReqQryTradingAccount(tq, self.inc_request_id()))

            # time.sleep(5)
            # qe = ApiStructure.QryExchangeRateField(BrokerID=self.broker_id, FromCurrencyID="USD", ToCurrencyID="CNY")
            # print(self.ReqQryExchangeRate(qe, self.inc_request_id()))

            # iq = ApiStructure.QryInvestorField(BrokerID=self.broker_id, InvestorID=self.investor_id)
            # print('Result:', self.ReqQryInvestor(iq, self.inc_request_id()))

            # settle = ApiStructure.QrySettlementInfoField()

            print(self.ReqQryDepthMarketData(ApiStructure.QryDepthMarketDataField(InstrumentID="pb1902"),
                                             self.inc_request_id()))

    def OnRspQryDepthMarketData(self, pDepthMarketData, pRspInfo, nRequestID, bIsLast):
        print(pDepthMarketData)

    def OnRspQryTradingAccount(self, pTradingAccount, pRspInfo, nRequestID, bIsLast):
        self.trading = pTradingAccount
        print(pTradingAccount, pRspInfo, nRequestID)

    def OnRspQryInvestorPosition(self, pInvestorPosition, pRspInfo, nRequestID, bIsLast):
        print("OnRsp investor position: ", end="")
        print(pInvestorPosition)
        print(pRspInfo)
        print(nRequestID)
        print(bIsLast)

    def OnRspSettlementInfoConfirm(self, pSettlementInfoConfirm, pRspInfo, nRequestID, bIsLast):
        print(pSettlementInfoConfirm, pRspInfo)
        print(pRspInfo.ErrorMsg.decode("GBK"))

    def OnRspQryExchangeRate(self, pExchangeRate, pRspInfo, nRequestID, bIsLast):
        print(pExchangeRate, pRspInfo, nRequestID, bIsLast)

    def inc_request_id(self):
        self.request_id += 1
        return self.request_id

    def OnRspQryInvestor(self, pInvestor, pRspInfo, nRequestID, bIsLast):
        print(pInvestor, pRspInfo)


if __name__ == "__main__":
    investor_id = "116266"
    broker_id = "9999"
    password = "audureyhB03"
    server = "tcp://180.168.146.187:10001"

    user_trader = Trader(broker_id=broker_id, investor_id=investor_id, password=password)

    user_trader.Create()
    user_trader.RegisterFront(server)
    user_trader.SubscribePrivateTopic(2)  # 只传送登录后的流内容
    user_trader.SubscribePrivateTopic(2)  # 只传送登录后的流内容

    user_trader.Init()
    print("API version:", user_trader.GetApiVersion())

    print("trader started")
    print(user_trader.GetTradingDay())

    # time.sleep(5)
    # print(user_trader.trading)
    # Do not store callback objects, they are managed by C++ side and could be corrupted after
    # callback returns

    user_trader.Join()
