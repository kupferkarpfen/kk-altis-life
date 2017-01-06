// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// TODO: Update to new trunk system

private _house = param[0, objNull, [objNull]];

if( isNull _house || !(_house isKindOf "House_F") ) exitWith {};

private _owner = _house getVariable [ "house_owner", [] ];
if( _owner isEqualTo [] ) exitWith {
    hint "Das Haus hat keinen Besitzer...";
};
private _uid = _owner select 0;
_owner = _owner select 1;

if( !([ _uid ] call XY_fnc_isUIDActive) ) exitWith {
    hint localize "STR_House_Raid_OwnerOff";
};

// TODO: Download trunk from server...
/*
private _trunk = _house getVariable ["trunk", []];
if( _trunk isEqualTo [] ) exitWith {
    hint localize "STR_House_Raid_Nothing";
};

// Three randomly delayed checks to prevent two players robbing simultaneously:
/*
sleep random 0.2;
if( !(_house getVariable["rip", false]) ) then {
    sleep random 0.2;
    if( !(_house getVariable["rip", false]) ) then {
        sleep random 0.2;
    };
};
if( _house getVariable["rip", false] ) exitWith {
    hint "Hier läuft bereits eine Durchsuchung!";
};
*/

if( XY_actionInUse ) exitWith {};
XY_actionInUse = true;

// Launch cooldown server-side to prevent deadlocking when client disconnects
[_house] remoteExec ["XY_fnc_robCooldown", 2];

// Lock the house:
_house setVariable["rip", true, true];

hint "Bleib in der Nähe!";

disableSerialization;
_duration = 120 + floor(random 30);
_cp = 0;
_startTime = time;
_timeOut = _startTime + _duration;
_interrupted = true;

5 cutRsc ["XY_progressBar", "PLAIN"];
_ui = uiNamespace getVariable "XY_progressBar";
_progressBar = _ui displayCtrl 38201;
_progressText = _ui displayCtrl 38202;

while { alive player && !(player getVariable["restrained", false]) && player distance _house <= 13 } do {

    _cp = (time - _startTime) / (_timeOut - _startTime);
    
	_progressBar progressSetPosition _cp;
	_progressText ctrlSetText format["Durchsuchung läuft (%1%2)", round(_cp * 100), "%"];

    if(_cp >= 1) exitWith {
        _interrupted = false;
    };

    sleep 0.25;
};

5 cutText ["", "PLAIN"];
XY_actionInUse = false;
_house setVariable["rip", false, true];

if( _interrupted ) exitWith {
    hint localize "STR_NOTF_ActionCancel";
};

private _value = 0;
private _newTrunk = [];
{
	_var = _x select 0;
	_val = _x select 1;
	
    _config = [ _var ] call XY_fnc_itemConfig;
	if( _config select 5 ) then	{
		if( _config select 4 > 0) then {
			_value = _value + (((_config select 4) * 0.5) * _val);

			_houseInvData deleteAt _forEachIndex;
		};
	};
} forEach _trunk;

if(_value > 0) then {
	[0, format[ localize "STR_House_Raid_Successful", [_value] call XY_fnc_numberText ]] remoteExec ["XY_fnc_broadcast"];
    [getPlayerUID player, 2, format ["Hat %1€ für beschlagnahmte Items aus Haus von %2 erhalten @ %3", [_value] call XY_fnc_numberText, _owner, mapGridPosition player]] remoteExec ["XYDB_fnc_log", XYDB];
    
    [_value, 1] call XY_fnc_addMoney;    
    [_house, _houseInvData] call XY_fnc_updateTrunk;
	[_house] remoteExec ["XY_fnc_updateHouseTrunk", 2];

} else {
	hint localize "STR_House_Raid_NoIllegal";
};