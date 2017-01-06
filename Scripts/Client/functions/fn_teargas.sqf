// Teargas
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

while { true } do {
    private _smokeShells = (player nearObjects ["SmokeShellRed", 12]);
    if( !(_smokeShells isEqualTo []) && { ((vest player) != "V_PlateCarrier1_blk" || playerSide isEqualTo civilian) } ) then {
        XY_tearGasActive = true;

        private _directVision = false;
        if( !((goggles player) isEqualTo "G_Combat") )then {
            {
                if( (player distance _x) < 3 || { !(lineIntersects [eyePos player, getPos _x, player, _x]) } ) exitWith {
                    _directVision = true;
                };
            } forEach _smokeShells;
        };

        "dynamicBlur" ppEffectEnable true;
        if( _directVision ) then {
            "dynamicBlur" ppEffectAdjust [3];
            addCamShake [10, 10, 2];
            5 fadeSound (0.15 min XY_soundTarget);
        } else {
            "dynamicBlur" ppEffectAdjust [1];
            addCamShake [2, 5, 2];
            5 fadeSound (0.5 min XY_soundTarget);
        };
        "dynamicBlur" ppEffectCommit 15;
        player setFatigue 1;

    } else {
        if( XY_tearGasActive ) then {
            XY_tearGasActive = false;
             "dynamicBlur" ppEffectEnable true;
             "dynamicBlur" ppEffectAdjust [0];
             "dynamicBlur" ppEffectCommit 15;
             15 fadeSound XY_soundTarget;
        };
    };
    uisleep 2;
};