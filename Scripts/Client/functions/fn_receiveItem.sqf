// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _unit = param[0, objNull, [objNull]];
private _item = param[1, "", [""]];
private _val = param[2, -1, [0]];
private _from = param[3, objNull, [objNull]];

if( isNull _unit || { _unit != player } || { isNull _from } || { _val <= 0 } || { _item isEqualTo "" } ) exitWith {};

if( (_item find "si_") isEqualTo 0 ) exitWith {
     private _licenseName = _item select [3];
     private _license = objNull;
    {
        if( (_x select 0) isEqualTo _licenseName ) exitWith {
            _license = _x;
        };
    } forEach (XY_licenses + XY_training);
   
    if( _license isEqualTo objNull ) exitWith {
        hint "Du hast ein wertloses Dokument erhalten";
    };

    private _licenseSide = switch( _license select 1 ) do {
        case( "cop" ): { west };
        case( "med" ): { independent };
        default { civilian };
    };

    if( playerSide != _licenseSide ) exitWith {
        hint "Du hast ein wertloses Dokument erhalten";
    };

    hint format["Du hast die Lizenz '%1' erhalten", _license select 2];
    missionNamespace setVariable[format["license_%1", _licenseName], true];
    call XY_fnc_save;
};

private _config = [_item] call XY_fnc_itemConfig;
if( _config isEqualTo [] ) exitWith {};

private _maxAmount = floor((XY_maxWeight - ([] call XY_fnc_getTrunkWeight)) / (_config select 1));
private _diffBack = _val - _maxAmount;
_val = _val min _maxAmount;

private _sourceRealname = _from getVariable["realName", "ERROR"];
private _sourceName = [_sourceRealname, "Maskierte Person"] select ([_from] call XY_fnc_playerMasked);

[_item, _val] call XY_fnc_addItemToTrunk;
hint parseText format[XY_hintMsg, format[XY_hintH1, "Item erhalten"], format["%1 hat dir %2x %3 gegeben", _sourceName, _val, _config select 2]];
[getPlayerUID player, 2, format ["Hat von %1 (%2) %3x %4 erhalten", _sourceRealname, getPlayerUID _from, _val, _config select 2]] remoteExec ["XYDB_fnc_log", XYDB];

if( _diffBack > 0 ) then {
    [_item, _diffBack, player] remoteExec ["XY_fnc_giveDiff", _from];
};

XY_forceSaveTime = time + 8;