// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _processorSource = param[0, objNull, [objNull]];
private _processorName = param[1, "", [""]];

if( isNull _processorSource || _processorName isEqualTo "" || player distance _processorSource > 5 || vehicle player != player ) exitWith {};

private _processor = [];
{
    if( (_x select 0) isEqualTo _processorName ) exitWith {
        _processor = _x;
    };
} forEach XY_resourceProcessors;

if( _processor isEqualTo [] ) exitWith {};

if( !(call (_processor select 3)) ) exitWith {};

private _hasLicense = _processorSource in [mari_processor, coke_processor, heroin_processor] || { [_processorName, true] call XY_fnc_hasLicense }; // << Default true, for resources without a license!

if( ([] call XY_fnc_getTrunkWeight) > XY_maxWeight ) exitWith {
    hint parseText format[XY_hintError, "Inventar ist voll"];
};

if( XY_actionInUse ) exitWith {};
XY_actionInUse = true;

[_processor, _hasLicense] spawn { scriptName "AutoProcess";

    private _processor = _this select 0;
    private _hasLicense = _this select 1;

    private _sourceItems = _processor select 1;
    private _targetItem = _processor select 2;

    private _targetItemConfig = [_targetItem] call XY_fnc_itemConfig;

    private _sourceItemNames = "";
    private _sourceItemWeight = 0;
    {
        private _config = [_x] call XY_fnc_itemConfig;
        _sourceItemWeight = _sourceItemWeight + (_config select 1);
        _sourceItemNames = format["%1%2 %3 ", _sourceItemNames, "1x", _config select 2];
    } forEach _sourceItems;

    if( currentWeapon player != "" ) then {
        XY_currentWeaponToRecall = currentWeapon player;
        player action ["SwitchWeapon", player, player, 100];
        sleep 5;
    };

    XY_interrupted = false;

    private _processProgress = 0;
    while { true } do { scopeName "Loop";

        if( XY_interrupted ) exitWith {
            XY_interrupted = false;
            hint parseText format[XY_hintError, "Abgebrochen"];
        };

        player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
        uisleep 2.1;
        _processProgress = _processProgress + ([0.7 + (random 0.3), 2 + (random 0.5)] select _hasLicense);

        while{ _processProgress >= _sourceItemWeight } do {
            {
                if( ([_x] call XY_fnc_getItemCountFromTrunk) < 1 ) exitWith {
                    hint parseText format[XY_hintError, "Keine Resourcen mehr vorhanden"];
                    breakOut "Loop";
                };
            } forEach _sourceItems;

            {
                [_x, 1] call XY_fnc_removeItemFromTrunk;
            } forEach _sourceItems;

            [_targetItem, 1] call XY_fnc_addItemToTrunk;

            private _message = format["Du hast %1zu 1x %2 verarbeitet (%3 gesamt)", _sourceItemNames,  _targetItemConfig select 2, [_targetItem] call XY_fnc_getItemCountFromTrunk];
            titleText[_message, "PLAIN" ];
            systemChat _message;

            if( ([] call XY_fnc_getTrunkWeight) > XY_maxWeight ) exitWith {
                hint parseText format[XY_hintError, "Inventar ist voll"];
                breakOut "Loop";
            };

            _processProgress = _processProgress - _sourceItemWeight;
            uisleep 0.2;
        };
    };
    XY_actionInUse = false;
};