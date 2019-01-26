BEFORE = """
# Interface exposed to users

from .TraderApi import TraderApiWrapper


class TraderApiPy(TraderApiWrapper):
    '''
    I choose not to expose Release
    '''

    def Create(self, pszFlowPath: str = ""):
        super().Create(pszFlowPath.encode())

    def Init(self):
        super().Init()

    def Join(self):
        return super().Join()

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

"""

TEMPLATE = '''
    def {method_name}(self, {p}, nRequestID: int):
        return super().{method_name}({p}, nRequestID)
'''


class DocSearcher:
    def __init__(self):
        with open('/home/parallels/PycharmProjects/ctpwrapper/ctp/header/ThostFtdcTraderApi.h') as f:
            self.lines = f.read().split('\n')

    def trace_back(self, idx):
        while not self.lines[idx].strip().startswith('///'):
            idx -= 1
        return self.lines[idx].strip()

    def find_doc_for_method(self, method_name):
        for i in range(len(self.lines)):
            if re.search(method_name, self.lines[i]) != None:
                return self.trace_back(i)
        raise RuntimeError("Cannot find doc for this method {}".format(method_name))


ds = DocSearcher()

import os
import re
from os.path import dirname as dir


def generate():
    GENERATE_FILE_PATH = os.path.join(dir(dir(__file__)), 'ctpwrapper/Trader.py')
    GENERATE_FILE = open(GENERATE_FILE_PATH, 'w')

    SOURCE_FILE_PATH = os.path.join(dir(dir(__file__)), 'ctpwrapper/TraderApi.pyx')
    SOURCE_FILE = open(SOURCE_FILE_PATH)

    GENERATE_FILE.write(BEFORE)

    line = SOURCE_FILE.readline()
    while not line.strip().startswith('# 客户端认证请求'):
        line = SOURCE_FILE.readline()

    reqs = parse_req(SOURCE_FILE)

    for req in reqs:
        GENERATE_FILE.write(req['line_doc'])
        GENERATE_FILE.write(req['method_str'])

    callbacks = parse_on(SOURCE_FILE)

    GENERATE_FILE.write('\n   # 回调函数\n\n')
    for cb in callbacks:
        GENERATE_FILE.write('    # ' + cb['doc_line'].replace("///", ""))
        GENERATE_FILE.write(cb['method_str'] + '\n')

    GENERATE_FILE.close()
    SOURCE_FILE.close()


def parse_req(SOURCE_FILE):
    reqs = []

    line_doc = '    # 客户端认证请求\n'

    for line in SOURCE_FILE:
        if line.strip().startswith('#'):
            line_doc = line

        if line.startswith(('# callbacks')):
            break  # hit callbacks

        if line.strip().startswith('def Req'):
            result = re.match('def (\w+)\(self, (\w+), int nRequestID\):', line.strip())
            method_name = result.groups()[0]
            p = result.groups()[1]

            method = TEMPLATE.format(
                method_name=method_name,
                p=p
            )

            reqs.append({
                'method_str': method,
                'line_doc': line_doc
            })
    return reqs


# provide callbacks for user
TEMPLATE_CALLBACKS = '''
    def {method_name}(self{the_rest}):
        pass
'''


def parse_on(SOURCE_FILE):
    callbacks = []
    for line in SOURCE_FILE:
        if line.startswith('cdef extern'):
            result = re.match(r'cdef extern int TraderSpi_(\w+)\(self(.*)\)', line)
            method_name = result.groups()[0]
            the_rest = result.groups()[1]

            # search for things other than self
            if the_rest != '':
                the_rest = [item for item in re.findall('\w+', the_rest) if item.startswith('p') or item.startswith('n')
                            or item.startswith('b')]
                the_rest = ', ' + ', '.join(the_rest)

            # search for doc of this callback in cpp header

            callbacks.append({'method_str': TEMPLATE_CALLBACKS.format(
                method_name=method_name,
                the_rest=the_rest,
            ), 'doc_line': ds.find_doc_for_method(method_name)})

    return callbacks


if __name__ == '__main__':
    generate()
