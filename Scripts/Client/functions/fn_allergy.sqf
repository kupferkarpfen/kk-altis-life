// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
// Medical system - Allergies against different painkillers

private _playerID = getPlayerUID player;
private _end = _playerID select [ (count _playerID) - 1 ];

if ( _end isEqualTo "2" || _end isEqualTo "4" || _end isEqualTo "6" ) then {
    XY_medAllergies pushBack "amadol";
} else {
    XY_medAllergies pushBack "metamizol";
};
if ( _end isEqualTo "1" || _end isEqualTo "5" || _end isEqualTo "9" ) then {
    XY_medAllergies pushBack "oxycodon";
} else {
    XY_medAllergies pushBack "morphin";
};