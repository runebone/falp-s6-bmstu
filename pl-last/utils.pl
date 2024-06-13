random_element(List, Element) :-
    length(List, Length),
    Length > 0,
    MaxIndex is Length + 1,
    random(1, MaxIndex, Index),
    nth1(Index, List, Element).

word_properties([], []).
word_properties([L|Ls], [P|Ps]) :-
    properties(L, P),
    word_properties(Ls, Ps).

words_properties([], []).
words_properties([W|Ws], [WP|WPs]) :-
    word_properties(W, WP),
    words_properties(Ws, WPs).

same_properties(L1, L2) :- properties(L1, Ps), properties(L2, Ps).

gen_list(Length, MaxValue, List) :-
    gen_list_helper(Length, MaxValue, [], List).

gen_list_helper(0, _, Acc, Acc) :- !.
gen_list_helper(Length, MaxValue, Acc, List) :-
    Length > 0,
    random_between(1, MaxValue, RandomValue),
    NewLength is Length - 1,
    gen_list_helper(NewLength, MaxValue, [RandomValue|Acc], List).
