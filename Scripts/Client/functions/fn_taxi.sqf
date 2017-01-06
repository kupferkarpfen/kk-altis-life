// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

disableSerialization;

private _mode = param[0, "", [""]];

if( (player distance2D (nearestBuilding player)) < 50 ) exitWith {
    hint "Bitte halte mindestens 50m Abstand zu Gebäuden, bevor du ein Taxi rufst";
};
if( (player distance (getMarkerPos "pvp_zone")) < 2200 ) exitWith {
    hint "Die Zentrale weigert sich ein Taxi in ein Kampfgebiet zu schicken";
};
if( (vehicle player) != player ) exitWith {
    hint "Du sitzt bereits in einem Fahrzeug";
};
if( !(isNil "XY_taxiCalled") && { time - XY_taxiCalled < 120 } ) exitWith {
    hint "Bitte warte ein paar Minuten, bevor du erneut ein Taxi bestellst";
};

if( !dialog ) then {
    createDialog "XY_dialog_callTaxi";
};

private _display = objNull;
waitUntil { _display = findDisplay 48900; !(isNull _display) };

private _lstDestinations = _display displayCtrl 48402;

if( _mode isEqualTo "init" ) exitWith {
    lbClear _lstDestinations;

    {
        private _pos = getMarkerPos (_x select 0);
        private _distance = (player distance2D _pos) / 1000.0;
        _distance = round( _distance * 10 ) / 10;

        if( _distance > 0.5 && ( ((_x select 0) find "_reb" < 0) || license_rebel )) then {

            private _price = (round(100 + (ceil(_distance) * 13)));
            // Cheaper for noobies
            if( (XY_CC + XY_CA) < (_price * 10) )then {
                _price = round((XY_CC + XY_CA) * 0.1);
            };

            _lstDestinations lbAdd format[ "%1 - %2 km - Kosten %3€", _x select 1, _distance, _price ];
            _lstDestinations lbSetData [(lbSize _lstDestinations) - 1, _x select 0];
            _lstDestinations lbSetValue [(lbSize _lstDestinations) - 1, _price];
        };

    } forEach XY_ssv_taxiStations;
};

if( _mode isEqualTo "call" ) exitWith {

    if( XY_actionInUse || XY_isArrested || (player getVariable ["restrained", false]) ) exitWith {};

    private _index = lbCurSel _lstDestinations;
    if( _index < 0 ) exitWith {};

    private _destination = _lstDestinations lbData _index;
    if( _destination isEqualTo "" ) exitWith {};

    private _price = _lstDestinations lbValue _index;
    if(_price < 0) exitWith {};

    [player, _destination, _price] remoteExec ["XY_fnc_callTaxi", XYDB];
    XY_taxiCalled = time;

    closeDialog 0;
};