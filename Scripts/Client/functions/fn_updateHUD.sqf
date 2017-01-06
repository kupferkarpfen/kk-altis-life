// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( !XY_hudON || !(call XY_fnc_isAlive) ) exitWith {};

disableSerialization;

private _hud = uiNamespace getVariable ["XY_HUD", displayNull];
if( isNull _hud && !dialog ) exitWith {
    // Re-open the HUD if it somehow got closed
    2 cutRsc ["XY_HUD", "PLAIN", 4, false];
};

(_hud displayCtrl 5100) progressSetPosition ( 1 - XY_thirst );
(_hud displayCtrl 5200) ctrlSetText ( format["%1", round(100 - XY_thirst * 100)] );

(_hud displayCtrl 5101) progressSetPosition ( 1 - XY_hunger );
(_hud displayCtrl 5201) ctrlSetText ( format["%1", round(100 - XY_hunger * 100)] );

(_hud displayCtrl 5102) progressSetPosition (1 - (damage player));
(_hud displayCtrl 5202) ctrlSetText ( format["%1", round(100 - (damage player) * 100)] );

(_hud displayCtrl 5103) progressSetPosition (1 - (getFatigue player));
(_hud displayCtrl 5203) ctrlSetText ( format["%1", round(100 - (getFatigue player) * 100)] );

(_hud displayCtrl 5204) ctrlShow ( [player] call XY_fnc_playerMasked );

(_hud displayCtrl 5104) ctrlSetText format["TS: ts.just4fungaming24.de | ZIVILISTEN: %1 | POLIZEI: %2 | SANITÄTER: %3 | BARGELD: %4€ | BANKKONTO: %5€ | GPS: %6", civilian countSide allPlayers, west countSide allPlayers, independent countSide allPlayers, [XY_CC] call XY_fnc_numberText, [XY_CA] call XY_fnc_numberText, [mapGridPosition player, "KEIN GPS"] select (player getVariable ["restrained", false]) ];