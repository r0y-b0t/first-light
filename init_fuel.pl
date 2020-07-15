airdrome(Airdrome) :- airdrome_property(Airdrome, terrain(the_channel)).

unlimited(unlimitedFuel).
unlimited(unlimitedAircrafts).
unlimited(unlimitedMunitions).

init_fuel(diesel).
init_fuel(gasoline).
init_fuel(jet_fuel).
init_fuel(methanol_mixture).

currently(airport(Airdrome, Unlimited), false) :-
    airdrome(Airdrome),
    unlimited(Unlimited).
currently(airport(Airdrome, Situation), 10) :-
    airdrome(Airdrome),
    init_fuel(InitFuel),
    Situation =.. [InitFuel, 'InitFuel'].

hook(currently(Situation, Current)) :- currently(Situation, Current).
