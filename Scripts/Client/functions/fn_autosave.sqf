// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _nextAutosave = time + 60;
while { true } do {

    uisleep 1;

    private _timeLeft = 0;
    if( (XY_RTC_SHUTDOWNTIME - serverTime) < 60 ) then {
        call XY_fnc_save;
    };

    if( _nextAutosave <= time || XY_forceSaveTime > 0 && XY_forceSaveTime <= time ) then {
        XY_forceSaveTime = 0;
        _nextAutosave = time + 60 + (random 60);
        call XY_fnc_save;
    };
};