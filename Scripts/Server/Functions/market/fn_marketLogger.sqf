// Kupferkarpfen market volume logger

private _data = ["insertMarketLog:%1:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14:%15:%16:%17:%18:%19:%20:%21:%22:%23:%24:%25:%26:%27:%28:%29:%30:%31"];

_data set [1, 0];
_data set [2, count allPlayers];
{
    private _config = [ _x select 0 ] call XY_fnc_sourceConfig;
    private _price = round((_x select 1) / (_config select 1));
    _data set [ _forEachIndex + 3, _price ];

} forEach XY_marketPrices;

[ format _data ] remoteExec ["XYDB_fnc_asyncCall", XYDB];

_data set [1, 1];
{
    _data set [_forEachIndex + 3, _x select 1];
    _x set [1, 0];
} forEach XY_marketVolumeLogger;

[ format _data ] remoteExec ["XYDB_fnc_asyncCall", XYDB];