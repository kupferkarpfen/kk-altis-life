diag_log format["houseCleanup(%1)", _this];

private _uid = param[0, "", [""]];
if( _uid isEqualTo "" ) exitWith {};

{
    diag_log format["CLEAN HOUSE: %1", _x];
    private _position = _x select 1;
    private _house = nearestBuilding _position;
    if( _house getVariable["locked", true] && !(_house getVariable["preventCleanup", false]) ) then {
        {
            diag_log format["REMOVE CONTAINER: %1", _x];
            if( !(isNull _x) ) then {
                deleteVehicle _x;
            };
        } forEach (_house getVariable ["containers", []]);

        _house setVariable["containers", nil, true];
        _house setVariable["house.loaded", false];

    } else {
        diag_log "NOT CLEANING HOUSE AS IT IS NOT LOCKED OR FORCEFULLY BEING OPENED";
    };

} forEach ([ format["selectHousesForUID:%1", _uid], true] call XYDB_fnc_asyncCall);