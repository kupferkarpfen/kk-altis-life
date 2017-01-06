// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

/*
XY_clothingShops = [

];

_clothes = switch (XY_clothingStore) do {
    case "civ": { [ "Seriöse Bekleidung", XY_clothing_civilian select _selection ] };
    case "cop": { [ "Dienstbekleidung" , XY_clothing_cop select _selection ] };
    case "reb": { [ "Unseriöse Bekleidung", XY_clothing_rebel select _selection ] };
    case "med": { [ "Sanitäter-Bedarf", XY_clothing_medic select _selection ] };
    case "kart": { ["Racing-Outfits", XY_clothing_kart select _selection ] };
    case "dive": { ["Tauch-Shop", XY_clothing_dive select _selection ] };
    default { [] };
};
*/

XY_clothing_civilian = [
    [
        [ "U_C_Poloshirt_blue", nil, 15],
        [ "U_C_Poloshirt_burgundy", "Poloshirt Burgundy", 15],
        [ "U_C_Poloshirt_redwhite", "Poloshirt Red/White", 15],
        [ "U_C_Poloshirt_salmon", "Poloshirt Salmon", 15],
        [ "U_C_Poloshirt_stripped", "Poloshirt stripped", 15],
        [ "U_C_Poloshirt_tricolour", "Poloshirt Tricolor", 15],
        [ "U_C_Poor_1", "Gebrauchte Kleidung", 5],
        [ "U_IG_Guerilla2_1", nil, 90],
        [ "U_IG_Guerilla2_2", nil, 90],
        [ "U_IG_Guerilla2_3", nil, 90],
        [ "U_IG_Guerilla3_1", nil, 90],
        [ "U_IG_Guerilla3_2", nil, 90],
        [ "U_I_C_Soldier_Bandit_1_F", nil, 95],
        [ "U_I_C_Soldier_Bandit_2_F", nil, 95],
        [ "U_I_C_Soldier_Bandit_3_F", nil, 95],
        [ "U_I_C_Soldier_Bandit_4_F", nil, 95],
        [ "U_I_C_Soldier_Bandit_5_F", nil, 95],
        [ "U_NikosBody", nil, 80],
        [ "U_C_Man_casual_1_F", nil, 65],
        [ "U_C_Man_casual_2_F", nil, 65],
        [ "U_C_Man_casual_3_F", nil, 65],
        [ "U_Rangemaster", nil, 40],
        [ "U_C_HunterBody_grn", nil, 100],
        [ "U_Competitor", nil, 60],
        [ "U_C_Journalist", nil, 60],
        [ "U_OrestesBody", nil, 65],
        [ "U_C_man_sport_1_F", nil, 75],
        [ "U_C_man_sport_2_F", nil, 75],
        [ "U_C_man_sport_3_F", nil, 75],
        [ "U_NikosAgedBody", "Anzug", 250],
        [ "U_Marshal", nil, 50],

        [ "U_B_Wetsuit", nil, 150, { license_civ_dive } ],

        [ "U_C_WorkerCoveralls", "Strahlenschutzanzug", 1500]

    ], [
        [ "H_Bandanna_camo", nil, 8],
        [ "H_Bandanna_surfer", nil, 8],
        [ "H_Bandanna_gry", nil, 8],
        [ "H_Bandanna_cbr", nil, 8],
        [ "H_Bandanna_surfer", nil, 8],
        [ "H_Bandanna_khk", nil, 8],
        [ "H_Bandanna_sgg", nil, 8],
        [ "H_StrawHat", nil, 7],
        [ "H_Booniehat_tan", nil, 6],
        [ "H_Hat_blue", nil, 9],
        [ "H_Hat_brown", nil, 9],
        [ "H_Hat_checker", nil, 9],
        [ "H_Hat_grey", nil, 9],
        [ "H_Hat_tan", nil, 9],
        [ "H_Cap_blu", nil, 5],
        [ "H_Cap_grn", nil, 5],
        [ "H_Cap_grn_BI", nil, 5],
        [ "H_Cap_oli", nil, 5],
        [ "H_Cap_red", nil, 5],
        [ "H_Cap_tan", nil, 5],
        [ "H_Helmet_Skate", nil, 5],
        [ "H_CrewHelmetHeli_O", "Strahlenschutzhelm", 250 ]
    ], [
        [ "G_Shades_Black", nil, 12],
        [ "G_Shades_Blue", nil, 12],
        [ "G_Sport_Blackred", nil, 13],
        [ "G_Sport_Checkered", nil, 13],
        [ "G_Sport_Blackyellow", nil, 13],
        [ "G_Sport_BlackWhite", nil, 13],
        [ "G_Squares", nil, 9],
        [ "G_Aviator", nil, 15],
        [ "G_Lady_Mirror", nil, 9],
        [ "G_Lady_Dark", nil, 9],
        [ "G_Lady_Blue", nil, 9],
        [ "G_Lowprofile", nil, 15],

        [ "G_Diving", nil, 25, { license_civ_dive } ]
    ], [
        [ "V_RebreatherB", nil, 600, { license_civ_dive }]
    ], [
        [ "B_AssaultPack_cbr", nil, 25],
        [ "B_Kitbag_mcamo", nil, 45],
        [ "B_TacticalPack_oli", nil, 35],
        [ "B_FieldPack_ocamo", nil, 30],
        [ "B_Kitbag_cbr", nil, 45],
        [ "B_Carryall_oli", nil, 50],
        [ "B_Carryall_khk", nil, 50]
    ]
];

