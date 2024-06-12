import pymorphy2
from tqdm import tqdm

morph = pymorphy2.MorphAnalyzer()

with open('russian.utf-8', 'r', encoding='utf-8') as f:
    words = f.read().splitlines()

nouns = set()

for word in tqdm(words):
    parsed_word = morph.parse(word)[0]
    if 'NOUN' in parsed_word.tag and 'Name' not in parsed_word.tag:
        nouns.add(parsed_word.normal_form)

with open('nouns.txt', 'w', encoding='utf-8') as f:
    for noun in sorted(nouns):
        f.write(noun + '\n')

print("Done")
