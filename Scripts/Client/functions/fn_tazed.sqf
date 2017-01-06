/*
    File: fn_tazed.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Starts the tazed animation and broadcasts out what it needs to.
*/
private["_unit","_shooter","_curWep","_curMags","_attach"];
_unit = [_this,0,Objnull,[Objnull]] call BIS_fnc_param;
_shooter = [_this,1,Objnull,[Objnull]] call BIS_fnc_param;
if(isNull _unit OR isNull _shooter) exitWith { XY_isTazed = false; };

if(_shooter isKindOf "Man" && alive player) then {
    if(!XY_isTazed) then {
        XY_isTazed = true;
        closeDialog 0;
        _curWep = currentWeapon player;
        _curMags = magazines player;
        _attach = if(primaryWeapon player != "") then {primaryWeaponItems _unit} else {[]};
        {player removeMagazine _x} forEach _curMags;
        player removeWeapon _curWep;
        player addWeapon _curWep;
        if(count _attach != 0 && primaryWeapon _unit != "") then
        {
            {
                _unit addPrimaryWeaponItem _x;
            } forEach _attach;
        };
        if(count _curMags != 0) then
        {
            {player addMagazine _x;} forEach _curMags;
        };

        [_unit, "tazersound"] remoteExecCall ["say3D", playableUnits select { isPlayer _x && { (_x distance player) < 100 } }];
        _obj = "Land_ClutterCutter_small_F" createVehicle (getPosATL _unit);
        _obj setPosATL (getPosATL _unit);
        [player, "AinjPfalMstpSnonWnonDf_carried_fallwc"] remoteExec ["XY_fnc_animSync", -2];
        [0, format[localize "STR_NOTF_Tazed", _unit getVariable["realName",name _unit], _shooter getVariable["realName", name _shooter]]] remoteExec ["XY_fnc_broadcast"];
        _unit attachTo [_obj,[0,0,0]];
        disableUserInput true;
        sleep 15;
        [player, "amovppnemstpsraswrfldnon"] remoteExec ["XY_fnc_animSync", -2];
        if(!(player getVariable["escorting",false])) then {
            detach player;
        };
        XY_isTazed = false;
        player allowDamage true;
        disableUserInput false;
    };
} else {
    _unit allowDamage true;
    XY_isTazed = false;
};