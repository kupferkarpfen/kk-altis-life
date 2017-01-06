/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Defuses blasting charges for the cops?
*/
private["_vault","_ui","_progress","_progressText","_cp","_sleep","_cpRate","_cycle"];

_vault = [_this, 0, ObjNull, [ObjNull]] call BIS_fnc_param;

if( isNull _vault ) exitWith {};
if( typeOf _vault != "Land_CargoBox_V1_F") exitWith {};
if( !(_vault getVariable["chargeplaced", false]) ) exitWith {
    hint localize "STR_ISTR_Defuse_Nothing"
};

XY_interrupted = false;
XY_actionInUse = true;

disableSerialization;

_duration = 20;
_cp = 0;
_sleep = 0.1; // 100ms timer
_cpRate = 1 / (_duration / _sleep); // Update-Rate errechnen

5 cutRsc ["XY_progressBar", "PLAIN"];
_ui = uiNamespace getVariable "XY_progressBar";
_progressBar = _ui displayCtrl 38201;
_progressText = _ui displayCtrl 38202;

_cycle = 0;
while {true} do {
	if(_cycle mod 10 == 0 && animationState player != "ainvpknlmstpsnonwnondnon_medic_1") then {
		[player, "AinvPknlMstpSnonWnonDnon_medic_1"] remoteExec ["XY_fnc_animSync", -2];
		player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
	};
    _cycle = _cycle + 1;

	_cP = _cP + _cpRate;
	_progressBar progressSetPosition _cp;
	_progressText ctrlSetText format["%1 (%2%3)...", localize "STR_ISTR_Defuse_Process", round(_cp * 100), "%"];

    if( _cp >= 1 ) exitWith {};
    if( !alive player || XY_interrupted) exitWith { 
        _interrupted = true;
    };    
    sleep _sleep;
};

XY_actionInUse = false;

//Kill the UI display and check for various states
5 cutText ["","PLAIN"];
player playActionNow "stop";

if( _interrupted ) exitWith {
    XY_interrupted = false;
    hint localize "STR_NOTF_ActionCancel";
};

_vault setVariable["chargeplaced", false, true];
[[0, 1], localize "STR_ISTR_Defuse_Success"] remoteExec ["XY_fnc_broadcast", [west, 2]];