domains
 list = integer*.

predicates
 nondeterm fib(integer, integer).
 nondeterm fib(integer, integer, integer, integer).
 nondeterm fact(integer, integer).
 nondeterm fact(integer, integer, integer).
 nondeterm length(list, integer).
 nondeterm length(list, integer, integer).
 nondeterm sum(list, integer).
 nondeterm sum(list, integer, integer).
 nondeterm sumOdd(list, integer).
 nondeterm sumOdd(list, integer, integer).
 nondeterm sumEven(list, integer).
 nondeterm append(list, list, list).
 nondeterm filterGt(integer, list, list).
 nondeterm filterGt(integer, list, list, list).
 nondeterm deleteAll(integer, list, list).
 nondeterm deleteAll(integer, list, list, list).
 nondeterm union(list, list, list).

clauses
 fib(0, F, _, F).
 fib(1, _, S, S).
 fib(N, F, S, R)
  :- N > 1, T = F + S, N1 = N - 1, fib(N1, S, T, R).
 fib(N, R)
  :- fib(N, 0, 1, R).

 fact(0, _, 1).
 fact(1, Acc, Acc).
 fact(N, Acc, Res)
  :- N > 1, N1 = N - 1, NewAcc = Acc * N, fact(N1, NewAcc, Res).
 fact(N, R)
  :- fact(N, 1, R).

 length([], Acc, Acc).
 length([_|T], Acc, Res)
  :- Acc1 = Acc + 1, length(T, Acc1, Res).
 length(Lst, Res)
  :- length(Lst, 0, Res).

 sum([], Acc, Acc).
 sum([H|T], Acc, Res)
  :- Acc1 = Acc + H, sum(T, Acc1, Res).
 sum(Lst, Res)
  :- sum(Lst, 0, Res).

 sumOdd([], Acc, Acc).
 sumOdd([_], Acc, Acc).
 sumOdd([_, H2|T], Acc, Res)
  :- Acc1 = Acc + H2, sumOdd(T, Acc1, Res).
 sumOdd(Lst, Res)
  :- sumOdd(Lst, 0, Res).

 sumEven([], 0).
 sumEven([H|T], Res)
  :- sumOdd(T, H, Res).

 append([], Lst, Lst).
 append([H1|T1], Lst, [H1|T3])
  :- append(T1, Lst, T3).

 filterGt(_, [], AccLst, AccLst).
 filterGt(X, [H|T], AccLst, ResLst)
  :- X < H, append(AccLst, [H], NewAccLst), filterGt(X, T, NewAccLst, ResLst), !.
 filterGt(X, [_|T], AccLst, ResLst)
  :- filterGt(X, T, AccLst, ResLst).
 filterGt(X, Lst, Res)
  :- filterGt(X, Lst, [], Res).

 deleteAll(_, [], AccLst, AccLst).
 deleteAll(H, [H|T], AccLst, ResLst)
  :- deleteAll(H, T, AccLst, ResLst), !.
 deleteAll(X, [H|T], AccLst, ResLst)
  :- append(AccLst, [H], NewAccLst), deleteAll(X, T, NewAccLst, ResLst).
 deleteAll(X, Lst, Res)
  :- deleteAll(X, Lst, [], Res).

 union(A, B, R) :- append(A, B, R).

goal
 /* deleteAll(9, [1, 9, 1, 2, 1, 8, 0, 3, 7, 1, 4, 6, 5, 1], R). */
 fact(10, R).
