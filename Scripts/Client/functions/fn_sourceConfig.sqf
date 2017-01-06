// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _item = param[0, "", [""]];
if( _item isEqualTo "" ) exitWith { [] };

private _sourceConfig = [];

if( _item find "uran" isEqualTo 0 ) then {
    // Special case for uran, since I'm lazy...
    _sourceConfig = [ "uranu" ] call XY_fnc_itemConfig;
} else {
    {
        if( (_x select 2) isEqualTo _item ) exitWith {
            {
                private _tmp = [ _x ] call XY_fnc_itemConfig;
                if( _sourceConfig isEqualTo [] || { (_sourceConfig select 1) < (_tmp select 1) } ) then {
                    _sourceConfig = _tmp;
                };
            } forEach (_x select 1);
        };
    } forEach XY_resourceProcessors;
};

if( _sourceConfig isEqualTo [] ) then {
    diag_log format[ "WARNING: No source resource found for resource %1", _item ];
    _sourceConfig = [_item] call XY_fnc_itemConfig;
};

_sourceConfig;