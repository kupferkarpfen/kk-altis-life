// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Single configuration for resource zones to prevent copy/paste fuckups
XY_resourceZones = [
    // <--         Zone Names        -->    <Product>     <required item>
    [["resource_legal_apple_1",
      "resource_legal_apple_2"],            "apple",          ""],
    [["resource_legal_peaches_1",
      "resource_legal_peaches_2"],          "peach",          ""],
    [["resource_legal_grape_1"],            "grapes",         ""],
    [["resource_illegal_heroin"],           "heroinu",        ""],
    [["resource_illegal_cocaine"],          "cocaine",        ""],
    [["resource_illegal_weed"],             "cannabis",       ""],
    [["resource_illegal_meth"],             "methu",          ""],
    [["resource_illegal_frogs"],            "frogs",          ""],
    [["resource_legal_wood"],               "holzu",          ""],
    [["resource_legal_sand"],               "sand",           ""],
    [["resource_legal_oilwaste"],           "oilu",           ""],
    [["resource_legal_bier"],               "hopfen",         ""],
    [["processor_illegal_moonshine"],       "propanol",       ""],
    [["resource_illegal_bweapon"],          "bweapon",        ""],
    [["resource_legal_plastic_1",
      "resource_legal_plastic_2"],          "plastic",        ""],

    [["resource_legal_copper"],             "copperore",      "pickaxe"],
    [["resource_legal_iron"],               "ironore",        "pickaxe"],
    [["resource_legal_salt"],               "salt",           "pickaxe"],
    [["resource_legal_diamond"],            "diamond",        "pickaxe"],
    [["resource_legal_rock"],               "rock",           "pickaxe"],
    [["resource_legal_uran"],               "uranu",          "pickaxe"],
    [["resource_legal_silber"],             "silberu",        "pickaxe"],
    [["resource_legal_gold"],               "goldu",          "pickaxe"],
    [["resource_legal_trash"],              "trash",          ""]
];

// Kupferkarpfen: Single configuration for resource processing to prevent copy/paste fuckups
XY_resourceProcessors = [
    // <Name>         <Source(s)>                      <Target>,   <Condition>
    [ "turtle",       ["turtle"],                       "turtle",      { true } ], // << Workaround to retrieve source resource for turtles
    [ "diamond",      ["diamond"],                      "diamondc",    { true } ],
    [ "copper",       ["copperore"],                    "copper_r",    { true } ],
    [ "iron",         ["ironore"],                      "iron_r",      { true } ],
    [ "salt",         ["salt"],                         "salt_r",      { true } ],
    [ "cement",       ["rock"],                         "cement",      { true } ],
    [ "grapes",       ["grapes"],                       "brandy",      { true } ],
    [ "gold",         ["goldu"],                        "goldp",       { true } ],
    [ "silber",       ["silberu"],                      "silberp",     { true } ],
    [ "glass",        ["sand"],                         "glass",       { true } ],
    [ "wood",         ["holzu"],                        "holzp",       { true } ],
    [ "bier",         ["hopfen"],                       "bottledbeer", { true } ],
    [ "heroin",       ["heroinu"],                      "heroinp",     { true } ],
    [ "cocaine",      ["cocaine"],                      "cocainep",    { true } ],
    [ "marijuana",    ["cannabis"],                     "marijuana",   { true } ],
    [ "lsd",          ["frogs"],                        "frogslsd",    { true } ],
    [ "meth",         ["methu"],                        "methp",       { true } ],
    [ "moonshine",    ["grapes"],                       "moonshine",   { true } ],
    [ "uran",         ["uranu"],                        "uranu2",      { true } ],
    [ "uran2",        ["uranu2"],                       "uranp",       { true } ],
    [ "uran3",        ["uranp"],                        "uranp2",      { true } ],
    [ "uran4",        ["uranu2"],                       "uranp3",      { true } ],
    [ "sarin",        ["bweapon", "propanol"],          "sarin",       { true } ],
    [ "jewelry",      ["goldp", "diamondc"],            "jewelry",     { true } ],
    [ "barrel",       ["iron_r", "copper_r"],           "barrel",      { true } ],
    [ "oilbarrel",    ["barrel"],                       "oilp",        { true } ],
    [ "crocodile",    ["heroinp", "oilu", "propanol"],  "crocodile",   { true } ],
    [ "trash",        ["trash"],                        "waste",       { true } ],
    [ "plastic",      ["plastic"],                      "trashbag",    { true } ],
    [ "trashp",       ["waste", "trashbag"],            "trashp",      { true } ],
    [ "usb1",         ["usbstick_1"],                   "usbstick_2",  { if( (["hackbook"] call XY_fnc_getItemCountFromTrunk) < 1 ) exitWith { hint "Du brauchst ein HackBook Pro für den Download!"; false }; true } ],
    [ "usb2",         ["usbstick_2"],                   "usbstick_3",  { if( (["hackbook"] call XY_fnc_getItemCountFromTrunk) < 1 ) exitWith { hint "Du brauchst ein HackBook Pro zum Entschlüsseln!"; false }; true } ]
];