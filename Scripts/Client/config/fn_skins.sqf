// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _side = param[0, playerSide, [sideUnknown]];

_return = [];
if( _side isEqualTo civilian ) exitWith {
    _return pushBack [
        "B_Truck_01_transport_F", [
            ["Standard", ["\A3\soft_f_beta\Truck_01\Data\truck_01_ext_01_co.paa"]]
        ]
    ];
    _return pushBack [
        "I_Heli_Transport_02_F", [
            ["Blau", ["\a3\air_f_beta\heli_transport_02\data\skins\heli_transport_02_1_ion_co.paa", "\a3\air_f_beta\heli_transport_02\data\skins\heli_transport_02_2_ion_co.paa", "\a3\air_f_beta\heli_transport_02\data\skins\heli_transport_02_3_ion_co.paa"]],
            ["Grün", ["\a3\air_f_beta\heli_transport_02\data\skins\heli_transport_02_1_dahoman_co.paa", "\a3\air_f_beta\heli_transport_02\data\skins\heli_transport_02_2_dahoman_co.paa", "\a3\air_f_beta\heli_transport_02\data\skins\heli_transport_02_3_dahoman_co.paa"]],
            ["Camo", ["\a3\air_f_beta\heli_transport_02\data\heli_transport_02_1_indp_co.paa", "\a3\air_f_beta\heli_transport_02\data\heli_transport_02_2_indp_co.paa", "a3\air_f_beta\heli_transport_02\data\heli_transport_02_3_indp_co.paa"]],
            ["Twitch", ["textures\vehicles\civ\mohawk\twitch_0.paa", "textures\vehicles\civ\mohawk\twitch_1.paa", "textures\vehicles\civ\mohawk\twitch_2.paa"], { false }]
        ]
    ];
    _return pushBack [
        "C_Hatchback_01_F", [
            ["Beige", ["\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_base01_co.paa"]],
            ["Grün", ["\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_base02_co.paa"]],
            ["Blau", ["\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_base03_co.paa"]],
            ["Gelb", ["\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_base06_co.paa"]]
        ]
    ];
    _return pushBack [
        "C_Hatchback_01_sport_F", [
            ["Rot", ["\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_sport01_co.paa"]],
            ["Dunkelblau", ["\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_sport02_co.paa"]],
            ["Orange", ["\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_sport03_co.paa"]],
            ["Schwarz-Weiß", ["\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_sport04_co.paa"]],
            ["Impulse", ["\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_sport05_co.paa"]],
            ["Grün", ["\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_sport06_co.paa"]],
            ["Sticker", ["textures\vehicles\civ\hatchback\sticker.paa"]],
            ["Blackline", ["#(argb,8,8,3)color(0.05,0.05,0.05,0.22)"]],
            ["Greyline", ["#(argb,8,8,3)color(0.4,0.4,0.4,0.15)"]],
            ["Christmas Minions", ["textures\vehicles\civ\hatchback\minions.paa"], { missionNamespace getVariable["XY_ssv_christmasSkinsEnabled", false] }]
        ]
    ];
    _return pushBack [
        "C_Offroad_01_F", [
            ["Rot", ["\a3\soft_f\offroad_01\data\offroad_01_ext_co.paa"]],
            ["Camel", ["\a3\soft_f\offroad_01\data\offroad_01_ext_base01_co.paa"]],
            ["Weiß", ["\a3\soft_f\offroad_01\data\offroad_01_ext_base02_co.paa"]],
            ["Blau", ["\a3\soft_f\offroad_01\data\offroad_01_ext_base03_co.paa"]],
            ["Dunkelrot", ["\a3\soft_f\offroad_01\data\offroad_01_ext_base04_co.paa"]],
            ["Blau-Weiß", ["\a3\soft_f\offroad_01\data\offroad_01_ext_base05_co.paa"]],
            ["Schwarz", ["#(ai,64,64,1)fresnel(0.3,3)"]],
            ["Taxi", ["#(argb,8,8,3)color(0.9,0.15,0.01,0.7)"]],
            ["Turquoise", ["#(argb,8,8,3)color(0.01,0.07,0.25,1)"]],
            ["Hellbraun", ["#(argb,8,8,3)color(0.7,0.4,0.05,0.2)"]],
            ["Rose", ["#(argb,8,8,3)color(1,0.75,0.84,0.1)"]],
            ["UltraViolet", ["#(argb,8,8,3)color(0.1,0.01,1,0.7)"]],
            ["Shiny Maid", ["#(argb,8,8,3)color(0.9,0.25,0.1,1)"]],
            ["Orange", ["#(argb,8,8,3)color(0.9,0.25,0.0,1)"]],
            ["Pink Power", ["#(argb,8,8,3)color(1,0.01,0.55,0.2)"]]
        ]
    ];
    _return pushBack [
        "B_G_Offroad_01_F", [
            ["Rebell", ["\A3\soft_f_gamma\Offroad_01\Data\offroad_01_ext_ig01_co.paa"]],
            ["Schwarz", ["#(ai,64,64,1)Fresnel(0.3,3)"]]
        ]
    ];
    _return pushBack [
        "C_Offroad_02_unarmed_F", [
            ["Schwarz", ["\a3\soft_f_exp\offroad_02\data\offroad_02_ext_black_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_ext_black_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_int_black_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_int_black_co.paa"]],
            ["Blau", ["\a3\soft_f_exp\offroad_02\data\offroad_02_ext_blue_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_ext_blue_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_int_blue_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_int_blue_co.paa"]],
            ["Braun", ["\a3\soft_f_exp\offroad_02\data\offroad_02_ext_brown_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_ext_brown_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_int_brown_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_int_brown_co.paa"]],
            ["Grün", ["\a3\soft_f_exp\offroad_02\data\offroad_02_ext_green_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_ext_green_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_int_green_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_int_green_co.paa"]],
            ["Olive", ["\a3\soft_f_exp\offroad_02\data\offroad_02_ext_olive_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_ext_olive_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_int_olive_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_int_olive_co.paa"]],
            ["Orange", ["\a3\soft_f_exp\offroad_02\data\offroad_02_ext_orange_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_ext_orange_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_int_orange_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_int_orange_co.paa"]],
            ["Rot", ["\a3\soft_f_exp\offroad_02\data\offroad_02_ext_red_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_ext_red_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_int_red_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_int_red_co.paa"]],
            ["Weiss", ["\a3\soft_f_exp\offroad_02\data\offroad_02_ext_white_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_ext_white_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_int_white_co.paa","\a3\soft_f_exp\offroad_02\data\offroad_02_int_white_co.paa"]],
            ["Twitch", ["textures\vehicles\civ\4wd\twitch.paa"], { false }],
            ["Jurassic Park", ["textures\vehicles\civ\4wd\MP_4WD_Jurassic_Park.paa"]]

        ]
    ];
    _return pushBack [
        "C_SUV_01_F", [
            ["Dunkelrot", ["\a3\soft_f_gamma\SUV_01\Data\suv_01_ext_co.paa"]],
            ["Schwarz", ["\a3\soft_f_gamma\SUV_01\Data\suv_01_ext_02_co.paa"]],
            ["Silber", ["\a3\soft_f_gamma\SUV_01\Data\suv_01_ext_03_co.paa"]],
            ["Orange", ["\a3\soft_f_gamma\SUV_01\Data\suv_01_ext_04_co.paa"]],
            ["Poly", ["textures\vehicles\civ\suv\poly.paa"]],
            ["Twitch", ["textures\vehicles\civ\suv\twitch.paa"], { false }],
            ["Christmas", ["textures\vehicles\civ\suv\christmas.paa"], { missionNamespace getVariable["XY_ssv_christmasSkinsEnabled", false] }],
            ["Deadpool", ["textures\vehicles\civ\suv\deadpool.paa"]],
            ["Marihuana", ["textures\vehicles\civ\suv\marihuana.paa"]],
            ["Hip-Hop", ["textures\vehicles\civ\suv\suv_hiphop_knippsa.paa"]],
            ["Rock", ["textures\vehicles\civ\suv\suv_rock_knippsa.paa"]],
            ["Scratchi", ["textures\vehicles\civ\suv\suv_scratchi_green_knippsa.paa"]],
            ["Terrorskull", ["textures\vehicles\civ\suv\suv_terrorskull_knippsa.paa"]],
            ["Tropical", ["textures\vehicles\civ\suv\suv_tropical2_knippsa.paa"]],
            ["Verflucht", ["textures\vehicles\civ\suv\suv_der_fluch_blau_knippsa.paa"]],
            ["Halloween", ["textures\vehicles\civ\suv\suv_halloween_knippsa.paa"], { false }]
        ]
    ];
    _return pushBack [
        "C_Van_01_box_F", [
            ["Weiß", ["\a3\soft_f_gamma\Van_01\Data\van_01_ext_co.paa", "\a3\soft_f_gamma\van_01\data\van_01_adds_co.paa"]],
            ["Rot", ["\a3\soft_f_gamma\Van_01\Data\van_01_ext_red_co.paa", "\a3\soft_f_gamma\van_01\data\van_01_adds_co.paa"]],
            ["Supermarkt", ["textures\vehicles\civ\van\box\truck_boxer_1_kabine_supermarkt_knippsa.paa","textures\vehicles\civ\van\box\truck_boxer_2_box_supermarkt_knippsa.paa"]],
            ["Brauerei", ["textures\vehicles\civ\van\box\truck_boxer_1_kabine_bier_knippsa.paa","textures\vehicles\civ\van\box\truck_boxer_2_box_bier_knippsa.paa"]],
            ["Pizzalieferant", ["textures\vehicles\civ\van\box\truck_boxer_1_kabine_pizza_knippsa.paa","textures\vehicles\civ\van\box\truck_boxer_2_box_pizza_knippsa.paa"]],
            ["Eismann", ["textures\vehicles\civ\van\box\truck_boxer_1_kabine_eismann_knippsa.paa","textures\vehicles\civ\van\box\truck_boxer_2_box_eismann_knippsa.paa"]],
            ["Bäcker", ["textures\vehicles\civ\van\box\truck_boxer_1_kabine_baecker_knippsa.paa","textures\vehicles\civ\van\box\truck_boxer_2_box_baecker_knippsa.paa"]],
            ["Bergbau", ["textures\vehicles\civ\van\box\truck_boxer_1_kabine_bergbau_knippsa.paa","textures\vehicles\civ\van\box\truck_boxer_2_box_bergbau_knippsa.paa"]]
        ]
    ];
    _return pushBack [
        "C_Van_01_transport_F", [
            ["Weiß", ["\a3\soft_f_gamma\Van_01\Data\van_01_ext_co.paa"]],
            ["Rot", ["\a3\soft_f_gamma\Van_01\Data\van_01_ext_red_co.paa"]]
        ]
    ];
    _return pushBack [
        "C_Van_01_fuel_F", [
            ["Dark Green", ["\a3\soft_f_gamma\Van_01\Data\van_01_ext_co.paa", "#(argb,8,8,3)color(0.13,0.31,0,0.55)"]],
            ["Rot", ["\a3\soft_f_gamma\Van_01\Data\van_01_ext_red_co.paa"]]
        ]
    ];
    _return pushBack [
        "B_Quadbike_01_F", [
            ["Rebellen", ["\a3\soft_f\quadbike_01\data\quadbike_01_opfor_co.paa"]],
            ["Schwarz", ["\a3\soft_f_beta\quadbike_01\data\quadbike_01_civ_black_co.paa"]],
            ["Blau", ["\a3\soft_f_beta\quadbike_01\data\quadbike_01_civ_blue_co.paa"]],
            ["Rot", ["\a3\soft_f_beta\quadbike_01\data\quadbike_01_civ_red_co.paa"]],
            ["Weiß", ["\a3\soft_f_beta\quadbike_01\data\quadbike_01_civ_white_co.paa"]],
            ["Independent", ["\a3\soft_f_beta\quadbike_01\data\quadbike_01_indp_co.paa"]],
            ["Hunter", ["\a3\soft_f_gamma\quadbike_01\data\quadbike_01_indp_hunter_co.paa"]]
        ]
    ];
    _return pushBack [
        "B_Heli_Light_01_F", [
            ["Black", ["\a3\air_f\Heli_Light_01\Data\heli_light_01_ext_ion_co.paa"]],
            ["Violet-Line", ["\a3\air_f\Heli_Light_01\Data\heli_light_01_ext_blue_co.paa"]],
            ["Red-Line", ["\a3\air_f\Heli_Light_01\Data\heli_light_01_ext_co.paa"]],
            ["Digi Camo", ["\a3\air_f\Heli_Light_01\Data\heli_light_01_ext_indp_co.paa"]],
            ["Blue Line", ["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_blueline_co.paa"]],
            ["Red-Tail", ["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_elliptical_co.paa"]],
            ["Furious", ["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_furious_co.paa"]],
            ["Jeans", ["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_jeans_co.paa"]],
            ["Speedy", ["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_speedy_co.paa"]],
            ["Sunset", ["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_sunset_co.paa"]],
            ["Vrana", ["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_vrana_co.paa"]],
            ["Wave", ["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_wave_co.paa"]],
            ["Digi Urban", ["\a3\air_f\Heli_Light_01\Data\Skins\heli_light_01_ext_digital_co.paa"]],
            ["Altis News", ["textures\vehicles\civ\humingbird\hummingbird_Altis_News_Knippsa.paa"]],
            ["Tropical", ["textures\vehicles\civ\humingbird\hummingbird_tropisch_Knippsa.paa"]]
        ]
    ];
    _return pushBack [
        "C_Heli_Light_01_civil_F", [
            ["Black", ["\a3\air_f\heli_light_01\data\heli_light_01_ext_ion_co.paa"]],
            ["Violet-Line", ["\a3\air_f\heli_light_01\data\heli_light_01_ext_blue_co.paa"]],
            ["Red-Line", ["\a3\air_f\heli_light_01\data\heli_light_01_ext_co.paa"]],
            ["Blue Line", ["\a3\air_f\heli_light_01\data\skins\heli_light_01_ext_blueline_co.paa"]],
            ["Red-Tail", ["\a3\air_f\heli_light_01\data\skins\heli_light_01_ext_elliptical_co.paa"]],
            ["Furious", ["\a3\air_f\heli_light_01\data\skins\heli_light_01_ext_furious_co.paa"]],
            ["Jeans", ["\a3\air_f\heli_light_01\data\skins\heli_light_01_ext_jeans_co.paa"]],
            ["Speedy", ["\a3\air_f\heli_light_01\data\skins\heli_light_01_ext_speedy_co.paa"]],
            ["Sunset", ["\a3\air_f\heli_light_01\data\skins\heli_light_01_ext_sunset_co.paa"]],
            ["Vrana", ["\a3\air_f\heli_light_01\data\skins\heli_light_01_ext_vrana_co.paa"]],
            ["Wave", ["\a3\air_f\heli_light_01\data\skins\heli_light_01_ext_wave_co.paa"]],
            ["Wasp", ["\a3\air_f\heli_light_01\data\skins\heli_light_01_ext_wasp_co.paa"]]
        ]
    ];
    _return pushBack [
        "C_Plane_Civil_01_F", [
            ["Racer (Braunes Leder)", ["a3\air_f_exp\plane_civil_01\data\btt_ext_01_racer_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_ext_02_racer_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_int_01_tan_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_int_02_tan_co.paa"]],
            ["Racer (Schwarzes Leder)", ["a3\air_f_exp\plane_civil_01\data\btt_ext_01_racer_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_ext_02_racer_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_int_01_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_int_02_co.paa"]],
            ["Red-Line (Braunes Leder)", ["a3\air_f_exp\plane_civil_01\data\btt_ext_01_redline_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_ext_02_redline_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_int_01_tan_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_int_02_tan_co.paa"]],
            ["Red-Line (Schwarzes Leder)", ["a3\air_f_exp\plane_civil_01\data\btt_ext_01_redline_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_ext_02_redline_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_int_01_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_int_02_co.paa"]],
            ["Tribal (Braunes Leder)", ["a3\air_f_exp\plane_civil_01\data\btt_ext_01_tribal_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_ext_02_tribal_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_int_01_tan_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_int_02_tan_co.paa"]],
            ["Tribal (Schwarzes Leder)", ["a3\air_f_exp\plane_civil_01\data\btt_ext_01_tribal_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_ext_02_tribal_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_int_01_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_int_02_co.paa"]],
            ["Blue Wave (Braunes Leder)", ["a3\air_f_exp\plane_civil_01\data\btt_ext_01_wave_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_ext_02_wave_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_int_01_tan_co.paa","a3\air_f_exp\plane_civil_01\data\btt_int_02_tan_co.paa"]],
            ["Blue Wave (Schwarzes Leder)", ["a3\air_f_exp\plane_civil_01\data\btt_ext_01_wave_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_ext_02_wave_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_int_01_co.paa", "a3\air_f_exp\plane_civil_01\data\btt_int_02_co.paa"]]
        ]
    ];
    _return pushBack [
        "O_Heli_Light_02_unarmed_F", [
            ["Black and White", ["\a3\air_f_heli\heli_light_02\data\heli_light_02_ext_opfor_v2_co.paa"]],
            ["Blue", ["\a3\air_f\heli_light_02\data\heli_light_02_ext_civilian_co.paa"]],
            ["Digi Camo", ["\a3\air_f\heli_light_02\data\heli_light_02_ext_indp_co.paa"]],
            ["Hex Camo", ["\a3\air_f\heli_light_02\data\heli_light_02_ext_opfor_co.paa"]]
        ]
    ];
    _return pushBack [
        "B_Truck_01_ammo_F", [
            ["Schlümpfe", ["textures\vehicles\civ\hemtt\smurf_0.paa", "textures\vehicles\civ\hemtt\smurf_1.paa", "textures\vehicles\civ\hemtt\smurf_2.paa"], { false }],
            ["Twitch", ["textures\vehicles\civ\hemtt\twitch_0.paa", "textures\vehicles\civ\hemtt\twitch_1.paa"], { false }]
        ]
    ];
    _return pushBack [
        "B_Heli_Transport_03_unarmed_green_F", [
            ["Blackline", ["#(argb,8,8,3)color(0,0,0,0.3)", "#(argb,8,8,3)color(0,0,0,0.3)"]]
        ]
    ];
    _return pushBack [
        "I_Truck_02_transport_F", [
            ["Orange/Blau", ["\A3\Soft_F_Beta\Truck_02\data\truck_02_kab_co.paa", "\a3\soft_f_beta\Truck_02\data\truck_02_kuz_co.paa"]],
            ["Blackline", ["#(argb,8,8,3)color(0.05,0.05,0.05,1)"]]
        ]
    ];
    _return pushBack [
        "I_Heli_light_03_unarmed_F", [
            ["Zivil", ["A3\Air_F_EPB\Heli_Light_03\data\Heli_Light_03_base_CO.paa"]],
            ["Rebell", ["A3\Air_F_EPB\Heli_Light_03\data\Heli_Light_03_base_INDP_CO.paa"]]
        ]
    ];
    _return pushBack [
        "I_Truck_02_covered_F", [
            ["Orange/Blau", ["\A3\Soft_F_Beta\Truck_02\data\truck_02_kab_co.paa", "\a3\soft_f_beta\Truck_02\data\truck_02_kuz_co.paa"]],
            ["Blackline", ["#(argb,8,8,3)color(0.05,0.05,0.05,1)"]],
            ["Twitch", ["textures\vehicles\civ\zamak\twitch_0.paa", "textures\vehicles\civ\zamak\twitch_1.paa"], { false }]
        ]
    ];
    _return;
};

