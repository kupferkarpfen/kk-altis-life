/*
    file: fn_smartphone.sqf
    Author: Silex
*/
// TODO: Some cleanup by Kupferkarpfen, but this shitty smartphone stuff really needs to be re-written nice and clean

private _type = param[0, 0, [0]];
private _data = param[1, 0, ["", [], 0]];

disableSerialization;

waitUntil { !isNull findDisplay 88888 };
_display = findDisplay 88888;
_cPlayerList = _display displayCtrl 88881;
_cMessageList = _display displayCtrl 88882;
_cMessageHeader = _display displayCtrl 88886;
_cMessageHeader ctrlSetText format["Von:                 Nachricht:"];
ctrlEnable[887892, false];

switch(_type) do {
    case 0: {
        lbClear _cPlayerList;
        {
            if( alive _x && _x != player ) then {
                // Meds already have their name prefixed
                private _prefix = switch(side _x) do {
                    case west: {"[COP] "};
                    case independent: {"[MED] "};
                    default { "" };
                };
                private _index = _cPlayerList lbAdd format["%1%2", _prefix, _x getVariable["realName", "ERROR"]];
                _cPlayerList lbSetData [_index, str(_x)];
            };
        } forEach playableUnits;

        [player] remoteExec ["XYDB_fnc_msgRequest", XYDB];
        ctrlEnable[887892, false];
    };
    case 1: {
        {
            private _msg = (_x select 2) select [0, 40 min (count (_x select 2))];
            private _rowData = [ _x select 0, _x select 1, _x select 2 ];
            private _index = _cMessageList lnbAddRow[_x select 0, format["%1 ...", _msg]];
            _cMessageList lnbSetData[[_index, 0], str(_rowData)];
        } forEach _data;
    };
    case 2: {
        ctrlEnable[887892, true];
        XY_smartphoneTarget = call compile format["%1", lbData[88881, lbCurSel 88881]];
    };
    case 4: {
        createDialog "XY_dialog_smartphoneWrite";
        ctrlSetText[88886, format["Nachricht an: %1", XY_smartphoneTarget getVariable["realName", "ERROR"]]];
        if( !XY_isAdmin ) then {
            ctrlShow[888897, false];
        };
    };
    case 5: {
        if( !(isObjectHidden player) ) then {
            player say3D "SmartphoneType";

            private _lastUpdate = player getVariable["typing", 0];
            if( serverTime - _lastUpdate > 3 ) then {
                player setVariable["typing", serverTime + 4, true];
            };
        };
    };
};