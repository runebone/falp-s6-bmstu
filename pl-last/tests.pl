[main].

:- begin_tests(my_tests).

test(props) :-
    properties(а, А),
    assertion(А == [гласная]),

    properties(б, Б),
    assertion(Б == [согласная, звонкая, парная]),

    properties(в, В),
    assertion(В == [согласная, звонкая, парная]),

    properties(г, Г),
    assertion(Г == [согласная, звонкая, парная]),

    properties(д, Д),
    assertion(Д == [согласная, звонкая, парная]),

    properties(е, Е),
    assertion(Е == [гласная]),

    properties(ё, Ё),
    assertion(Ё == [гласная]),

    properties(ж, Ж),
    assertion(Ж == [согласная, звонкая, парная]),

    properties(з, З),
    assertion(З == [согласная, звонкая, парная]),

    properties(и, И),
    assertion(И == [гласная]),

    properties(й, Й),
    assertion(Й == [согласная, звонкая, непарная]),

    properties(к, К),
    assertion(К == [согласная, глухая, парная]),

    properties(л, Л),
    assertion(Л == [согласная, звонкая, непарная]),

    properties(м, М),
    assertion(М == [согласная, звонкая, непарная]),

    properties(н, Н),
    assertion(Н == [согласная, звонкая, непарная]),

    properties(о, О),
    assertion(О == [гласная]),

    properties(п, П),
    assertion(П == [согласная, глухая, парная]),

    properties(р, Р),
    assertion(Р == [согласная, звонкая, непарная]),

    properties(с, С),
    assertion(С == [согласная, глухая, парная]),

    properties(т, Т),
    assertion(Т == [согласная, глухая, парная]),

    properties(у, У),
    assertion(У == [гласная]),

    properties(ф, Ф),
    assertion(Ф == [согласная, глухая, парная]),

    properties(х, Х),
    assertion(Х == [согласная, глухая, непарная]),

    properties(ц, Ц),
    assertion(Ц == [согласная, глухая, непарная]),

    properties(ч, Ч),
    assertion(Ч == [согласная, глухая, непарная]),

    properties(ш, Ш),
    assertion(Ш == [согласная, глухая, парная]),

    properties(щ, Щ),
    assertion(Щ == [согласная, глухая, непарная]),

    properties(ъ, Ъ),
    assertion(Ъ == [согласная, беззвучная]),

    properties(ы, Ы),
    assertion(Ы == [гласная]),

    properties(ь, Ь),
    assertion(Ь == [согласная, беззвучная]),

    properties(э, Э),
    assertion(Э == [гласная]),

    properties(ю, Ю),
    assertion(Ю == [гласная]),

    properties(я, Я),
    assertion(Я == [гласная]).

test(word_props) :-
    word_properties([е, л, ь], Ель),
    properties(е, Е1),
    properties(л, Л1),
    properties(ь, Ь1),
    assertion(Ель == [Е1, Л1, Ь1]),

    word_properties([в, р, е, м, я], Время),
    properties(в, В2),
    properties(р, Р2),
    properties(е, Е2),
    properties(м, М2),
    properties(я, Я2),
    assertion(Время == [В2, Р2, Е2, М2, Я2]),

    word_properties([о, б, е, з, ь, я, н, а], Обезьяна),
    properties(о, О3),
    properties(б, Б3),
    properties(е, Е3),
    properties(з, З3),
    properties(ь, Ь3),
    properties(я, Я3),
    properties(н, Н3),
    properties(а, А3),
    assertion(Обезьяна == [О3, Б3, Е3, З3, Ь3, Я3, Н3, А3]).

test(same_props) :-
    same_properties(а, я),
    same_properties(б, в),
    same_properties(й, р),
    same_properties(ь, ъ),
    not(same_properties(г, к)),
    not(same_properties(а, щ)),
    same_properties(о, о).

test(gen_word_by_props) :-
    word_properties([к, о, з, а], WPs1),
    gen_word_by_props(WPs1, W1),
    assertion(W1 == [к, а, б, а]),

    word_properties([е, л, ь], WPs2),
    gen_word_by_props(WPs2, W2),
    assertion(W2 == [е, л, ь]).

test(gen_words_by_props) :-
    W1 = [к, о, з, а],
    W2 = [е, л, ь],
    W3 = [к, а, б, а],
    word_properties(W1, WPs1),
    word_properties(W2, WPs2),
    gen_words_by_props([WPs1, WPs2], Words),
    assertion(Words == [W3, W2]).

test(gen_letter_props) :-
    L1 = а,
    properties(L1, LPs1),
    gen_letter_props(LPs1, 1, 1, LPs1),
    dif(LPs1, LPs2),
    gen_letter_props(LPs1, 1, 2, LPs2).

test(gen_rwps) :-
    W1 = [е, л, ь],
    W2 = [л, е, с],
    word_properties(W1, WPs1),
    word_properties(W2, WPs2),
    List = [1, 2, 1],
    gen_rwps(WPs1, List, 1, RWPs1),
    gen_rwps(WPs2, List, 2, RWPs2),
    properties(е, Е),
    properties(л, Л),
    properties(ь, Ь),
    properties(с, С),
    RWPs1 = [Е, НеЛ, Ь],
    RWPs2 = [НеЛ, Е, НеС],
    assertion(not(НеЛ = Л)),
    assertion(not(НеС = С)).

test(get_best_fit_letter) :-
    W1 = [е, л, ь],
    Ps1 = [гласная],
    Ps2 = [согласная, звонкая, непарная],
    Ps3 = [согласная, беззвучная],
    get_best_fit_letter(W1, Ps1, X),
    get_best_fit_letter(W1, Ps2, Y),
    get_best_fit_letter(W1, Ps3, Z),
    assertion(X == е),
    assertion(Y == л),
    assertion(Z == ь).

:- end_tests(my_tests).
