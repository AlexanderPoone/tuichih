class Category {
    String id;                                              // cGeographicalEntity
    enum pos;							// CategoryPos		// POS.vt
    String name;                                            // '地名'
    String url;                                             // https://www.wikidata.org/Q123
    String parentCategoryId = null;                         // 'cProperNoun'
    String[] subcategoryIds;                                // {'cLake', 'cRiver', 'cCountry'}
    String[] corpus;                                        // {'阿爾巴尼亞', '百慕逹'}
}

enum POS {
	n = 0,
	vt = 1,
	vi = 2,
	adj = 3,
	adv = 4,
	pron = 5,
	prep = 6,
	a = 7,
	interj = 8
}

function parseJSON() {

    standardisePunctuations(s);                             // in-place function
    for (s in breakIntoSentences()) {
        breakIntoClauses();
    }

    let fs = require('fs');
    let files = fs.readdirSync('../rules');

    let jsonArr = [];
    for (let x in files) {
        jsonArr.concat(x);
        // Search by keys
        while (json.next()) {
            if (obj.has('assertPos')) assertPos(clause, '', 0, 'vt');
            if (obj.has('aura')) aura(categoryId, 'cGeographicalEntity');
            if (obj.has('lookbehindClause')) lookbehindClause('', 3);
            if (obj.has('lookafterClause')) lookafterClause('', 0);
        }
    }
}

function assertPos(clause, sfregex, occurence, pos) {
    arrayOfEnum = buildParseTree(clause);                 // NER
    let o = 1;
    // if x is very big then start from the end
    arrayOfEnum.forEach( function(p) {
        if (p == pos) 
        {
            if (o == occurence) {
                return true;
            }
            else o++;
        }
    });
    return false;
}

function aura(categoryId, sfregex) {
    category = findCategoryById(categoryId);
    let found = false;
    for (s in category.sfrbase)
    { 
        found = lookbehindSentence(s, Constant.auraNumSentence);
        if (!found) {
            found = lookafterSentence(s, Constant.auraNumSentence);
        }
    }
    return found;
}

function lookbehindClause(sfregex, numClauses) {
    let trigger = "2", regexp = new RegExp('^[1-9]\d{0,2}$'), test = regexp.test(trigger);
    return true;
}

function lookafterClause(sfregex, numClauses) {
    return true;
}

function replace(clauseSentenceArray, oldSfregex, newSfregex) {
    // Parse Sfregex logic here
    listOfJsRegexPairs = generateStringListFromSfregex(oldSfregex, newSfregex)
    clauseSentenceArray.replace(oldPartialJsRegex, newPartialJsRegex);
}

function generateStringListFromSfregex(oldSfregex, newSfregex) {
	let listOfJsRegexPairs = [];
	// c(a|b)		(d|e)(a|b) => [(x, y), (z, zz), (zzz, zzzz)...]
	return listOfJsRegexPairs;
}