// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _events = [];

// List of positive events...
_events pushBack [
    "Drogendezernat hebt Drogenlabor aus", // Headline
    "Die Drogenversorgung bricht zusammen +++ Preise für Drogen explodieren", // Ticker line
    1, // price direction, 1 = up, 0 = down
    [ // names of goods to be influenced by this event
        "marijuana",
        "cocainep",
        "heroinp",
        "methp",
        "frogslsd",
        "crocodile"
    ]
];

_events pushBack [
    "Ölplattform durch Tsunami beschädigt",
    "Aufgrund des Engpasses steigen die Preise für Öl stark an",
    1,
    [
        "oilp"
    ]
];

_events pushBack [
    "De Beers plant Expansion auf Altis",
    "Die Spekulationen treiben die Diamanten- und Schmuckpreise in die Höhe",
    1,
    [
        "diamondc",
        "jewelry"
    ]
];

_events pushBack [
    "Bau GmbH plant Wolkenkratzer in Kavala",
    "Baumaterialien stark nachgefragt +++ Eisen-, Zement-, und Holzpreise steigen",
    1,
    [
        "cement",
        "iron_r",
        "holzp"
    ]
];

_events pushBack [
    "Gericht in Pyrgos verbietet Scheidung",
    "Nachfrage nach Alkohol steigt +++ Viele Ehemänner sehen dies als letzten Ausweg",
    1,
    [
        "moonshine",
        "brandy",
        "bottledbeer"
    ]
];

_events pushBack [
    "Raumfahrtzentrum plant Marsrover",
    "Wegen nötiger Bauteile steigt die Nachfrage aller Metalle",
    1,
    [
        "goldp",
        "silberp",
        "iron_r",
        "copper_r"
    ]
];

_events pushBack [
    "Banken sind pleite",
    "Anleger schichten Ihr Vermögen in Edelmetalle um +++ Preise steigen",
    1,
    [
        "goldp",
        "silberp",
        "jewelry"
    ]
];

_events pushBack [
    "Aquarium in Athira eröffnet",
    "Die Nachfrage nach Schildkröten steigt rasant an",
    1,
    [
        "turtle"
    ]
];

_events pushBack [
    "Terroristen planen schmutzige Bombe",
    "Das Uran soll von Altis importiert werden +++ Die Spekulationen treiben die Preise hoch",
    1,
    [
        "uranp", "uranp2"
    ]
];

_events pushBack [
    "Energie-Reserven knapp",
    "Windräder produzieren zu wenig Strom +++ Der Preis für verbrennbare Abfälle steigt rasant",
    1,
    [
        "trashp"
    ]
];

_events pushBack [
    "EU fördert den Bau neuer Kernkraftwerke",
    "Der Kernbrennstoff soll von Altis importiert werden +++ Die Spekulationen treiben die Preise hoch",
    1,
    [
        "uranp3"
    ]
];

_events pushBack [
    "Neuer verrückter Diktator greift nach der Macht",
    "Nachfrage nach Nervengas steigt rasant +++ Sarinpreise im Höhenflug",
    1,
    [
        "sarin"
    ]
];

// negative events

_events pushBack [
    "Synthetische Diamanten überfluten den Markt",
    "Fast so rein wie natürliche Diamanten: Keiner kauft mehr die Originalen",
    -1,
    [
        "diamondc",
        "jewelry"
    ]
];

_events pushBack [
    "Alkoholpanscher aufgeflogen",
    "Fälschungen bekannter Marken wurden in Sofia hergestellt +++ Preise für Alkohol sinken rasant",
    -1,
    [
        "moonshine",
        "brandy",
        "bottledbeer"
    ]
];

_events pushBack [
    "J4FG Gold AG schürfte Katzengold",
    "Die Edelmetallpreise stürzen aufgrund des Skandals ins Bodenlose",
    -1,
    [
        "goldp",
        "silberp",
        "jewelry"
    ]
];

