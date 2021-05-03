safe(_, _, []) :- !.
safe(X, Y, [[X2|Y2]|People]) :- 
    sqrt((X2 - X)^2 + (Y2 - Y)^2) >= 6, safe(X, Y, People).

not_member(_, []) :- !.
not_member(X, [Head|Tail]) :-
     X \= Head,
    not_member(X, Tail).

move(X, Y, X2, Y2) :-
    X2 is X, Y2 is Y + 1.
move(X, Y, X2, Y2) :-
    X2 is X + 1, Y2 is Y.
move(X, Y, X2, Y2) :-
    X2 is X - 1, Y2 is Y.

%user-facing solve()
solve([Start_x, Start_y], End_y, [Grid_x, Grid_y], People, Ans_path) :- 
    solve([Start_x, Start_y], End_y, [Grid_x, Grid_y], People, _, [Start_x, Start_y], Ans_path).

solve(_, End_Y, _, _, Ans_path, [_, End_Y], Temp_path) :- 
    Temp_path = Ans_path,!.

solve([Start_x, Start_y], End_y, [Grid_x, Grid_y], People, Ans_path, [X, Y], Temp_path) :- 
    move(X, Y, X2, Y2), safe(X2, Y2, People), X2 =< Grid_x, X2 > 0, Y2 > 0,
    append(Ans_path, [[X2, Y2]], New_path),
    not_member([X2, Y2], Ans_path),
    solve([Start_x, Start_y], End_y, [Grid_x, Grid_y], People, New_path, [X2, Y2], Temp_path).

%solve([starting x, starting y], ending y, [max grid x, max grid y], [people], solution array)
%Ex: solve([13,0],24,[25,25],[[20,4],[13,7],[4,19]],P).
