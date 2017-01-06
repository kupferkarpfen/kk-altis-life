// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// based on "fn_numberText" by Karel Moricky

private _number = param[0, 0, [0]];
private _decimal = param[1, 0, [0]];

private _negative = _number < 0;
private _negativePart = "";
if( _negative ) then {
    _negativePart = "-";
    _number = _number * -1;
};
private _numberString = _number toFixed _decimal;
private _decimalPart = "";
if( _decimal > 0 ) then {
    // Cut off decimal part to re-attach it later
    private _index = _numberString find ".";
    _decimalPart = format[",%1", _numberString select [_index + 1]];
    _numberString = _numberString select [0, _index];
};

private _length = count _numberString;
private _modBase = _length % 3;

private _result = "";
{
    _result = format["%1%2%3", _result, ["", "."] select ((_forEachindex - _modBase) % 3 isEqualTo 0 && !(_forEachindex isEqualTo 0)), _x];
} forEach (_numberString splitString "");

format["%1%2%3", _negativePart, _result, _decimalPart];