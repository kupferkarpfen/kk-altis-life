/*
    Author: Bryan "Tonic" Boardwine

    Description:
    Handles various different ammo types being fired.
*/

private _ammoType = _this select 4;
private _projectile = _this select 6;

if( (vehicle player) isKindOf "Air" ) exitWith {
    titleCut [ "NICHT AUS HELIKOPTERN SCHIESSEN", "BLACK IN", 10];
    player setAmmo [currentWeapon player, 0];
    deleteVehicle _projectile;
};

if( XY_IN_SAFEZONE && { !(playerSide isEqualTo west) } && { !(_projectile in ["B_9x21_Ball", "B_556x45_dual"]) } ) exitWith {
    titleCut [ "NICHT IN DER SAFEZONE SCHIESSEN", "BLACK IN", 10];
    player setAmmo [currentWeapon player, 0];
    deleteVehicle _projectile;
};

if( _ammoType isEqualTo "GrenadeHand_stone" ) then {
    _projectile spawn {
        private ["_position"];
        while { !(isNull _this) } do {
            _position = getPosATL _this;
            uisleep 0.1;
        };
        [_position] remoteExec ["XY_fnc_flashbang", -2];
    };
};