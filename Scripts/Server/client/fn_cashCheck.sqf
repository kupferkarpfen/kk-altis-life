// OZ Cash check
// by Kupferkarpfen
private["_previous", "_now"];

scriptName "XY_fnc_cashCheck";

_previous = XY_CC + XY_CA;
while { true } do {
    uisleep 3;
    _now = XY_CC + XY_CA;
    if( (_now - _previous) >= 500000 ) then {
        [getPlayerUID player, 19, format ["Geld plötzlich von %1€ auf %2€ gestiegen", [_previous] call XY_fnc_numberText, [_now] call XY_fnc_numberText ]] remoteExec ["XYDB_fnc_log", XYDB];
    };
    _previous = _now;
};