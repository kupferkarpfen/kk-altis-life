/*
    file: fn_newMsg.sqf
    Author: Silex
*/

private["_to","_type","_playerData","_msg"];
disableSerialization;

private _type = param[0, -1, [0]];
private _playerData = param[1, -1, [0]];
private _msg = param[2, "", [""]];

_display = findDisplay 88888;
_cPlayerList = _display displayCtrl 88881;
_cMessageEdit = _display displayCtrl 88884;

switch(_type) do {
    case 0: {
        XY_smartphoneTarget = call compile format["%1",_playerData];
        ctrlSetText[88886, format["Nachricht an: %1",name XY_smartphoneTarget]];
        if( !XY_isAdmin ) then {
            ctrlShow[888897,false];
        };
    };
    //normal message
    case 1: {
        if( isNull XY_smartphoneTarget ) exitWith {hint format["Keine Person ausgwählt!"];};
        ctrlShow[88885, false];
        if(_msg == "") exitWith {hint "Du musst eine Nachricht schreiben, die du schicken möchtest!";ctrlShow[88885, true];};
        [XY_smartphoneTarget, _msg, player, 0] remoteExec ["XYDB_fnc_handleMessages", XYDB];
        hint format["Du hast %1 eine Nachricht geschickt: %2",name XY_smartphoneTarget,_msg];
        ctrlShow[88885, true];
        closeDialog 88883;
    };
    //copmessage
    case 2: {
        if(({side _x == west} count playableUnits) == 0) exitWith {hint format["Die Polizei ist derzeit nicht zu erreichen. Bitte versuchen Sie es später nochmal."];};
        ctrlShow[888895,false];
        if(_msg == "") exitWith {hint "Du musst eine Nachricht schreiben, die du schicken möchtest!";ctrlShow[888895,true];};
        _msg = format["%1 - Koordinaten %2", _msg, mapGridPosition player ];
        [objNull, _msg, player, 1] remoteExec ["XYDB_fnc_handleMessages", XYDB];
        _to = "An die Polizei";
        hint format["Du hast %1 eine Nachricht geschickt: %2",_to,_msg];
        ctrlShow[888895,true];
        closeDialog 887890;
    };
    //msgadmin
    case 3: {
        ctrlShow[888896,false];
        if(_msg == "") exitWith {hint "Du musst eine Nachricht schreiben, die du schicken möchtest!";ctrlShow[888896,true];};
        _msg = format["%1 - Koordinaten %2", _msg, mapGridPosition player ];
        [objNull, _msg, player, 2] remoteExec ["XYDB_fnc_handleMessages", XYDB];
        _to = "An die Admins";
        hint format["Du hast %1 eine Nachricht geschickt: %2",_to,_msg];
        ctrlShow[888896,true];
        closeDialog 887890;
    };
    //emsrequest
    case 4: {
        if(({side _x == independent} count playableUnits) == 0) exitWith {hint format["Zurzeit ist kein Arzt im Dienst. Bitte probiere es später nochmal."];};
        ctrlShow[888899,false];
        if(_msg == "") exitWith {hint "Du musst eine Nachricht schreiben, die du schicken möchtest!";ctrlShow[888899,true];};
        _msg = format["%1 - Koordinaten %2", _msg, mapGridPosition player ];
        [objNull, _msg, player, 4] remoteExec ["XYDB_fnc_handleMessages", XYDB];
        _to = "An die Sanitäter";
        hint format["Du hast %1 eine Nachricht geschickt: %2",_to,_msg];
        ctrlShow[888899,true];
        closeDialog 887890;
    };
    //adminToPerson
    case 5: {
        if( !XY_isAdmin ) exitWith {hint "Du bist kein Admin!";};
        if(isNULL XY_smartphoneTarget) exitWith {hint format["Keine Person ausgwählt!"];};
        if(_msg == "") exitWith {hint "Du musst eine Nachricht schreiben, die du schicken möchtest!";};
        [XY_smartphoneTarget, _msg, player, 3] remoteExec ["XYDB_fnc_handleMessages", XYDB];
        hint format["Admin Nachricht gesendet an: %1 - Nachricht: %2",name XY_smartphoneTarget,_msg];
        closeDialog 88883;
    };
    //emergencyloading
    case 6: {
        if( XY_copLevel < 4 ) then {
            ctrlShow[888901, false];
        } else {
            ctrlShow[888901, true];
        };
        if( XY_medicLevel < 3 ) then {
            ctrlShow[888902, false];
        } else {
            ctrlShow[888902, true];
        };
        if( !XY_isAdmin ) then {
            ctrlShow[888898, false];
            ctrlShow[888896, true];
        } else {
            ctrlShow[888898, true];
            ctrlShow[888896, false];
        };
    };
    //adminMsgAll
    case 7: {
        if( !XY_isAdmin) exitWith {hint "Du bist kein Admin!";};
        if(_msg == "") exitWith {hint "Du musst eine Nachricht schreiben, die du schicken möchtest!";};
        [objNull, _msg, player, 5] remoteExec ["XYDB_fnc_handleMessages", XYDB];
        hint format["Admin Nachricht an ALLE: %1",_msg];
        closeDialog 887890;
    };
    //THWrequest
    case 8: {
    };
    // Police broadcast
    case 9: {
        if( XY_copLevel < 4 ) exitWith {hint "Du bist kein qualifizierter Cop!";};
        if(_msg == "") exitWith {hint "Du musst eine Nachricht schreiben, die du schicken möchtest!";};
        [objNull, _msg, player, 7] remoteExec ["XYDB_fnc_handleMessages", XYDB];
        hint format["Polizeimeldung an ALLE: %1", _msg];
        closeDialog 887890;
    };
    // Medic broadcast
    case 10: {
        if( XY_medicLevel < 3 ) exitWith {hint "Du bist kein qualifizierter Sanitäter!";};
        if(_msg == "") exitWith {hint "Du musst eine Nachricht schreiben, die du schicken möchtest!";};
        [objNull, _msg, player, 8] remoteExec ["XYDB_fnc_handleMessages", XYDB];
        hint format["Sanitätermeldung an ALLE: %1", _msg];
        closeDialog 887890;
    };
};