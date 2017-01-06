// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

"SurvivalTracker" spawn { scriptName _this;

    // 30s call interval
    // increment of 0.005 means
    // 1 / 0.005 * 30 = 6000s until starvation ~ 1 3/5 hour

    // player movement goes into the calculation as 5 percent per kilometer

    private _fnc_food = {

        XY_hunger = XY_hunger + 0.005;
        // Add in player movement
        if( _this > 0 ) then {
            XY_hunger = XY_hunger + ( 0.05 / 1000 * _this );
        };

        switch(true) do {
            case (XY_hunger >= 1): {
                hint parseText "<t size='1.5' color='#FF0000'>Du bist verhungert</t>";
                [0, format["%1 ist verhungert", profileName]] remoteExec ["XY_fnc_broadcast"];
                uisleep 5;
                player setDamage 1;
            };
            case ( XY_hunger >= 0.9 ): {
                hint parseText "<t size='2' color='#FF0000'>Du verhungerst</t>";
            };
        };
        if( XY_hunger >= 0.95 ) then {
            player setFatigue 1;
        };
    };

    // 30s call interval
    // increment of 0.0083 means
    // 1 / 0.0083 * 30 = 3614s until dehydration ~ 1 hour

    // player movement goes into the calculation as 15 percent per kilometer

    private _fnc_water = {

        XY_thirst = XY_thirst + 0.0083;
        // Add in player movement
        if( _this > 0 ) then {
            XY_thirst = XY_thirst + ( 0.15 / 1000 * _this );
        };

        switch(true) do {
            case (XY_thirst >= 1): {
                hint parseText "<t size='2' color='#FF0000'>Du bist verdurstet</t>";
                [0, format["%1 ist verdurstet", profileName]] remoteExec ["XY_fnc_broadcast"];
                uisleep 5;
                player setDamage 1;
            };
            case (XY_thirst >= 0.925): {
                hint parseText "<t size='2' color='#FF0000'>Du verdurstest</t>";
            };
        };
        if( XY_thirst >= 0.95 ) then {
            player setFatigue 1;
        };
    };

    uisleep 60;

    private _position = getPos player;
    while{ true } do {

        private _distance = 0;
        if( (vehicle player) isEqualTo player ) then {
            // cap at 66m to prevent short drives or incorrect calculations messing up the player fun
            // 66m is the approx. movement distance you can achieve within 30 seconds when moving at ~8km/h (fast walking)
            _distance = 66 min (player distance _position);
        };
        _position = getPos player;

        if( alive player && { !(player getVariable ["restrained", false]) } ) then{
            uisleep 15;
            _distance call _fnc_water;
            uisleep 15;
            _distance call _fnc_food;
        };
    };
};

"WeightTracker" spawn { scriptName _this;

    private _notified = false;
    while{ true } do {

        uisleep 5;

        if( ([] call XY_fnc_getTrunkWeight) > XY_maxWeight ) then {
            if( !_notified )then {
                hint parseText format[XY_hintError, "Du trägst zu viel"];
                _notified = true;
            };
            player setFatigue 1;
        } else {
            _notified = false;
        };
    };
};

"KidneyTracker" spawn { scriptName _this;
    while{true} do {

        waitUntil { uiSleep 5; player getVariable ["missingOrgan", false] };

        while{ player getVariable ["missingOrgan", false] } do {
            if(damage player < 0.5) then {
                player setDamage (damage player + 0.05);
            };
            XY_thirst = 0.5 max XY_thirst;
            XY_hunger = 0.5 max XY_hunger;
            "dynamicBlur" ppEffectEnable true;
            "dynamicBlur" ppEffectAdjust [1];
            "dynamicBlur" ppEffectCommit 5;
            uiSleep 5;
        };
        "dynamicBlur" ppEffectEnable false;
    };
};

