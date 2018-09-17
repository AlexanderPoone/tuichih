class ChineseNumberBuilder(object):
    """docstring for ChineseNumberBuilder"""
    def __init__(self, substr, twoOrdinal=False):        # r'[,\.\d\s]*?[^年]'    [^(電話|傳真|號碼)][：]+ 
        super(ChineseNumberBuilder, self).__init__()
        self.substr = substr.strip()
        self.twoOrdinal = twoOrdinal

    def _identifySeparators(self):
        self.thousand = ','            # Criteria: r'[0-9]{3}'    1,234 is ambiguious. Treat as seperator.
        self.substr = self.substr.strip(self.thousand)
        self.decimalPos = -1

        self.decimalPos = 7            

    def _build(self):
        self.substr[:self.decimalPos][]

        larger = {12:'兆',8:'億',4:'萬'}        # > 4? yes.            6 % 4 = 2 二百
        smaller = {3:'千',2:'百',1:'十'}
        cardinals = ('', '一', '二', '三', '四', '五', '六', '七', '八', '九')


        if (self.decimalPos < 0 and int(self.substr) == 2):
            self.substr = '兩'
            return

        buffer = ''
        for x in reversed(range(len())):
            new += cardinals[int(self.substr[~x])]
            if (x > 4):
                y = x % 4
                if (y != 0):
                    new += smaller[y]
                else:
                    new += larger[x]
        if self.decimalPos > 0:
            new += '點'
            for x in range(self.decimalPos, len(self.substr))):            # 如年分
                new += cardinals[int(self.substr[x])]


        # '兩' '廿'


        
        self.substr = new


    def get(self):
        return self.substr



/* Advantage of a TypeScript web application: accessible and installation-free */


class SettingStore(object):
    """docstring for SettingStore"""
    def __init__(self):
        pass

    def get(self, string):
        return None