// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Check if string is a valid number
// _value = String to check
// _isInteger = Check if it is an valid Integer (default)

private _value = param[0, "", [""]];
private _isInteger = param[1, true, [false]];

if( _value isEqualTo "" ) exitWith { false };

private _validNumbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];

private _return = true;
{
    if( !(_x in _validNumbers) || { !_isInteger && !(_x isEqualTo ".") } ) exitWith {
        _return = false;
    };
} forEach( _value splitString "" );

_return;