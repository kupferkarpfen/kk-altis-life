/*
    File: fn_calcWeightDiff.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Calculates weight differences in the _cWeight (current Weight) against the _mWeight (Max Weight)
    Multiple purpose system for this life mission.
*/
private _item =    param[0, "", [""]];
private _count =   param[1, -1,  [0]];
private _cWeight = param[2, -1,  [0]];
private _mWeight = param[3, -1,  [0]];

if( _item isEqualTo "" || _count < 0 || _cWeight < 0 || _mWeight < 0 ) exitWith {    
    [format["<CERROR> %1 (%2) called calcWeightDiff incorrectly: %3", profileName, getPlayerUID player, _this]] remoteExec ["XY_fnc_log", 2];
};

private _weight = (([_item] call XY_fnc_itemConfig) select 1);
private _sum = _count;

while { (_cweight + (_weight * _sum)) > _mWeight && _sum > 0 } do {
    _sum = _sum - 1;
};

_sum;