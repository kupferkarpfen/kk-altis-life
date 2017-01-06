// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// based upon Tonics work

private _control = _this select 0;
private _code = _this select 1;
private _shift = _this select 2;
private _ctrlKey = _this select 3;
private _alt = _this select 4;

private _handled = false;

// Block ESC when teargas'ed
if( XY_tearGasActive && _code isEqualTo 1 ) exitWith { true };

// Block tactical view
if( _code in (actionKeys "TacticalView") ) exitWith { true };

// Default Windows-Key, otherwise assigned key
private _interactionKey = if( count (actionKeys "User10") == 0 ) then { 219 } else {(actionKeys "User10") select 0};
private _interruptionKeys = [17, 30, 31, 32]; // W, A, S, D

private _forbidden = (actionKeys "SelectAll") + (actionKeys "ForceCommandingMode");
private _forbiddenInJail = (actionKeys "GetOver") + (actionKeys "Turbo") + (actionKeys "Crouch") + (actionKeys "Prone") + (actionKeys "moveDown");
private _forbiddenRestrained = _forbiddenInJail + (actionKeys "ReloadMagazine") + (actionKeys "Salute") + (actionKeys "SitDown");

private _vehicle = vehicle player;
private _cursorObject = cursorObject;

if( _code in _forbidden ) exitWith { true };
if( XY_isArrested && { _code in _forbiddenInJail } ) exitWith { true };
if( (player getVariable ["restrained", false]) && { _code in _forbiddenRestrained  } ) exitWith { true };

if( XY_actionInUse && { !XY_interrupted } && { _code in _interruptionKeys } ) then {
    XY_interrupted = true;
    _handled;
};
if( player getVariable ["restrained", false] ) exitWith {
    _handled;
};

//Hotfix for Interaction key not being able to be bound on some operation systems.
if( count (actionKeys "User10") != 0 && { (inputAction "User10") > 0 } && { time - XY_cooldown > 1 } ) exitWith {
    XY_cooldown = time;
    call XY_fnc_actionKeyHandler;
    true;
};

if( _code in [17, 30, 31, 32] && _ctrlKey ) then {
    if( !(isNil "XY_MOVE_OBJECT") ) then {
        private _pos = getPos XY_MOVE_OBJECT;
        if( !_shift ) then {
            _pos set[0, (_pos select 0) + ([0, 0.1] select (_code == 32)) + ([0, -0.1] select (_code == 30))];
            _pos set[1, (_pos select 1) + ([0, 0.1] select (_code == 17)) + ([0, -0.1] select (_code == 31))];
        } else {
            _pos set[2, (_pos select 2) + ([0, 0.1] select (_code == 17)) + ([0, -0.1] select (_code == 31))];
        };
        XY_MOVE_OBJECT setPos _pos;
        _handled = true;
    };
};

; //A, S, W, D

