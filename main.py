from unicodedata import normalize
from re import split

def remove_accents(input_str):
    nfkd_form = normalize('NFKD', input_str)								# Normalization Form: Compatibility (K) Decomposition.
    only_ascii = nfkd_form.encode('ASCII', 'ignore').decode('utf-8')		# must use decode(), str() results in "b'blah blah'"
    return only_ascii

def check_locution(input_locution):
	pass


'''
LIST OF ALIAS
.replace('（', '(')
.replace('）', ')')
.replace('｜', '|');


'''

text = 'Zu dieser Kamera gibt es noch allerlei Zubehör, wie Tasche, Fernauslöser und Stativ.'
roughs = split(r'[\.\,\;\:\!\?\s]+', text)
roughs.remove('')
print(roughs)
roughs2 = '/'.join([remove_accents(x) for x in roughs])
print(roughs2)
for c in roughs:
    stack = []
    for cha in c:
        stack.append(cha)
        check_locution(stack)
