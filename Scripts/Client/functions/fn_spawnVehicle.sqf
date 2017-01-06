// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _class =          param[0, "", [""]];
private _spawnPositions = param[1, [], [[]]];
private _price =          param[2, -1, [0]];
private _color =          param[3, -1, [0]];
private _vid =            param[4, -1, [0]];
private _targetSide =     param[5, sideUnknown, [sideUnknown]];
private _chipType =       param[6, -1, [0]];
private _ownedVehicle =   param[7, true, [false]];

if( _class isEqualTo "" || _spawnPositions isEqualTo [] || _price < 0 || _color < 0 || _targetSide isEqualTo sideUnknown ) exitWith {};

// Select spawnpoint
private _spawn = [];
{
    if( (nearestObjects[ _x select 0, [ "Car", "Ship", "Air" ], 7]) isEqualTo [] ) exitWith {
        _spawn = _x
    };
} forEach _spawnPositions;

if( _spawn isEqualTo [] ) exitWith {
    hint "Der Spawnpunkt ist blockiert";
    nil
};
// Vehicle spawned and ready: remove money
if( !([_price, [2, 0] select (_vid < 0) ] call XY_fnc_pay) ) exitWith {
    hint "Du hast zu wenig Geld";
    nil;
};

// Spawn
private _pos = _spawn select 0;

private _vehicle = createVehicle[_class, [0, 0, 1000], [], 500, "NONE"];
_vehicle setVariable ["BIS_enableRandomization", false, true];
_vehicle allowDamage false;
_vehicle lock 2;
_vehicle setDir (_spawn select 1);
_vehicle setPos [_pos select 0, _pos select 1, (_pos select 2) + 0.5];
_vehicle setVectorUp (surfaceNormal _pos);

if( _class != "B_MRAP_01_hmg_F" ) then {
    {
        // Do not remove horn...
        if( (_x find "Horn") < 0 && ( _targetSide != civilian || _x != "SmokeLauncher") ) then {
            _vehicle removeWeapon _x;
        };
    } forEach weapons _vehicle;
};

clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

if( _class isEqualTo "B_Heli_Transport_01_F" ) then {
    _vehicle removeMagazinesTurret ["2000Rnd_65x39_Belt_Tracer_Red", [1]];
    _vehicle removeMagazinesTurret ["2000Rnd_65x39_Belt_Tracer_Red", [2]];
};

// Color
[_vehicle, _color] call XY_fnc_setVehicleColor;

// Attach variables
_vehicle setVariable["usedBy", "", true];
_vehicle setVariable["owner", getPlayerUID player, true];
_vehicle setVariable["ownerName", profileName, true];
_vehicle setVariable["users", [profileName], true];
_vehicle setVariable["id", _vid, true];
_vehicle setVariable["spawnTime", serverTime, true];
_vehicle setVariable["lastUseTime", serverTime, true];
_vehicle setVariable["side", _targetSide, true];

private _insure = (_vid < 0 && _ownedVehicle) || missionNamespace getVariable ["XY_GM_insureNextVehicle", false];
if( _insure ) then {
    _vehicle setVariable [ "insured", true, true ];
};

// Temporarely disable chip tuning
_chipType = 0;
if( _chipType > 0 ) then {
    _vehicle setVariable ["chip.enabled", true, true];
    _vehicle setVariable ["chip.type", _chipType, true];
};

// Special side-dependent stuff
switch( _targetSide ) do {
    case west: {
        if( _class isEqualTo "C_Offroad_01_F" ) then {
            _vehicle animate ["HidePolice", 0];
            _vehicle animate ["HideBumper1", 0];
        };
    };
    case independent: {
        if( _class isEqualTo "C_Offroad_01_F" ) then {
            _vehicle animate ["HidePolice", 0];
        };
    };
};

// Add vehicle keys to keychain
XY_vehicles pushBack _vehicle;

// Register key server-side (Do not use _targetSide here!)
[player, playerSide, _vehicle] remoteExec ["XY_fnc_addToKeychain", 2];

// Register vehicle for deletion if it keeps staying on its spawn
[_vehicle] remoteExec ["XY_fnc_cleanupSpawn", 2];

// Add special equipment for non-civ
if( _targetSide != civilian ) then {

    // Every car has at least pylons and small barriers
    _vehicle setVariable ["equipCarrier", 1, true];

    // COP HEMTT BOX
    if( _class isEqualTo "I_Truck_02_ammo_F" ) then {
        _vehicle setVariable ["equipCarrier", 7, true];
    };
};

private _message = ["<t color='#F0C010' size='1.6' align='center'>%1<br/><br/><t color='#FFFFFF' size='1.1'>%2</t><br/><br/><t color='#FF0000' size='1.1'>%3</t></t>"];
if( _targetSide != playerSide ) then {
    _message set [1, "Das Fahrzeug ist ausgeparkt"];
    _message set [2, "Bitte gib den Schlüssel an den Besitzer weiter"];
} else {
    _message set [1, "Dein Fahrzeug ist bereit"];

    if( _vid > 0 ) then {
        [getPlayerUID player, 10, format ["Parkt Fahrzeug %1 aus (VERSICHERT: %2) @ %3", getText(configFile >> "CfgVehicles" >> (_class) >> "displayName"), [ "NEIN", "JA" ] select _insure,  mapGridPosition player]] remoteExec ["XYDB_fnc_log", XYDB];
    };
    
    if( _insure ) then {
        _message set [2, "Es wurde automatisch gegen Zerstörung versichert, bis es eingeparkt wird"];
    } else {
        if( _vid < 0 ) then {
            _message set [2, "Der Mietwagen gehört dir bis zum Neustart"];
        } else {
            _message set [2, "Bitte vergiss' nicht eine Versicherung gegen Zerstörung abzuschließen (Windows-Taste -> Versichern)"];
        };
    };
};
_message set[3, "ACHTUNG: Wenn das Fahrzeug den Spawnpunkt blockiert wird es gelöscht!"];
hint parseText format _message;

_vehicle spawn {
    uisleep 5;
    _this allowDamage true;
};

_vehicle;