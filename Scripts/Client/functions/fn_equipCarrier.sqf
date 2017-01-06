// Support for equip carrier vehicles (pylons, barriers, etc.)
// Add action if near vehicles
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( !(playerSide in [independent, west]) ) exitWith{};

private _actions = [];
while { true } do {
    uisleep 8;

    XY_equipCarrierDistance = 1000;
    _actionLevel = 0;
    _nearVehicles = nearestObjects[ player, ["Car", "Air"], 100];
    {
        _al = _x getVariable ["equipCarrier", 0];
        if( _al > _actionLevel ) then {
            _actionLevel = _al;
            XY_equipCarrierDistance = XY_equipCarrierDistance min (player distance _x);
        };

    } forEach _nearVehicles;

    if( _actionLevel > 0 && _actions isEqualTo [] ) then {

        {
            _actions pushBack ( player addAction[ (_x select 1) + " nehmen", { [_this select 3] call XY_fnc_placeItem }, _x select 2, 0, false, true, "", "!XY_actionInUse && cursorTarget distance player < 6 && cursorTarget getVariable[""equipCarrier"", 0] >= " + str(_x select 0) ] );
        } forEach XY_placeableItems;

        _actions pushBack ( player addAction[ "<t color='#FF0000'>Demontieren</t>", {
            private _objects = nearestObjects[player, [], 3];
            {
                if( _x getVariable["deployed", 0] == 1 ) exitWith {
                    deleteVehicle _x;
                };
            } forEach _objects;
        }, "", 0.5, false, true, "", "private _objects = nearestObjects[player, [], 5]; _found = false; { if( _x getVariable[""deployed"", 0] isEqualTo 1 ) exitWith { _found = true; }; } forEach _objects; !XY_actionInUse && _found;" ] );

        _actions pushBack ( player addAction[ "<t color='#FF0000'>Alles demontieren (50m)</t>", {

            private _action = [
                "Alle im Umkreis von 50m aufgestellten Elemente wieder verladen?",
                "Verladen bestätigen",
                "Ja",
                "Nein"
            ] call XY_fnc_showQuestionbox;

            if( !_action ) exitWith {};

            private _objects = nearestObjects[player, [], 50];
            {
                if( _x getVariable["deployed", 0] == 1 ) then {
                    deleteVehicle _x;
                };
            } forEach _objects;
        }, "", 0, false, true, "", "XY_equipCarrierDistance < 30 && { !XY_actionInUse } && { cursorTarget distance player < 6 } && { cursorTarget getVariable[""equipCarrier"", 0] > 0 };" ] );
    };

    if( _actionLevel isEqualTo 0 && !(_actions isEqualTo []) ) then {
        {
            player removeAction _x;
        } forEach _actions;

        _actions = [];
    };
};