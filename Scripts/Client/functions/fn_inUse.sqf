// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
//
// can be called to check if a vehicle is in use

private _vehicle = param[0, objNull, [objNull] ];
if( isNull _vehicle ) exitWith { true; };
    
private _unuse = param[1, false, [false]];

if( _unuse ) exitWith {
    _vehicle setVariable ["usedBy", "", true];
    _vehicle setVariable ["usedBy.timeout", 0, true];
	false;
};

private _usedBy = "";
private _timeout = _vehicle getVariable ["usedBy.timeout", 0];
if( _timeout > serverTime ) then {
    _usedBy = _vehicle getVariable ["usedBy", ""];
};

if( _usedBy isEqualTo (getPlayerUID player) ) exitWith { 
    // refresh timeout variable after 5 minutes
    if( _timeout < serverTime - 300 ) then {
        _vehicle setVariable ["usedBy.timeout", serverTime + 600, true];
    };
    false;
};

if( !(_usedBy isEqualTo "") && { !([_usedBy] call XY_fnc_onlineUID) } ) then {
    _usedBy = "";
};
if( !(_usedBy isEqualTo "") ) exitWith { true };

_vehicle setVariable ["usedBy", getPlayerUID player, true];
_vehicle setVariable ["usedBy.timeout", serverTime + 600, true];

false;