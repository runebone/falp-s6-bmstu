with open('nouns.txt', 'r') as f:
    words = f.read().splitlines()

words_with_lengths = list(map(lambda word: "{:02d} {}".format(len(word), word), words))

with open('nouns-with-lengths.txt', 'w') as f:
    f.write('\n'.join(words_with_lengths))
