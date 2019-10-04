from pprint import pprint as pp
import json as j
from re import sub as s

class punct_interface(object):
	def __init__(self):
		super(punct_interface, self).__init__()
		with open('punct_info.json', 'r') as x:
		    punct = x.read()
		self.jp = j.loads(punct)

	def replace(self, inputSen):
		for key in self.jp:
			pp(key)
			print('('+'|'.join(self.jp[key]['variants']).replace('U+',r'\u')+')', self.jp[key]['replaceWith'].replace('U+',r'\u'))
			inputSen = s('('+'|'.join(self.jp[key]['variants']).replace('U+',r'\u')+')', chr(int(self.jp[key]['replaceWith'].replace('U+','0x'), 16)), inputSen)
		return inputSen

if __name__ == '__main__':
	pp(punct_interface().replace('A　•‧B'))