/*
    File: fn_settingsMenu
    Author: Bryan "Tonic" Boardwine

    Description:
    Setup the settings menu.
*/
if(isNull (findDisplay 2900)) then
{
    if(!createDialog "XY_dialog_settings") exitWith {hint "Something went wrong, the menu won't open?"};
};

disableSerialization;

ctrlSetText[2902, format["%1", tawvd_foot]];
ctrlSetText[2912, format["%1", tawvd_car]];
ctrlSetText[2922, format["%1", tawvd_air]];

//Setup Sliders range
{ slidersetRange [_x,100,12000];} forEach [2901,2911,2921];
//Setup Sliders speed
{ ((findDisplay 2900) displayCtrl _x) sliderSetSpeed [100,100,100]; } forEach [2901,2911,2921];
//Setup Sliders position
{
    sliderSetPosition[_x select 0, _x select 1];
} forEach [[2901,tawvd_foot],[2911,tawvd_car],[2921,tawvd_air]];

private _display = findDisplay 2900;
private _hud = _display displayCtrl 2972;
private _side = _display displayCtrl 2971;
private _tags = _display displayCtrl 2970;

if( XY_tagsON ) then {
    _tags ctrlSetTextColor [0, 1, 0, 1];
    _tags ctrlSetText "AN";
} else {
    _tags ctrlSetTextColor [1, 0, 0, 1];
    _tags ctrlSetText "AUS";
};

if(XY_sidechat) then {
    _side ctrlSetTextColor [0,1,0,1];
    _side ctrlSetText "AN";
} else {
    _side ctrlSetTextColor [1,0,0,1];
    _side ctrlSetText "AUS";
};

if( XY_hudON ) then {
    _hud ctrlSetTextColor [0,1,0,1];
    _hud ctrlSetText "AN";
} else {
    _hud ctrlSetTextColor [1,0,0,1];
    _hud ctrlSetText "AUS";
};