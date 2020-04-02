:- discontiguous hook/1.
:- public hook/1.

element_name(25/apa, "Arthur Middleton").
element_name(26/apa, "Samuel Chase").
element_name(27/apa, "George Clymer").

hook(element(Element, zip(unit^name, Name))) :- element_name(Element, Name).

element(Element) :- element_name(Element, _).

hook(element(Element, zip(Zipper, Now))) :- element(Element), zip(Zipper, Now).

zip(unit^frequency,     127500000).
zip(unit^modulation,    0).
zip(unit^skill,         "Average").
zip(unit^type,          "USS_Samuel_Chase").

hook(element(Element, echelon(apa))) :- element(Element).
hook(element(Element, country(usa))) :- element(Element).
