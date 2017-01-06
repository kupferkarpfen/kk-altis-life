// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _obj = param[0, objNull, [objNull]];
if( isNull _obj || { player distance _obj > 5 } ) exitWith {};

if( playerSide isEqualTo civilian && ((_obj getVariable["side", sideUnknown]) in [independent]) ) exitWith {
    hint parseText format[XY_hintError, "Das darfst du nicht aufheben"];
};

private _trunk = _obj getVariable ["items", []];
if( _trunk isEqualTo [] ) exitWith {
    deleteVehicle _obj;
};

// Attach UID
if( !((_obj getVariable["owner", ""]) isEqualTo "") ) exitWith {};
_obj setVariable["owner", getPlayerUID player, true];

if( XY_actionInUse ) exitWith {};
XY_actionInUse = true;
XY_interrupted = false;

player playMove "AinvPknlMstpSlayWrflDnon";

_obj spawn { scriptName "PickupItem";

    private _obj = _this;
    private _trunk = _obj getVariable ["items", []];

    // Delay pickup randomly to prevent duping
    uisleep 0.1 + (random 2.5);

    private _takenItems = 0;
    private _totalValue = 0;
    for [{_i= 0},{_i < (count _trunk)},{_i = _i + 1}] do {
        if( XY_interrupted ) exitWith {};

        if( !((_obj getVariable["owner", ""]) isEqualTo (getPlayerUID player)) ) exitWith {
            hint "Ein anderer Spieler versucht grad ebenfalls den Koffer aufzuheben";
        };

        private _trunkEntry = _trunk select _i;
        private _item = _trunkEntry select 0;
        private _count = _trunkEntry select 1;

        private _config = [_item] call XY_fnc_itemConfig;
        if( _config isEqualTo [] ) exitWith {};

        // It has no weight, it shouldn't be looted:
        if( (_config select 1) < 1 ) then {
            [XY_fnc_removeItemFromTrunk, [_item, _count, _trunk]] call XY_fnc_unscheduled;
            _i = (_i - 1) max 0;
        } else {

            player playMove "AinvPknlMstpSlayWrflDnon";

            if( playerSide isEqualTo west && (_config select 5) ) then {
                _totalValue = _totalValue + round((_config select 4) * 0.5);
                hint parseText format[XY_hintMsg, format[XY_hintH1, "Beweismittel"], format["Du hast %1x %2 sichergestellt", _count, _config select 2]];
                [XY_fnc_removeItemFromTrunk, [_item, _count, _trunk]] call XY_fnc_unscheduled;
                _i = (_i - 1) max 0;
                _takenItems = _takenItems + 1;
                [getPlayerUID player, 7, format ["Hat %1x %2 vom Boden sichergestellt @ %3", _count, _config select 2, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];

            } else {

                // Take the minimum from carryable weight and item count
                private _amount = floor((XY_maxWeight - ([] call XY_fnc_getTrunkWeight)) / (_config select 1)) min _count;
                if( _amount < 1 ) exitWith {};

                if( [XY_fnc_removeItemFromTrunk, [_item, _amount, _trunk]] call XY_fnc_unscheduled ) then {
                    _takenItems = _takenItems + 1;
                    _i = (_i - 1) max 0;
                    [XY_fnc_addItemToTrunk, [_item, _amount]] call XY_fnc_unscheduled;
                    hint parseText format[XY_hintMsg, format[XY_hintH1, "Aufgehoben"], format["%1x %2", _amount, _config select 2]];
                    [getPlayerUID player, 7, format ["Hat %1x %2 vom Boden aufgehoben @ %3", _amount, _config select 2, mapGridPosition player ]] remoteExec ["XYDB_fnc_log", XYDB];
                };

                uisleep 1.75;
            };
        };
    };

    if( _takenItems < 1 ) then {
        hint parseText format[XY_hintError, "Dein Inventar ist voll"];
    };

    XY_actionInUse = false;
    XY_forceSaveTime = time;

    if( _totalValue > 0 ) then {
        hint parseText format[XY_hintMsg, format[XY_hintH1, "Beweismittel"], format["Du hast Beweismittel im Wert von %1€ gesichert", [_totalValue] call XY_fnc_numberText]];
        [_totalValue, true] call XY_fnc_addMoney;
    };

    if( _trunk isEqualTo [] ) exitWith {
        deleteVehicle _obj;
    };

    _obj setVariable["items", _trunk, true];
    uisleep 0.5;
    _obj setVariable["owner", "", true];
};