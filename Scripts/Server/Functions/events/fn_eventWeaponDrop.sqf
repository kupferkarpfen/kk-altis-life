// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _loadout = param[0, -1, [0]];

diag_log "<EVENT> eventWeaponDrop";
XY_allowPVPEvents = false;

private _locations = [];
_locations pushBack [19152, 7072, 0];
_locations pushBack [19717, 6314, 0];
_locations pushBack [20775, 5631, 0];
_locations pushBack [21744, 5232, 0];
_locations pushBack [21250, 6678, 0];
_locations pushBack [22261, 7425, 0];
_locations pushBack [21396, 7502, 0];
_locations pushBack [20789, 6726, 0];
_locations pushBack [20298, 7431, 0];
_locations pushBack [21237, 8030, 0];
_locations pushBack [21921, 8505, 0];

private _pos = [];
private _box = objNull;

private _randomLoadout = [];

_randomLoadout pushBack {
    private _box = param[0, objNull, [objNull]];
    if( _box isEqualTo objNull ) exitWith {};
    diag_log "<EVENT> arming box with loadout 0";
    _box addWeaponCargoGlobal ["arifle_CTARS_ghex_F", 1];
    _box addMagazineCargoGlobal ["100Rnd_580x42_Mag_F", 8];
    _box addItemCargoGlobal ["HandGrenade", 3];
};
_randomLoadout pushBack {
    private _box = param[0, objNull, [objNull]];
    if( _box isEqualTo objNull ) exitWith {};
    diag_log "<EVENT> arming box with loadout 1";
    _box addWeaponCargoGlobal ["arifle_SPAR_03_khk_F", 1];
    _box addMagazineCargoGlobal ["20Rnd_762x51_Mag", 15];
    _box addItemCargoGlobal ["muzzle_snds_H", 1];
    _box addItemCargoGlobal ["HandGrenade", 3];
};
_randomLoadout pushBack {
    private _box = param[0, objNull, [objNull]];
    if( _box isEqualTo objNull ) exitWith {};
    diag_log "<EVENT> arming box with loadout 2";
    _box addWeaponCargoGlobal ["arifle_CTAR_hex_F", 1];
    _box addMagazineCargoGlobal ["30Rnd_580x42_Mag_F", 15];
    _box addItemCargoGlobal ["HandGrenade", 3];
};
_randomLoadout pushBack {
    private _box = param[0, objNull, [objNull]];
    if( _box isEqualTo objNull ) exitWith {};
    diag_log "<EVENT> arming box with loadout 3";
    _box addWeaponCargoGlobal ["arifle_Katiba_C_F", 1];
    _box addMagazineCargoGlobal ["30Rnd_65x39_caseless_green", 10];
    _box addItemCargoGlobal ["muzzle_snds_H", 1];
    _box addItemCargoGlobal ["HandGrenade", 3];
};
_randomLoadout pushBack {
    private _box = param[0, objNull, [objNull]];
    if( _box isEqualTo objNull ) exitWith {};
    diag_log "<EVENT> arming box with loadout 4";
    _box addWeaponCargoGlobal ["srifle_EBR_F", 1];
    _box addMagazineCargoGlobal ["20Rnd_762x51_Mag", 15];
    _box addItemCargoGlobal ["optic_Nightstalker", 1];
    _box addItemCargoGlobal ["HandGrenade", 3];
};
_randomLoadout pushBack {
    private _box = param[0, objNull, [objNull]];
    if( _box isEqualTo objNull ) exitWith {};
    diag_log "<EVENT> arming box with loadout 5";
    _box addWeaponCargoGlobal ["SMG_01_Holo_pointer_snds_F", 1];
    _box addMagazineCargoGlobal ["30Rnd_45ACP_Mag_SMG_01", 15];
    _box addItemCargoGlobal ["G_Combat", 3];
    _box addItemCargoGlobal ["HandGrenade", 3];
};
_randomLoadout pushBack {
    private _box = param[0, objNull, [objNull]];
    if( _box isEqualTo objNull ) exitWith {};
    diag_log "<EVENT> arming box with loadout 6";
    _box addWeaponCargoGlobal ["arifle_ARX_hex_F", 1];
    _box addMagazineCargoGlobal ["30Rnd_65x39_caseless_green", 15];
    _box addMagazineCargoGlobal ["10Rnd_50BW_Mag_F", 15];
    _box addItemCargoGlobal ["HandGrenade", 3];
};
_randomLoadout pushBack {
    private _box = param[0, objNull, [objNull]];
    if( _box isEqualTo objNull ) exitWith {};
    diag_log "<EVENT> arming box with loadout 7";
    _box addWeaponCargoGlobal ["arifle_AKM_F", 1];
    _box addMagazineCargoGlobal ["30Rnd_762x39_Mag_F", 15];
    _box addItemCargoGlobal ["HandGrenade", 3];
};
_randomLoadout pushBack {
    private _box = param[0, objNull, [objNull]];
    if( _box isEqualTo objNull ) exitWith {};
    diag_log "<EVENT> arming box with loadout 8";
    _box addWeaponCargoGlobal ["srifle_DMR_07_hex_F", 1];
    _box addMagazineCargoGlobal ["20Rnd_650x39_Cased_Mag_F", 15];
    _box addItemCargoGlobal ["muzzle_snds_H", 1];
    _box addItemCargoGlobal ["HandGrenade", 3];
};

