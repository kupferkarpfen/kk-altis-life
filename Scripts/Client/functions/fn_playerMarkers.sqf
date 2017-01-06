// Unified script for all fractions to display special markers on the map
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

disableSerialization;

private _display = objNull;
waitUntil { _display = findDisplay 12; !(isNull _display) };

_display displayAddEventHandler['KeyDown', {
    if( !_ctrl ) exitWith {};
    if( currentChannel isEqualTo 7 ) then {
        setCurrentChannel 3;
    };
}];

XY_PlayerIcons = [];

(_display displayCtrl 51) ctrlAddEventHandler ["Draw", {

    private _ctrl = _this select 0;
    {
        _ctrl drawIcon _x;
    } forEach XY_PlayerIcons;
}];

while{ true } do {
    uisleep 1;
    while { visibleMap || visibleGPS } do {

        private _icons = [];

        {
            private _unit = _x;
            // Mark players of own side / gang
            if( !(_unit getVariable ["restrained", false]) && { !(isObjectHidden _unit) } ) then {

                // Check if in vehicle with other players...
                private _found = false;
                {
                    if( (vehicle (_x select 0)) isEqualTo (vehicle _unit) ) exitWith {
                        // append name
                        private _icon = _x select 1;
                        _icon set[6, format["%1, %2", _icon select 6, _unit getVariable["realName", "ERROR"]]];
                        _found = true;
                    };
                } forEach _icons;

                if( !_found ) then {
                    private _vehicle = vehicle _unit;
                    _icons pushBack [ _unit,
                        [
                            getText( configFile >> "CfgVehicles" >> typeOf _vehicle >> "Icon" ),
                            [1, 1, 1, 1],
                            visiblePosition _vehicle,
                            24,
                            24,
                            direction _vehicle,
                            format["%1", _unit getVariable["realName", "ERROR"]]
                        ]
                    ];
                };
            };

        } forEach (units group player);

        private _playerIcons = [];
        {
            _playerIcons pushBack (_x select 1);
        } forEach _icons;

        XY_PlayerIcons = _playerIcons;
    };
};