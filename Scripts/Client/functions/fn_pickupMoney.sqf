// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _obj = param[0, objNull, [objNull]];
if( isNull _obj || { player distance _obj > 5 } ) exitWith {};

private _value = _obj getVariable["money", -1];
if( _value < 1 ) exitWith {
    deleteVehicle _obj;
};

if( playerSide isEqualTo civilian && ((_obj getVariable["side", sideUnknown]) in [independent]) ) exitWith {
    hint parseText format[XY_hintError, "Das darfst du nicht aufheben"];
};

// Stop people picking up huge values of money which should stop spreading dirty money.
if( _value > 1000000 ) then {
    _value = round(_value * 0.5);
};
if( _value > 1000000 ) then {
    _value = round(_value * 0.2);
};

// Attach UID
if( !(_obj getVariable["owner", ""] isEqualTo "") ) exitWith {};
_obj setVariable["owner", getPlayerUID player, true];

XY_actionInUse = true;

player playMove "AinvPknlMstpSlayWrflDnon";

[_obj, _value] spawn { scriptName "PickupMoney";

    private _obj = _this select 0;
    private _value = _this select 1;

    // Delay pickup randomly to prevent duping
    sleep 0.1 + (random 2.5);

    XY_actionInUse = false;
    if( !(_obj getVariable["owner", ""] isEqualTo (getPlayerUID player)) ) exitWith {
        hint "Ein anderer Spieler versucht grad ebenfalls das Geld aufzuheben";
        _obj setVariable["owner", "", true];
    };
    deleteVehicle _obj;

    [getPlayerUID player, 3, format ["Hat %1€ vom Boden aufgehoben @ %2", [_value] call XY_fnc_numberText, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];
    hint format["Du hast %1€ aufgehoben", [_value] call XY_fnc_numberText];
    [_value, true] call XY_fnc_addMoney;
};