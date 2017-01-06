// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
// based on work by Tonic

// Paycheck for civs, other factions are configured in their init script
XY_PC = 30;

// max z-inventory size
XY_maxWeight = if( playerSide isEqualTo civilian ) then { floor(90 * XY_ssv_backbackMultiplier) } else { 150 };

// time between paychecks (minutes)
XY_PC_period = 5;

// gang prices
// gang creation
XY_gangPrice = 15000;
// base price for extension (costs per target slot, after upgrade)
XY_gangUpgradeBase = 1000;

XY_genStore = [
    ["Binocular", nil, 5],
    ["ItemGPS", nil, 5],
    ["ItemMap", nil, 2],
    ["ItemWatch", nil, 1],
    ["ToolKit", nil, 50],
    ["FirstAidKit", nil, 50],
    ["NVGoggles_INDEP", nil, 125]
];

// TAXISTATIONEN
XY_taxiStations = [

    ["taxi_spawn_kavala",   "Kavala", independent],
    ["taxi_spawn_athira",   "Athira", independent],
    ["taxi_spawn_pyrgos",   "Pyrgos", independent],
    ["taxi_spawn_sofia",    "Sofia", independent],

    ["taxi_spawn_kavalap",  "Kavala", west],
    ["taxi_spawn_athirap",  "Athira", west],
    ["taxi_spawn_pyrgosp",  "Pyrgos", west],
    ["taxi_spawn_sofiap",   "HW Patrol", west]
];

XY_placeableItems = [

// <LVL>, <NAME>, <CLASS>
    [ 1, "Pylon",              "RoadCone_L_F"                ],
    [ 1, "Sperre (klein)",     "Roadbarrier_small_F"         ],
    [ 1, "Absperrband",        "TapeSign_F"                  ],
    [ 2, "Sperre (groß)",      "RoadBarrier_F"               ],
    [ 3, "Beleuchtung",        "Land_PortableLight_single_F" ],
    [ 3, "Warnschild",         "SignAd_Sponsor_F"            ],
    [ 4, "Betonsperre",        "Land_CncBarrier_stripes_F"   ],
    [ 4, "Leitplanke",         "Land_Crash_barrier_F"        ],
    [ 5, "Betonsperre (lang)", "Land_CncBarrierMedium4_F"    ],
    [ 5, "Schranke",           "Land_BarGate_F"              ],
    [ 6, "Pfeile (links)",     "ArrowDesk_L_F"               ],
    [ 6, "Pfeile (rechts)",    "ArrowDesk_R_F"               ],
    [ 7, "Blitzer",            "Land_Runway_PAPI"            ]
];

// All spawnpoints
// <SIDE>, <MARKER>, <NAME>, <CONDITION (default true if omitted)>
XY_spawnpoints = [

    [west, "cop_spawn_1", "Kavala HQ"],
    [west, "cop_spawn_2", "Pyrgos HQ"],
    [west, "cop_spawn_3", "Altis Mitte"],
    [west, "cop_spawn_4", "Sofia HQ"],

    [independent, "medic_spawn_1", "Kavala Krankenhaus"],
    [independent, "medic_spawn_2", "Medizinisches Zentrum"],

    [civilian, "civ_spawn_1", "Kavala", { !(["rebel"] call XY_fnc_hasLicense) }],
    [civilian, "civ_spawn_2", "Pyrgos", { !(["rebel"] call XY_fnc_hasLicense) && (["spawn2"] call XY_fnc_hasLicense) }],
    [civilian, "civ_spawn_3", "Athira", { (["spawn3"] call XY_fnc_hasLicense) }],
    [civilian, "civ_spawn_4", "Sofia", { (["spawn4"] call XY_fnc_hasLicense) }],
    [civilian, "civ_spawn_5", "AirService Nord", { (["spawn5"] call XY_fnc_hasLicense) }],
    [civilian, "civ_spawn_6", "Kavala Stadion", { (["spawn6"] call XY_fnc_hasLicense) }],
    [civilian, "civ_spawn_7", "Pyrgos Ost", { (["spawn7"] call XY_fnc_hasLicense) }],
    [civilian, "civ_spawn_8", "Paros Nord", { (["spawn8"] call XY_fnc_hasLicense) }],

    [civilian, "reb_spawn_1", "Rebellen-HQ Süd", { license_rebel } ],
    [civilian, "reb_spawn_2", "Rebellen-HQ Nord", { license_rebel } ]
];

{
    if( count _x < 4 ) then {
        _x set [3, { true }];
    };
} forEach XY_spawnpoints;

// Default loadouts after spawning...
XY_defaultLoadouts = [
    [ west, [[],[],[],["U_BG_Guerilla2_1",[]],[],[],"","",[],["ItemMap","","","ItemCompass","ItemWatch",""]] ],
    [ civilian, [[],[],[],["U_C_Poor_1",[]],[],[],"","",[],["ItemMap","","","ItemCompass","ItemWatch",""]] ],
    [ independent, [[],[],[],["U_B_CTRG_1",[]],[],["B_Bergen_mcamo",[["Medikit",1]]],"","",[],["ItemMap","","","ItemCompass","ItemWatch",""]] ]
];