# encoding: utf-8

from yaml import load, Loader
from pprint import pprint

def main():
	try:
		with open(r'.\rules_compiled\zh\rules_koo.yaml', 'r', encoding='utf8')  as f:
			compiled = load(f.read(), Loader=Loader)
		pprint(compiled)
	except FileNotFoundError as e:
		print('Compiled files not found. Trying to recompile...')
		exit(1)
	except PermissionError as e:
		print('Please close the compiled files before running the program.')
		exit(1)

if __name__ == '__main__':
	main()