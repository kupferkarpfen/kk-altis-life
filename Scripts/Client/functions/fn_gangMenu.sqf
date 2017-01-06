// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

disableSerialization;

private _mode = param[ 0, "", [""] ];

private _display = findDisplay 2620;

private _group = group player;
private _ownerID = _group getVariable["owner", ""];
if( _ownerID isEqualTo "" ) exitWith {
    closeDialog 0;
};
private _gangMaxMembers = _group getVariable[ "maxMembers", 4 ];
private _gangMaxStorehouses = _group getVariable[ "maxStorehouses", 0 ];
private _gangBank = _group getVariable[ "bank", 0 ];
private _members = _group getVariable[ "members", [] ];
private _moderators = _group getVariable[ "moderators", [] ];

private _uid = getPlayerUID player;
private _isLeader = _uid isEqualTo _ownerID;
private _isModerator = (_uid in _moderators) || _isLeader;

private _lstMembers = _display displayCtrl 1500;
private _cmbPlayers = _display displayCtrl 2100;

switch( _mode ) do {

    case "open": {

        if( XY_actionInUse ) exitWith {};

        if( isNull _display ) then {
            createDialog "XY_dialog_GangDialog";
        };

        [ "refresh" ] call XY_fnc_gangMenu;
    };

    case "refresh": {

        (_display displayCtrl 1100) ctrlEnable _isModerator;
        (_display displayCtrl 1101) ctrlEnable _isLeader;
        (_display displayCtrl 1102) ctrlEnable _isLeader;
        (_display displayCtrl 1103) ctrlEnable _isModerator;
        (_display displayCtrl 1104) ctrlEnable _isModerator;
        (_display displayCtrl 1105) ctrlEnable _isModerator;
        (_display displayCtrl 1106) ctrlEnable _isModerator;
        (_display displayCtrl 1107) ctrlEnable _isLeader;

        (_display displayCtrl 2200) ctrlSetStructuredText parseText format[ "<t size='1.0' align='center'>%1€</t>", [_gangBank] call XY_fnc_numberText ];
        (_display displayCtrl 2300) ctrlSetStructuredText parseText format[ "<t size='1.0' align='center'>%1</t>", _gangMaxMembers ];

        lbClear _lstMembers;
        lbClear _cmbPlayers;

        {
            if( (side _x) isEqualTo civilian && !((group player) isEqualTo (group _x)) ) then {
                _cmbPlayers lbAdd (_x getVariable["realName", "ERROR"]);
                _cmbPlayers lbSetData[ (lbSize _cmbPlayers) - 1, str(_x) ];
            };
        } forEach allPlayers;

        private _unknownUIDs = [];
        {
            private _uid = _x;
            private _name = "";
            private _found = false;

            {
                if( (_x select 0) isEqualTo _uid ) exitWith {
                    _found = true;
                    _name = _x select 1;
                };

            } forEach XY_nameCache;

            if( !_found ) then {
                {
                    if( (getPlayerUID _x) isEqualTo _uid ) exitWith {
                        _name = _x getVariable["realName", ""];
                        if( !(_name isEqualTo "") ) then {
                            XY_nameCache pushBack [ _uid, _name ];
                            _found = true;
                        };
                    };
                } forEach allPlayers;
            };

            if( !_found ) then {
                _name = "Unbekannter Spieler...";
                _unknownUIDs pushBack _uid;
            };

            if( _uid isEqualTo _ownerID ) then {
                _name = format[ "%1 (LEADER)", _name];
            };
            if( _uid in _moderators ) then {
                _name = format[ "%1 (MOD)", _name];
            };

            _lstMembers lbAdd _name;
            _lstMembers lbSetData [(lbSize _lstMembers) - 1, str([_uid, _name])];

        } forEach _members;

        if( !(_unknownUIDs isEqualTo []) )then {
            [player, _unknownUIDs] remoteExec ["XYDB_fnc_uidToName", 2];
        };
    };

    case "kick": {
        private _selection = lbCurSel _lstMembers;
        if( _selection < 0 ) exitWith {
            hint "Es wurde kein Spieler ausgewählt";
        };
        private _playerInfo = call compile format["%1", _lstMembers lbData _selection];
        if( isNil "_playerInfo" ) exitWith {};

        if( (_playerInfo select 0) isEqualTo _uid ) exitWith {};
        if( (_playerInfo select 0) isEqualTo _ownerID ) exitWith {};

        private _action = [
            format[ "Willst du %1 aus der Gang werfen?", _playerInfo select 1 ],
            "Spieler kicken",
            localize "STR_Global_Yes",
            localize "STR_Global_No"
        ] call XY_fnc_showQuestionbox;

        if( !_action ) exitWith {};

        _members = _members - [_playerInfo select 0];
        _moderators = _moderators - [_playerInfo select 0];

        _group setVariable["members", _members, true];
        _group setVariable["moderators", _moderators, true];
        [_group] remoteExec ["XYDB_fnc_updateGang", XYDB];
        ["refresh"] call XY_fnc_gangMenu;

        {
            if( (getPlayerUID _x) isEqualTo (_playerInfo select 0) ) exitWith {
                [_x, _group] remoteExecCall ["XY_fnc_gangKick", _x];
            };
        } forEach allPlayers;

    };

    case "moderator": {
        private _selection = lbCurSel _lstMembers;
        if( _selection < 0 ) exitWith {
            hint "Es wurde kein Spieler ausgewählt";
        };
        private _playerInfo = call compile format["%1", _lstMembers lbData _selection];
        if( isNil "_playerInfo" ) exitWith {};

        private _uid = _playerInfo select 0;
        if( _uid isEqualTo _ownerID ) exitWith {};

        if( _uid in _moderators ) then {
            _moderators = _moderators - [_uid];
        } else {
            _moderators pushBack _uid;
        };

        _group setVariable["moderators", _moderators, true];
        [_group] remoteExec ["XYDB_fnc_updateGang", XYDB];
        [ "refresh" ] call XY_fnc_gangMenu;
    };

    case "leader": {
        private _selection = lbCurSel _lstMembers;
        if( _selection < 0 ) exitWith {
            hint "Es wurde kein Spieler ausgewählt";
        };
        private _playerInfo = call compile format["%1", _lstMembers lbData _selection];
        if( isNil "_playerInfo" ) exitWith {};

        private _uid = _playerInfo select 0;
        if( _uid isEqualTo _ownerID ) exitWith {};

        private _action = [
            format[ "Willst du die Gang-Leitung an %1 übertragen?", _playerInfo select 1 ],
            "Neue Gang-Leitung",
            localize "STR_Global_Yes",
            localize "STR_Global_No"
        ] call XY_fnc_showQuestionbox;

        if( !_action ) exitWith {};

        if( _uid in _moderators ) then {
            _moderators = _moderators - [_uid];
        } else {
            _moderators pushBack _uid;
        };

        _group setVariable["owner", _uid, true];
        [_group] remoteExec ["XYDB_fnc_updateGang", XYDB];
        [ "refresh" ] call XY_fnc_gangMenu;
    };

    case "invite": {
        private _perm = param[1, false, [false]];

        if( count _members >= _gangMaxMembers ) exitWith {
            hint "Alle Slots belegt: Du musst deine Gang-Slots erweitern, oder einen anderes Gangmitglied kicken";
        };

        private _selection = lbCurSel _cmbPlayers;
        if( _selection < 0 ) exitWith {
            hint "Es wurde kein Spieler ausgewählt";
        };
        private _player = call compile format["%1", _cmbPlayers lbData _selection];
        if( isNull _player ) exitWith {};
        if( _player isEqualTo player ) exitWith {};
        if( _perm && ((group _player) getVariable ["id", -1]) >= 0 ) exitWith {
            hint "Der Spieler ist schon in einer Gang"
        };
        if( _player getVariable ["restrained", false] || _player getVariable["invited", false] ) exitWith {
            hint "Der Spieler kann grad nicht in die Gruppe eingeladen werden";
        };

        private _action = [
            [ "Willst du den Spieler temporär in deine Gang einladen? Er erhält dadurch keinen Zugriff auf die Gang-Kasse oder -Lagerhäuser und verlässt die Gang automatisch, sobald er die Verbindung trennt.", "Willst du den Spieler wirklich in die Gang einladen? Er erhält dadurch Zugriff auf die Gang-Kasse und -Lagerhäuser." ] select _perm,
            "Gang-Einladung",
            localize "STR_Global_Yes",
            localize "STR_Global_No"
        ] call XY_fnc_showQuestionbox;

        if( !_action ) exitWith {};

        _player setVariable["invited", true, true];
        [profileName, _group, _perm] remoteExec ["XY_fnc_gangInvite", _player];
        hint "Einladung abgesendet";
    };

    case "deposit": {

        createDialog "XY_dialog_gangBank";
        private _depositDialog = findDisplay 2526;
        (_depositDialog displayCtrl 2500) ctrlSetText "Geld einzahlen";
        (_depositDialog displayCtrl 2501) ctrlSetStructuredText parseText "<t size='1.0' align='center'>Bitte gib den Betrag ein, den du einzahlen möchtest</t>";
        (_depositDialog displayCtrl 2503) ctrlShow true;
        (_depositDialog displayCtrl 2504) ctrlShow false;
    };

    case "withdraw": {

        createDialog "XY_dialog_gangBank";
        private _depositDialog = findDisplay 2526;
        (_depositDialog displayCtrl 2500) ctrlSetText "Geld abheben";
        (_depositDialog displayCtrl 2501) ctrlSetStructuredText parseText "<t size='1.0' align='center'>Bitte gib den Betrag ein, den du abheben möchtest</t>";
        (_depositDialog displayCtrl 2503) ctrlShow false;
        (_depositDialog displayCtrl 2504) ctrlShow true;
    };

    case "postDeposit": {
        private _amount = parseNumber( ctrlText ((findDisplay 2526) displayCtrl 2502) );
        if( _amount < 1 ) exitWith {
            hint "Du musst mindenstens 1€ einzahlen";
        };
        if( !([_amount, 2] call XY_fnc_pay) ) exitWith {
            hint "So viel Geld hast du nicht";
        };
        closeDialog 0;

        [ player, _group, _amount ] remoteExec [ "XYDB_fnc_gangBank", XYDB ];
        [getPlayerUID player, 3, format ["Gangkasse: %1€ eingezahlt", [_amount] call XY_fnc_numberText]] remoteExec ["XYDB_fnc_log", XYDB];
        hint "Geld wird eingezahlt...";
    };

    case "postWithdrawal": {
        private _amount = parseNumber( ctrlText ((findDisplay 2526) displayCtrl 2502) );
        if( _amount < 1 ) exitWith {
            hint "Du musst mindenstens 1€ abheben";
        };
        if( _amount > _gangBank ) exitWith {
            hint "So viel hat die Gang nicht in der Kasse";
        };
        closeDialog 0;

        [ player, _group, _amount * -1 ] remoteExec [ "XYDB_fnc_gangBank", XYDB ];
        [getPlayerUID player, 3, format ["Gangkasse: %1€ abgehoben", [_amount] call XY_fnc_numberText]] remoteExec ["XYDB_fnc_log", XYDB];

        hint "Geld wird abgehoben...";
    };

    case "log": {

        private _display = findDisplay 2527;
        if( isNull _display ) exitWith {
            createDialog "XY_dialog_gangBankLog";
            [ player, _group ] remoteExec [ "XYDB_fnc_requestBanklog", XYDB ];
        };

        private _lstLog = _display displayCtrl 1550;
        private _log = param[ 1, [], [[]] ];
        {
            _lstLog lbAdd format[ "[%1] %2 %3 %4€",
                    _x select 0,
                    _x select 1,
                    _x select 2,
                    [_x select 3] call XY_fnc_numberText
                ];
        } forEach _log;
    };

    case "expandSlots": {

        private _targetMax = _gangMaxMembers + 2;
        private _upgradePrice = round(_targetMax * 2500);

        private _action = [
            format[ "Willst du deine Gang-Slots von %1 auf %2 erhöhen? Das kostet %3€!",
                    _gangMaxMembers,
                    _targetMax,
                    [_upgradePrice] call XY_fnc_numberText
                ],
            "Gang-Slots erweitern",
            localize "STR_Global_Buy",
            localize "STR_Global_Cancel"
        ] call XY_fnc_showQuestionbox;

        if( !_action ) exitWith {};

        if( !([_upgradePrice] call XY_fnc_pay) ) exitWith {
            hint "Du hast dafür nicht genug Geld";
        };

        _group setVariable["maxMembers", _targetMax, true];
        [_group] remoteExec ["XYDB_fnc_updateGang", XYDB];

        hint "Gang-Slots wurden erweitert";
        ["refresh"] call XY_fnc_gangMenu;
    };

    case "disband": {

        private _action = [
            "Willst du die Gang wirklich auflösen? Sie wird dauerhaft entfernt und kann nicht wiederhergestellt werden und es gibt keine Erstattung für gekaufte Slots oder Geld auf dem Gang-Konto.",
            "Gang auflösen",
            localize "STR_Global_Yes",
            localize "STR_Global_No"
        ] call XY_fnc_showQuestionbox;

        if( !_action ) exitWith {};

        hint "Gang wird aufgelöst...";
        [_group] remoteExec [ "XYDB_fnc_removeGang", XYDB ];
        closeDialog 0;
    };

    case "leave": {

        if( _isLeader ) exitWith {
            hint "Du kannst die Gang nicht verlassen ohne einen neuen Anführer zu bestimmen";
        };

        private _action = [
            "Willst du die Gang wirklich verlassen?",
            "Gang verlassen",
            localize "STR_Global_Yes",
            localize "STR_Global_No"
        ] call XY_fnc_showQuestionbox;

        if( !_action ) exitWith {};

        hint "Gang wird verlassen...";

        if( _uid in _members ) then {

            _members = _members - [_uid];
            _moderators = _moderators - [_uid];

            _group setVariable["members", _members, true];
            _group setVariable["moderators", _moderators, true];
            [_group] remoteExec ["XYDB_fnc_updateGang", XYDB];
        };
        hint "Trete aus Gang aus...";

        XY_actionInUse = true;

        // Wait a few seconds before leaving
        [] spawn {
            sleep 3;
            [player] joinSilent (createGroup civilian);
            XY_actionInUse = false;
            hint "Gang wurde verlassen";
        };
        closeDialog 0;
    };
};