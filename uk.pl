:- discontiguous hook/1.
:- public hook/1.

airdrome(needs_oar_point).
airdrome(funtington).
airdrome(tangmere).
airdrome(ford_af).
airdrome(chailey).

hook(airdrome(Airdrome, country(uk))) :- airdrome(Airdrome).

hook(fix(coalition(Airdrome), blue)) :-
    airdrome(Airdrome),
    \+ currently(coalition(Airdrome), _).

airdrome_point(Airdrome, Point) :-
    airdrome(Airdrome),
    airdrome_property(Airdrome, reference(point(Point))).

hook(add(section(_/_/raf), Point)) :-
    findall(Point_, airdrome_point(_, Point_), Points),
    random_member(Point0, Points),
    Point0 =.. [Terrain, X, Z],
    random_between(10 000, 15 000, Y),
    Point =.. [Terrain, X, Y, Z].
