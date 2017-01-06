// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _accelDay = round(1 + (random 7));
private _accelNight = round(8 + (random 8));

diag_log format["<ACCEL> Time accelerator, day %1, night %2", _accelDay, _accelNight];

diag_log format[ "<ACCEL> Jumping from %1 to %2, by %3", daytime, XY_ssv_daytime, XY_ssv_daytime - daytime ];
skipTime (XY_ssv_daytime - daytime);
diag_log format["<ACCEL> Skipped to %1...", daytime];

XY_enableAutoTimeMultiplier = true;
while { XY_enableAutoTimeMultiplier } do {
    if( sunOrMoon == 0 && timeMultiplier != _accelNight ) then {
        setTimeMultiplier _accelNight;
        diag_log format["<ACCEL> NIGHT ACCEL: %1", timeMultiplier];
    };
    if( sunOrMoon == 1 && timeMultiplier != _accelDay ) then {
        setTimeMultiplier _accelDay;
        diag_log format["<ACCEL> DAY ACCEL: %1", timeMultiplier];
    };
    uisleep 90;
};