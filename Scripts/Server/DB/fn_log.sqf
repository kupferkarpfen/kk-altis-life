// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// log to database

// type codes:
// 1 = wire transfer
// 2 = money transfer
// 3 = money withdrawal
// 4 = money deposit
// 5 = pullout vehicle
// 6 = restraining
// 7 = robbing
// 8 = knockout
// 9 = buy house
// 10 = buy vehicle
// 11 = kill
// 12 = break house
// 13 = buy insurance
// 14 = buy gear
// 15 = login
// 16 = logout
// 17 = broadcast
// 18 = emergency call
// 19 = suspicious money increase
// 20 = bug report
// 21 = car interactions
// 22 = revive
// 23 = panic button

private _pid = param[0, "", [""]];
private _type = param[1, 0, [0]];
private _messages = param[2, "", [[], ""]];

// Backward compatibility...
if( (typeName _messages) isEqualTo "STRING" ) then {
    _messages = [_messages];
};

{
    [format[ "insertPLog:%1:%2:%3", _pid, _type, [_x] call XYDB_fnc_strip ]] call XYDB_fnc_asyncCall;
} forEach _messages;