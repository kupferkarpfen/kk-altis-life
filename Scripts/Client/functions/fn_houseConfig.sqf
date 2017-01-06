// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _house = param[ 0, "", [""] ];

switch ( _house ) do {

    case "Land_i_Garage_V1_F";
    case "Land_i_Garage_V2_F": { [100000, 0] };

    case "Land_i_Stone_HouseSmall_V2_F";
    case "Land_i_Stone_HouseSmall_V1_F";
    case "Land_i_Stone_HouseSmall_V3_F": { [150000, 1] };

    case "Land_i_House_Small_02_V1_F";
    case "Land_i_House_Small_02_V2_F";
    case "Land_i_House_Small_02_V3_F";
    case "Land_i_House_Small_01_V1_F";
    case "Land_i_House_Small_01_V2_F";
    case "Land_i_House_Small_01_V3_F": { [300000, 2] };

    case "Land_i_House_Big_02_V1_F";
    case "Land_i_House_Big_02_V2_F";
    case "Land_i_House_Big_02_V3_F";
    case "Land_i_House_Small_03_V1_F": { [450000, 3] };

    case "Land_i_House_Big_01_V1_F";
    case "Land_i_House_Big_01_V2_F";
    case "Land_i_House_Big_01_V3_F": { [600000, 4] };

    default { [] };
};