if( _side isEqualTo west ) exitWith {
    _return pushBack [
        "B_Heli_Transport_01_F", [
            ["Polizei", ["textures\vehicles\cop\cop_ghosthawk_front.paa", "textures\vehicles\cop\cop_ghosthawk_back.paa"]]
        ]
    ];
    _return pushBack [
        "I_MRAP_03_F", [
            ["Polizei", ["textures\vehicles\cop\cop_strider.paa"]]
        ]
    ];
    _return pushBack [
        "C_Hatchback_01_F", [
            ["Polizei", ["textures\vehicles\cop\cop_hatchback.paa"]]
        ]
    ];
    _return pushBack [
        "C_Hatchback_01_sport_F", [
            ["Polizei", ["textures\vehicles\cop\cop_hatchback.paa"]],
            ["Rot", ["\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_sport01_co.paa"]],
            ["Dunkelblau", ["\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_sport02_co.paa"]],
            ["Orange", ["\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_sport03_co.paa"]],
            ["Schwarz-Weiß", ["\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_sport04_co.paa"]],
            ["Impulse", ["\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_sport05_co.paa"]],
            ["Grün", ["\a3\soft_f_gamma\Hatchback_01\data\hatchback_01_ext_sport06_co.paa"]],
            ["Christmas Minions", ["textures\vehicles\civ\hatchback\minions.paa"], { missionNamespace getVariable["XY_ssv_christmasSkinsEnabled", false] }]
        ]
    ];

    _return pushBack [
        "B_T_LSV_01_unarmed_F", [
            ["Polizei", ["textures\vehicles\cop\Prowler_0_Polizei_Knippsa.paa", "textures\vehicles\cop\Prowler_1_Polizei_Knippsa.paa", "textures\vehicles\cop\Prowler_2_Polizei_Knippsa.paa", "textures\vehicles\cop\Prowler_3_Polizei_Knippsa.paa"]]
        ]
    ];


    _return pushBack [
        "C_Offroad_01_F", [
            ["Polizei", ["textures\vehicles\cop\cop_offroad.paa"]]
        ]
    ];
    _return pushBack [
        "C_SUV_01_F", [
            ["Polizei", ["textures\vehicles\cop\cop_suv.paa"]],
            ["Dunkelrot", ["\a3\soft_f_gamma\SUV_01\Data\suv_01_ext_co.paa"]],
            ["Schwarz", ["\a3\soft_f_gamma\SUV_01\Data\suv_01_ext_02_co.paa"]],
            ["Silber", ["\a3\soft_f_gamma\SUV_01\Data\suv_01_ext_03_co.paa"]],
            ["Orange", ["\a3\soft_f_gamma\SUV_01\Data\suv_01_ext_04_co.paa"]],
            ["Hip-Hop", ["textures\vehicles\civ\suv\suv_hiphop_knippsa.paa"]],
            ["Rock", ["textures\vehicles\civ\suv\suv_rock_knippsa.paa"]],
            ["Scratchi", ["textures\vehicles\civ\suv\suv_scratchi_green_knippsa.paa"]],
            ["Terrorskull", ["textures\vehicles\civ\suv\suv_terrorskull_knippsa.paa"]],
            ["Tropical", ["textures\vehicles\civ\suv\suv_tropical2_knippsa.paa"]],
            ["Verflucht", ["textures\vehicles\civ\suv\suv_der_fluch_blau_knippsa.paa"]],
            ["Christmas", ["textures\vehicles\civ\suv\christmas.paa"], { missionNamespace getVariable["XY_ssv_christmasSkinsEnabled", false] }]
        ]
    ];
    _return pushBack [
        "B_MRAP_01_F", [
            ["Polizei", ["textures\vehicles\cop\cop_hunter_front.paa", "textures\vehicles\cop\cop_hunter_back.paa"]]
        ]
    ];
    _return pushBack [
        "B_Quadbike_01_F", [
            ["Polizei", ["textures\vehicles\cop\cop_quad.paa"]]
        ]
    ];
    _return pushBack [
        "B_Heli_Light_01_F", [
            ["Polizei", ["textures\vehicles\cop\cop_littlebird.paa"]],
            ["Black", ["\a3\air_f\Heli_Light_01\Data\heli_light_01_ext_ion_co.paa"]]
        ]
    ];
    _return pushBack [
        "O_Heli_Light_02_unarmed_F", [
            ["SEK", ["textures\vehicles\cop\cop_sek_orca.paa"], { ["cop_sek"] call XY_fnc_hasLicense }]
        ]
    ];
    _return pushBack [
        "I_Heli_light_03_unarmed_F", [
            ["Polizei", ["textures\vehicles\cop\cop_hellcat.paa"]]
        ]
    ];
    _return pushBack [
        "B_MRAP_01_hmg_F", [
            ["Polizei", ["textures\vehicles\cop\cop_hunter_front.paa", "textures\vehicles\cop\cop_hunter_back.paa"]]
        ]
    ];
    _return pushBack [
        "I_Truck_02_covered_F", [
            ["Jail", ["textures\vehicles\cop\cop_zamak_jail_covered_1.paa", "textures\vehicles\cop\cop_zamak_jail_covered_2.paa"]]
        ]
    ];
    _return pushBack [
        "B_Heli_Transport_03_unarmed_F", [
            ["Polizei", ["textures\vehicles\cop\cop_huron_front.paa", "textures\vehicles\cop\cop_huron_back.paa"]]
        ]
    ];
    _return pushBack [
        "I_Truck_02_ammo_F", [
            ["Sondereinheit", ["textures\vehicles\cop\cop_zamak_rep_covered_1.paa", "textures\vehicles\cop\cop_zamak_rep_covered_2.paa"]]
        ]
    ];
    _return;
};
if( _side isEqualTo independent ) exitWith {
    _return pushBack [
        "I_MRAP_03_F", [
            ["Sanitäter", ["textures\vehicles\medic\medic_strider.paa"]]
        ]
    ];
    _return pushBack [
        "C_Offroad_01_F", [
            ["Sanitäter", ["textures\vehicles\medic\medic_offroad.paa"]]
        ]
    ];

    _return pushBack [
        "C_SUV_01_F", [
            ["Sanitäter", ["textures\vehicles\medic\medic_suv.paa"]]
        ]
    ];
    _return pushBack [
        "C_Hatchback_01_sport_F", [
            ["Sanitäter", ["textures\vehicles\medic\medic_hatchback.paa"]]
        ]
    ];
    _return pushBack [
        "C_Van_01_box_F", [
            ["Sanitäter", ["textures\vehicles\medic\medic_boxer_0.paa", "textures\vehicles\medic\medic_boxer_1.paa"]]
        ]
    ];

    _return pushBack [
        "B_Heli_Light_01_F", [
            ["Sanitäter", ["textures\vehicles\medic\medic_hummingbird.paa"]]
        ]
    ];
    _return pushBack [
        "O_Heli_Light_02_unarmed_F", [
            ["Sanitäter", ["textures\vehicles\medic\medic_orca.paa"]]
        ]
    ];
    _return pushBack [
        "I_Heli_light_03_unarmed_F", [
            ["SAR", ["textures\vehicles\medic\medic_hellcat_sar.paa"]]
        ]
    ];
    _return pushBack [
        "B_MRAP_01_F", [
            ["Sanitäter", ["textures\vehicles\medic\medic_hunter_1.paa"]]
        ]
    ];
    _return;
};

_return;