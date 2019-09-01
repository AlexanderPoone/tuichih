#mw-content-text > div > p:nth-child(9) > span > abbr
//*[@id="French"]

#mw-content-text > div > h2:nth-child(3) 


#mw-content-text > div > h2 > span#French

'//*[@id="mw-content-text"]/div/[h2/span/[@id="French"]]/p/span/abbr/text()'

base_url_m = 'https://en.wiktionary.org/wiki/Category:French_masculine_nouns'
base_url_f = 'https://en.wiktionary.org/wiki/Category:French_feminine_nouns'

=1. masculine adj to feminine==
TypeScript Regex Lookahead????
Word boundary regex???? \\b

*e -> pass			/\b.*(?=e)\b/gi
*eur, *eux -> euse /\b.*(?=eu(r|x|se)\b)/gi
*teur -> trice		/\b.*(?=teur)\b/gi
*er -> ère			/\b.*(?=er)\b/gi
*et -> ète 
*f -> ve
*ain -> aine
*[aeiou][nt] -> [aeiou][nt]{2}e
beau -> belle
blanc -> blanche
faux -> fausse
long -> longue
nouveau -> nouvelle
roux -> rousse
vieux -> vieille
else -> +e

=2. nom+adj to plural==
*au -> aux
*ou -> oux
*al -> aux
*s|x|z -> pass
tout -> tous
else -> +s

Exceptions: ail -> ails; bail -> baux


Family names aren’t pluralized in French. For example, the Martins lose the –s in French but keep the article: Les Martin.

1. Find 'le', 'la', 'les', 'du', 'des', 'au', 'aux', 'ton', 'ta', 'tes' case-insensitive. '^+[lL]e( )'
2. Lookbehind 1 (nom? adjetif?)
	nom? 3. (find nom first!!! for both nom. and adj.)
	adj?
	else? terminate
3. Lookbehind 2
	nom?
	adj?
		no nom? terminate
		find actual gender of nom, check [x-1], check [x+1]
nm nf nmpl nfpl


'h aspiré', 'aspirated h': 'l\''
https://fr.wiktionary.org/wiki/Cat%C3%A9gorie:Termes_en_fran%C3%A7ais_%C3%A0_h_aspir%C3%A9
https://fr.wiktionary.org/w/api.php?action=query&generator=categorymembers&gcmtitle=Cat%C3%A9gorie:Termes_en_fran%C3%A7ais_%C3%A0_h_aspir%C3%A9&prop=categories&cllimit=max&gcmlimit=max
# Just need to think about plural rules:
# Exceptions!!!!!! https://en.wiktionary.org/wiki/Category:French_irregular_plurals_ending_in_%22-i%22
# Uncountable nouns!!!!!!