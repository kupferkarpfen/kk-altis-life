// Market configuration
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Price is per volume unit ( = ingame LE )
// This is the default price, the script scales from there to 150% depending on player count, and then slowly moves on
#define PRICE_LOW 3
#define PRICE_MID 4
#define PRICE_HIGH 6
#define PRICE_ILLEGAL 8
#define PRICE_ILLEGAL_HIGH 9

// IMPORTANT: Keep ordering in sync with the marketLogger SQL statement!
XY_marketConfiguration = [
 // <RESOURCE>,  <PRICE-PER-UNIT>
    ["oilp",        PRICE_HIGH * 1.5],
    ["iron_r",      PRICE_MID],
    ["diamondc",    PRICE_HIGH],
    ["copper_r",    PRICE_LOW],
    ["salt_r",      PRICE_MID],
    ["cement",      PRICE_MID],
    ["goldp",       PRICE_HIGH],
    ["jewelry",     PRICE_HIGH * 1.3],
    ["silberp",     PRICE_HIGH],
    ["holzp",       PRICE_MID],
    ["bottledbeer", PRICE_MID],
    ["brandy",      PRICE_MID],
    ["uranp3",      PRICE_HIGH],
    ["moonshine",   PRICE_ILLEGAL],
    ["turtle",      PRICE_ILLEGAL_HIGH],
    ["marijuana",   PRICE_ILLEGAL],
    ["cocainep",    PRICE_ILLEGAL],
    ["heroinp",     PRICE_ILLEGAL],
    ["frogslsd",    PRICE_ILLEGAL],
    ["methp",       PRICE_ILLEGAL],
    ["sarin",       PRICE_ILLEGAL * 1.3],
    ["crocodile",   PRICE_ILLEGAL_HIGH],
    ["uranp",       PRICE_ILLEGAL_HIGH],
    ["uranp2",      PRICE_ILLEGAL_HIGH * 1.15],
    ["waste",       PRICE_HIGH],
    ["trashbag",    PRICE_HIGH],
    ["trashp",      PRICE_HIGH * 1.3],
    ["barrel",      PRICE_HIGH],
    ["glass",       PRICE_MID]
];

XY_resourceOfTheDay = (selectRandom XY_marketConfiguration) select 0;
publicVariable "XY_resourceOfTheDay";

// Add resources to global name-price variable
XY_marketPrices = [];
{
    // Initialize for first start
    private _item = _x select 0;
    private _price = round( (([_item] call XY_fnc_sourceConfig) select 1) * (_x select 1) );
    XY_marketPrices pushBack [_item, _price, _price - ([_item] call XY_fnc_marketBasePrice), 0];
} forEach XY_marketConfiguration;

// Add market volume for processing purposes
XY_marketVolume = [];
{
    XY_marketVolume pushBack [_x select 0, 0];
} forEach XY_marketConfiguration;

// Add market volume for logging purposes
XY_marketVolumeLogger = [];
{
    XY_marketVolumeLogger pushBack [_x select 0, 0];
} forEach XY_marketConfiguration;