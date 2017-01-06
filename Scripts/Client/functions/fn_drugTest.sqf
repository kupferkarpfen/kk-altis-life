// drugTest
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
//

private _cop = param[0, objNull, [objNull]];

if( isNull _cop ) exitWith {};

private _cancel = false;
if( !(player getVariable ["restrained", false]) ) then {
    private _action = [
        "Der Polizist will dich auf Drogen und Alkohol testen. Willst du das zulassen?",
        "Untersuchung zustimmen",
        localize "STR_Global_Yes",
        localize "STR_Global_No"
    ] call XY_fnc_showQuestionbox;

    _cancel = !_action;
};
if( _cancel ) exitWith {
    [1, "<t color='#FF0000' size='1'>Die Person verweigert einen Test</t>"] remoteExec [ "XY_fnc_broadcast", _cop ];
};

private _promille = round(XY_promille * 10) / 10;
private _drugged = if( XY_drugged > 0.1 ) then { "POSITIV" } else { "NEGATIV" };

// Wanted-Liste
if( XY_drugged >= 0.1 ) then {
    [getPlayerUID player, "112"] remoteExec ["XY_fnc_wantedAdd", 2];
} else {
    if( _promille >= 0.5 ) then {
        [getPlayerUID player, "112"] remoteExec ["XY_fnc_wantedAdd", 2];
    };
};

[ 1, format["<t color='#FF0000' size='1'>Alkoholtest: %1 Promille</t><br/><t color='#FFD700' size='1'>Drogentest: %2", _promille, _drugged] ] remoteExec [ "XY_fnc_broadcast", _cop ];