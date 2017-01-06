private _item = param[0, "", [""]];
private _amount = param[1, -1, [0]];
private _source = param[2, objNull, [objNull]];

if( _item isEqualTo "" || _amount < 1 || isNull _source ) exitWith {};

private _name = ([_item] call XY_fnc_itemConfig) select 2;

[_item, _amount] call XY_fnc_addItemToInventory;
hint parseText format[XY_hintMsg, format[XY_hintH1, "Item zurückerhalten"], format["Du hast %1x %2 zurückerhalten", _amount, _name]];

[getPlayerUID player, 2, format ["Hat von %1 (%2) %3x %4 zurückerhalten (Ziel hatte kein Platz)", _source getVariable["realName", "ERROR"], getPlayerUID _source, _amount, _name]] remoteExec ["XYDB_fnc_log", XYDB];
XY_forceSaveTime = time + 3;