XY_clothing_rebel = [
    [
        [ "U_BG_Guerilla1_1", nil, 150],
        [ "U_BG_Guerrilla_6_1", nil, 150],

        [ "U_I_CombatUniform", nil, 250],
        [ "U_I_CombatUniform_shortsleeve", nil, 250],

        [ "U_I_G_Story_Protagonist_F", nil, 300],
        [ "U_BG_leader", nil, 300],
        [ "U_I_G_resistanceLeader_F", nil, 400],
        [ "U_B_CombatUniform_mcam_vest", nil, 450],

        [ "U_B_PilotCoveralls", nil, 500],
        [ "U_O_PilotCoveralls", nil, 500],

        [ "U_B_CTRG_Soldier_urb_1_F", nil, 750],
        [ "U_B_CTRG_Soldier_urb_2_F", nil, 750],
        [ "U_B_CTRG_Soldier_urb_3_F", nil, 750],

        [ "U_O_OfficerUniform_ocamo", nil, 600],
        [ "U_I_OfficerUniform", nil, 1500],

        [ "U_B_T_Soldier_F", nil, 1500],
        [ "U_B_T_Soldier_AR_F", nil, 1500],

        [ "U_O_CombatUniform_ocamo", nil, 1500],
        [ "U_O_CombatUniform_oucamo", nil, 1500],

        [ "U_I_C_Soldier_Para_1_F", nil, 1000],
        [ "U_I_C_Soldier_Para_2_F", nil, 1000],
        [ "U_I_C_Soldier_Para_3_F", nil, 1000],
        [ "U_I_C_Soldier_Para_4_F", nil, 1000],
        [ "U_I_C_Soldier_Para_5_F", nil, 1000],
        [ "U_O_T_Officer_F", nil, 1500],

        [ "U_O_SpecopsUniform_ocamo", nil, 1750],

        [ "U_B_CTRG_Soldier_F", nil, 1750],
        [ "U_B_CTRG_Soldier_2_F", nil, 1750],
        [ "U_B_CTRG_Soldier_3_F", nil, 1750],

        [ "U_I_GhillieSuit", nil, 2250],
        [ "U_O_GhillieSuit", nil, 2250],
        [ "U_B_GhillieSuit", nil, 2250],

        [ "U_B_FullGhillie_ard", nil, 3500],
        [ "U_B_FullGhillie_sard", nil, 3500],
        [ "U_B_FullGhillie_lsh", nil, 3500],

        [ "U_I_FullGhillie_ard", nil, 3500],
        [ "U_I_FullGhillie_sard", nil, 3500],
        [ "U_I_FullGhillie_lsh", nil, 3500],

        [ "U_O_FullGhillie_ard", nil, 3500],
        [ "U_O_FullGhillie_sard", nil, 3500],
        [ "U_O_FullGhillie_lsh", nil, 3500]

    ], [
        // Helmets
        [ "H_Booniehat_dgtl", nil, 75 ],
        [ "H_Booniehat_tna_F", nil, 75 ],
        [ "H_Cap_brn_SPECOPS", nil, 25 ],
        [ "H_Cap_tan_specops_US", nil, 25 ],
        [ "H_Cap_khaki_specops_UK", nil, 25 ],
        [ "H_Cap_blk_Raven", nil, 25 ],
        [ "H_MilCap_ghex_F", nil, 25 ],
        [ "H_MilCap_tna_F", nil, 25 ],
        [ "H_MilCap_oucamo", nil, 25 ],
        [ "H_Bandanna_camo", nil, 25 ],
        [ "H_Bandanna_mcamo", nil, 25 ],
        [ "H_Shemag_tan", nil, 95 ],
        [ "H_Shemag_khk", nil, 95 ],
        [ "H_ShemagOpen_khk", nil, 95 ],
        [ "H_Shemag_olive", nil, 95 ],
        [ "H_HelmetO_ocamo", nil, 75 ],
        [ "H_HelmetB_tna_F", nil, 75 ],
        [ "H_HelmetB_Light_tna_F", nil, 75 ],
        [ "H_HelmetSpecO_ghex_F", nil, 75 ],
        [ "H_HelmetO_ghex_F", nil, 75 ],
        [ "H_HelmetB_TI_tna_F", nil, 750 ],
        [ "H_HelmetLeaderO_ghex_F", nil, 75 ],
        [ "H_HelmetB_Enh_tna_F", nil, 75 ],
        [ "H_PilotHelmetHeli_I", nil, 75 ],
        [ "H_CrewHelmetHeli_I", nil, 75 ],
        [ "H_PilotHelmetFighter_B", nil, 750 ]

    ], [
        // Goggles
        [ "G_Shades_Black", nil, 7 ],
        [ "G_Shades_Blue", nil, 8 ],
        [ "G_Sport_Blackred", nil, 7 ],
        [ "G_Sport_Checkered", nil, 8 ],
        [ "G_Sport_Blackyellow", nil, 8 ],
        [ "G_Sport_BlackWhite", nil, 8 ],
        [ "G_Squares", nil, 9 ],
        [ "G_Lowprofile", nil, 12 ],
        [ "G_Bandanna_beast", nil, 12 ],
        [ "G_Bandanna_tan", nil, 12 ],
        [ "G_Bandanna_khk", nil, 12],
        [ "G_Bandanna_oli", nil, 12 ],
        [ "G_Bandanna_blk", nil, 12 ],
        [ "G_Balaclava_oli", nil, 1500 ],
        [ "G_Balaclava_blk", nil, 1500 ],
        [ "G_Tactical_Clear", nil, 11 ],
        [ "G_Tactical_Black", nil, 11 ]

    ], [
        // Vests
        [ "V_TacVest_khk", nil, 125],
        [ "V_PlateCarrierIA2_dgtl", nil, 500],
        [ "V_PlateCarrier1_blk", "Blackwater", 500],
        [ "V_TacVest_camo", nil, 105],
        [ "V_BandollierB_cbr", nil, 45],
        [ "V_I_G_resistanceLeader_F", nil, 105],
        [ "V_HarnessO_brn", nil, 75],

        [ "V_HarnessOGL_brn", "Bombenweste", 22500]

    ], [
        // Backpacks
        [ "B_AssaultPack_cbr", nil, 25 ],
        [ "B_Kitbag_mcamo", nil, 45 ],
        [ "B_TacticalPack_oli", nil, 35 ],
        [ "B_FieldPack_ocamo", nil, 30 ],
        [ "B_FieldPack_blk", nil, 75 ],
        [ "B_Bergen_sgg", nil, 45 ],
        [ "B_Bergen_blk", "Blackwater", 75 ],
        [ "B_Kitbag_cbr", nil, 45 ],
        [ "B_Carryall_oli", nil, 50 ],
        [ "B_Carryall_khk", nil, 50 ],
        [ "B_Parachute", "Fallschirm", 700 ]
    ]
];

