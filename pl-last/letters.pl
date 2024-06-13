% Буквы
letter(а).
letter(б).
letter(в).
letter(г).
letter(д).
letter(е).
letter(ё).
letter(ж).
letter(з).
letter(и).
letter(й).
letter(к).
letter(л).
letter(м).
letter(н).
letter(о).
letter(п).
letter(р).
letter(с).
letter(т).
letter(у).
letter(ф).
letter(х).
letter(ц).
letter(ч).
letter(ш).
letter(щ).
letter(ъ).
letter(ы).
letter(ь).
letter(э).
letter(ю).
letter(я).

% Гласные
vowel(а).
vowel(я).
vowel(у).
vowel(ю).
vowel(о).
vowel(ё).
vowel(ы).
vowel(и).
vowel(э).
vowel(е).
consonant(L) :- letter(L), not(vowel(L)).

% Звонкие
soundless(ъ).
soundless(ь).
voiced(б).
voiced(в).
voiced(г).
voiced(д).
voiced(ж).
voiced(з).
voiced(й).
voiced(л).
voiced(м).
voiced(н).
voiced(р).
voiceless(L) :- consonant(L), not(voiced(L)), not(soundless(L)).

% Парные
pair(б, п).
pair(в, ф).
pair(г, к).
pair(д, т).
pair(ж, ш).
pair(з, с).
paired(L) :- pair(L, _); pair(_, L).
pairless(L) :- consonant(L), not(paired(L)), not(soundless(L)).

property(L, гласная)    :- vowel(L).
property(L, согласная)  :- consonant(L).
property(L, беззвучная) :- soundless(L).
property(L, звонкая)    :- voiced(L).
property(L, глухая)     :- voiceless(L).
property(L, парная)     :- paired(L).
property(L, непарная)   :- pairless(L).

properties(L, Ps) :- findall(P, property(L, P), Ps).
