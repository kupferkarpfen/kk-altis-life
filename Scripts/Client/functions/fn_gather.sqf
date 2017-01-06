// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( player getVariable ["surrender", false] || playerSide != civilian ) exitWith { false };

//Find out what zone we're near and get its configuration
private _zone = "";
private _item = "";
private _requiredItem = "";

{
    {
        if( player distance2D (getMarkerPos _x) < 33 ) exitWith {
            _zone = _x;
        };
    } forEach (_x select 0);

    if( _zone != "" ) exitWith {
        _item = (_x select 1);
        _requiredItem = (_x select 2);
    };
} forEach XY_resourceZones;

if( _zone isEqualTo "" || { _item isEqualTo "" } || { vehicle player != player } || { (_zone find "underwater") >= 0 && ((getPosATL player) select 2) > 6 } ) exitWith { false };

// Check if we have the required item
if( !(_requiredItem isEqualTo "") && { ([_requiredItem] call XY_fnc_getItemCountFromTrunk) < 1 } ) exitWith {
    hint parseText format[XY_hintError, "Dir fehlt das passende Werkzeug"];
    false;
};

private _itemConfig = [_item] call XY_fnc_itemConfig;
if( _itemConfig isEqualTo [] ) exitWith { false };

if( XY_actionInUse ) exitWith {};
XY_actionInUse = true;

_itemConfig spawn { scriptName "AutoGather";

    private _itemConfig = _this;
    private _itemWeight = _itemConfig select 1;

    if( currentWeapon player != "" ) then {
        XY_currentWeaponToRecall = currentWeapon player;
        player action ["SwitchWeapon", player, player, 100];
        sleep 5;
    };

    XY_interrupted = false;

    private _gatherProgress = 0;
    while { true } do {

        private _trunkWeight = [XY_fnc_getTrunkWeight, []] call XY_fnc_unscheduled;
        private _availableWeight = XY_maxWeight - _trunkWeight;
        if( _availableWeight < _itemWeight ) exitWith {
            hint parseText format[XY_hintError, "Dein Inventar ist voll"];
        };
        if( XY_interrupted ) exitWith {
            XY_interrupted = false;
            hint parseText format[XY_hintError, "Abgebrochen"];
        };

        player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
        uisleep 2.1;
        _gatherProgress = _gatherProgress + (2 + (random 0.33));

        while { _gatherProgress >= _itemWeight } do {
            titleText[ format["Du hast %1 gesammelt", _itemConfig select 2], "PLAIN" ];
            [_itemConfig select 0, 1] call XY_fnc_addItemToTrunk;
            _gatherProgress = _gatherProgress - _itemWeight;
            uisleep 0.25;
        };
    };
    XY_actionInUse = false;
};

true;