// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Script useful for (air-)racing events, must be enabled from ingame console by setting variable on server and making it public
// XY_enableRacing = true;
// publicVariable "XY_enableRacing";

// All race-vehicles must be spawned by an admin and must hava a variable set to prevent idiots from abusing the race-script
// _vehicle setVariable ["racingEnabled", true];
// Vehicles used once are not allowed to re-enter the race
// used vehicles get deleted when unoccupied for 90s

// place map markers as checkpoints using the ingame console
// map markers need special names to configure the checkpoint

// mrace_T_S_M_N_X

// mrace = start token to identifiy this as an race checkpoint
// T = Type, replace with A = Air race, G = Ground race
// S = Size, replace with checkpoint size, recommended is 150m for Air Race and 80m for ground race (As script runs unscheduled we require a large detection area)
// M = Mode, replace with S = Single (if more than one crew member exists, don't count the checkpoint as completed), X = Disable check
// N = Number, replace with checkpoint number, 0 = start, 1 = 1st checkpoint, ..., X = finish line
// X = Special condition, replace with "NON" for no special condition
//     "FS" = flying start, for air race a min speed of 100kmph and a min altitude of 100m is required to trigger the checkpoint

// Example: mrace_A_150_S_0_FS

// -> Start trigger for air race, triggers when air vehicle is inside 150m around marker, requires single crew and a flying vehicle faster 100kmph and 100m height

// ! define finish line as last marker, as this will freeze the configuration of the checkpoints !

disableSerialization;

private _waypoints = [];
private _activeWaypoint = [];
private _finishWaypoint = [];
private _startTime = 0;
private _finishTime = 0;
private _inVehicle = time;
private _display = objNull;
private _lockedVehicle = objNull;
private _timer = objNull;
private _reset = false;