XY_clothing_cop = [
    [
        [ "U_B_CombatUniform_mcam_vest", "Einsatzkleidung", 90 ],
        [ "U_B_GEN_Soldier_F", "SEK", 100, { ["cop_sek"] call XY_fnc_hasLicense } ],
        [ "U_B_GEN_Commander_F", "SEK", 100, { ["cop_sek"] call XY_fnc_hasLicense } ],
        [ "U_O_Wetsuit", "Taucheranzug", 15, { XY_copLevel > 2 } ],
        [ "U_C_Poloshirt_burgundy", nil, 5, { XY_copLevel > 2 } ],
        [ "U_C_Poloshirt_redwhite", nil, 5, { XY_copLevel > 2 } ],
        [ "U_C_Poloshirt_salmon", nil, 5, { XY_copLevel > 2 } ],
        [ "U_C_Poloshirt_stripped", nil, 5, { XY_copLevel > 2 } ],
        [ "U_C_Poloshirt_tricolour", nil, 5, { XY_copLevel > 2 } ],
        [ "U_C_Poor_1", "Gebrauchte Kleidung", 5, { XY_copLevel > 2 } ],
        [ "U_IG_Guerilla2_1", nil, 60, { XY_copLevel > 2 } ],
        [ "U_IG_Guerilla2_2", nil, 60, { XY_copLevel > 2 } ],
        [ "U_IG_Guerilla2_3", nil, 60, { XY_copLevel > 2 } ],
        [ "U_IG_Guerilla3_1", nil, 60, { XY_copLevel > 2 } ],
        [ "U_IG_Guerilla3_2", nil, 60, { XY_copLevel > 2 } ],
        [ "U_NikosBody", nil, 60, { XY_copLevel > 2 } ],

        [ "U_O_OfficerUniform_ocamo", nil, 600, { XY_copLevel > 5 }],
        [ "U_I_OfficerUniform", nil, 1500, { XY_copLevel > 5 }],

        [ "U_B_T_Soldier_F", nil, 1500, { XY_copLevel > 5 }],
        [ "U_B_T_Soldier_AR_F", nil, 1500, { XY_copLevel > 5 }],

        [ "U_O_CombatUniform_ocamo", nil, 1500, { XY_copLevel > 5 }],
        [ "U_O_CombatUniform_oucamo", nil, 1500, { XY_copLevel > 5 }],

        [ "U_I_C_Soldier_Para_1_F", nil, 1000, { XY_copLevel > 5 }],
        [ "U_I_C_Soldier_Para_2_F", nil, 1000, { XY_copLevel > 5 }],
        [ "U_I_C_Soldier_Para_3_F", nil, 1000, { XY_copLevel > 5 }],
        [ "U_I_C_Soldier_Para_4_F", nil, 1000, { XY_copLevel > 5 }],
        [ "U_I_C_Soldier_Para_5_F", nil, 1000, { XY_copLevel > 5 }],
        [ "U_O_T_Officer_F", nil, 1500, { XY_copLevel > 5 }],

        [ "U_O_SpecopsUniform_ocamo", nil, 1750, { XY_copLevel > 5 }],

        [ "U_B_CTRG_Soldier_F", nil, 1750, { XY_copLevel > 5 }],
        [ "U_B_CTRG_Soldier_2_F", nil, 1750, { XY_copLevel > 5 }],
        [ "U_B_CTRG_Soldier_3_F", nil, 1750, { XY_copLevel > 5 }]

    ], [
        [ "H_Beret_blk_POLICE", nil, 5, { XY_copLevel > 0 } ],
        [ "H_Beret_02", nil, 5, { XY_copLevel > 1 } ],
        [ "H_MilCap_gry", nil, 5, { XY_copLevel > 2 } ],
        [ "H_MilCap_blue", nil, 5, { XY_copLevel > 2 } ],
        [ "H_Cap_blk", nil, 5, { XY_copLevel > 2 } ],
        [ "H_Watchcap_blk", "SEK", 12, { ["cop_sek"] call XY_fnc_hasLicense } ],
        [ "H_PilotHelmetHeli_B", nil, 90, { XY_copLevel > 2 } ],
        [ "H_CrewHelmetHeli_B", nil, 90, { XY_copLevel > 2 } ],
        [ "H_Beret_Colonel", nil, 15, { XY_copLevel > 7 } ]
    ], [
        [ "G_Diving", nil, 25 ],
        [ "G_Shades_Black", nil, 7 ],
        [ "G_Shades_Blue", nil, 7 ],
        [ "G_Sport_Blackred", nil, 9 ],
        [ "G_Sport_Checkered", nil, 9 ],
        [ "G_Sport_Blackyellow", nil, 9 ],
        [ "G_Sport_BlackWhite", nil, 9 ],
        [ "G_Aviator", nil, 13 ],
        [ "G_Squares", nil, 9 ],
        [ "G_Lowprofile", nil, 9 ],
        [ "G_Bandanna_blk", nil, 100, { XY_copLevel > 3 } ],
        [ "G_Bandanna_aviator", "SEK", 120, { ["cop_sek"] call XY_fnc_hasLicense } ],
        [ "G_Balaclava_oli", nil, 1500, { XY_copLevel > 4 } ],
        [ "G_Balaclava_blk", nil, 1500, { XY_copLevel > 4 } ]
    ], [
        [ "V_RebreatherB", nil, 600 ],
        [ "V_PlateCarrier1_blk", "Antigasweste", 85 ]
    ], [
        [ "B_Bergen_Base", nil, 80 ],
        [ "B_Parachute", "Fallschirm", 800 ]
    ]
];

