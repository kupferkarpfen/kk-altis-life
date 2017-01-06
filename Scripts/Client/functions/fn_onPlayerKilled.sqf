/*
    File: fn_onPlayerKilled.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    When the player dies collect various information about that player
    and pull up the death dialog / camera functionality.
*/
disableSerialization;

closeDialog 0;

private _unit = param[0, objNull, [ObjNull]];
private _killer = param[1, objNull, [objNull]];

private _killerVehicle = "KEINS";
if( !(_killer isEqualTo (vehicle _killer)) ) then {
    _killerVehicle = getText(configFile >> "CfgVehicles" >> (typeOf  (vehicle _killer)) >> "displayName");
};

switch (true) do {

    case( _unit isEqualTo _killer ): {
        [ getPlayerUID player, 11, format ["Getötet durch Selbstmord, Bug oder Dummheit - Position %1", mapGridPosition player] ] remoteExec ["XYDB_fnc_log", XYDB];
    };
    case( _killer isEqualTo objNull ): {
        [ getPlayerUID player, 11, format ["Getötet durch unbekannte Ursache (Skript-Tod oder Admin-Tötung) - Position %1", mapGridPosition player] ] remoteExec ["XYDB_fnc_log", XYDB];
    };
    default {
        [ getPlayerUID player, 11, format ["Getötet von %1 (%2) @ %3, Eigene Position %4, Distanz %5, Mörderfahrzeug: %6", _killer getVariable["realName", "NO_PLAYER"], getPlayerUID _killer, mapGridPosition _killer, mapGridPosition player, round(player distance _killer), _killerVehicle ] ] remoteExec ["XYDB_fnc_log", XYDB];
        [ getPlayerUID _killer, 11, format ["Tötet %1 (%2) @ %3, Eigene Position %4, Distanz %5, Fahrzeug: %6", profileName, getPlayerUID player, mapGridPosition player, mapGridPosition _killer, round(player distance _killer), _killerVehicle ] ] remoteExec ["XYDB_fnc_log", XYDB];

        // Kupferkarpfen: Announce kills > 700m distance...may be funny to know...
        if( isPlayer _killer && (vehicle _killer) isEqualTo _killer ) then {
            private _distance = round( player distance _killer );
            if( _distance > 700 ) then {
                [0, format["%1 wurde aus %2m Entfernung ausgeschaltet!", profileName, [_distance] call XY_fnc_numberText]] remoteExec ["XY_fnc_broadcast"];
            };
        };
    };
};

2 cutText ["", "PLAIN"];

// Eject immediately
if( !((vehicle _unit) isEqualTo _unit) ) then {
    _unit action ["getOut", vehicle _unit];
    private _distanceX = ([-1, 1] select ((random 100) < 50)) * ((random 3) + 2);
    private _distanceY = ([-1, 1] select ((random 100) < 50)) * ((random 3) + 2);
    private _pos = getPos _unit;
    _unit setPos [(_pos select 0) + _distanceX, (_pos select 1) + _distanceY, _pos select 2];
};

_unit setVariable["revive", false, true];
_unit setVariable["name", profileName, true];
_unit setVariable["restrained", false ,true];
_unit setVariable["escorting", false, true];
_unit setVariable["steam64ID", getPlayerUID player, true];
_unit setVariable["missingOrgan", false, true];
_unit setVariable["inPVP", XY_IN_PVP, true];

XY_corpse = _unit;

["init", _killer] call XY_fnc_deathScreen;

// Make the killer wanted
if( !(isNull _killer) && {_killer != _unit} && { (side _killer) isEqualTo civilian } && { alive _killer } ) then {
    if( (vehicle _killer) isKindOf "Car") then {
        [getPlayerUID _killer, "115"] remoteExec ["XY_fnc_wantedAdd", 2];
        //Get rid of this if you don't want automatic vehicle license removal.
        if( !(local _killer) )then {
            [1] remoteExec ["XY_fnc_removeLicenses", _killer];
        };
    } else {
        [getPlayerUID _killer, "146", -1, profileName] remoteExec ["XY_fnc_wantedAdd", 2];

        // Send my karma, as I am dead the variable attached to the player may be unreliable
        [ player, XY_karma ] remoteExec ["XY_fnc_killedPlayer", _killer];
    };
};

// hint: side maybe unreliable when player is dead, so query the side of the group
if( playerSide isEqualTo civilian && { !(isNull _killer) } && { ((side _killer) isEqualTo west) } ) then {
    XY_removeWanted = true;
};

[_unit] call XY_fnc_dropItems;

XY_hunger = 0;
XY_thirst = 0;

[player, XY_sidechat, playerSide] remoteExec ["XY_fnc_managesc", 2];

call XY_fnc_save;