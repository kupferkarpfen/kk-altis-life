// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// --- key-value-store keys

KV_name = "name";
KV_level = "level";
KV_birthday = "birthday";
KV_birthlocation = "birthlocation";
KV_address = "address";
KV_town = "town";
KV_height = "height";
KV_eyecolor = "eyecolor";
KV_cash = "cash";
KV_bank = "bank";
KV_gear = "gear";
KV_trunk = "trunk";
KV_licenses = "licenses";
KV_karma = "karma";
KV_arrested = "arrested";
KV_jailTime = "jt";
KV_playTime = "pt";

XY_kvs_modifiedKeys = [];
// ---

XY_isAdmin = false;
XY_immunity = 0;
XY_showAdminMessages = false;
XY_karma = 0;
XY_alwaysTrue = true;
XY_MM_showResourcesLegal = 1;
XY_MM_showResourcesIllegal = 1;
XY_MM_showProcessorsLegal = 1;
XY_MM_showProcessorsIllegal = 1;
XY_MM_showTradersLegal = 1;
XY_MM_showTradersIllegal = 1;
XY_MM_showTradersIllegal = 1;
XY_MM_showFuelstations = 1;
XY_MM_showATMs = 1;
XY_MM_showShops = 1;
XY_MM_showGarages = 1;
XY_MM_showAirservices = 1;
XY_MM_showPOIs = 1;
XY_MM_showOthers = 1;
XY_MM_scale = 1;
XY_MM_alpha = 1;
XY_sidechat = true;
XY_tagsON = true;
XY_hudON = true;
XY_spawnPos = [];
XY_lastAirVehicle = 0;
XY_nameCache = [];
XY_nextBoost = 0;
XY_infoCache = [];
XY_radx = 0;
XY_trackerVehicle = objNull;
XY_trackerTimeout = 0;
XY_headbag = false;
XY_forceSaveTime = 0;
XY_mapMarkersActive = false;
XY_tearGasActive = false;
XY_bailPaid = false;
XY_canPayBail = false;
XY_bailAmount = 0;
XY_gameRunning = false;
XY_garageStore = false;
XY_netDropped = false;
XY_clothingFilter = 0;
XY_clothingUniform = -1;
XY_redgullEffectTimeout = time;
XY_impoundInUse = false;
XY_actionInUse = false;
XY_spikeStrip = objNull;
XY_interrupted = false;
XY_removeWanted = false;
XY_empLastVehicles = [];
XY_empInUse = false;
XY_playerTrunk = [];
XY_promille = 0;
XY_drugged = 0;
XY_lastDrugSound = 0;
XY_hardDrugged = false;
XY_soundTarget = 1;
XY_smartphoneTarget = objNull;
XY_atmUsable = true;
XY_isArrested = false;
XY_deliveryInProgress = false;
XY_nitroInUse = false;
XY_thirst = 0;
XY_hunger = 0;
XY_isTazed = false;
XY_cooldown = time;
XY_vehicles = [];
XY_medAllergies = [];
XY_medActive = false;
XY_marketVolume = [];
XY_marketLastAction = 0;
XY_spawnPoint = [];
XY_vehiclePreviewPos = [20569.4, 10585.1, 4];
XY_vehiclePreviewDir = 7.6;
XY_IN_PVP = false;
XY_hintH1 = "<t color='#F0C010' size='1.6' align='center'>%1</t>";
XY_hintError = "<t color='#DD0000' size='1.2' align='center'>%1</t>";
XY_hintMsg = "%1<br/><br/><t color='#FFFFFF' size='1.1'>%2</t>";

XY_copLevel = 0;
XY_medicLevel = 0;

XY_vehicleShopConfig = [
    // internal name, shop title, condition
    ["civ_car", "Autohändler", { ["civ_driver"] call XY_fnc_hasLicense }],
    ["civ_ship", "Bootshändler", { ["civ_boat"] call XY_fnc_hasLicense }],
    ["civ_truck", "LKW-Händler", { ["civ_truck"] call XY_fnc_hasLicense }],
    ["civ_air", "Helikopter-Händler", { ["civ_air"] call XY_fnc_hasLicense }],
    ["jet_shop", "Flugzeug-Shop", { ["civ_air"] call XY_fnc_hasLicense }],
    ["civ_reb", "Rebellenfahrzeuge", { ["rebel"] call XY_fnc_hasLicense }],
    ["kart_shop", "Kart-Shop", { ["civ_driver"] call XY_fnc_hasLicense }],
    ["cop_car", "Polizei-Fahrzeuge", { XY_copLevel > 0 }],
    ["cop_air", "Polizei-Helikopter", { ["cop_air"] call XY_fnc_hasLicense || ["cop_air_small"] call XY_fnc_hasLicense }],
    ["cop_ship", "Polizei-Boote", { ["cop_cg"] call XY_fnc_hasLicense }],
    ["med", "Sanitäterfahrzeuge", { XY_medicLevel > 0 }]
];

XY_IN_SAFEZONE = false;
XY_SAFEZONES = [];
{
    if( (_x find "safezone") >= 0 ) then {
        XY_SAFEZONES pushBack _x;
    };
} forEach allMapMarkers;

XY_actionDefaultCondition = "!(playerSide in [%1]) && (vehicle player) isEqualTo player && !XY_actionInUse";

XY_CC = 0;
XY_PC = 0;

// price difference for buying clothes
// (0)uniform, (1)headgear, (2)glasses, (3)vest, (4)backpack
XY_clothingPurchase = [-1, -1, -1, -1, -1];