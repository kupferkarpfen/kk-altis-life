// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _cop = param[0, objNull, [objNull]];

if( isNull _cop ) exitWith {};

private _cancel = false;
if( !(player getVariable ["restrained", false]) ) then {
    private _action = [
        "Der Polizist will dich durchsuchen (Ausweis + Führerscheine). Falls du maskiert bist wird er so deinen richtigen Namen erfahren. Willst du das zulassen?",
        "Durchsuchung zustimmen",
        localize "STR_Global_Yes",
        localize "STR_Global_No"
    ] call XY_fnc_showQuestionbox;

    _cancel = !_action;
};
if( _cancel ) exitWith {
    [1, "<t color='#FF0000' size='1'>Die Person verweigert eine Durchsuchung</t>"] remoteExec [ "XY_fnc_broadcast", _cop ];
};

private _licenses = "";
//Licenses
{
	if( missionNamespace getVariable [format["license_%1", _x select 0], false] && (_x select 1) isEqualTo "civ" ) then {
		_licenses = _licenses + (_x select 2) + "<br/>";
	};
} forEach XY_licenses;

if( _licenses isEqualTo "" ) then {
    _licenses = "Keine Lizenzen gefunden";
};

[1, format["<t color='#FF0000' size='2'>%1</t><br/><t color='#FFD700' size='1.5'>Lizenzen</t><br/>%2", profileName, _licenses]] remoteExec [ "XY_fnc_broadcast", _cop ];
[_cop] call XY_fnc_givePassport;
