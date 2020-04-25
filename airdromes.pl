%!  airdrome_country(+Airdrome, -Country) is semidet.
%
%   Use Needs Oar Point, Hampshire,  to   determine  the country of each
%   aerodrome based on their reference point within the Normandy theatre
%   of war. This assumes  that  Needs   is  southmost  within the United
%   Kingdom, and that no other French  aerodrome lies further north than
%   Needs. This will need modifying if these assumptions change.
%
%   Take care to select only aerodromes  within the Normandy theatre for
%   their  northing.  By  default,    airdrome_property/2  accesses  all
%   aerodromes throughout the world.

airdrome_country(Airdrome, fra) :-
    airdrome_northing(needs_oar_point, Northing0),
    airdrome_northing(Airdrome, Northing),
    Northing < Northing0,
    !.
airdrome_country(_Airdrome, uk).

airdrome_northing(Airdrome, Northing) :-
    airdrome_property(Airdrome, terrain(normandy)),
    airdrome_property(Airdrome, reference(point(Point))),
    point_property(Point, northing(Northing)).

hook(airdrome(Airdrome, country(Country))) :-
    airdrome_property(Airdrome, terrain(normandy)),
    airdrome_country(Airdrome, Country).
