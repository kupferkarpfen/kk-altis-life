// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _civ = param[0, objNull, [objNull]];
private _cop = param[1, objNull, [objNull]];

if( isNull _civ || isNull _cop ) exitWith {};

private _uid = getPlayerUID _civ;
{
    if( (_x select 0) isEqualTo _uid ) exitWith {
        private _total = 0;
        {
            _total = _total + (_x select 1);
        } forEach (_x select 1);

        // ony receive fraction of the bounty to encourage the cop to make the guy pay
        private _bounty = round(_total * 0.66);
        [_bounty] remoteExec ["XY_fnc_bountyReceive", _cop];

        [0, format["%1 hat %2 ins Gefängnis gesteckt und erhält eine Belohnung von %3€", _cop getVariable["realName", "ERROR"],  _civ getVariable["realName", "ERROR"], [_bounty] call XY_fnc_numberText]] remoteExec [ "XY_fnc_broadcast" ];
    };
} forEach XY_wantedList;