while { true } do {

    _pos = [ selectRandom _locations, random 100, random 360, 0, [0, 0], [300, "Box_NATO_Wps_F"] ] call SHK_pos;
    // Check if there are players nearby...
    diag_log format["<EVENT> Checking random position: %1", _pos];

    _valid = true;
    {
        if( _pos distance (getMarkerPos _x) < 100 ) exitWith {
            diag_log format["<EVENT> Position too near to marker: %1", _x];
            _valid = false;
        };
    } forEach allMapMarkers;

    {
        if( _pos distance _x < 500 ) exitWith {
            diag_log format["<EVENT> Position too near to player: %1", _x];
            _valid = false;
        };
    } forEach allPlayers;

    if( _valid ) exitWith {
        diag_log "<EVENT> Found valid position for weaponbox, testing spawn...";

        _box = "Box_NATO_Wps_F" createVehicle [0, 0, 0];
        _box setVariable[ "despawn", false, true];
        _box setVariable[ "rope.allow", false, true];
        _box setVariable[ "box.locked", serverTime + 900, true];
        _box setDir (random 360);
        _box setPos _pos;
        _box setVectorUp [0, 0, 1];
        clearMagazineCargoGlobal _box;
        clearWeaponCargoGlobal _box;
        clearItemCargoGlobal _box;

        if( _loadout < 0 || _loadout >= (count _randomLoadout) ) then {
            [_box] call (selectRandom _randomLoadout);
        } else {
            [_box] call (_randomLoadout select _loadout);
        };
    };
    uisleep 20;
};

[3, "Waffentransport über Altis abgestürzt", "Eine Waffenkiste mit seltenen Waffen wird aktuell vermisst +++ Die ungefähre Position wurde markiert +++ Bitte näheren Sie sich nicht dem Absturzgebiet"] remoteExec ["XY_fnc_broadcast", [civilian, west]];

private _marker = createMarker[ "poi_PVPWeaponBox", [0,0,0] ];
_marker setMarkerColor "ColorRed";
_marker setMarkerShape "ELLIPSE";
_marker setMarkerBrush "SolidBorder";

private _markerText = createMarker [ "poi_PVPWeaponBoxText", [0,0,0] ];
_markerText setMarkerColor "ColorYellow";
_markerText setMarkerType "mil_marker";
_markerText setMarkerText "Waffenkiste";

private _maxFake = 850;
private _minSize = 50;

while { true } do {

    private _fakePos = [ (_pos select 0) + ((_maxFake * (random 1)) - _maxFake / 2), (_pos select 1) + ((_maxFake * (random 1)) - _maxFake / 2), 0];

    _marker setMarkerPos _fakePos;
    _marker setMarkerSize [_maxFake, _maxFake];

    _markerText setMarkerPos _fakePos;

    uisleep 100;
    if( _maxFake <= _minSize ) exitWith {};
    _maxFake = (_maxFake - 40) max _minSize;
};