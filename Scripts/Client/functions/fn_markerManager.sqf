// Unified script for all fractions to display special markers on the map
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

disableSerialization;

private _mode = param[0, "", [""]];

if( _mode isEqualTo "update" ) exitWith {

    {
        private _marker = _x;
        private _show = switch( true ) do {
            case( (_marker find "resource_legal") > -1 ): { XY_MM_showResourcesLegal };
            case( (_marker find "resource_illegal") > -1 ): { XY_MM_showResourcesIllegal };
            case( (_marker find "processor_legal") > -1 ): { XY_MM_showProcessorsLegal };
            case( (_marker find "processor_illegal") > -1 ): { XY_MM_showProcessorsIllegal };
            case( (_marker find "trader_legal") > -1 ): { XY_MM_showTradersLegal };
            case( (_marker find "trader_illegal") > -1 ): { XY_MM_showTradersIllegal };
            case( (_marker find "trader_illegal") > -1 ): { XY_MM_showTradersIllegal };
            case( (_marker find "fuel_") > -1 ): { XY_MM_showFuelstations };
            case( (_marker find "atm_") > -1 ): { XY_MM_showATMs };
            case( (_marker find "shop_") > -1 ): { XY_MM_showShops };
            case( (_marker find "garage_") > -1 ): { XY_MM_showGarages };
            case( (_marker find "airservice_") > -1 ): { XY_MM_showAirservices };
            case( (_marker find "poi_") > -1 ): { XY_MM_showPOIs };
            case( (_marker find "other_") > -1 ): { XY_MM_showOthers };
            default { 1 };
        };
        // Never hide safezone-markers
        if( _marker find "safezone" < 0 ) then {
            _marker setMarkerAlphaLocal ([0, XY_MM_alpha] select (_show isEqualTo 1));
        };
        if( (markerShape _marker) isEqualTo "ICON") then {
            _marker setMarkerSizeLocal [XY_MM_scale, XY_MM_scale];
        };

    } forEach allMapMarkers;
};

