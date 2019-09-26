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
se = soup.select("#mw-content-text > div > table > tbody > tr")
for i in range(len(se)):
    print(f'{i}/{len(se)}')
    tdList = se[i].findAll('td')
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
            # Get other locales here
            v=u(f'https://www.wikidata.org/w/api.php?action=wbsearchentities&format=json&language=en&search={q(currName)}&type=item')
            h=v.read().decode('utf-8')
            l = j.loads(h)
            if len(l['search']) > 0:
                qnum = l['search'][0]['id']
                #print(qnum)

                v=u(f'https://www.wikidata.org/w/api.php?action=wbgetentities&format=json&ids={qnum}&languages=zh%7Czh-cn%7Czh-hant%7Cyue&props=labels%7Cdescriptions')
                h=v.read().decode('utf-8')
                l = j.loads(h)
                if 'yue' in l['entities'][qnum]['labels']:
                    #print(0)
                    zhCurrencyName = l['entities'][qnum]['labels']['yue']['value']
                elif 'zh-hant' in l['entities'][qnum]['labels']:
                    #print(1)
                    zhCurrencyName = l['entities'][qnum]['labels']['zh-hant']['value']
                # elif 'zh-hk' in l['entities'][qnum]['labels']:
                #     #print(2)
                #     zhCurrencyName = l['entities'][qnum]['labels']['zh-hk']['value']
                elif 'zh' in l['entities'][qnum]['labels']:
                    #print(3)
                    zhCurrencyName = hc().toTraditional(l['entities'][qnum]['labels']['zh']['value'])
            else:
                zhCurrencyName = None
            doneCurrencyNames[currName] = {'zh': zhCurrencyName, 'symbol': currSymb, 'iso4217': currIso4217, 'fractional': {'name': currFracElem, 'numToBasic': numToBasic}}
        # print(currName + '   ||   ' + tdList[2 - shift].text.replace('\n','') + '   ||   ' + currIso4217)
l = j.dumps(doneCurrencyNames)
with open('currency_info.json', 'w') as x:
    x.write(l)
pp(doneCurrencyNames)
inputSymb = input('Insert a currency symbol: ')
for k, v in doneCurrencyNames.items():
    if v['symbol'] == inputSymb:
        print(k)