params["_unit", "_id", "_uid", "_name"];

private _containers = nearestObjects[_unit, ["WeaponHolderSimulated", "GroundWeaponHolder"], 5];
{
    deleteVehicle _x;
} foreach _containers;
deleteVehicle _unit;

[_uid, 16, "Verbindung getrennt"] remoteExec ["XYDB_fnc_log", XYDB];
[_uid] remoteExec ["XYDB_fnc_houseCleanup", XYDB];