_events pushBack [
    "Drogen überschwemmen Altis",
    "Billig importierte Drogen machen den lokalen Markt kaputt +++ Drogenpreise fallen rasant",
    -1,
    [
        "marijuana",
        "cocainep",
        "heroinp",
        "methp",
        "frogslsd",
        "crocodile"
    ]
];

_events pushBack [
    "Subventionen für Bauvorhaben gestrichen",
    "Zahlreiche Baustellen stehen still +++ Baumaterialien werden nicht mehr nachgefragt",
    -1,
    [
        "cement",
        "iron_r",
        "holzp"
    ]
];

_events pushBack [
    "Universität erfindet Super-Akku",
    "Elektroautos gehören die Zukunft +++ Der Ölpreis fällt rasant",
    -1,
    [
        "oilp"
    ]
];

_events pushBack [
    "Altis soll grüner werden",
    "Nach dem Planungsstopp des Kernkraftwerks soll die Uranförderung stillgelegt werden +++ Der Preis für Kernbrennstoff fällt",
    -1,
    [
        "uranp3"
    ]
];

_events pushBack [
    "Große Plutonium- und Uran 238-Bestände aus alten Sovjet-Lagern geklaut",
    "Die strahlende Ware wird zu Ramschpreisen auf dem Schwarzmarkt angeboten +++ Der Preis für die Produkte fällt",
    -1,
    [
        "uranp",
        "uranp2"
    ]
];

_events pushBack [
    "Konflikte im Nahen Osten beigelegt",
    "Nachfrage nach Nervengas schwindet rasant +++ Sarinpreise im Keller",
    -1,
    [
        "sarin"
    ]
];

private _nextPossibleEvent = time + 600;
private _lowCount = 0;

