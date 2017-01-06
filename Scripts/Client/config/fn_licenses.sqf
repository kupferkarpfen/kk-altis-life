// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// internal license name and which side may buy it, its name and its price
XY_licenses = [
    ["cop_air",             "cop", "Pilotenschein",                  -1    ],
    ["cop_air_small",       "cop", "kl. Pilotenschein",              -1    ],
    ["cop_cg",              "cop", "Bootsschein",                    -1    ],
    ["cop_sniper",          "cop", "Scharfschütze",                  -1    ],
    ["cop_sek",             "cop", "SEK",                            -1    ],
    ["cop_board",           "cop", "Polizeirat",                     -1    ],
    ["cop_trainer",         "cop", "Ausbilder",                      -1    ],

    ["med_air",             "med", "Pilotenschein",                  -1    ],
    ["med_trainer",         "med", "Ausbilder",                      -1    ],

    ["civ_lawyer",          "civ", "Anwaltslizenz",                  15000 ],
    ["civ_boat",            "civ", "Bootsschein",                    100   ],
    ["civ_driver",          "civ", "Führerschein",                   10    ],
    ["civ_home",            "civ", "Hausbesitzurkunde",              150000],
    ["civ_truck",           "civ", "LKW-Führerschein",               500   ],
    ["civ_air",             "civ", "Pilotenschein",                  1500  ],
    ["civ_dive",            "civ", "Tauchschein",                    250   ],
    ["civ_gun",             "civ", "Waffenschein",                   2500  ]
];

// Trainings (Resource processing, used to prevent information leaking to cops)
XY_training = [
    ["rebel",           "civ", "Rebellenausbildung",            20000     ],
    ["bier",            "civ", "Bierverarbeitung",              850       ],
    ["grapes",          "civ", "Branntweinherstellung",         850       ],
    ["crocodile",       "civ", "Crocodileherstellung",          3000      ],
    ["diamond",         "civ", "Diamantenschleifer",            1250      ],
    ["iron",            "civ", "Eisenverarbeitung",             250       ],
    ["barrel",          "civ", "Fassherstellung",               1750      ],
    ["glass",           "civ", "Glasverarbeitung",              850       ],
    ["gold",            "civ", "Goldverarbeitung",              850       ],
    ["heroin",          "civ", "Heroinverarbeitung",            3000      ],
    ["wood",            "civ", "Holzverarbeitung",              850       ],
    ["uran4",           "civ", "Kernbrennstoffherstellung",     1750      ],
    ["cocaine",         "civ", "Kokainverarbeitung",            3000      ],
    ["copper",          "civ", "Kupferverarbeitung",            100       ],
    ["lsd",             "civ", "LSD-Verarbeitung",              3000      ],
    ["marijuana",       "civ", "Marihuanaverarbeitung",         3000      ],
    ["meth",            "civ", "Meth-Koch",                     3000      ],
    ["trash",           "civ", "Mülltennung",                   1750      ],
    ["trashp",          "civ", "Müllverpackung",                1750      ],
    ["oilp",            "civ", "Ölabfüllgenehmigung",           1750      ],
    ["plastic",         "civ", "Plastikverwertung",             1750      ],
    ["uran3",           "civ", "Plutoniumherstellung",          3000      ],
    ["oilbarrel",       "civ", "Rohölabfüllung",                1750      ],
    ["salt",            "civ", "Salzveredlung",                 850       ],
    ["sarin",           "civ", "Sarinherstellung",              3000      ],
    ["jewelry",         "civ", "Schmuckherstellung",            1750      ],
    ["moonshine",       "civ", "Schwarzbranntherstellung",      3000      ],
    ["silber",          "civ", "Silberverarbeitung",            850       ],
    ["uran2",           "civ", "Urananreicherung",              3000      ],
    ["uran",            "civ", "Uranitverarbeitung",            1750      ],
    ["cement",          "civ", "Zementverarbeitung",            850       ]
];

XY_spawnLicenses = [
    ["spawn2", "civ", "Spawnberechtigung Pyrgos", 3000],
    ["spawn3", "civ", "Spawnberechtigung Athira", 3000],
    ["spawn4", "civ", "Spawnberechtigung Sofia", 3000],
    ["spawn5", "civ", "Spawnberechtigung AirService Nord", 15000],
    ["spawn6", "civ", "Spawnberechtigung Kavala Stadion", 15000],
    ["spawn7", "civ", "Spawnberechtigung Pyrgos Ost", 15000],
    ["spawn8", "civ", "Spawnberechtigung Paros Nord", 15000]
];

// initialize
{
    missionNamespace setVariable[ format["license_%1", _x select 0], false];
} forEach ( XY_licenses + XY_training + XY_spawnLicenses );