// usePainkiller
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private["_medicine"];
_medicine = [_this, 0, "", [""]] call BIS_fnc_param;
if(_medicine == "") exitWith {};

closeDialog 0;

// Did the player already use a painkiller?
if( XY_medActive ) exitWith {
    // allergic reaction!
    hintSilent parseText "<t size='1' color='#FF0000'>Eine Überdosis Schmerzmittel kann tödlich sein!</t>";
    XY_hardDrugged = true;
    XY_drugged = XY_drugged + (1.0 + (random 1.0));
    
    [] spawn {
        sleep 10;
        {
            titleCut ["", "WHITE IN", 0.5 + (random 1)];
            sleep _x;
        } forEach [1, 1.5, 2, 1, 1.2, 2.5, 5, 10];
    };
};
XY_medActive = true;

// Check if we are allergic against this medicine
if( _medicine in XY_medAllergies ) then {

    // allergic reaction!
    hintSilent parseText "<t size='1' color='#FF0000'>Du scheinst allergisch auf das Medikament zu reagieren!</t>";
    XY_hardDrugged = true;
    XY_drugged = XY_drugged + 0.5;
    
    [] spawn {
        sleep 5;
        {
            player setDamage (0.5 min (damage player + 0.01));
            titleCut ["", "WHITE IN", 0.5 + (random 1)];
            sleep _x;
        } forEach [1, 1.5, 2, 1, 1.2, 2.5, 5, 1, 1, 10];
        XY_medActive = false;
    };

} else {

    // Enable drug-effects
    XY_drugged = XY_drugged + (0.2 + (random 0.2));
    // Give the player some benefits from using the painkiller
    player setFatigue 0;
    [] spawn {
        sleep 5;
        titleCut ["", "WHITE IN", 1];
        sleep 1;
        titleCut ["", "WHITE IN", 1];

        private["_timeOut"];
        _timeOut = time + 150;
        while { alive player && time < _timeOut } do {
            player enableFatigue false;
            XY_thirst = 0.75 min (XY_thirst * 1.025);
            XY_hunger = 0.75 min (XY_hunger * 1.025);
            player setDamage (damage player - 0.035);
            sleep 10;
        };
        XY_medActive = false;
        player enableFatigue true;
    };
};