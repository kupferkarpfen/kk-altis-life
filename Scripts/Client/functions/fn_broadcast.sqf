// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( !hasInterface || !(missionNamespace getVariable["XY_gameRunning", false]) ) exitWith {};

private _type =     param[ 0, -1, [[], 0] ];
private _message =  param[ 1, "", [""]    ];
private _extra =    param[ 2, "", [""]    ];
private _duration = param[ 3, -1, [0]     ];

if( _message isEqualTo "" ) exitWith {};

if( !((typeName _type) isEqualTo "ARRAY") ) then {
    _type = [_type];
};

{
    switch( _x ) do {
        case 0: {
            systemChat _message;
        };
        case 1: {
            hint parseText _message;
            if( _duration > 0 && _duration < 10 ) then {
                uisleep _duration;
                hintSilent "";
            };
        };
        case 2: {
            titleText[_message, "PLAIN"];
        };
        case 3: {
            [parseText format["<t size='2'>BREAKING NEWS</t><br/>%1", _message], parseText (format["+++ %1 +++ %1 +++ %1 +++ %1 +++ %1 +++ %1 +++", _extra]) ] spawn BIS_fnc_AAN;
            uisleep 25;
            (uiNamespace getVariable "BIS_AAN") closeDisplay 1;
        };
    };
} forEach _type;