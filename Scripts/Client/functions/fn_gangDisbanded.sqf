// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

disableSerialization;

private _display = findDisplay 2620;
if( !(isNull _display) ) then {
    _display closeDisplay 0;
};

hint "Deine Gang wurde vom Leader aufgelöst";
[player] joinSilent (createGroup civilian);