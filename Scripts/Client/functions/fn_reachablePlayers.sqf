// reachablePlayers
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// return near players for the give item / key / money list, or player tags

private _radius = param [ 0, 5, [0] ];
private _return = [];

// When inside vehicle return players inside vehicle
if( !((vehicle player) isEqualTo player) ) then {
	{
		if( !(_x isEqualTo player) && { isPlayer _x } && { alive _x } && { !(isObjectHidden _x) } ) then {
            _return pushBack ([_x] call XY_fnc_playerInfo);
		};
	} forEach (crew vehicle player);

} else {
	{
		if( !(_x isEqualTo player) && { isPlayer _x } && { (vehicle _x) isEqualTo _x } && { alive _x } && { !(isObjectHidden _x) } && { !(lineIntersects [eyePos player, eyePos _x, player, _x]) } ) then {
			_return pushBack ([_x] call XY_fnc_playerInfo);
		};
	} forEach (player nearEntities ["Man", _radius]);
};
_return;