switch (_code) do {

    case 59: {
        // F1 - open help menu
        if( !dialog && !XY_actionInUse && !_shift && !_alt && !_ctrlKey ) then {
            _handled = true;
            ["init"] call XY_fnc_helpMenu;
        };
    };
    case 62: {
        // F4 - toggle admin messages
        if( XY_isAdmin && !dialog && !XY_actionInUse && !_shift && !_alt && !_ctrlKey ) then {
            _handled = true;
            XY_showAdminMessages = !XY_showAdminMessages;
            titleText[format["ADMINNACHRICHTEN %1", ["AUS", "AN"] select XY_showAdminMessages], "PLAIN"];
        };
    };
    case 63: {
        // F5 - panic button
        if( time >= (missionNamespace getVariable ["XY_panicCooldown", 0]) && !_shift && !_alt && !_ctrlKey ) then {
            _handled = true;
            XY_panicCooldown = time + 120;
            titleCut["SPIELER IN DER UMGEBUNG WURDEN PROTOKOLLIERT", "WHITE IN", 2];

            private _object = [XY_corpse, player] select (call XY_fnc_isAlive);
            private _players = playableUnits select { isPlayer _x && { _x distance _object < 500 } };
            _players = _players apply { [_x distance _object, _x] };
            _players sort true;

            private _logData = [];
            {
                private _player = _x select 1;
                _logData pushBack format [
                    "DISTANCE: %1m, HEIGHT: %2m, RELATIVE DIRECTION: %3, NAME: %4 (%5), WEAPON/VEHICLE: %6, MASKED: %7",
                    _object distance _player,
                    round((getPos _player) select 2),
                    _object getRelDir _player,
                    _player getVariable["realName", "ERROR"],
                    getPlayerUID _player,
                    if( (vehicle _player) isEqualTo _player ) then { if( (currentWeapon _player) isEqualTo "") then { "NONE" } else { currentWeapon _player } } else { typeOf(vehicle _player) },
                    ["NO", "YES"] select ([_player] call XY_fnc_playerMasked)
                ];
            } forEach _players;

            [getPlayerUID player, 23, _logData] remoteExecCall ["XYDB_fnc_log", XYDB];
        };
    };
    case 64: {
        // F6 - log player position
        diag_log format["%1 - %2", getPos player, getDir player];
        _handled = true;
    };
    //Space key for Jumping
    case 57: {
        if(isNil "jumpActionTime") then {
            jumpActionTime = 0;
        };
        if(_shift && {animationState player != "AovrPercMrunSrasWrflDf"} && {isTouchingGround player} && {stance player == "STAND"} && {speed player > 2} && {!XY_isArrested} && {(velocity player) select 2 < 2.5} && {time - jumpActionTime > 1.5}) then {
            jumpActionTime = time;
            [player] remoteExec ["XY_fnc_jumpFnc"];
            _handled = true;
        };
    };

    //Holster / recall weapon.
    case 35: {
        if( !XY_actionInUse && (_shift || _ctrlKey) && time - XY_cooldown > 2 ) then {
            if(_shift && !_ctrlKey && currentWeapon player != "") then {
                XY_currentWeaponToRecall = currentWeapon player;
                player action ["SwitchWeapon", player, player, 100];
                player switchcamera cameraView;
                XY_cooldown = time;
            };
            if(!_shift && _ctrlKey && !isNil "XY_currentWeaponToRecall" && {(XY_currentWeaponToRecall != "")}) then {
                if(XY_currentWeaponToRecall in [primaryWeapon player,secondaryWeapon player,handgunWeapon player]) then {
                    player selectWeapon XY_currentWeaponToRecall;
                };
                XY_cooldown = time;
            };
        };
    };

    //Interaction key (default is Left Windows, can be mapped via Controls -> Custom -> User Action 10)
    case _interactionKey: {
        if( !XY_actionInUse && (time - XY_cooldown) > 1 ) then {
            XY_cooldown = time;
            _handled = true;
            call XY_fnc_actionKeyHandler;
        };
    };

    case 19: {

        //Restraining (Shift + R)
        if( _shift && !_alt && !_ctrlKey ) then {
            _handled = true;

            if( !(isNull _cursorObject) && _cursorObject isKindOf "Man" && isPlayer _cursorObject && alive _cursorObject && _cursorObject distance player < 4 && !(_cursorObject getVariable "escorting") && !(_cursorObject getVariable "restrained") && speed _cursorObject < 1.5 && time - XY_cooldown > 1 ) then {
                XY_cooldown = time;
                // Some more checks if we are civilian...
                if( ( playerSide isEqualTo west && side _cursorObject != west ) || (animationState _cursorObject) == "incapacitated" ) then {
                    if( playerSide isEqualTo west || { (["handschellen", 1] call XY_fnc_removeItemFromTrunk) } ) then {
                        [_cursorObject] call XY_fnc_restrainAction;
                    } else {
                        hint "Du hast keine Handschellen dabei!";
                    };
                };
            };
        };

        // Repack Magazines (STRG + R)
        if( !_shift && !_alt && _ctrlKey ) then {
            [] spawn XY_fnc_repackMagazines;
            _handled = true;
        };

        // Red Gull (ALT + R)
        if( !_shift && _alt && !_ctrlKey ) then {
            _handled = true;
            [ "redgull" ] call XY_fnc_useItem;
        };
    };

    //T Key (Trunk)
    case 20: {

        if( !_shift && !_alt && !_ctrlKey ) then {
            _handled = true;

            if( !XY_actionInUse && (time - XY_cooldown) > 2 ) then {
                XY_cooldown = time;

                if( _vehicle isEqualTo player ) then {
                    _vehicle = _cursorObject;
                };
                private _isHouse = _vehicle isKindOf "House_F";
                if( (_vehicle isKindOf "Car" || _vehicle isKindOf "Air" || _vehicle isKindOf "Ship" || _isHouse) && [_vehicle] call XY_fnc_isPlayerNearVehicle ) then {
                    // We have a valid vehicle/building
                    if( _vehicle in XY_vehicles || { _isHouse && !(_vehicle getVariable["locked", true]) } || { !_isHouse && ((locked _vehicle) isEqualTo 0) } ) then {
                        if( !(_vehicle getVariable["busy", false]) ) then {
                            ["init", _vehicle] call XY_fnc_trunkMenu;
                        };
                    };
                };
            };
        };
    };
    //L Key?
    case 38: {
        // Turn on flashlights
        if( _shift && (_vehicle getVariable[ "side", sideUnknown ]) in [west, east, independent] && _vehicle != player && (driver _vehicle) isEqualTo player && time - XY_cooldown > 3 ) then {
            XY_cooldown = time;
            _handled = true;

            // Toggle lights status
            _vehicle setVariable["lights", !(_vehicle getVariable["lights", false]), true];

            // Should it be on?
            if( _vehicle getVariable["lights", false] ) then {
                titleText ["BLAULICHT AN", "PLAIN"];
                [_vehicle] remoteExec ["XY_fnc_flashLights", -2];
            } else {
                titleText ["BLAULICHT AUS", "PLAIN"];
            };
        };
        if( !_alt && !_ctrlKey ) then {
            [] call XY_fnc_radar;
        };
    };
    //Y Player Menu
    case 21: {
        if( !_alt && !_ctrlKey && !dialog && !XY_actionInUse ) then {
            [] call XY_fnc_p_openMenu;
        };
    };
    // Shift -> Chip tuning boost
    case 42: {
        if( _vehicle != player && { local _vehicle } && { isEngineOn _vehicle } && { _vehicle getVariable["chip.enabled", false] } ) then {
            [_vehicle] call XY_fnc_chipboost;
        };
    };
    case 24: {
        // Shift+O, gate opener
        if( _shift && !_alt && !_ctrlKey ) then {
            _handled = true;
            if ( playerSide != civilian && (time - XY_cooldown) > 2 ) then {
                XY_cooldown = time;
                [] call XY_fnc_copOpener;
            };
        };
        // Alt+O, show passport
        if ( !_shift && _alt && !_ctrlKey ) then {
            _handled = true;

            if( !(isPlayer _cursorObject) ) then {
              hint parseText format[XY_hintError, "Du musst eine Person anschauen, der du den Ausweis zeigen möchtest"];
            } else {
              if( (time - XY_cooldown) > 6 ) then {
                XY_cooldown = time;
                [_cursorObject] call XY_fnc_givePassport;
                titleText ["Du hast deinen Ausweis gezeigt", "PLAIN"];
              };
            };
        };
        // Ctrl+O, recall passport
        if ( !_shift && !_alt && _ctrlKey ) then {
            _handled = true;

            private _expired = (missionNamespace getVariable ["XY_PP_LASTPASS_EXPIRE", 0]) <= time;
            private _data = missionNamespace getVariable ["XY_PP_LASTPASS", []];
            if( !_expired && !(_data isEqualTo []) ) then {
                _data call XY_fnc_showPassport;
            };
        };
    };

    //F Key
    case 33: {

        private _side = _vehicle getVariable[ "side", sideUnknown ];

        if( _vehicle isEqualTo player && _shift && !_alt && !_ctrlKey ) then {
            _handled = true;

            if( !(playerSide isEqualTo civilian) && (side _cursorObject) isEqualTo civilian ) exitWith {};

            // Some pre-conditions need to be met, otherwise the cooldown cripples the effectivity of the action
            if( time - XY_cooldown > 1 && { !(isNull _cursorObject) } && { isPlayer _cursorObject } ) then {
                XY_cooldown = time;
                [_cursorObject] call XY_fnc_knockoutAction;
            };
        };
        if( !(_vehicle isEqualTo player) && { (driver _vehicle) isEqualTo player } && { _side in [west, east, independent] } && { time - XY_cooldown > 2 } ) then {
            XY_cooldown = time;

            _message = "";
            _duration = 0;
            _sirenSound = "";

             switch ( true ) do {
                // F = Standard Siren
                case( _side == west && !_alt && !_ctrlKey && !_shift ): {
                    _message = "Sirene";
                    _sirenSound = "sirencoplong";
                    _duration = 3.8;
                };
                // Shift+F = Short siren
                case( _side == west && !_alt && !_ctrlKey && _shift ): {
                    _message = "Heulen";
                    _sirenSound = "sirencop";
                    _duration = 3.7;
                };
                // Strg+F = Megaphon voice
                case( _side == west && playerSide == west && !_alt && _ctrlKey && !_shift ): {
                    _message = "Warnung";
                    _sirenSound = "warningcop";
                    _duration = 8;
                };
                case( _side == independent && !_alt && !_ctrlKey && !_shift ): {
                    _message = "Sirene";
                    _sirenSound = "sirenmedic" ;
                    _duration = 3;
                };
                case( _side == independent && !_alt && !_ctrlKey && _shift ): {
                    _message = "Horn";
                    _sirenSound = "sirenmedicalt" ;
                    _duration = 6.5;
                };
            };

            if( _sirenSound isEqualTo "" ) exitWith {};

            _state = _vehicle getVariable[ _sirenSound, false];
            _vehicle setVariable[ _sirenSound, !_state, true ];

            if( _state ) then {
                titleText[_message + " AUS", "PLAIN"];
            } else {
                titleText[_message + " AN", "PLAIN"];
                [_vehicle, _sirenSound, _duration] remoteExec ["XY_fnc_siren", -2 ];
            };
        };
    };

    //U Key
    case 22: {
        if( !_alt && !_ctrlKey && time - XY_cooldown > 1 ) then {
            XY_cooldown = time;
            _handled = true;

            if( _vehicle isEqualTo player ) then {
                _vehicle = _cursorObject;
            };

            if( _vehicle isKindOf "House_F" && playerSide isEqualTo civilian ) then {
                if( _vehicle in XY_vehicles && player distance2D _vehicle < 15 ) then {
                    _door = [_vehicle] call XY_fnc_nearestDoor;
                    if( _door < 1 ) exitWith {
                        hint localize "STR_House_Door_NotNear"
                    };
                    _locked = _vehicle getVariable [format["bis_disabled_Door_%1",_door],0];
                    if( _locked == 0 ) then {
                        _vehicle setVariable[format["bis_disabled_Door_%1",_door],1,true];
                        _vehicle animate [format["door_%1_rot",_door],0];
                        systemChat localize "STR_House_Door_Lock";
                    } else {
                        _vehicle setVariable[format["bis_disabled_Door_%1",_door],0,true];
                        _vehicle animate [format["door_%1_rot",_door],1];
                        systemChat localize "STR_House_Door_Unlock";
                    };
                };
            } else {
                _locked = locked _vehicle;
                if( _vehicle in XY_vehicles && [_vehicle] call XY_fnc_isPlayerNearVehicle ) then {
                    _targetState = [0, 2] select (locked _vehicle != 2);
                    [ _vehicle, _targetState ] remoteExec ["XY_fnc_lockVehicle", _vehicle];
                    hint parseText format[XY_hintH1, format[XY_hintMsg, ["Aufgeschlossen", "Abgeschlossen"] select (_targetState isEqualTo 2), ["Dein Fahrzeug (Sitzplätze, Inventar und Kofferraum) ist nun für alle geöffnet", "Der Kofferraum ist für Besitzer des Schlüssels weiterhin geöffnet"] select (_targetState isEqualTo 2 )]];
                    [_vehicle, "locksound"] remoteExecCall ["say3D", playableUnits select { isPlayer _x && { (_x distance player) < 100 } }];
                };
            };
        };
    };

    //Q Key
    case 16: {
        if( playerSide isEqualTo west && { _vehicle != player } && { driver _vehicle == player } && { _vehicle isKindOf "Car" } && { time - XY_cooldown > 3 } ) then {
            _handled = true;
            XY_cooldown = time;
            [_vehicle, "policehonk"] remoteExecCall ["say3D", playableUnits select { isPlayer _x && { (_x distance player) < 100 } }];
        };
    };

    //Surrender key Shift + B
    case 48: {

        if (_shift) then {
            _handled = true;
            if( _vehicle isEqualTo player && (animationState player) != "incapacitated" && !XY_isTazed ) then {
                if (player getVariable ["surrender", false]) then {
                    player setVariable ["surrender", false, true];
                } else {
                    [] spawn XY_fnc_surrender;
                };
            };
        };

        if( _alt ) then {
            _handled = true;
            if( playerSide isEqualTo west && { time - XY_cooldown > 1 } ) then {
                XY_cooldown = time;
                call XY_fnc_seizeObjects;
            };
        };
    };

    //EMP Konsole - K
    case 37: {
        if( !_shift && !_alt && !_ctrlKey && (playerSide isEqualTo west) && _vehicle != player && (typeOf _vehicle) in ["B_Heli_Transport_01_F", "I_Heli_light_03_unarmed_F"]) then {
            [] call XY_fnc_openEmpMenu;
        };
    };

    //Shift+P = Faded Sound
    case 25: {
        if( _shift ) then {
            [] call XY_fnc_fadeSound;
            _handled = true;
        };
    };

    case 0x02;
    case 0x03;
    case 0x04: {
        if( _vehicle isEqualTo player && !dialog ) then {
            if( time - XY_cooldown > 2 ) then {
                XY_cooldown = time;
                player playActionNow (if( _code isEqualTo 0x02 ) then { "gestureHi" } else { if( _code isEqualTo 0x03 ) then { "gestureHiB" } else { "gestureHiC" }});
            };
            _handled = true;
        };
    };

    default {

        if( _code in (actionKeys "ShowMap") && !visibleMap ) then {
            [] spawn XY_fnc_mapMarkers;
        };

        // Some movement and gesture shit
        if( (_shift || _ctrlKey) && _code in [0x52, 0x4F, 0x50, 0x51, 0x4B, 0x4C, 0x4D, 0x47, 0x48, 0x49] && _vehicle isEqualTo player ) then {
            if( time - XY_cooldown > 2 ) then {
                XY_cooldown = time;
                if( _shift ) then {
                    player playMove (switch(_code) do {
                        case(0x52): { "AmovPercMstpSnonWnonDnon_exercisekneeBendA" };
                        case(0x4F): { "AmovPercMstpSnonWnonDnon_exercisekneeBendB" };
                        case(0x50): { "AmovPercMstpSnonWnonDnon_exercisePushup" };
                        case(0x51): { "AmovPercMstpSnonWnonDnon_exerciseKata" };
                        case(0x4B): { "AmovPercMstpSnonWnonDnon_Scared" };
                        case(0x4C): { "Acts_AidlPercMstpSlowWrflDnon_pissing" };
                    });
                };
                if( _ctrlKey ) then {
                    player playAction (switch(_code) do {
                        case(0x52): { "GestureNo" };
                        case(0x4F): { "GestureNod" };
                        case(0x50): { "GestureGo" };
                        case(0x51): { "GestureCover" };
                        case(0x4B): { "GestureCeaseFire" };
                        case(0x4C): { "GestureFollow" };
                        case(0x4D): { "GestureUp" };
                        case(0x47): { "GestureAdvance" };
                        case(0x48): { "GesturePoint" };
                    });
                };
            };
            _handled = true;
        };
    };
};

_handled;
