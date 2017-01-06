// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// entity: Object - unit or vehicle to which EH is assigned
// weapon: String - weapon that got reloaded
private _weapon = _this select 1;
// muzzle: String - weapon's muzzle that got reloaded
// newMagazine: Array - new magazine info
private _newMagazine = _this select 3;
// oldMagazine: Array or Nothing - old magazine info

if( _weapon in ["hgun_P07_snds_F", "hgun_P07_F"] && playerSide isEqualTo west ) then {
    player setAmmo [handgunWeapon player, 6 min (player ammo handgunWeapon player)];
};