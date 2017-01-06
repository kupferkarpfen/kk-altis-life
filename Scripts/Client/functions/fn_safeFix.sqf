/*
	I am so tired of writing this.
*/
private["_vault"];
_vault = _this select 0;
if(!(_vault getVariable["safe_open",false])) exitWith {hint localize "STR_Cop_VaultLocked"};

XY_actionInUse = true;

//Setup the progress bar
disableSerialization;
_title = localize "STR_Cop_RepairVault";
5 cutRsc ["XY_progressBar","PLAIN"];
_ui = uiNamespace getVariable "XY_progressBar";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;

while {true} do
{
	if(animationState player != "AinvPknlMstpSnonWnonDnon_medic_1") then {
		[player, "AinvPknlMstpSnonWnonDnon_medic_1"] remoteExec ["XY_fnc_animSync", -2];
		player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
	};
	sleep 0.26;
	if(isNull _ui) then {
		5 cutRsc ["XY_progressBar","PLAIN"];
		_ui = uiNamespace getVariable "XY_progressBar";
		_progressBar = _ui displayCtrl 38201;
		_titleText = _ui displayCtrl 38202;
	};
	_cP = _cP + .012;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if(_cP >= 1 OR !alive player) exitWith {};
	if(XY_interrupted) exitWith {};
};

//Kill the UI display and check for various states
5 cutText ["","PLAIN"];
player playActionNow "stop";
if(!alive player) exitWith {XY_actionInUse = false;};
if(XY_interrupted) exitWith {XY_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN"]; XY_actionInUse = false;};

XY_actionInUse = false;

_vault setVariable["safe_open",false,true];
hint localize "STR_Cop_VaultRepaired";