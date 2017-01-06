// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
disableSerialization;

private _control = _this select 0;
private _index = _this select 1;

//Fetch some information.
private _dataArr = _control lbData _index;
_dataArr = call compile format["%1", _dataArr];

private _classname = _dataArr select 0;

// get vehicle skin
private _config = [_classname, _dataArr select 2] call XY_fnc_colorConfig;
private _vehicleColor = "Standard";
if( !(_config isEqualTo []) ) then {
    _vehicleColor = _config select 0;
};

_owner = _dataArr select 1;
((findDisplay 2800) displayCtrl 2803) ctrlSetStructuredText parseText format[
    "<br/>" +
	" Besitzer: %1<br/>" +
	" Lackierung: %2<br/>",
    _owner,
    _vehicleColor
];

ctrlShow [2803, true];
ctrlShow [2830, true];