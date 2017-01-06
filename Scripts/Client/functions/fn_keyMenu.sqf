/*
	File: fn_keyMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Initializes the key menu
	Will be revised.
*/
private["_display","_vehicles","_plist","_pic","_name","_text","_color","_index"];

disableSerialization;

waitUntil {!isNull (findDisplay 2700)};
_display = findDisplay 2700;
_vehicles = _display displayCtrl 2701;
lbClear _vehicles;
_plist = _display displayCtrl 2702;
lbClear _plist;

for "_i" from 0 to (count XY_vehicles) - 1 do {
	_veh = XY_vehicles select _i;
	if(!isNull _veh && alive _veh) then {

		_name = getText(configFile >> "CfgVehicles" >> (typeOf _veh) >> "displayName");
		_pic = getText(configFile >> "CfgVehicles" >> (typeOf _veh) >> "picture");
		_vehicles lbAdd format["%1 - [Entfernung: %2m]", _name, round(player distance _veh)];
		if(_pic != "pictureStaticObject") then {
			_vehicles lbSetPicture [(lbSize _vehicles)-1,_pic];
		};
		_vehicles lbSetData [(lbSize _vehicles)-1,str(_i)];
	};
};

{
	_plist lbAdd format["%1", [_x select 2, _x select 1] select (_x select 6) ];
	_plist lbSetData [(lbSize _plist) - 1, str(_x select 0)];
} forEach ([8] call XY_fnc_reachablePlayers);

if(((lbSize _vehicles)-1) == -1) then {
	_vehicles lbAdd "Du hast keine Fahrzeuge";
	_vehicles lbSetData [(lbSize _vehicles)-1,str(ObjNull)];
};