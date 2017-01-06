/*

    file: fn_handleMessages.sqf
    Author: Silex

*/

// #KK this function sucks ... but made it suck slightly less

private _target = param [0, objNull, [objNull]];
private _msg = param [1, "", [""]];
private _player = param [2, objNull, [objNull]];
private _type = param [3, -1, [0]];

if( _msg isEqualTo "" || isNull _player || _type < 0 ) exitWith {};

private _pid = getPlayerUID _player;
private _escapedMsg = [_msg] call XYDB_fnc_strip;

private _fromName = _player getVariable["realName", "Unbekannt"];
private _toName = _target getVariable["realName", "Unbekannt"];

private _plogHeader = "";

private _destination = switch(_type) do {
    //normal message
    case 0: {
        [format["insertMessage:%1:%2:%3:%4:%5", _pid, getPlayerUID _target, _escapedMsg, _fromName, _toName]] call XYDB_fnc_asyncCall;
        _target
    };
    //message to cops
    case 1: {
        _plogHeader = "COP-ANFRAGE";
        west
    };
    //to admins
    case 2: {
        _plogHeader = "ADMIN-ANFRAGE";
        -2
    };
    //adminToPerson
    case 3: {
        _plogHeader = format["ADMIN-NACHRICHT AN %1 (%2)", _toName, getPlayerUID _target];
        _target
    };
    //ems request
    case 4: {
        _plogHeader = "MEDIC-ANFRAGE";
        independent
    };
    //adminMsgAll
    case 5: {
        _plogHeader = "ADMIN-RUNDNACHRICHT";
        -2
    };
    // Police broadcast
    case 7: {
        _plogHeader = "POLIZEI-MELDUNG";
        -2
    };
    // Medic broadcast
    case 8: {
        _plogHeader = "MEDIC-MELDUNG";
        -2
    };
};

[_msg, _fromName, _type] remoteExec ["XY_fnc_clientMessage", _destination];
if( !(_plogHeader isEqualTo "") ) then {
    [format[ "insertPLog:%1:%2:%3", _pid, 18, format["%1 - %2", _plogHeader, _escapedMsg]]] call XYDB_fnc_asyncCall;
};