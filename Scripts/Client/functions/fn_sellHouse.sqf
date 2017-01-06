// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _house = param[0, objNull, [objNull]];
if( isNull _house || !(_house isKindOf "House_F")) exitWith {};

closeDialog 0;

private _uid = getPlayerUID player;
if( !(((_house getVariable ["house_owner", [""]]) select 0) isEqualTo (getPlayerUID player)) ) exitWith {
    hint "Das Haus gehört dir nicht";
};

private _houseCfg = [typeOf _house] call XY_fnc_houseConfig;
if( _houseCfg isEqualTo [] ) exitWith {};

private _price = round((_houseCfg select 0) / 2);

private _action = [
    format["Das Haus hat einen Marktwert von %1€. Bist Du sicher, dass du dein Haus verkaufen möchtest?", [_price] call XY_fnc_numberText],
    "VERKAUFEN?",
    "VERKAUFEN",
    "ABBRECHEN"
] call XY_fnc_showQuestionbox;

if( !_action ) exitWith {};

hint "Verkaufe Haus...";
[_house, player, _price] remoteExec ["XYDB_fnc_deleteHouse", 2];