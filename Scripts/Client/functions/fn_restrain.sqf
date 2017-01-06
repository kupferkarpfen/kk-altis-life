// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _unit = param[0, objNull, [objNull]];
if(isNull _unit) exitWith {};

if( player getVariable["restrained", false] ) exitWith {};
player setVariable["restrained", true, true];
player setVariable["surrender", false, true];

[getPlayerUID player, 6, format ["Wurde von %1 (%2) gefesselt @ %3", name _unit, getPlayerUID _unit, mapGridPosition _unit]] remoteExec ["XYDB_fnc_log", XYDB];

// remove gps & map
player unassignItem "itemMAP";
player unassignItem "itemGPS";
// remove player from group
private _oldGroupID = (group player) getVariable["id", -1];
if( _oldGroupID >= 0 && { (count units group player) > 1 } ) then {
    [player] joinSilent (createGroup playerSide);
} else {
    _oldGroupID = -1;
};

private _message = format["Du wurdest von %1 gefangen genommen", [_unit getVariable["realName", "ERROR"], "maskierter Person"] select ([_unit] call XY_fnc_playerMasked)];

systemChat _message;
titleText[ _message, "PLAIN"];

player playMove "amovpercmstpsnonwnondnon_ease";

private _time = time;

while { (player getVariable ["restrained", false]) && (call XY_fnc_isAlive) } do {

    if( (vehicle player) isEqualTo player && { !((animationState player) isEqualTo "amovpercmstpsnonwnondnon_ease") } ) then {
        player playMove "amovpercmstpsnonwnondnon_ease";
    };

    if( !((vehicle player) isEqualTo player) && { driver(vehicle player) isEqualTo player } ) then {
        player action["eject", vehicle player];
    };

    // Check if there are still players nearby after 5 Minutes...
    if( (time - _time) > 300 && ( { _x != player && player distance _x < 50 && !(_x getVariable["restrained", false]) && !(_x getVariable["surrender", false]) } count playableUnits <= 0 ) ) exitWith {
        hint "Du bist unbeobachtet und konntest deine Fesseln lösen";
    };
};

if( !("itemMAP" in (items player)) ) then {
    player addItem "itemMAP";
};
player assignItem "itemMAP";

if( !("itemGPS" in (items player) ) ) then {
    player addItem "itemGPS";
};
player assignItem "itemGPS";

if( _oldGroupID >= 0 ) then {
    private _gang = [_oldGroupID] call XY_fnc_searchMyGang;
    if( !(isNull _gang) ) then {
        [player] joinSilent _gang;
    };
};

if( (call XY_fnc_isAlive) ) then {
    player switchMove "AmovPercMstpSlowWrflDnon_SaluteIn";
    [player, "cuff"] remoteExecCall ["say3D", playableUnits select { isPlayer _x && { (_x distance player) < 100 } }];
    titleText["Dir wurden die Handschellen abgenommen, du kannst dich nun frei bewegen", "PLAIN"];
    detach player;
};

player setVariable ["restrained", false, true];
player setVariable ["escorting", false, true];