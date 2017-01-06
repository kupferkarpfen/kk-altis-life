// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

disableSerialization;

if( isNull (findDisplay 3494)) exitWith {};
private _list = (findDisplay 3494) displayCtrl 2902;

lbClear _list;
XY_empLastVehicles = [];
{
    if( !((vehicle player) isEqualTo _x) ) then {
        _list lbAdd format [ "%1 | Distanz: %2m", getText(configFile >> "CfgVehicles" >> typeOf _x >> "DisplayName"), round(player distance _x) ];
        XY_empLastVehicles pushBack _x;
    };
} forEach nearestObjects [player, ["Air"], 250];