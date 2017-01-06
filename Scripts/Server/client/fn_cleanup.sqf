// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

scriptName "XY_fnc_cleanup";

private _nextCleanup = time;

private _lastKarmapoint = time;
private _nextKarmapoint = time + 60;

XY_LAST_KEY_ACTION = time;
XY_NEXT_WARNING = 0;
(findDisplay 46) displayAddEventHandler ["KeyDown", { XY_LAST_KEY_ACTION = time; } ];

0 enableChannel false;
1 enableChannel false;
2 enableChannel false;

private _lastPosition = getPos player;
private _lastMove = time;

while {true} do {

    uisleep 1;

    if( (_lastPosition distance (getPos player)) > 0.1 ) then {
        _lastMove = time;
        _lastPosition = getPos player;
    };

    if( time - XY_LAST_KEY_ACTION > 300 && time - _lastMove > 300 && (call XY_fnc_isAlive) && !(isObjectHidden player) ) then {
        if( time - XY_LAST_KEY_ACTION > 600 && time - _lastMove > 600 ) then {
            KICKED_FOR_IDLE = format["%1, %2, %3, %4", time, KICKED_FOR_IDLE, _lastMove, (call XY_fnc_isAlive)];
            publicVariableServer "KICKED_FOR_IDLE";
        };
        if( time >= XY_NEXT_WARNING ) then {
            playSound "Notification";
            hint parseText format[XY_hintMsg, format[XY_hintError, "INAKTIVITÄT"], "Achtung: Wenn du zu lange inaktiv bist, wirst du vom Server entfernt"];
            XY_NEXT_WARNING = time + 60;
        };
    };

    if( cameraView isEqualTo "GROUP" && (alive player) ) then {
        (vehicle player) switchCamera "EXTERNAL";
    };
    if( !(commandingMenu isEqualTo "") ) then {
        showCommandingMenu "";
    };

    // ---
    // fed workaround
    XY_FED_DOME setVariable["bis_disabled_Door_1", 1];
    XY_FED_DOME setVariable["bis_disabled_Door_2", [1, 0] select (fed_bank getVariable["door.open.2", false])];
    XY_FED_DOME setVariable["bis_disabled_Door_3", [1, 0] select (fed_bank getVariable["door.open.3", false])];

    XY_FED_RSB setVariable["bis_disabled_Door_1", [1, 0] select (fed_bank getVariable["door.open.1", false])];
    // ---

    private _vehicle = vehicle player;

    if( _vehicle getVariable["unusable", false] ) then {
        player action ["GetOut", _vehicle];
    };

    if( _vehicle isKindOf "Air" || _vehicle isKindOf "Ship" ) then {
        // Check if we have goldbars loaded...
        if( ([XY_fnc_getItemCountFromTrunk, ["goldbar"]] call XY_fnc_unscheduled) > 0 ) then {
            hint parseText format[XY_hintError, "Du bist zu schwer um mit einem Helikopter zu fliegen"];
            player action ["GetOut", _vehicle];
        };
    };

    if( _vehicle isKindOf "Air" ) then {
        XY_lastAirVehicle = time;
    };

    if( _nextKarmapoint <= time ) then {
        _nextKarmapoint = time + 600 + (random 300);
        if( (alive player) && (isNil "XY_corpse") && XY_hunger < 0.9 && XY_thirst < 0.9 ) then {

            // Some ideas for karma regeneration:
            // When near other players (not in own gang) and talking

            private _timeDelta = time - _lastKarmapoint;
            private _karmaPointsGained = XY_ssv_karmaReg / 3600 * _timeDelta;
            private _newKarma = (XY_karma + _karmaPointsGained) min XY_ssv_karmaMax;
            diag_log format["<KARMA> FROM %1 TO %2 / DELTA: %3 / TIME PASSED: %4s", XY_karma, _newKarma, _karmaPointsGained, _timeDelta];
            XY_karma = _newKarma;
            player setVariable["karma", XY_karma, true];
        };
        _lastKarmapoint = time;
    };

    private _slingload = getSlingLoad _vehicle;
    if( !(isNull _slingload) && { !(_slingload getVariable["rope.allow", true]) } ) exitWith {
        hint parseText format[XY_hintError, "Das darfst du nicht heben"];
        _vehicle setSlingLoad objNull;
    };

    // support abandon vehicles display
    if( _vehicle != player && { serverTime - (_vehicle getVariable ["lastUseTime", 0]) > 120 } ) then {
        _vehicle setVariable[ "lastUseTime", serverTime, true ];
    };
    if( _vehicle != player ) then {
        _vehicle setVariable ["lastUsedByMe", time ];
    };

    if( time >= _nextCleanup ) then {
        _nextCleanup = time + 10;
        {
            if( local _x && { (units _x) isEqualTo [] } ) then {
                deleteGroup _x;
            };
        } forEach allGroups;
    };

    {
        private _o = agent _x;
        if( (_o isKindOf "Snake_random_F") || (_o isKindOf "Rabbit_F")) then {
            deleteVehicle _o;
        };
    } forEach agents;
};