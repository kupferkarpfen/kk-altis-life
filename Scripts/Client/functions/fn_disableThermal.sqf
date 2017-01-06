// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

XY_DT_ACTIVE = false;
addMissionEventHandler ["EachFrame", {
    if( (currentVisionMode player) > 1 && { (cameraOn isEqualTo player) || !((typeOf cameraOn) in ["O_Heli_Transport_04_covered_F", "I_Heli_light_03_unarmed_F", "I_MRAP_03_F", "B_T_UAV_03_F"]) } ) then {
        if( !XY_DT_ACTIVE ) then {
            XY_DT_ACTIVE = true;
            333 cutText ["Thermalsicht ist offline", "BLACK", 0.0001];
        };
    } else {
        if( XY_DT_ACTIVE ) then {
            XY_DT_ACTIVE = false;
            333 cutText ["", "PLAIN", 0.5];
        };
    };
}];