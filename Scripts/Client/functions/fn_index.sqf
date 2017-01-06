// File: fn_index.sqf
private["_item", "_stack", "_return"];

_item = _this select 0;
_stack = _this select 1;
_return = -1;

{
    if(_item in _x) exitWith {
        _return = _forEachIndex;
    };
} forEach _stack;

_return;