// You might guess that the original sucked, so I added this one
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// No interface, no siren...
if( !hasInterface ) exitWith {};

private["_vehicle", "_sound", "_duration"];

_vehicle  = [ _this, 0, ObjNull, [ObjNull] ] call BIS_fnc_param;
_sound    = [ _this, 1, "",      [""]      ] call BIS_fnc_param;
_duration = [ _this, 2, 0.0,     [0.0]     ] call BIS_fnc_param;

if( isNull _vehicle || _sound == "" || _duration <= 0 ) exitWith {};

uisleep 1;

while { !(isNull _vehicle) && { _vehicle getVariable[_sound, false] } && { alive _vehicle } && { count (crew _vehicle) > 0 } } do {

    if ( _vehicle distance player > 500 ) then {
        uisleep 8;
    } else {
        _vehicle say3D _sound;
        uisleep _duration;
    };
};

// Sleep a bit to prevent too many clients changing this variable at once
sleep (random 1);
if( _vehicle getVariable [_sound, false] ) then {
    _vehicle setVariable [_sound, false, true];
};