"AlcoholDrugsTracker" spawn { scriptName _this;
    while {true} do {

        // Alle paar Sekunden testen ob wir besoffen/bekifft sind
        waitUntil { sleep 5; XY_promille > 0 || XY_drugged > 0 };
        // Dies Verzögert die Wirkung von Alkohol/Drogen...fast wie im echten Leben :)
        sleep 5 + random 10;

        // Solange der Spieler noch lebt und Stoff intus hat...
        while{ alive player && (XY_promille > 0 || XY_drugged > 0) } do {

            // Effekte aktivieren (Innerhalb der Loop, falls sie an anderer Stelle deaktiviert werden...):
            "chromAberration" ppEffectEnable true;
            "filmGrain" ppEffectEnable true;
            "radialBlur" ppEffectEnable true;
            enableCamShake true;

            switch(true) do {
                case( XY_promille < 0.5 && XY_drugged < 0.2 ): {
                    // Bis 0.5 Promille: Leichte Effekte
                    "chromAberration" ppEffectAdjust[0, 0, false];
                    "chromAberration" ppEffectCommit 0.5;
                    "filmGrain" ppEffectAdjust [random 0.1, 1, 1, 0.2, 0.2, false];
                    "radialBlur" ppEffectAdjust [random 0.2, random 0.2, 0.5 + random 0.2, 0.5 + random 0.2];
                };
                case( XY_promille < 1.0 && XY_drugged < 0.4 ): {
                    // Bis 1 Promille: Etwas stärkere Effekte
                    "chromAberration" ppEffectAdjust[0, 0, false];
                    "chromAberration" ppEffectCommit 0.5;
                    "filmGrain" ppEffectAdjust [random 0.2, 1, 3, random 0.25, random 0.25, false];
                    "radialBlur" ppEffectAdjust [0.1 + random 0.1, 0.1 + random 0.1, 0.2 + random 0.3, 0.2 + random 0.3];
                    if( (vehicle player != player) && (driver vehicle player == player) && (XY_promille > 0 || XY_hardDrugged) ) then {
                        addCamShake[2 + random 1, 20, 2 + random 1];
                    };
                };
                case( XY_promille < 1.5 && XY_drugged < 1.0 ): {
                    // Bis 1.5 Promille: Stärkere Effekte
                    "chromAberration" ppEffectAdjust[0.01, 0.01, false];
                    "chromAberration" ppEffectCommit 0.5;
                    "filmGrain" ppEffectAdjust [0.2 + random 0.2, 1, 4, 0.3 + random 0.2, 0.3 + random 0.2, false];
                    "radialBlur" ppEffectAdjust [0.2 + random 0.1, 0.2 + random 0.1, 0.2 + random 0.3, 0.2 + random 0.3];
                    if( (vehicle player != player) && (driver vehicle player == player) ) then {
                        addCamShake[4 + random 4, 20, 3 + random 3];
                    };
                };
                case( XY_promille < 2.5 && XY_drugged < 1.5 ): {
                    // Bis 2.5 Promille: Heftige Effekte
                    "chromAberration" ppEffectAdjust[0.02, 0.02, false];
                    "chromAberration" ppEffectCommit 0.5;
                    "filmGrain" ppEffectAdjust [0.2 + random 0.2, 1, 4, 0.2 + random 0.5, 0.2 + random 0.5, false];
                    "radialBlur" ppEffectAdjust [0.2 + random 0.2, 0.2 + random 0.2, 0.2 + random 0.1, 0.2 + random 0.1];
                    if( (vehicle player != player) && (driver vehicle player == player) ) then {
                        addCamShake[8 + random 5, 20, 3 + random 5];
                    };
                    player setFatigue 1;
                };
                case( XY_promille < 3.0 && (XY_drugged < 2.5 || (XY_drugged >= 2.5 && !XY_hardDrugged)) ): {
                    // Bis 3.0 Promille: Extreme Effekte
                    // Maximalstufe für Marihuana
                    "chromAberration" ppEffectAdjust[0.05 + random 0.05, 0.05 + random 0.05, false];
                    "chromAberration" ppEffectCommit 1;
                    "filmGrain" ppEffectAdjust [0.3 + random 0.2, 1, 5, 0.5 + random 0.5, 0.5 + random 0.5, false];
                    "radialBlur" ppEffectAdjust [0.3 + random 0.3, 0.3 + random 0.3, 0.1 + random 0.1, 0.1 + random 0.1];
                    if( (vehicle player != player) && (driver vehicle player == player) ) then {
                        addCamShake[12 + random 6, 20, 5 + random 5];
                    };
                    player setFatigue 1;
                };
                case( XY_promille >= 3.0 || XY_drugged >= 2.5 ): {
                    // Ab 3.0 Promille oder 2.5 'Drogen': Koma
                    "chromAberration" ppEffectAdjust[0.25 + random 0.25, 0.25 + random 0.25, false];
                    "chromAberration" ppEffectCommit 1;
                    "filmGrain" ppEffectAdjust [0.8, 1, 8, 1, 1, false];
                    "radialBlur" ppEffectAdjust [1, 1, 0, 0];
                    addCamShake[20, 20, 20];
                    player setFatigue 1;

                    // Spieler verletzen...
                    if(damage player < 0.9) then {
                        player setDamage (damage player + 0.05);
                    };
                };
            };

            // Effekte übernehmen:
            "filmGrain" ppEffectCommit 10;
            "radialBlur" ppEffectCommit 10;

            if( XY_promille >= 4.0 ) exitWith {
                // Ab 4 Promille: Spieler töten
                hint parseText "<t size='1.5' color='#FF0000'>Du hast dich zu Tode gesoffen!</t>";
                [0, format["%1 hat sich zu Tode gesoffen: Die Gerichtsmedizin stellte %2 Promille Blutalkohol fest!", profileName, [round(XY_promille * 10) / 10] call XY_fnc_numberText] ] remoteExec ["XY_fnc_broadcast"];
                sleep 5;
                player setDamage 1;
            };
            if( XY_drugged >= 3.3 && XY_hardDrugged ) exitWith {
                // Ab 3.3 'Drogen': Spieler töten
                hint parseText "<t size='1.5' color='#FF0000'>Du hast eine Überdosis genommen!</t>";
                [0, format["%1 hat eine Überdosis genommen: Die Gerichtsmedizin stellte %2 mg/l Betäubungsmittelkonzentration fest!", profileName, [round(XY_drugged * 10) / 10] call XY_fnc_numberText] ] remoteExec ["XY_fnc_broadcast"];
                sleep 5;
                player setDamage 1;
            };

            // Alle x Sekunden wird 0.01 + X Promille abgebaut...
            sleep 8 + random 4;
            if( XY_promille > 0 ) then {
                XY_promille = XY_promille - 0.015;
            };
            if( XY_drugged > 0 ) then {
                XY_drugged = XY_drugged - 0.01;
            };
        };

        // Effekte ausschalten
        "chromAberration" ppEffectEnable false;
        "filmGrain" ppEffectEnable false;
        "radialBlur" ppEffectEnable false;

        XY_hardDrugged = false;
        XY_drugged = 0;
        XY_promille = 0;
    };
};