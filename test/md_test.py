import sys
import time

sys.path.insert(0, "/home/parallels/PycharmProjects/ctpwrapper/build/lib.linux-x86_64-3.5")

from ctpwrapper import MdApiPy
from ctpwrapper.pyStruct import ReqUserLoginField


class MyMd(MdApiPy):
    def __init__(self, broker_id, investor_id, password, request_id=1):
        self.broker_id = broker_id
        self.investor_id = investor_id
        self.password = password
        self.request_id = request_id

    def OnFrontConnected(self):
        '''
        Request login when onFrontConnected
        :return:
        '''
        # raise RuntimeError()
        print("On front connected")

        # Construct login credentials
        user_login = ReqUserLoginField(BrokerID=self.broker_id,
                                       UserID=self.investor_id,
                                       Password=self.password)

        # API
        # Request_ID is fed as a parameter in callback onRspUserLogin
        print("Login in with {}".format(user_login))
        if self.ReqUserLogin(user_login, self.request_id) == 0:
            print("Send login request suc")
        else:
            print("Send login request unsuc")

    def OnRspUserLogin(self, pRspUserLogin, pRspInfo, nRequestID, bIsLast):
        if pRspInfo.ErrorID != 0:
            # todo verify GBK encoding
            print("Md OnRspUserLogin failed error_id={} msg:{}".format(
                pRspInfo.ErrorID, pRspInfo.ErrorMsg.decode('gbk')))
        else:
            print("Md user login successfully")
            print(pRspUserLogin)
            print(pRspInfo)
            # print(nRequestID)

    def OnRspSubMarketData(self, pSpecificInstrument, pRspInfo, nRequestID, bIsLast):
        if pRspInfo.ErrorID != 0:
            print("Md OnRspSubMarketData failed error_id={} msg".format(
                pRspInfo.ErrorID, pRspInfo.ErrorMsg.decode("gbk")
            ))
        else:
            print("Subscribe Market Data successfully")
            print(pSpecificInstrument)
            print(pRspInfo)

    def OnRtnDepthMarketData(self, pDepthMarketData):
        print(pDepthMarketData)

    def OnRspUnSubMarketData(self, pSpecificInstrument, pRspInfo, nRequestID, bIsLast):
        print("Unsubscribe:", pSpecificInstrument)
        print(pRspInfo)
        print("Request ID", nRequestID)


if __name__ == '__main__':
    BROKER_ID = '9999'
    SERVER = 'tcp://180.168.146.187:10011'
    USER_ID = '116266'
    PASSWORD = 'audureyhB03'
    # PASSWORD = ""

    md = MyMd(BROKER_ID, USER_ID, PASSWORD)
    md.Create()  # Create API instance
    md.RegisterFront(SERVER)  # Register server
    md.Init()  # Register SPI, run

    # wait for Connection
    time.sleep(3)

    INST = 'IF1902'
    # time.sleep(1)
    # day = md.GetTradingDay()
    # print(day)
    # print("API works!")

    insts = []
    insts.append(INST)
    if md.SubscribeMarketData(insts) == 0:
        print("Sub suc")
    else:
        print("Sub unsuc")

    time.sleep(10)
    if md.UnSubscribeMarketData([INST]) == 0:
        print("Unsubscribe suc")
    else:
        print("Unsubscribe unsuc")

    md.Join()  # Blocking call until the API thread finishes
