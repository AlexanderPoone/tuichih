# Solidarity
<p align="center">
<img src="https://drive.google.com/uc?export=view&id=1ghaysvquwMPmQWyoN5Zmxku1MdGQzZZ9" />
</p>
<p align="center"><strong>多國語言　　繕改程式</strong></p>
<!-- Introduction -->

I don't think people at https://github.com/jazzband/inflect do not have a clear understanding of linguistics.

__What is a basilect?__

A basilect is a culturally weak dialect. The Han Basilect is extensively used among all social classes, both colloquially and formally. Newscasters and prominent government officials used it on a daily basis.

In fact, almost everyone in China use the Chinese basilect in last century's standards. 

Tags: proofing tools, language, basilect, linguisitic purism.

Now we have pidgin Chinese, made by the Chinese themeselves, in addition to pidgin English
Resistance is futile.

The project, thus, is dedicated to style and linguistic purity. I am opposed to machine translation, but technology is at least useful in filtering out nauseating expressions.

## How does it work?
Tules are coded using the RLL Logic Language. Definitions are based on web content. Web content are scraped and processed at HKT 06:00 (GMT 22:00) every day.

## The RLL Logic Language (*.rll)
RLL is a logical language designed for rule-based lexical analysis. It compiles to YAML.
The RLL Compiler compiles rules from top to bottom and **ORDER MATTERS**. Your rules can be overridden by some rule(s) below.

Implementations of RLL include the mobile application **Zai Lihk**.

### Severity
Severity	Description	Example
High	Unacceptible mistakes
Medium	Common mistakes
Low	Suggestions	們 眾

### Operations
a = b													Replacement
a = b, c, d 											Multiple replacements
expToBeDeleted ~										Deletion
((ab|cd))abc((ef|gh)) = x((ef|gh))y((ab|cd))			Retainment (both sides must be the same)

### Matching
[completely|entirely] optional  						Optional
(either|or)												Or
^(not|never)											Not
?()														Non-capturing
?^()													Non-capturing not
~happy													Word plus synonyms
~(well done)											Expression plus synonyms

<@animals|@buildings>									Semantic Categories (cf. Semantic Categories definition)
<v|n|adj|adv|art|prep|pron|proper>						Parts of speech
<+|->													Sentiment (laudatory and derogatory)
<inf|fml>												Formality
<@animals,v,+,fml>										Combination of the above four
<*>														Wildcard (Matches all recorded expressions. If there is a phrase, matches the whole phrase.)
delim													Punctuation marks
ldelim(祖)												Character left of a punctuation mark, same as (祖)?(delim)
rdelim(祖)												Character right of a punctuation mark, same as ?(delim)(祖)

### Aura
{5.@animals}											Aura: Search 5 words/CKJ characters before for the Semantic Category for animals
{@animals.5}											Aura: Search 5 words/CKJ characters after for the Semantic Category for animals
{5.@animals.10}											Aura: Search 5 words/CKJ characters before, and 10 words/CKJ characters after for the Semantic Category for animals
{5.(@animals|@plants).10}								Aura: Search 5 words/CKJ characters before, and 10 words/CKJ characters after for the Semantic Category for animals or plants

### Comments
/* this is a comment */									Comment

## Features

### General
* Removes double spaces
* Replaces tabs with spaces
* Adds space before opening parantheses

### 漢語（國語及粵語）
* 阿拉伯數字 → 中文數字（年、月、日）
/* Keep condition: [In|Before|After] (mid-)+ 1939 */
* % /「巴仙」 → 百分之
* 統一中文標點符號
/* 首先統一中文標點符號，再判斷有關詞藻是否在同一句。 */
* 多餘「一」字
* 「妳」、「您」等 → 「你」
* 多餘空白 與 中、英字間隔 Dash英文字母符號前後
* 歐化惡詞（煉字）
* 日化惡詞（煉字）
* 紅色惡詞（煉字）
* 金元譯音（維基百科）
* 統一粵語字 /* Yet to name the standardisation */ e.g. 「俾」 → 「畀」
* 刪小農歎詞 (麼。咱們。噯呀。唷。唏。)
* 「$ → 元」等

### 英語
* 阿拉伯數字 → 英文數字（十或以下）
* 保守whom, whomever
* 英語濫用字 ('challenge (n)', 'epic (adj)', cf. McMillan\'s Manual of Style)
* £ → pound(s) etc.

### 法語
* Point -> virgule 法語小數點寫法轉換 
* Orthographe (e.g. guillemets)
* Remplacer les anglicismes (selon l\'Académie française / as per Académie française)
* € → euro(s) etc.

### Project Structure
p00_nouns:
include(g00)
include(cp00) /* Cantonese locutions */


p01_verbs:

p02_adjective

Temporarily 3 categories


十位是0個位不是0 = 「零」
Lenses: 1. POS; 2. Inspection

### 德語
#### General algorithm
All accented words:
Remove umlaut
Not in German and Not in English
Insert non-umlaut word<tab>umlaut word

Download one by one: https://en.wiktionary.org/w/index.php?title=Category:German_lemmas
No morphemes.

Plurals: some plural nouns may not have pages. Check presence of


Proper nouns are NOT invariable in some languages, like Polish and Russian.

Article-adjective-noun stack
3rd layer - noun - Error?
(2nd layer flach - adj. detected. Error? No, continue.)
1st layer ein/fünf


### UI
• Accordion with header icon
<cog-icon> Tasks
• Convert currency symbols to text (money logo)

## Roadmap

### 漢語（國語及粵語）
* 修正絕句或律詩之平仄與格律

### 法語
* Conversion entre l'orthographe classque et l'orthographe 1990

## Compendium of Basilects
<!-- Redirects to our wiki -->

## Disgust Index
PageRank

<!-- ## Donate -->
