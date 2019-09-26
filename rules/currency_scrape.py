from urllib.request import urlopen as u
from urllib.parse import quote as q
from urllib.error import HTTPError
from bs4 import BeautifulSoup as b
from re import findall as fa, sub as s
from collections import OrderedDict as d
from subprocess import Popen as p
from pprint import pprint as pp
import json as j
from hanziconv import HanziConv as hc

doneCurrencyNames = {}
currencies = "https://en.wikipedia.org/wiki/List_of_circulating_currencies"

v=u(currencies)
h=v.read().decode('utf-8')
soup=b(h,'html.parser')
shift = 0
for i in soup.select("#mw-content-text > div > table > tbody > tr"):
    tdList = i.findAll('td')
    if len(tdList) >= 5:
        if len(tdList) == 5:
            shift = 1
        else:
            shift = 0
        currName = s(r'\[.*\]','',tdList[1 - shift].text).replace('\n','')
        if currName == '(none)':
            continue

        currSymb = s(r'\[.*\]','',tdList[2 - shift].text).replace('\n','')
        if currSymb == '(none)':
            currSymb = None
        elif ' or ' in currSymb:
            currSymb =  currSymb.split(' or ')

        currIso4217Elem = tdList[3 - shift].findAll()
        if len(currIso4217Elem) >= 2:
            currIso4217 = currIso4217Elem[0].text.replace('\n','')
        else:
            currIso4217 = tdList[3 - shift].text.replace('\n','')
        if currIso4217 == '(none)':
            currIso4217 = None

        currFracElem = tdList[4 - shift].findAll()
        if len(currFracElem) >= 2:
            currFracElem = currFracElem[0].text.replace('\n','')
        else:
            currFracElem = tdList[4 - shift].text.replace('\n','')
        if currFracElem == '(none)':
            currFracElem = None

        numToBasic = tdList[5 - shift].text.replace('\n','')
        if numToBasic == '(none)':
            numToBasic = None
        else:
            numToBasic = int(numToBasic)

        if currName not in doneCurrencyNames:
            doneCurrencyNames[currName] = {'symbol': currSymb, 'iso4217': currIso4217, 'fractional': {'name': currFracElem, 'numToBasic': numToBasic}}
        # print(currName + '   ||   ' + tdList[2 - shift].text.replace('\n','') + '   ||   ' + currIso4217)
l = j.dumps(doneCurrencyNames)
with open('currency_info.json', 'w') as x:
    x.write(l)
pp(doneCurrencyNames)
inputSymb = input('Insert a currency symbol: ')
for k, v in doneCurrencyNames.items():
    if v['symbol'] == inputSymb:
        print(k)