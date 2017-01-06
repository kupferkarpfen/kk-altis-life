// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _sourceUnit = param[0, objNull, [objNull]];
private _sourceKarma = param[1, -1, [0]];

private _modifier = _sourceKarma / XY_karma;
private _karmaLoss = XY_ssv_karmaLoss * _modifier;
private _newKarma = (XY_karma - _karmaLoss) max 0;

diag_log format["<KARMA> FROM %1 TO %2 / DELTA: %3 / FACTOR: %4", XY_karma, _newKarma, _karmaLoss, _modifier];
XY_karma = _newKarma;

player setVariable["karma", XY_karma, true];