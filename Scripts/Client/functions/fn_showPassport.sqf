// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _side = param[0, sideUnknown, [sideUnknown]];
private _name = param[1, "", [""]];
private _address = param[2, "", [""]];
private _town = param[3, "", [""]];
private _birthday = param[4, "", [""]];
private _birthlocation = param[5, "", [""]];
private _height = param[6, "", [""]];
private _eyecolor = param[7, "", [""]];
private _recall = param[8, false, [false]];

if( XY_actionInUse ) exitWith {};

if( !_recall && (speed player) > 3 ) exitWith {
    hint parseText format[XY_hintError, "Jemand hat versucht dir seinen Ausweis zu zeigen, aber du bist in Bewegung"];
};

XY_PP_LASTPASS = _this;
XY_PP_LASTPASS set[8, true];
XY_PP_LASTPASS_EXPIRE = time + 300;

"passport" cutRsc ["XY_PASSPORT", "PLAIN"];

private _display = uiNamespace getVariable ['XY_PASSPORT', displayNull];

private _lbBackground = _display displayCtrl 8801;
private _lbName = _display displayCtrl 8810;
private _lbAddress = _display displayCtrl 8811;
private _lbTown = _display displayCtrl 8812;
private _lbBirthday = _display displayCtrl 8813;
private _lbBirthlocation = _display displayCtrl 8814;
private _lbHeight = _display displayCtrl 8815;
private _lbEyecolor = _display displayCtrl 8816;

_lbBackground ctrlSetText ( switch(_side) do {
    case(civilian): { "images\passport_civilian.paa" };
    case(independent): { "images\passport_medic.paa" };
    case(west): { "images\passport_cop.paa" };
});

_lbName ctrlSetStructuredText parseText format["<t size='0.9'>%1</t>", _name];
_lbAddress ctrlSetStructuredText parseText format["<t size='0.9'>%1</t>", _address];
_lbTown ctrlSetStructuredText parseText format["<t size='0.9'>%1</t>", _town];
_lbBirthday ctrlSetStructuredText parseText format["<t size='0.9'>%1</t>", _birthday];
_lbBirthlocation ctrlSetStructuredText parseText format["<t size='0.9'>%1</t>", _birthlocation];
_lbHeight ctrlSetStructuredText parseText format["<t size='0.9'>%1 cm</t>", _height];
_lbEyecolor ctrlSetStructuredText parseText format["<t size='0.9'>%1</t>", _eyecolor];