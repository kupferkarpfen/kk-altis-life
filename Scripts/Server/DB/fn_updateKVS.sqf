// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

diag_log format["updateKVS (%1)", _this];

private _player = param[ 0, objNull, [objNull] ];
private _side = param[ 1, sideUnknown, [sideUnknown] ];
private _kvStore = param[ 2, [], [[]] ];

if( _player isEqualTo objNull || _side isEqualTo sideUnknown ) exitWith {};

private _sideID = XY_playerSides find _side;
if( _sideID < 0 ) exitWith {
    diag_log format["requestKVS ERROR: Unknown side %1 in %2 = %3", _side, XY_playerSides, _sideID]
};

private _uid = getPlayerUID _player;
if( _uid isEqualTo "" ) exitWith {};

{ scopeName "Loop";
    private _key = _x select 0;
    private _value = _x select 1;
    private _type = typeName _value;

    // If we save the player inventory remove unwanted entries
    if( _key isEqualTo KV_trunk ) then {
        _value = [_value] call XY_fnc_removeVolatileItems;
    };
    if( _type isEqualTo "SCALAR" ) then {

        // Convert number to string to prevent scientific notation
        private _numberText = "";
        {
            _numberText = format["%1%2", _numberText, str _x];
        } forEach (_value call BIS_fnc_numberDigits);
        _value = _numberText;

    } else {
        // Pre-convert value to prevent a colon slipping in...
        _value = [ format["%1", _value] ] call XYDB_fnc_strip;
    };

    [format ["updateKVStore:%1:%2:%3:%4:%5:%4:%5", _uid, _sideID, _key, _value, _type]] call XYDB_fnc_asyncCall;
} forEach _kvStore;
