// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

diag_log "<EVENT> eventDrone";
XY_allowPVPEvents = false;

private _locations = [];
_locations pushBack [18660, 7232, 0];
_locations pushBack [19126, 7935, 0];
_locations pushBack [19279, 6551, 0];
_locations pushBack [19992, 6224, 0];
_locations pushBack [20675, 8236, 0];
_locations pushBack [21724, 8647, 0];
_locations pushBack [21757, 7998, 0];

private _pos = [];
private _wreck = objNull;

while { true } do {

    _pos = [ selectRandom _locations, random 100, random 360, 0, [0, 0], [300, "B_UAV_02_F"] ] call SHK_pos;
    // Check if there are players nearby...
    diag_log format["<EVENT> Checking random position: %1", _pos];

    _valid = true;
    {
        if( _pos distance (getMarkerPos _x) < 200 ) exitWith {
            diag_log format["<EVENT> Position too near to marker: %1", _x];
            _valid = false;
        };
    } forEach allMapMarkers;

    {
        if( _pos distance _x < 2000 ) exitWith {
            diag_log format["<EVENT> Position too near to player: %1", _x];
            _valid = false;
        };
    } forEach allPlayers;

    if( _valid ) exitWith {
        diag_log "<EVENT> Found valid position for UAV wreck, testing spawn...";

        XY_pvpUAVwreck = "B_UAV_02_F" createVehicle [0, 0, 0];
        publicVariable "XY_pvpUAVwreck";

        XY_pvpUAVwreck setVariable[ "despawn", false, true];
        XY_pvpUAVwreck setVariable[ "rope.allow", false, true];
        XY_pvpUAVwreck setDamage 1;
        uisleep 3;
        XY_pvpUAVwreck setPos _pos;
        XY_pvpUAVwreck setDir (random 360);
        XY_pvpUAVwreck setVectorUp [0, 0, -1];
        uisleep 5;
        XY_pvpUAVwreck enableSimulation false;
    };
    uisleep 20;
};

{ diag_log format["<EVENT> (UAVWreck) addAction to %1", XY_pvpUAVwreck]; [XY_pvpUAVwreck, "usb1"] call XY_fnc_initializeProcessor; } remoteExecCall ["bis_fnc_call", -2, true];

// Create global marker for wreck position
private _marker = createMarker [ "poi_PVPDroneWreck", _pos ];
_marker setMarkerColor "ColorRed";
_marker setMarkerType "hd_dot";
_marker setMarkerText "Abgestürzte Drohne";

// --- PROCESSOR ---
_pos = [22703, 6930, 0.3];

XY_pvpUAVprocessor = "Land_Device_assembled_F" createVehicle [0, 0, 0];
publicVariable "XY_pvpUAVprocessor";

XY_pvpUAVprocessor setPosATL _pos;
XY_pvpUAVprocessor setDir 70;
XY_pvpUAVprocessor setVectorUp [0, 0, 1];
XY_pvpUAVprocessor enableSimulation false;

// Create global marker for wreck position
_marker = createMarker [ "poi_PVPDroneProcessor", _pos ];
_marker setMarkerColor "ColorRed";
_marker setMarkerType "hd_dot";
_marker setMarkerText "Entschlüsselungsstation";

{ diag_log format["<EVENT> (UAVProcessor) addAction to %1", XY_pvpUAVprocessor]; [XY_pvpUAVprocessor, "usb2"] call XY_fnc_initializeProcessor; } remoteExecCall ["bis_fnc_call", -2, true];

// --- TRADER ---

_pos = [20854, 6726, 3.815];

XY_pvpUAVtrader = "Land_InfoStand_V2_F" createVehicle [0, 0, 0];
publicVariable "XY_pvpUAVtrader";

XY_pvpUAVtrader setPosATL _pos;
XY_pvpUAVtrader setDir 275;
XY_pvpUAVtrader setVectorUp [0, 0, 1];
XY_pvpUAVtrader enableSimulation false;

// Create global marker for wreck position
_marker = createMarker [ "poi_PVPDroneTrader", _pos ];
_marker setMarkerColor "ColorRed";
_marker setMarkerType "hd_dot";
_marker setMarkerText "Darknet-Händler";

["update"] remoteExec [ "XY_fnc_markerManager", -2 ];

{ diag_log format["<EVENT> (UAVTrader) addAction to %1", XY_pvpUAVtrader]; [XY_pvpUAVtrader, ["darknet", { playerSide isEqualTo civilian }]] call XY_fnc_initializeVirtualShop; } remoteExecCall ["bis_fnc_call", -2, true];

[3, "Drohnenabsturz in Konfliktgebiet", "Die Drohne enthält möglicherweise wertvolle Geheimnisse +++ Mit HackBook Pro und USB-Sticks bewaffnete Gangs werden in Kürze am Absturzort erwartet"] remoteExec ["XY_fnc_broadcast", civilian];