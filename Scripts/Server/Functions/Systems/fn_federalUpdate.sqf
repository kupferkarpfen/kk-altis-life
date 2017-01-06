// Raise fed funds based on player count
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _counter = 0;

while { true } do {
    uisleep 900;
    diag_log format["CP: %1, SO: %2", fed_bank getVariable["chargeplaced", false], fed_bank getVariable["safe_open", false] ];
    if( !(fed_bank getVariable["chargeplaced", false]) && !(fed_bank getVariable["safe_open", false]) )then {

        private _random = random ((count playableUnits) / 10);
        private _newFunds = 400 min round((fed_bank getVariable["safe", 0]) + _random);
        fed_bank setVariable["safe", _newFunds, true];

        _counter = _counter + 1;
        if( (_counter mod 4) isEqualTo 0 ) then {
            // Announce federal reserve funds
            [0, format[ "In einem Pressebericht erwähnt die Staatsbank, dass %1 Goldbarren eingelagert sind. Die Staatsbank gilt als sicherste Bank der Region.", _newFunds ]] remoteExec ["XY_fnc_broadcast", -2];
        };
    };
};