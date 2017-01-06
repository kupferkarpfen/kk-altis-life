disableSerialization;

6 cutRsc ["XY_timer","PLAIN"];

private _uiDisp = uiNamespace getVariable "XY_timer";
private _timer = _uiDisp displayCtrl 38301;
private _time = time + (20 * 60);

while {true} do {
    if(isNull _uiDisp) then {
        6 cutRsc ["XY_timer","PLAIN"];
        _uiDisp = uiNamespace getVariable "XY_timer";
        _timer = _uiDisp displayCtrl 38301;
    };
    if( round(_time - time) < 1 ) exitWith {};
    if( !(fed_bank getVariable["chargeplaced", false]) ) exitWith {};

    _timer ctrlSetText format["%1", [_time - time, "MM:SS.MS"] call BIS_fnc_secondsToString];
    sleep 0.075;
};
6 cutText["", "PLAIN"];