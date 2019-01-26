# Interface exposed to users


from ctpwrapper.MdApi import MdApiWrapper
from ctpwrapper.pyStruct import *


class MdApiPy(MdApiWrapper):
    '''
    The interface exposed to users
    '''

    def Create(self, pszFlowPath="", bIsUsingUdp=False, bIsMulticast=False):
        '''
        创建MdApi
        :param pszFlowPath: 存贮订阅信息文件的目录，默认为当前目录
        :param bIsUsingUdp:
        :param bIsMulticast:
        :return:
        '''
        super().Create(pszFlowPath.encode(), bIsUsingUdp, bIsMulticast)

    def Init(self):
        '''
        初始化行情接口的工作线程。初始化之后,线程自动启动,并使用上一步中注册的地址向服务端请求建立连接。
        :return:
        '''
        super().Init()

    def Join(self) -> int:
        '''
        等待接口线程结束运行
        :return: 线程退出代码
        '''
        return super().Join()

    def ReqUserLogin(self, pReqUserLogin, nRequestID) -> int:
        '''
        用户登录请求
        :param pReqUserLogin:
        :param nRequestID:
        :return:
        '''
        # self is implicitly passed to super method in super()
        return super().ReqUserLogin(pReqUserLogin, nRequestID)

    def ReqUserLogout(self, pUserLogout, nRequestID) -> int:
        '''
        登出请求
        :param pUserLogout:
        :param nRequestID:
        :return:
        '''
        return super().ReqUserLogout(pUserLogout, nRequestID)

    def GetTradingDay(self) -> str:
        '''
        获取当前交易日
        retrun 获取到的交易日
        只有登录成功后,才能得到正确的交易日
        decode bytes returned by MdApiWrapper.getTradingDay
        :return: current Trading Day, as string
        '''
        # todo print out bytes
        return super().GetTradingDay().decode()

    def RegisterFront(self, pszFrontAddress: str):
        '''
        注册前置机网络地址

        @remark 网络地址的格式为：“protocol://ipaddress:port”，如：”tcp://127.0.0.1:17001”。
        @remark “tcp”代表传输协议，“127.0.0.1”代表服务器地址。”17001”代表服务器端口号。
        :param pszFrontAddress: 前置机网络地址
        :return:
        '''
        super().RegisterFront(pszFrontAddress.encode())

    def RegisterNameServer(self, pszNsAddress: str):
        '''
        注册名字服务器网络地址
        :param pszNsAddress:
        :return:
        '''
        super().RegisterNameServer(pszNsAddress.encode())

    def RegisterFensUserInfo(self, pFensUserInfo):
        '''
        注册名字服务器用户信息
        :param pFensUserInfo:
        :return:
        '''
        super().RegisterFensUserInfo(pFensUserInfo)

    def SubscribeMarketData(self, ppInstrumentID: list):
        '''
        订阅行情
        Convert list of strings to list of bytes
        :param ppInstrumentID: a list of strings of intruments
        :return:
        '''
        ids = [bytes(item, encoding='utf-8') for item in ppInstrumentID]
        return super().SubscribeMarketData(ids)

    def UnSubscribeMarketData(self, ppInstrumentID):
        '''
        退订行情
        :param ppInstrumentID:
        :return:
        '''
        ids = [bytes(item, encoding='utf-8') for item in ppInstrumentID]
        return super().UnSubscribeMarketData(ids)

    def SubscribeForQuoteRsp(self, ppInstrumentID):
        '''
        订阅询价
        :param ppInstrumentID:
        :return:
        '''
        ids = [bytes(item, encoding='utf-8') for item in ppInstrumentID]
        return super().SubscribeForQuoteRsp(ids)

    def UnSubscribeForQuoteRsp(self, ppInstrumentID):
        '''
        退订询价
        :param ppInstrumentID:
        :return:
        '''
        ids = [bytes(item, encoding='utf-8') for item in ppInstrumentID]
        return super().UnSubscribeForQuoteRsp(ids)

    '''
========================================================================================================================
Callbacks to be overridden by users
========================================================================================================================
    '''

    def OnFrontConnected(self):
        '''
        当客户端与交易后台建立起通信连接时（还未登录前），该方法被调用。
        :return:
        '''
        pass

    def OnHeartBeatWarning(self, nTimeLapse):
        pass

    def OnFrontDisconnected(self, nReason):
        pass

    def OnRspUserLogin(self, pRspUserLogin: RspUserLoginField, pRspInfo: RspInfoField, nRequestID, bIsLast):
        '''
        登录请求响应
        :param self:
        :param pRspUserLogin:
        :param pRspInfo:响应信息
        :param nRequestID:
        :param bIsLast:
        :return:
        '''
        pass

    def OnRspUserLogout(self, pUserLogout: UserLogoutField, pRspInfo: RspInfoField, nRequestID, bIsLast):
        """
        登出请求响应
        :param pUserLogout:
        :param pRspInfo:
        :param nRequestID:
        :param bIsLast:
        :return:
        """
        pass

    def OnRspError(self, pRspInfo: RspInfoField, nRequestID, bIsLast):
        """
        错误应答
        :param pRspInfo:
        :param nRequestID:
        :param bIsLast:
        :return:
        """
        pass

    def OnRspSubMarketData(self, pSpecificInstrument: SpecificInstrumentField, pRspInfo: RspInfoField, nRequestID,
                           bIsLast):
        """
        订阅行情应答
        :param pSpecificInstrument:
        :param pRspInfo:
        :param nRequestID:
        :param bIsLast:
        :return:
        """
        pass

    def OnRspUnSubMarketData(self, pSpecificInstrument: SpecificInstrumentField, pRspInfo: RspInfoField, nRequestID,
                             bIsLast):
        """
        取消订阅行情应答
        :param pSpecificInstrument:
        :param pRspInfo:
        :param nRequestID:
        :param bIsLast:
        :return:
        """
        pass

    def OnRspSubForQuoteRsp(self, pSpecificInstrument: SpecificInstrumentField, pRspInfo: RspInfoField, nRequestID,
                            bIsLast):
        """
        订阅询价应答
        :param pSpecificInstrument:
        :param pRspInfo:
        :param nRequestID:
        :param bIsLast:
        :return:
        """
        pass

    def OnRspUnSubForQuoteRsp(self, pSpecificInstrument: SpecificInstrumentField, pRspInfo: RspInfoField, nRequestID,
                              bIsLast):
        """
        取消订阅询价应答
        :param pSpecificInstrument:
        :param pRspInfo:
        :param nRequestID:
        :param bIsLast:
        :return:
        """
        pass

    def OnRtnDepthMarketData(self, pDepthMarketData: DepthMarketDataField):
        """
        深度行情通知
        :param pDepthMarketData:
        :return:
        """
        pass

    def OnRtnForQuoteRsp(self, pForQuoteRsp: ForQuoteRspField):
        """
        询价通知
        :param pForQuoteRsp:
        :return:
        """
        pass