// loop gets executed when XY_enableRacing is set
_fnc_raceLoop = {

    private _return = _this;
    switch (_this) do {
        case "INIT": {

            _waypoints = [];

            private _isComplete = false;
            // detect race markers
            {
                private _split = _x splitString "_";
                if( (_split select 0) isEqualTo "mrace" ) then {

                    // parse marker config
                    private _isAir = (_split select 1) isEqualTo "A";
                    private _size = parseNumber(_split select 2);
                    private _isSingle = (_split select 3) isEqualTo "S";
                    private _number = _split select 4;
                    if( _number isEqualTo "X" ) then {
                        _number = count _waypoints;
                        _isComplete = _number > 0;
                    } else {
                        _number = parseNumber(_number);
                    };
                    _waypoints set [ _number, [_number, getMarkerPos _x, _size, _isAir, _isSingle] ];

                    if( _isComplete ) exitWith {};
                };
            } forEach allMapMarkers;

            // No finish line yet
            if( !_isComplete ) then {
                // Recheck in 30 seconds
                uisleep 30;
            } else {
                if( !(isNil "XY_racingDebug") && { XY_racingDebug } ) then {
                    hint "WAITING FOR RACE START";
                    diag_log format["Waypoint list %1", _waypoints];
                };
                _activeWaypoint = _waypoints select 0;
                _finishWaypoint = _waypoints select ((count _waypoints) - 1);
                _return = "RUN";
            };
        };
        case "RUN": {

            if( !(alive player) || !(isNil "XY_corpse") || !(isNil "XY_resetRace") || _reset || ( _finishTime > 0 && time - _finishTime > 90 ) ) exitWith {

                if( _finishTime > 0 ) then {
                    systemChat "Du kannst nun wieder am Rennen teilnehmen";
                    hint "Du kannst nun wieder am Rennen teilnehmen";
                };

                if( !(isNil "XY_currentTask") ) then {
                    player removeSimpleTask XY_currentTask;
                    XY_currentTask = nil;
                };

                6 cutText["", "PLAIN"];
                _activeWaypoint = _waypoints select 0;
                _startTime = 0;
                _finishTime = 0;
                _reset = false;
                _display = objNull;
                _timer = objNull;
                _lockedVehicle = objNull;
                uisleep 10;
            };
            // Player finished
            if( _activeWaypoint isEqualTo [] ) exitWith {
                uisleep 30;
            };
            if( _activeWaypoint isEqualTo (_waypoints select 0) && { player distance2D (_activeWaypoint select 1) > 750 } ) exitWith {
                // Too far away from start, sleep to preserve some scripting cycles...
                uisleep 5;
            };

            if( _startTime > 0 ) then {
                if( isNull _display || isNull _timer ) then {
                    6 cutRsc ["XY_timer", "PLAIN"];
                    _display = uiNamespace getVariable "XY_timer";
                    _timer = _display displayCtrl 38301;
                };
                _timer ctrlSetText format["%1",[time - _startTime, "MM:SS.MS"] call BIS_fnc_secondsToString];
            };

            // Do we have the correct vehicle?
            private _vehicle = vehicle player;
            if( _vehicle isEqualTo player || { !(_vehicle getVariable ["racingEnabled", false]) } ) exitWith {

                // if more than 75s outside vehicle during race, abort
                if( !(_activeWaypoint isEqualTo []) && { (_activeWaypoint select 0) > 0 } && { time - _inVehicle > 75 } ) then {
                    _reset = true;
                    [0, format["%1 hat das Rennen abgebrochen", profileName]] remoteExec ["XY_fnc_broadcast"];
                    hint parseText "<t color='#FF0000' size ='1.2' align='center'>Rennen abgebrochen</t>";
                };
            };

            _inVehicle = time;

            // Check if we reached current waypoint...
            if( player isEqualTo (driver _vehicle) && { player distance2D (_activeWaypoint select 1) < (_activeWaypoint select 2) } ) then {

                if( _activeWaypoint select 4 && count crew _vehicle > 1 ) exitWith {
                    hint parseText "<t color='#FF0000' size ='1.2' align='center'>Beifahrer sind nicht erlaubt</t>";
                    uisleep 5;
                };
                if( !(isNull _lockedVehicle) && { !(_vehicle isEqualTo _lockedVehicle) } ) exitWith {
                    hint parseText "<t color='#FF0000' size ='1.2' align='center'>Das ist nicht mehr das Fahrzeug, mit dem du gestartet bist</t>";
                    uisleep 5;
                };

                if( _activeWaypoint isEqualTo _finishWaypoint ) exitWith {
                    hint parseText "<t color='#FF0000' size ='1.5' align='center'>Rennen beendet</t>";
                    6 cutText["", "PLAIN"];
                    _activeWaypoint = [];
                    _finishTime = time;
                    if( !(isNil "XY_currentTask") ) then {
                        player removeSimpleTask XY_currentTask;
                        XY_currentTask = nil;
                    };
                    [0, format["%1 hat das Rennen abgeschlossen, Zeit: %2", profileName, [ _finishTime - _startTime, "MM:SS.MS" ] call BIS_fnc_secondsToString]] remoteExec ["XY_fnc_broadcast"];
                    [player, _finishTime - _startTime] remoteExec ["XY_fnc_racingPlayerFinished", 2];
                    // disable racing on the vehicle to prevent abusing the race-script
                    _vehicle setVariable ["racingEnabled", false, true];
                };
                if( _activeWaypoint isEqualTo (_waypoints select 0) ) then {
                    hint parseText "<t color='#FF0000' size ='1.5' align='center'>Rennen gestartet</t>";
                    [0, format["%1 hat das Rennen gestartet", profileName]] remoteExec ["XY_fnc_broadcast"];
                    _startTime = time;
                    _lockedVehicle = _vehicle;

                    _vehicle spawn {
                        while { true } do {
                            private _vehicle = _this;
                            if( (isNull _vehicle) ) exitWith {};
                            if( (speed _vehicle) < 1 && { (crew _vehicle) isEqualTo [] } && { (serverTime - (_vehicle getVariable[ "lastUseTime", 0 ])) > 300 } ) exitWith {
                                deleteVehicle _vehicle;
                            };
                            uisleep 10;
                        };
                    };
                } else {
                    [0, format["%1 hat Wegpunkt %2 erreicht, aktuelle Zeit: %3", profileName, _activeWaypoint select 0, [ time - _startTime, "MM:SS.MS" ] call BIS_fnc_secondsToString]] remoteExec ["XY_fnc_broadcast"];
                };

                _activeWaypoint = _waypoints select ((_activeWaypoint select 0) + 1);

                if( !(isNil "XY_currentTask") ) then {
                    player removeSimpleTask XY_currentTask;
                };
                XY_currentTask = player createSimpleTask ["Nächster Wegpunkt"];
                XY_currentTask setSimpleTaskDestination (_activeWaypoint select 1);
                XY_currentTask setSimpleTaskDescription ["Checkpoint", "Checkpoint", "Checkpoint"];
                XY_currentTask setTaskState "Assigned";
                player setCurrentTask XY_currentTask;

                player say3D "beep";
            };
        };
        default {
            // something went horribly wrong, sleep to prevent cpu hogging
            uisleep 10;
        };
    };
    _return;
};

private _runMode = "INIT";
while { true } do {

    if( !(isNil "XY_enableRacing") && { XY_enableRacing } ) then {
        _runMode = _runMode call _fnc_raceLoop;
    } else {
        // Reset run-mode if disabled
        _runMode = "INIT";
        uisleep 90;
    };
};