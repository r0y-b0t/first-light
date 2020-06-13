:- discontiguous hook/1.
:- public hook/1.

hook(echelon(11/group/raf, country(uk))).

squadron(19,    "QV",   luton).
squadron(41,    "EB",   mitor).
squadron(54,    "KL",   rabbit).
squadron(64,    "SH",   freema).
squadron(66,    "LZ",   fibius).
squadron(72,    "RN",   tennis).
squadron(74,    "ZP",   dysoe).
squadron(92,    "QJ",   gannic).

section(red,    0'A,    a).
section(yellow, 0'J,    a).
section(blue,   0'P,    b).
section(green,  0'X,    b).

element(Element) :- between(1, 3, Element).

hook(element(Element, section(Section))) :-
    element_section(Element, Section).

element_section(Element/Section/Squadron/raf, Section/Squadron/raf) :-
    squadron(_, _, Squadron),
    section(Section, _, _),
    element(Element).

hook(section(Section, echelon(11/group/raf))) :-
    section_name(Section, _).
hook(section(Section, zip(group^name, Name))) :-
    section_name(Section, Name).

section_name(Section/Squadron/raf, Name) :-
    section_name_(Section/Squadron/raf, Name0),
    format(string(Name), '~s Section', [Name0]).

section_name_(Section/Squadron/raf, Name) :-
    squadron(No, _, Squadron),
    section(Section, _, Flight),
    restyle_identifier('OneTwo', Squadron, Squadron_),
    restyle_identifier('OneTwo', Flight, Flight_),
    restyle_identifier('OneTwo', Section, Section_),
    format(string(Name),
           '~d Sqn (~s) ~s-Flight ~s',
           [No, Squadron_, Flight_, Section_]).

hook(element(Element, zip(unit^name, Name))) :-
    element_name(Element, Name).

element_name(Element/Section/Squadron/raf, Name) :-
    element(Element),
    section_name_(Section/Squadron/raf, Name0),
    format(string(Name), '~s-~d', [Name0, Element]).

hook(element(Element, zip(Zipper, Now))) :-
    element_name(Element, _),
    spitfire(Zipper, Now).

spitfire(unit^'Radio'/'Radio'^1/'Radio'^channels/channels^1,124).
spitfire(unit^'Radio'/'Radio'^1/'Radio'^channels/channels^2,40).
spitfire(unit^'Radio'/'Radio'^1/'Radio'^channels/channels^3,41).
spitfire(unit^'Radio'/'Radio'^1/'Radio'^channels/channels^4,42).
spitfire(unit^livery_id,"RAF Standard").
spitfire(unit^payload/payload^chaff,0).
spitfire(unit^payload/payload^flare,0).
spitfire(unit^payload/payload^fuel,247).
spitfire(unit^payload/payload^gun,100).
spitfire(unit^payload/payload^pylons,[]).
spitfire(unit^psi,0).
spitfire(unit^skill,"Client").
spitfire(unit^type,"SpitfireLFMkIX").

hook(element(Element, zip(unit^onboard_num, OnboardNum))) :-
    element_onboard_num(Element, OnboardNum).

element_onboard_num(Element/Section/Squadron/raf, OnboardNum) :-
    element_section(Element/Section/Squadron/raf, Section/Squadron/raf),
    squadron(_, OnboardNum12, Squadron),
    section(Section, OnboardNum3_, _),
    OnboardNum3 is OnboardNum3_ + Element - 1,
    format(string(OnboardNum), '~s~c', [OnboardNum12, OnboardNum3]).

payload(
    section(Section),
    group{ communication:true,
           frequency:124,
           hidden:false,
           modulation:0,
           name:Name,
           radioSet:false,
           task:"CAP",
           tasks:[],
           uncontrolled:false
         }) :-
    section_name(Section, Name).
payload(
    element(Element),
    unit{ callsign:callsign{1:1,2:1,3:1,name:"Enfield11"},
          livery_id:"RAF Standard",
          name:Name,
          onboard_num:OnboardNum,
          payload:payload{ ammo_type:1,
                           chaff:0,
                           flare:0,
                           fuel:247,
                           gun:100,
                           pylons:[]
                         },
          psi:0,
          skill:"Client",
          type:"SpitfireLFMkIX"
        }) :-
    element_name(Element, Name),
    element_onboard_num(Element, OnboardNum).

hook(section(Section, payload(Payload))) :- payload(section(Section), Payload).
hook(element(Element, payload(Payload))) :- payload(element(Element), Payload).
