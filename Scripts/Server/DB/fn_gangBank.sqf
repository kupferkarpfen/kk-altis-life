// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _player = param[ 0, objNull, [objNull] ];
private _group = param[ 1, grpNull, [grpNull] ];
private _amount = param[ 2, 0, [0] ];

diag_log format["<GANGBANK> %1", _this];

if( isNull _player || _group isEqualTo grpNull || _amount isEqualTo 0 ) exitWith {
    diag_log format["<ERROR> gangBank invalid param %1", _this];
};

private _gangID = _group getVariable ["id", -1];
if( _gangID < 0 ) exitWith {
    diag_log format["<ERROR> gangBank id invalid %1", _this];
};

MUTEX_GANGBANK call enterCriticalSection;

if( _amount < 0 && { _group getVariable["withdrawal.locked", 0] > time } ) exitWith {
    [[0, 1], "Abhebung fehlgeschlagen: Bitte warte ein paar Sekunden bevor du es erneut versuchst..." ] remoteExec ["XY_fnc_broadcast", _player];
    MUTEX_GANGBANK call leaveCriticalSection;
};
_group setVariable["withdrawal.locked", time + 30];

private _before = _group getVariable [ "bank", 0 ];
if( _amount < 0 && { abs(_amount) > (_group getVariable [ "bank", 0 ]) } ) exitWith {
    [[0, 1], "Abhebung fehlgeschlagen: Die Gangkasse hat nicht genügend Geld..." ] remoteExec ["XY_fnc_broadcast", _player];
    MUTEX_GANGBANK call leaveCriticalSection;
};

[getPlayerUID _player, 3, format ["Gangkasse: %1€ %2", [abs _amount] call XY_fnc_numberText, ["eingezahlt", "abgehoben"] select (_amount < 0) ]] call XYDB_fnc_log;

[format["updateGangBank:%1:%2", _amount, _gangID]] call XYDB_fnc_asyncCall;

[format["insertGangBankLog:%1:%2:%3:%4", _gangID, getPlayerUID _player, [1, 2] select (_amount < 0), abs _amount]] call XYDB_fnc_asyncCall;

private _changed = false;
private _timeout = time + 10;

while { !_changed } do {

    uisleep 0.5;

    private _queryResult = [format ["selectGangBank:%1", _gangID], true] call XYDB_fnc_asyncCall;
    diag_log format["selectGangBank(%1)", _queryResult];
    if( _queryResult isEqualTo [] ) exitWith {
        diag_log format["<ERROR> gangBank query failed %1 --> %2", _this, _group getVariable["bank", -1]];
    };

    private _newBank = (_queryResult select 0) select 0;
    if( _before isEqualTo _newBank ) then {
        diag_log format["<WARN> gangBank update pending... %1 --> %2", _this, _group getVariable["bank", -1]];
    } else {

        diag_log format["<INFO> gangBank update %1 --> %2", _group getVariable["bank", -1], _newBank];

        _group setVariable [ "bank", _newBank, true ];

        // withdrawal?
        if( _amount < 0 ) then {
            [abs _amount, false, 2] remoteExec[ "XY_fnc_addMoney", _player ];
        };
        _changed = true;
    };
    
    if( time > _timeout ) exitWith {
        diag_log format["<WARN> gangBank update timed out (%1) for %2", _this, _gangID];
    };
};
["refresh"] remoteExec ["XY_fnc_gangMenu", _player];

MUTEX_GANGBANK call leaveCriticalSection;