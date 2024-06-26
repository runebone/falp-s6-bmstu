use_module(library(clpfd)). % for transpose
:- consult(nouns).
:- consult(letters).
:- consult(utils).

% По слову сгенерировать N слов, где в каждом столбце ровно одна буква подходит под описание исходного слова.
solution(W, RRWs, N, List) :-
    length(W, Len),
    gen_list(Len, N, List),
    word_properties(W, WPs),
    gen_words(WPs, List, N, RWs),
    reverse(RWs, RRWs).

gen_words(WPs, L, N, RWs) :-
    gen_words_props(WPs, L, N, RWPss),
    gen_words_by_props(RWPss, RWs).

gen_words_props(_, _, 0, []) :- !.
gen_words_props(WPs, L, N, [RWPs|RWPss]) :-
    gen_rwps(WPs, L, N, RWPs),
    NewN is N - 1,
    gen_words_props(WPs, L, NewN, RWPss).

gen_rwps([], [], _, []) :- !.
gen_rwps([WP|WPs], [LH|LT], N, [RWP|RWPs]) :-
    gen_letter_props(WP, LH, N, RWP),
    gen_rwps(WPs, LT, N, RWPs).

gen_letter_props(WP, N, N, WP) :- !.
gen_letter_props(WP, _, _, RWP) :- dif(RWP, WP).

gen_words_by_props([], []) :- !.
gen_words_by_props([RWPs|RWPss], [RW|RWs]) :-
    gen_word_by_props(RWPs, RW),
    gen_words_by_props(RWPss, RWs).

gen_word_by_props(RWPs, RW) :-
    length(RWPs, Len),
    noun(RW, Len),
    word_properties(RW, RWPs).

% По кортежу слов [W|Ws] и описанию свойств букв искомого слова [P|Ps] составить слово из букв слов исходного кортежа. Гарантируется, что в каждом столбце [W|Ws] ровно одна буква подходит под описание соответствующей буквы из [P|Ps].
reverse_solution([W|Ws], [P|Ps], [RW|RWs]) :-
    length(W, Len),
    transpose([W|Ws], [T|Ts]),
    get_best_fit_letter(T, P, RW),
    NewLen is Len - 1,
    reverse_solution_helper(Ts, Ps, RWs, NewLen).

get_best_fit_letter([L|_], Ps, L) :-
    properties(L, Ps), !.
get_best_fit_letter([_|Ls], Ps, R) :-
    get_best_fit_letter(Ls, Ps, R).

reverse_solution_helper([], [], [], 0) :- !.
reverse_solution_helper([W|Ws], [P|Ps], [RW|RWs], Acc) :-
    get_best_fit_letter(W, P, RW),
    NewAcc is Acc - 1,
    reverse_solution_helper(Ws, Ps, RWs, NewAcc).

% ?- W = [е,л,ь], solution(W, RWs, 3, List).
% ?- W = [в,р,е,м,я], solution(W, RWs, 3, List).
% ?- W = [е,л,ь], word_properties(W, WPs), solution(W, RWs, 3, List), reverse_solution(RWs, WPs, RS).
% ?- W = [в,р,е,м,я], word_properties(W, WPs), solution(W, RWs, 3, List), reverse_solution(RWs, WPs, RS).
% ?- W = [й,о,д], solution(W, Q, 3, L), word_properties(W, WPs), words_properties(Q, QPs).
