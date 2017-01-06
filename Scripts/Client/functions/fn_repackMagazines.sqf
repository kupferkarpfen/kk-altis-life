// Written by TourettKeks
// License: CC BY-NC-SA 4.0

private _magazinesFull = magazinesAmmoFull player;
private _magazineSum = [];
private _found = false;

if( XY_actionInUse ) exitWith {};

{
    private _found = false;
    private _magazineType = _x select 0;
    private _ammoCount = _x select 1;
    {
        if (_magazineType isEqualTo (_x select 0)) then {
            _x set [0, _magazineType];
            _x set [1, (_x select 1) + _ammoCount];
            _found = true
        };
    } forEach _magazineSum;

    if( !_found ) then {
        _magazineSum pushBack [_magazineType, _ammocount];
    };

} forEach _magazinesFull;

if (_magazineSum isEqualTo []) exitWith {
    hint "Du hast keine Magazine zum Umpacken";
};

XY_actionInUse = true;

{
    player removePrimaryWeaponItem (_x select 0);
    player removeSecondaryWeaponItem (_x select 0);
    player removeHandgunItem (_x select 0);
    player removeMagazines (_x select 0);
} forEach _magazineSum;

if( !(["repackMagazines", "Packe Magazine um"] call XY_fnc_showProgress) ) exitWith {
    {
        player addMagazine [_x select 0, _x select 1];
    } forEach _magazinesFull;
};

{
    private _maxammo = getNumber (configFile >> "CfgMagazines" >> (_x select 0) >> "count");
    player addMagazines [_x select 0,floor ((_x select 1) / _maxammo)];
    if (((_x select 1) % _maxammo) != 0) then {
        player addMagazine [_x select 0, (_x select 1) % _maxammo];
    }
} forEach _magazineSum;
XY_actionInUse = false;
