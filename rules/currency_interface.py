from re import findall as fa, sub as s, IGNORECASE, fullmatch as fm
from collections import OrderedDict as d
from subprocess import Popen as p
from pprint import pprint as pp
from unidecode import unidecode as ud
import json as j
from hanziconv import HanziConv as hc

class currency_interface(object):
    """docstring for ClassName"""
    def __init__(self, load=True):
        super(currency_interface, self).__init__()
        if load:
            with open('currency_info.json', 'r') as x:
                self.doneCurrencyNames=j.loads(x.read())
        
    def interactive(self, json=None):
        while True:
            if json is not None:
                self.doneCurrencyNames = json
            doneCurrencyNames = self.doneCurrencyNames
            # inputSymb = input('Insert a currency symbol: ')
            # for k, v in doneCurrencyNames.items():
            #     if v['symbol'] == inputSymb:
            #         print(k)
            inputSen = input('Insert a sentence (e.g. I have 5,000 groszy.): ')
            print(self.toSymbol(inputSen))
            inputSen = input('Insert a sentence (e.g. I have ฿123,456.789): ')
            for k, v in doneCurrencyNames.items():
                # The hardest step is to make sure whether this is a currency. Some currency symbols are simply letters like L or KM.
                pass

    def toSymbol(self, inputSen):
        doneCurrencyNames = self.doneCurrencyNames
        for k, v in doneCurrencyNames.items():
            if v['symbol'] is not None:
                if isinstance(v['symbol'],list):
                    symbol = v['symbol'][0]
                else:
                    symbol = v['symbol']
                nounCurrency = s('^.* ','',k,flags=IGNORECASE)                                                                      # fm('[a-z]+', k, flags=IGNORECASE) != None
                if ' ' not in k:                                                                                                # exception: one-word currency: euro, bitcoin
                    nounCurrency = k
                if v['plural'] is not None:
                    pluralPrefix = f'{v["plural"]}|{ud(v["plural"])}|'                                  # orders matter. It's always {plural|singular} rather than {singular|plural}
                else:
                    pluralPrefix = ''
                allInstances = fa(f'[0-9\\,\\.]+ (?:{pluralPrefix}{nounCurrency}|{ud(nounCurrency)})(?:e?s)?', inputSen, flags=IGNORECASE)    # all should be uncaptured. Use (?:) instead of ()   <- captured
                for i in allInstances:
                    numberPart = fa(f'[0-9\\,\\.]+', i)
                    # Left or right ?
                    if len(numberPart) > 0:
                        if symbol.isalpha():  # Cyrillic and zloty are alphas !
                            rpmt = f'{numberPart[0]} {symbol}'
                        else:
                            rpmt = f'{symbol}{numberPart[0]}'
                        inputSen = s(i, rpmt, inputSen, flags=IGNORECASE)

                # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                if v['fractional']['name'] is not None:
                    nounFraction = v['fractional']['name']
                    allInstances = fa(f'[0-9\\,\\.]+ (?:{nounFraction}|{ud(nounFraction)})(?:e?s)?', inputSen, flags=IGNORECASE)    # all should be uncaptured. Use (?:) instead of ()   <- captured
                    for i in allInstances:
                        numberPart = fa(f'[0-9\\,\\.]+', i)
                        # Left or right ?
                        if len(numberPart) > 0:
                            if symbol.isalpha():  # Cyrillic and zloty are alphas !
                                rpmt = f'{float(numberPart[0].replace(",","")) / v["fractional"]["numToBasic"]} {symbol}'
                            else:
                                rpmt = f'{symbol}{float(numberPart[0].replace(",","")) / v["fractional"]["numToBasic"]}'
                            inputSen = s(i, rpmt, inputSen, flags=IGNORECASE)
        return inputSen

    def toCurrencyName(locale='en'):
        pass

if __name__ == '__main__':
    currency_interface().interactive()