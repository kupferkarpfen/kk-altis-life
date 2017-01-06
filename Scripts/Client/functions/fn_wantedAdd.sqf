private["_unit", "_crime", "_crimeID", "_message"];

ctrlShow[2001, false];

if( (lbCurSel 9902) == -1 ) exitWith {
    hint "Niemand wurde ausgewählt";
    ctrlShow[2001, true];
};

_unit = lbData [9902, lbCurSel 9902];
_unit = call compile format["%1", _unit];
_crime = lbText[9991, lbCurSel 9991];
_crimeID = lbData [9991, lbCurSel 9991];

if( isNil "_unit" || {isNull _unit} ) exitWith {
    ctrlShow[2001, true];
};

_message = format["%1 wurde wegen '%2' von %3 zur Fahndung ausgeschrieben", _unit getVariable["realName", "FEHLER"], _crime, profileName];
[1, _message ] remoteExec ["XY_fnc_broadcast", [west] ];
[0, _message ] remoteExec ["XY_fnc_broadcast"];

[ getPlayerUID _unit, _crimeID] remoteExec ["XY_fnc_wantedAdd", 2];