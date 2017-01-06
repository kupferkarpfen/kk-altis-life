/*
    File: fn_vehicleShop.sqf
    Author: Bryan "Tonic" Boardwine
    
    Description:
    Initializes the vehicle shop.
    CANT WAIT TO SCRAP THIS! ( You should scrap yourself for what you did )
*/
private["_display","_locations","_price","_pos1","_pos2","_dest_name","_distance","_time"];
disableSerialization;

if(vehicle player != player) exitWith {
    hint "Du musst erst das Fahrzeug verlassen, bevor du einen Taxi-Service benutzen kannst";
};
if(!dialog) then {
    createDialog "XY_dialog_taxi";
    XY_taxiLocation = (_this select 3) select 0;
};

_display = findDisplay 48400;
_locations = _display displayCtrl 48402;
lbClear _locations;

ctrlSetText[48401, "Taxistation " + (switch (XY_taxiLocation) do {
    case "taxi_spawn_kavalap"; case "taxi_spawn_kavala": { "Kavala" };
    case "taxi_spawn_athirap"; case "taxi_spawn_athira": { "Athira" };
    case "taxi_spawn_pyrgosp"; case "taxi_spawn_pyrgos": { "Pyrgos" };
    case "taxi_spawn_sofiap"; case "taxi_spawn_sofia": { "Sofia" };
    case "taxi_spawn_airfield": { "Flughafen" };
    case "taxi_spawn_rebhq": { "Rebellen HQ" };
    default { "ERROR" };
})];

{
    if( playerSide == _x select 2 ) then {
        if( count _x < 4 || count _x == 4 && { call (_x select 3) } ) then {

            _dest_name = (_x select 0);
            if(XY_taxiLocation != _dest_name) then {
                _pos1 = getMarkerPos XY_taxiLocation;
                _pos2 = getMarkerPos _dest_name;
                _distance = _pos1 distance _pos2;
                _price = round(_distance / 200.0);
                _time = round(_distance / 1000 * 6);
                _locations lbAdd format[ "%1 - Standardtarif (Dauer: %2): %3€ - Expresstarif (Dauer: %4): %5€", _x select 1,  [_time, "MM:SS"] call BIS_fnc_secondsToString, [_price] call XY_fnc_numberText, [_time / 3, "MM:SS"] call BIS_fnc_secondsToString, [round(_price * 2)] call XY_fnc_numberText ];
                _locations lbSetData [(lbSize _locations)-1,_dest_name];
                _locations lbSetValue [(lbSize _locations)-1,_price];
            };
        };
    };
} forEach XY_taxiStations;