if( _mode isEqualTo "init" ) exitWith {

    private _display = objNull;
    waitUntil { _display = findDisplay 12; !(isNull _display) };

    private _rowHeight = safeZoneH * 0.0175;
    private _height = _rowHeight * 23;
    private _x = safeZoneX;
    private _y = safeZoneY + (safeZoneH / 2) - (_height / 2);
    private _px = safeZoneW * 0.001;
    private _width = safeZoneW * 0.1;

    private _control = _display ctrlCreate ['RscText', -1];
    _control ctrlSetPosition [_x, _y, _width, _height];
    _control ctrlSetBackgroundColor [0, 0, 0, 0.7];
    _control ctrlCommit 0;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='center' size='1.2'>Kartenfilter</t>";
    _control ctrlSetPosition [_x, _y, _width, _rowHeight + _px * 3];
    _control ctrlCommit 0;

    private _counter = 2;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='center' size='0.8'>Resourcen</t>";
    _control ctrlSetPosition [_x, _y + _rowHeight * _counter, _width, _rowHeight];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscCheckBox', -1];
    _control ctrlAddEventHandler  ["CheckedChanged", { XY_MM_showResourcesLegal = _this select 1; ["update"] call XY_fnc_markerManager; }];
    _control cbSetChecked  true;
    _control ctrlSetPosition [_x + _px, _y + _rowHeight * _counter, _rowHeight - _px * 2, _rowHeight];
    _control ctrlCommit 0;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='left' size='0.8'>Legal</t>";
    _control ctrlSetPosition [_x + _rowHeight, _y + _rowHeight * _counter, _width, _rowHeight];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscCheckBox', -1];
    _control ctrlAddEventHandler  ["CheckedChanged", { XY_MM_showResourcesIllegal = _this select 1; ["update"] call XY_fnc_markerManager; }];
    _control cbSetChecked  true;
    _control ctrlSetPosition [_x + _px, _y + _rowHeight * _counter, _rowHeight - _px * 2, _rowHeight];
    _control ctrlCommit 0;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='left' size='0.8'>Illegal</t>";
    _control ctrlSetPosition [_x + _rowHeight, _y + _rowHeight * _counter, _width, _rowHeight];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='center' size='0.8'>Verarbeiter</t>";
    _control ctrlSetPosition [_x, _y + _rowHeight * _counter, _width, _rowHeight];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscCheckBox', -1];
    _control ctrlAddEventHandler  ["CheckedChanged", { XY_MM_showProcessorsLegal = _this select 1; ["update"] call XY_fnc_markerManager; }];
    _control cbSetChecked  true;
    _control ctrlSetPosition [_x + _px, _y + _rowHeight * _counter, _rowHeight - _px * 2, _rowHeight];
    _control ctrlCommit 0;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='left' size='0.8'>Legal</t>";
    _control ctrlSetPosition [_x + _rowHeight, _y + _rowHeight * _counter, _width, _rowHeight];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscCheckBox', -1];
    _control ctrlAddEventHandler  ["CheckedChanged", { XY_MM_showProcessorsIllegal = _this select 1; ["update"] call XY_fnc_markerManager; }];
    _control cbSetChecked  true;
    _control ctrlSetPosition [_x + _px, _y + _rowHeight * _counter, _rowHeight - _px * 2, _rowHeight];
    _control ctrlCommit 0;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='left' size='0.8'>Illegal</t>";
    _control ctrlSetPosition [_x + _rowHeight, _y + _rowHeight * _counter, _width, _rowHeight];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='center' size='0.8'>Händler</t>";
    _control ctrlSetPosition [_x, _y + _rowHeight * _counter, _width, _rowHeight];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscCheckBox', -1];
    _control ctrlAddEventHandler  ["CheckedChanged", { XY_MM_showTradersLegal = _this select 1; ["update"] call XY_fnc_markerManager; }];
    _control cbSetChecked  true;
    _control ctrlSetPosition [_x + _px, _y + _rowHeight * _counter, _rowHeight - _px * 2, _rowHeight];
    _control ctrlCommit 0;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='left' size='0.8'>Legal</t>";
    _control ctrlSetPosition [_x + _rowHeight, _y + _rowHeight * _counter, _width, _rowHeight];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscCheckBox', -1];
    _control ctrlAddEventHandler  ["CheckedChanged", { XY_MM_showTradersIllegal = _this select 1; ["update"] call XY_fnc_markerManager; }];
    _control cbSetChecked  true;
    _control ctrlSetPosition [_x + _px, _y + _rowHeight * _counter, _rowHeight - _px * 2, _rowHeight];
    _control ctrlCommit 0;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='left' size='0.8'>Illegal</t>";
    _control ctrlSetPosition [_x + _rowHeight, _y + _rowHeight * _counter, _width, _rowHeight];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='center' size='0.8'>Sonstige</t>";
    _control ctrlSetPosition [_x, _y + _rowHeight * _counter, _width, _rowHeight];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscCheckBox', -1];
    _control ctrlAddEventHandler  ["CheckedChanged", { XY_MM_showFuelstations = _this select 1; ["update"] call XY_fnc_markerManager; }];
    _control cbSetChecked  true;
    _control ctrlSetPosition [_x + _px, _y + _rowHeight * _counter, _rowHeight - _px * 2, _rowHeight];
    _control ctrlCommit 0;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='left' size='0.8'>Tankstellen</t>";
    _control ctrlSetPosition [_x + _rowHeight, _y + _rowHeight * _counter, _width, _rowHeight];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscCheckBox', -1];
    _control ctrlAddEventHandler  ["CheckedChanged", { XY_MM_showATMs = _this select 1; ["update"] call XY_fnc_markerManager; }];
    _control cbSetChecked  true;
    _control ctrlSetPosition [_x + _px, _y + _rowHeight * _counter, _rowHeight - _px * 2, _rowHeight];
    _control ctrlCommit 0;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='left' size='0.8'>Bankautomaten</t>";
    _control ctrlSetPosition [_x + _rowHeight, _y + _rowHeight * _counter, _width, _rowHeight];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscCheckBox', -1];
    _control ctrlAddEventHandler  ["CheckedChanged", { XY_MM_showShops = _this select 1; ["update"] call XY_fnc_markerManager; }];
    _control cbSetChecked  true;
    _control ctrlSetPosition [_x + _px, _y + _rowHeight * _counter, _rowHeight - _px * 2, _rowHeight];
    _control ctrlCommit 0;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='left' size='0.8'>Shops</t>";
    _control ctrlSetPosition [_x + _rowHeight, _y + _rowHeight * _counter, _width, _rowHeight];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscCheckBox', -1];
    _control ctrlAddEventHandler  ["CheckedChanged", { XY_MM_showGarages = _this select 1; ["update"] call XY_fnc_markerManager; }];
    _control cbSetChecked  true;
    _control ctrlSetPosition [_x + _px, _y + _rowHeight * _counter, _rowHeight - _px * 2, _rowHeight];
    _control ctrlCommit 0;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='left' size='0.8'>Garagen</t>";
    _control ctrlSetPosition [_x + _rowHeight, _y + _rowHeight * _counter, _width, _rowHeight];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscCheckBox', -1];
    _control ctrlAddEventHandler  ["CheckedChanged", { XY_MM_showAirservices = _this select 1; ["update"] call XY_fnc_markerManager; }];
    _control cbSetChecked  true;
    _control ctrlSetPosition [_x + _px, _y + _rowHeight * _counter, _rowHeight - _px * 2, _rowHeight];
    _control ctrlCommit 0;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='left' size='0.8'>Heli-Service</t>";
    _control ctrlSetPosition [_x + _rowHeight, _y + _rowHeight * _counter, _width, _rowHeight];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscCheckBox', -1];
    _control ctrlAddEventHandler  ["CheckedChanged", { XY_MM_showPOIs = _this select 1; ["update"] call XY_fnc_markerManager; }];
    _control cbSetChecked  true;
    _control ctrlSetPosition [_x + _px, _y + _rowHeight * _counter, _rowHeight - _px * 2, _rowHeight];
    _control ctrlCommit 0;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='left' size='0.8'>POIs</t>";
    _control ctrlSetPosition [_x + _rowHeight, _y + _rowHeight * _counter, _width, _rowHeight];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscCheckBox', -1];
    _control ctrlAddEventHandler  ["CheckedChanged", { XY_MM_showOthers = _this select 1; ["update"] call XY_fnc_markerManager; }];
    _control cbSetChecked  true;
    _control ctrlSetPosition [_x + _px, _y + _rowHeight * _counter, _rowHeight - _px * 2, _rowHeight];
    _control ctrlCommit 0;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='left' size='0.8'>Sonstige</t>";
    _control ctrlSetPosition [_x + _rowHeight, _y + _rowHeight * _counter, _width, _rowHeight];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='center' size='0.8'>Größe</t>";
    _control ctrlSetPosition [_x, _y + _rowHeight * _counter, _width, _rowHeight];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscSlider', -1];
    _control ctrlSetPosition [_x, _y + _rowHeight * _counter, _width, _rowHeight];
    _control sliderSetRange [0, 20];
    _control sliderSetPosition 10;
    _control ctrlAddEventHandler  ["SliderPosChanged", { XY_MM_scale = (_this select 1) / 10; ["update"] call XY_fnc_markerManager; }];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscStructuredText', -1];
    _control ctrlSetStructuredText parseText "<t align='center' size='0.8'>Transparenz</t>";
    _control ctrlSetPosition [_x, _y + _rowHeight * _counter, _width, _rowHeight];
    _control ctrlCommit 0;

    _counter = _counter + 1;

    _control = _display ctrlCreate ['RscSlider', -1];
    _control ctrlSetPosition [_x, _y + _rowHeight * _counter, _width, _rowHeight];
    _control sliderSetRange [0, 10];
    _control sliderSetPosition 0;
    _control ctrlAddEventHandler  ["SliderPosChanged", { XY_MM_alpha = 1 - ((_this select 1) / 10); ["update"] call XY_fnc_markerManager; }];
    _control ctrlCommit 0;

};