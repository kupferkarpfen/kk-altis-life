// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// loosely based on Tonics work

private _curTarget = cursorTarget;
if( XY_interrupted ) exitWith {
    XY_interrupted = false;
};

if( dialog ) exitWith {};
if( vehicle player != player ) exitWith {};

// Use cursorObject to pickup stuff, this solves the shitty problem the objects have to be "reveal"'ed befor cursorTarget recognized them
private _cursorObject = cursorObject;
if( !(isNull _cursorObject) && { player distance2D _cursorObject < 3 } && { !((_cursorObject getVariable["items", [-1]]) isEqualTo [-1]) } ) exitWith {
    [_cursorObject] call XY_fnc_pickupItem;
};
if( !(isNull _cursorObject) && { player distance2D _cursorObject < 3 } && { (_cursorObject getVariable["money", -1]) >= 0 } ) exitWith {
    [_cursorObject] call XY_fnc_pickupMoney;
};
if( _curTarget isKindOf "House_F" && { [_curTarget] call XY_fnc_isPlayerNearVehicle } ) exitWith {
    [_curTarget] call XY_fnc_houseInteractionMenu;
};
if( (_curTarget isKindOf "Car" || _curTarget isKindOf "Ship" || _curTarget isKindOf "Air") && [_curTarget] call XY_fnc_isPlayerNearVehicle ) exitWith {
    [_curTarget] call XY_fnc_vehicleInteractionMenu;
};
if( typeOf _curTarget isEqualTo "Land_Runway_PAPI" ) exitWith {
    [_curTarget] call XY_fnc_speedtrapInteractionMenu;
};

// Test gathering at this spot...
if( call XY_fnc_gather ) exitWith {};

if( isNull _curTarget ) exitWith {
    if( playerSide == civilian ) then {
        if( !([] call XY_fnc_gather) && { (surfaceIsWater (getPosASL player)) } ) then {
            private _fish = (nearestObjects[getPos player,["Fish_Base_F", "Turtle_F"], 4]);
            if( !(_fish isEqualTo []) ) then {
                [_fish select 0] call XY_fnc_catchFish;
            };
        };
    };
};

if( player distance _curTarget > 3 ) exitWith {};

if( _curTarget isKindOf "Man" ) exitWith {
    if( !(alive _curTarget) && { playerSide in [west, independent] } && { "Medikit" in (items player) } ) exitWith {
        if( playerSide isEqualTo west && { (independent countSide playableUnits) > 0 } ) exitWith {
            hint "Bitte wende dich an die Sanitäter um jemanden zu reanimieren";
        };
        [_curTarget] spawn XY_fnc_revivePlayer;
    };
    if( isPlayer _curTarget && { alive _curTarget } ) exitWith {
        [_curTarget] call XY_fnc_playerInteractionMenu;
    };
};

if( (typeOf _curTarget) in [ "Salema_F", "Ornate_random_F", "Mackerel_F", "Tuna_F", "Mullet_F", "CatShark_F", "Turtle_F" ]) exitWith {
    [_curTarget] call XY_fnc_catchFish;
};