XY_clothing_kart = [
    [
        ["U_C_Driver_1_black", nil, 120],
        ["U_C_Driver_1_blue", nil, 120],
        ["U_C_Driver_1_red", nil, 120],
        ["U_C_Driver_1_orange", nil, 120],
        ["U_C_Driver_1_green", nil, 120],
        ["U_C_Driver_1_white", nil, 120],
        ["U_C_Driver_1_yellow", nil, 120],
        ["U_C_Driver_2", nil, 120],
        ["U_C_Driver_1", nil, 120],
        ["U_C_Driver_3", nil, 120],
        ["U_C_Driver_4", nil, 120]
    ], [
        ["H_RacingHelmet_1_black_F", nil, 70],
        ["H_RacingHelmet_1_red_F", nil, 70],
        ["H_RacingHelmet_1_white_F", nil, 70],
        ["H_RacingHelmet_1_blue_F", nil, 70],
        ["H_RacingHelmet_1_yellow_F", nil, 70],
        ["H_RacingHelmet_1_green_F", nil, 70],
        ["H_RacingHelmet_1_F", nil, 70],
        ["H_RacingHelmet_2_F", nil, 70],
        ["H_RacingHelmet_3_F", nil, 70],
        ["H_RacingHelmet_4_F", nil, 70]
    ], [
    ], [
    ], [
    ]
];