while { true } do {

    uisleep (550 + (random 100));

    MUTEX_MARKET call enterCriticalSection;

    private _priceBoost = _lowCount > 10;
    _lowCount = 0;

    // process resources...
    {
        private _shortName = _x select 0;
        private _normPrice = [_shortName] call XY_fnc_marketBasePrice;

        if( _shortName isEqualTo XY_resourceOfTheDay ) then {
            _normPrice = _normPrice * 3;
        };

        private _price = _x select 1;

        // Check if there has been sales volume for this item...
        private _salesVolume = 0;
        private _volumeRow = [];
        {
            if( (_x select 0) isEqualTo _shortName ) exitWith {
                _salesVolume = _x select 1;
                _volumeRow = _x;
            }
        } forEach XY_marketVolume;

        private _mod = 0;
        private _branch = "ERROR";

        private _config = [_shortName] call XY_fnc_itemConfig;
        private _sourceConfig = [_shortName] call XY_fnc_sourceConfig;

        // Process sales volume...
        if( _salesVolume > 0 ) then {

            private _volume = (round(_salesVolume / 15) max 75) min _salesVolume;
            if( _shortName isEqualTo XY_resourceOfTheDay ) then {
                _volume = _salesVolume;
            };

            _volumeRow set [1, _salesVolume - _volume];
            _branch = format[ "Processing %1 of %2, remaining: %3", _volume, _shortName, _volumeRow select 1 ];

            // Save new volume for resource
            [format["insertVolumelog:%1:%2", _shortName, _volumeRow select 1]] remoteExec ["XYDB_fnc_asyncCall", XYDB];

            private _volumeFactor = switch(true) do {
                case( _shortName isEqualTo XY_resourceOfTheDay ): { 0.2 };
                case(_price > _normPrice * 2): { 3 + (random 0.1) };
                case(_price > _normPrice * 1.66): { 2.5 + (random 0.1) };
                case(_price > _normPrice * 1.33): { 2 + (random 0.1) };
                case(_price > _normPrice): { 1.25 + (random 0.25) };
                case(_price < _normPrice * 0.5): { 0.8 + (random 0.1) };
                case(_price < _normPrice * 0.25): { 0.5 + (random 0.1) };
                case(_price < _normPrice * 0.1): { 0.1 + (random 0.1) };
                default { 1 + (random 0.25) };
            };

            private _newPrice = (1 + (random 100)) max (_price - (_volume * _volumeFactor) / 100.0);

            if( _shortName isEqualTo "copper_r" ) then {
                // noob-friendly min. price for copper, masked by some randomness
                _newPrice = ((8 + (random 3)) max _newPrice);
            };

            _lowCount = _lowCount + 1;

            _mod = _newPrice - _price;

        } else {

            if( _price < _normPrice ) then {
                _lowCount = _lowCount + 1;
                _mod = (_normPrice / (_sourceConfig select 1)) / 4;
                _branch = "< NORM";
            } else {
                if( _price > ( _normPrice * 1.5 ) ) then {
                    _mod = ((count allPlayers) * ((random 1) max 0.3)) * 0.015;
                    _branch = "> 150%";
                } else {
                    _mod = (count allPlayers) * 0.0166;
                    _branch = ">= NORM";
                };

                if( _priceBoost ) then {
                    _branch = format["%1 (BOOST)", _branch];
                    _mod = _mod * 1.25;
                };
            };

            if( _config select 5 ) then {
                // illegal item, boost price by cop count...
                _mod = _mod * (1 + ((playersNumber west) / 600));
            };

            // normalize price to item weight
            _mod = _mod * (_sourceConfig select 1);
        };

        diag_log format[ "<MARKET> Changed: %1 to %2$ (from %3$ by %4$, NORM: %5$, BRANCH: %6)", _shortName, _price + _mod, _price, _mod, _normPrice, _branch ];
        _price = _price + _mod;

        // Short-term price change
        _x set [3, _mod];
        // Long-term price change
        _x set [2, _price - _normPrice];
        // New price
        _x set [1, _price];

    } forEach XY_marketPrices;

    // random event chance

    if( _nextPossibleEvent < time && XY_RTC_REMAININGMINUTES > 30 && (random 100) < 9 ) then {
        _nextPossibleEvent = time + (4500 + (random 2500));

        private _event = selectRandom _events;

        diag_log format["<MARKET> Event triggered: %1", _event select 0];
        [3, _event select 0, _event select 1] remoteExec ["XY_fnc_broadcast", civilian];

        private _direction = _event select 2;
        private _changes = _event select 3;

        // change market
        {
            private _shortName = _x;
            {
                if( (_x select 0) isEqualTo _shortName ) exitWith {

                    private _price = _x select 1;
                    private _normPrice = [_shortName] call XY_fnc_marketBasePrice;
                    private _newPrice = 0;

                    if( _direction > 0 ) then {
                        // We're going upwards, double norm price ftw.
                        _newPrice = (_price * 1.2) max (_normPrice * 2.0);
                    } else {
                        // We're going down, breach down to fractions the norm price
                        private _factor = (0.5 * (random 1)) max 0.1;
                        _newPrice = (_price * _factor) min (_normPrice * _factor);
                        // Add artifical volume to hold price down a few iterations
                        {
                            if( (_x select 0) isEqualTo _shortName ) exitWith {
                                _x set[1, (_x select 1) + 200];
                            };
                        } forEach XY_marketVolume;
                    };

                    diag_log format[ "<MARKET> Disturbing market value of %1 from %2$ to %3$ by %4$", _shortName, _x select 1, _newPrice, _newPrice - (_x select 1) ];

                    // Short-term price change
                    _x set [3, _newPrice - (_x select 1)];
                    // Long-term price change
                    _x set [2, _newPrice - _normPrice];
                    // New price
                    _x set [1, _newPrice];

                };
            } forEach XY_marketPrices;

        } forEach _changes;
    };

    // Save changes
    {
        [ format["insertPricelog:%1:%2", _x select 0, _x select 1 ] ] remoteExec [ "XYDB_fnc_asyncCall", XYDB ];
    } forEach XY_marketPrices;

    MUTEX_MARKET call leaveCriticalSection;

    // Publish
    publicVariable "XY_marketPrices";
    // Update item prices:
    call XY_fnc_marketUpdate;

    // Log
    call XY_fnc_marketLogger;
};