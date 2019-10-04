# encoding: utf-8

'''
	PART OF THE RLL ENGINE
	2019 SOFTFETA. ALL WRONGS RESERVED.
'''

from yaml import dump, Dumper
from pprint import pprint
#from os import 

# Find all .rll files in ./rules

def main():

	commentBlockBegins = False

	try:
		with open(r'.\rules_compiled\rules_koo.proto', 'w', encoding='utf8') as w:				# .\rules_compiled\zh\rules_koo.proto
			with open(r'.\rules\rules_koo.rll', 'r', encoding='utf8') as r:						# .\rules\zh\rules_koo.rll
				structure = object()
				cnt = 0
				failed = []
				for line in r.readlines():
					cnt += 1
					if line.isspace():
						continue
					if '/*' in line:
						commentBlockBegins = True
					if commentBlockBegins and '*/' in line:
						commentBlockBegins = False
					tokens = line.split('\t\t')
					pprint(f'Line {cnt}; no. of tokens: {len(tokens)}; tokens: {tokens}')
					if len(tokens) == 4:
						dt = {'raw_input' : tokens[0], 'raw_output' : tokens[1], 'initial_depravity_idx' : tokens[2], 'remarks' : tokens[3]}
						pprint(f'Line {cnt}; output: {dt}')
					else:
						failed.append(cnt)
				print(f'''++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Checking finished. {len(failed)} line{'' if (len(failed) == 1) else 's'} failed:''')
				print('Line' if (len(failed) == 1) else 'Lines')
				for lineno in failed:
					print(f'{lineno}', end='\t')
				# #TODO
				# r.write(dump(structure, Dumper = Dumper))
	except FileNotFoundError as e:
		print('Rule files not found. Trying to download the latest files from server...')
		exit(1)
	except PermissionError as e:
		print('Please close the rule files before running the program.')
		exit(1)

if __name__ == '__main__':
	main()