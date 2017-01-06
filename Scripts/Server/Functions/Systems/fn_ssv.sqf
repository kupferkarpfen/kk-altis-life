// SSV, Server-Side-Variables
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Retrieves variables from DB and pushes them to all clients via publicVariable

private _mode = param[0, "", [""]];
if( _mode isEqualTo "" ) exitWith {};

if( _mode isEqualTo "loop" ) exitWith {
    "SSVloop" spawn { scriptName _this;
        while{ true } do {
            uisleep 1200;
            [ "update" ] remoteExec [ "XY_fnc_ssv", XYDB ];
        };
    };
};

if( !(_mode isEqualTo "update") ) exitWith {
    diag_log format["<ERROR> SSV, invalid mode: %1", _this];
};

diag_log "<SSV> updating variables...";
{
    // diag_log format[ "<SSV> processing: %1", _x ];

    private _name = _x select 0;
    private _value = _x select 1;

    if( isNil { missionNamespace getVariable _name } || { !((missionNamespace getVariable _name) isEqualTo _value) } ) then {
        diag_log format[ "<SSV> publish: %1 = %2 (%3)", _name, _value, typeName _value ];
        missionNamespace setVariable[ _name, _value ];
        publicVariable _name;
    };

} forEach ([ "getConfigSSV", true] call XYDB_fnc_asyncCall);

diag_log "<SSV> updating XY_virtItems";
private _itemList = [];
{
    _x set[ 5, (_x select 5 isEqualTo 1) ];

    private _condition = { true };
    if( typeName (_x select 6) isEqualTo "CODE" ) then {
        _condition = _x select 6;
    };
    _x set[6, _condition];

    _itemList pushBack _x;

} forEach ([ "getConfigItems", true ] call XYDB_fnc_asyncCall);

if( isNil "XY_virtItems" || { !(XY_virtItems isEqualTo _itemList) } ) then {
    diag_log format["<SSV> publish XY_virtItems: %1", _itemList];

    XY_virtItems = _itemList;
    // Update virtual items with market-prices
    call XY_fnc_marketUpdate;
};

diag_log "<SSV> updating XY_vehicleList";
private _vehicleList = [];
{
    // diag_log format[ "<SSV> processing: %1, %2", _x,  typeName (_x select 7), typeName (_x select 8) ];

    private _shops = [];
    if( typeName (_x select 7) isEqualTo "ARRAY" ) then {
        _shops = _x select 7;
    };

    private _condition = { true };
    if( typeName (_x select 8) isEqualTo "CODE" ) then {
        _condition = _x select 8;
    };

    _vehicleList pushBack [
        // IDX 0: vehicle side
        switch( _x select 0) do { case "all": { sideUnknown }; case "cop": { west }; case "civ": { civilian }; case "med": { independent }; default { "ERR" } },
        _x select 1, // IDX 1: classname
        _x select 2, // IDX 2: trunk capacity
        (_x select 3) * XY_ssv_VD * XY_ssv_GD, // IDX 3: buy value
        (_x select 4) * XY_ssv_VD * XY_ssv_GD, // IDX 4: rent value
        (_x select 5) * XY_ssv_VD * XY_ssv_GD, // IDX 5: insure value
        (_x select 6) * XY_ssv_VD * XY_ssv_GD, // IDX 6: unpark value
        ((_x select 3) * XY_ssv_VD * XY_ssv_GD) * XY_ssv_SF, // IDX 7: sale value
        _shops, // IDX 8: shop list
        _condition // IDX 9: buy pre-condition
    ];

} forEach ([ "getConfigVehicles", true] call XYDB_fnc_asyncCall);

if( isNil "XY_vehicleList" || { !(XY_vehicleList isEqualTo _vehicleList) } ) then {
    diag_log "<SSV> publish XY_vehicleList";
    XY_vehicleList = _vehicleList;
    publicVariable "XY_vehicleList";
};

diag_log "<SSV> updating XY_virtShops";
private _shopList = ([ "getConfigTraders", true ] call XYDB_fnc_asyncCall);

if( isNil "XY_virtShops" || { !(XY_virtShops isEqualTo _shopList) } ) then {
    diag_log "<SSV> publish XY_virtShops";
    XY_virtShops = _shopList;
    publicVariable "XY_virtShops";
};

// We cannot load the whole list in one go, so we have to do a few more calls...
diag_log "<SSV> updating XY_objectShops";
private _objectShopList = [];
{
    private _shop = _x select 0;
    {
        private _condition = { true };
        if( typeName (_x select 3) isEqualTo "CODE" ) then {
            _condition = _x select 3;
        };

        private _entry = [ _x select 0, _x select 1, _x select 2, _condition ];
        private _found = false;
        {
            if( (_x select 0) isEqualTo _shop )exitWith {
                _found = true;
                (_x select 1) pushBack _entry;
            };
        } forEach _objectShopList;

        if( !_found )then {
            _objectShopList pushBack [ _shop, [_entry] ];
        };

    } forEach ( [format[ "getConfigObjectsFromShop:%1", _shop], true ] call XYDB_fnc_asyncCall);
} forEach ([ "getConfigObjectsShops", true ] call XYDB_fnc_asyncCall);

if( isNil "XY_objectShops" || { !(XY_objectShops isEqualTo _objectShopList) } ) then {
    diag_log "<SSV> publish XY_objectShops";
    XY_objectShops = _objectShopList;
    publicVariable "XY_objectShops";
};

[format["updateDaytime:%1", daytime]] call XYDB_fnc_asyncCall;
[format["updateFed:%1", fed_bank getVariable["safe", 0]]] call XYDB_fnc_asyncCall;