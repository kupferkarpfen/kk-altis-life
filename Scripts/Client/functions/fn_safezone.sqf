// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _wasInside = false;
private _airWarnings = 0;

while { true } do {

    private _inside = false;
    private _currentSafezone = "";
    {
        _inside = !(([vehicle player] inAreaArray _x) isEqualTo []);
        if( _inside ) exitWith {
            _currentSafezone = _x;
        };
    } forEach XY_SAFEZONES;
    XY_IN_SAFEZONE = _inside;

    private _vehicle = vehicle player;

    if( XY_IN_SAFEZONE && !_wasInside ) then {
        hint parseText "<t color='#FF0000' size ='2.25' align='center'>Absolute Safezone</t><br/><t color='#00BB00' align='center' size='1.1'>ALLE illegalen Aktivitäten sind zu unterlassen!</t>";
        player allowDamage false;

        if( _currentSafezone find "_vgod_" >= 0 && { !(_vehicle isEqualTo player) } && { (local _vehicle) } && { !(_vehicle getVariable ["safezone.godmode", false]) } ) then {
            _vehicle setVariable ["safezone.godmode", true, true];
            _vehicle setVariable ["lockpick.timeout", serverTime + 999999, true];
            _vehicle allowDamage false;
        };
    };
    if( !XY_IN_SAFEZONE && _wasInside ) then {
        hint "ACHTUNG: Du hast die Safezone verlassen";
        player allowDamage true;
    };
    _wasInside = XY_IN_SAFEZONE;

    if( XY_IN_SAFEZONE && { playerSide isEqualTo civilian } && { _vehicle != player } && { local _vehicle } && { isEngineOn _vehicle } && { _vehicle isKindOf "Air" } && { (serverTime - (_vehicle getVariable["spawnTime", 0])) > 90 } && { (((getPosATL _vehicle) select 2) < 290 || speed _vehicle < 10) } ) then {

        _airWarnings = _airWarnings + 1;

        if( _airWarnings >= 50 ) then {
            [_vehicle, 0] remoteExecCall ["setFuel", _vehicle];
            [] remoteExecCall ["XY_fnc_stripPlayer", crew _vehicle];
            [0, format["%1 wurde der Sprit geklaut, weil er über eine Safezone geflogen oder gehovert ist", profileName]] remoteExec ["XY_fnc_broadcast"];
            _airWarnings = 0;
            uisleep 45;
        } else {
            hint parseText format[ "<t color='#FF0000' size ='2' align='center'>Flugverbotszone</t><br/><t color='#00BB00' align='center' size='1'>Das Fliegen unterhalb 300m oder das Hovern über einer Safezone ist verboten, nach Ablauf der Zeit wirst du bestraft<br/><br/>Verbleibende Zeit %1s</t>", (50 - _airWarnings) ];
            uisleep 1;
            hintSilent "";
        };
    } else {
        if( _airWarnings > 0 ) then {
            _airWarnings = _airWarnings - 1;
            uisleep 5;
        };
    };
};