XY_clothing_dive = [
    [
        [ "U_B_Wetsuit", nil, 125, { license_civ_dive } ]
    ], [
    ], [
        [ "G_Diving", nil, 25, { license_civ_dive } ]
    ], [
        [ "V_RebreatherB", nil, 600, { license_civ_dive } ]
    ], [
    ]
];

XY_clothing_medic = [
    [
        [ "U_B_CTRG_1", "Einsatzkleidung", 75],
        [ "U_I_Wetsuit", nil, 175 ]
    ], [
        [ "H_Cap_red", nil, 5],
        [ "H_Cap_marshal", nil, 5],
        [ "H_Beret_02", nil, 5 ],
        [ "H_MilCap_gry", nil, 5 ],
        [ "H_MilCap_blue", nil, 4 ],
        [ "H_Cap_blk", nil, 3 ],
        [ "H_Watchcap_blk", nil, 3 ],
        [ "H_Booniehat_tna_F", nil, 5 ],
        [ "H_Booniehat_tan", nil, 5 ],
        [ "H_Booniehat_dgtl", nil, 5 ],
        [ "H_PilotHelmetHeli_B", nil, 7 ],
        [ "H_CrewHelmetHeli_B", nil, 7 ],
        [ "H_Beret_Colonel", nil, 15 ]
    ], [
        [ "G_Diving", nil, 5 ],
        [ "G_Shades_Black", nil, 12 ],
        [ "G_Shades_Blue", nil, 12 ],
        [ "G_Sport_Blackred", nil, 9 ],
        [ "G_Sport_Checkered", nil, 9 ],
        [ "G_Sport_Blackyellow", nil, 9 ],
        [ "G_Sport_BlackWhite", nil, 9 ],
        [ "G_Aviator", nil, 9 ],
        [ "G_Squares", nil, 9 ],
        [ "G_Lowprofile", nil, 9 ]
    ], [
        [ "V_RebreatherIA", nil, 600 ]
    ], [
        [ "B_Bergen_mcamo", nil, 40 ]
    ]
];