// weather script
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _weather = [];

// Add your weather scripts to the _weather master...
_weather pushBack {

    private _minutes = round(60 + (random 90));
    diag_log format[ "<WEATHER> Making it sunny for %1 minutes", _minutes ];

    private _endTime = time + (_minutes * 60);
    while { time < _endTime } do {
        900 setOvercast 0;
        900 setRain 0;
        900 setLightnings 0;
        900 setFog 0;
        uisleep 900;
    };

    diag_log "<WEATHER> Sunny period ended";
};

_weather pushBack {

    private _minutes = round(60 + (random 90));
    diag_log format[ "<WEATHER> Making it lightly overcast for %1 minutes", _minutes ];

    private _endTime = time + (_minutes * 60);
    while { time < _endTime } do {
        900 setOvercast 0.2;
        900 setRain 0;
        900 setLightnings 0;
        900 setFog 0;
        uisleep 900;
    };

    diag_log "<WEATHER> Overcast period ended";
};

_weather pushBack {

    if( (random 100) < 40 ) exitWith {};

    private _minutes = round(30 + (random 30));
    diag_log format[ "<WEATHER> Making it medium overcast for %1 minutes", _minutes ];

    private _endTime = time + (_minutes * 60);
    while { time < _endTime } do {
        900 setOvercast 0.5;
        900 setRain 0;
        900 setLightnings 0;
        900 setFog 0;
        uisleep 300;
    };

    diag_log "<WEATHER> Overcast period ended";
};

_weather pushBack {

    if( (random 100) < 50 ) exitWith {};

    private _minutes = round(15 + (random 30));
    diag_log format[ "<WEATHER> Making it hard overcast for %1 minutes", _minutes ];

    private _endTime = time + (_minutes * 60);
    while { time < _endTime } do {
        900 setOvercast 1;
        900 setRain 0;
        900 setLightnings 0;
        900 setFog 0;
        uisleep 300;
    };

    diag_log "<WEATHER> Overcast period ended";
};

_weather pushBack {

    if( (random 100) < 65 ) exitWith {};

    diag_log "<WEATHER> Light rain, preparing overcast";

    900 setOvercast 0.8;
    uisleep 600;

    private _minutes = round(8 + (random 12));
    diag_log format[ "<WEATHER> Making it rain for %1 minutes", _minutes ];

    _endTime = time + (_minutes * 60);
    while { time < _endTime } do {
        300 setOvercast 0.8;
        300 setRain ([0, 0.1] select (XY_ssv_enableRain isEqualTo 1));
        300 setLightnings 0;
        300 setFog 0;
        uisleep 300;
    };

    diag_log "<WEATHER> Removing rain";

    300 setRain 0;
    300 setFog 0;

    uisleep 300;

    diag_log "<WEATHER> Weather done";
};

_weather pushBack {

    if( (random 100) < 75 ) exitWith {};

    diag_log "<WEATHER> Medium rain, preparing overcast";

    900 setOvercast 0.9;
    uisleep 600;

    private _minutes = round(8 + (random 9));
    diag_log format[ "<WEATHER> Making it rain for %1 minutes", _minutes ];

    private _endTime = time + (_minutes * 60);
    while { time < _endTime } do {
        300 setOvercast 0.9;
        300 setRain ([0, 0.33] select (XY_ssv_enableRain isEqualTo 1));
        300 setLightnings 1;
        300 setFog 0;
        uisleep 300;
    };

    diag_log "<WEATHER> Removing rain";

    600 setRain 0;
    600 setLightnings 0;
    300 setFog 0;
    uisleep 300;

    diag_log "<WEATHER> Weather done";
};

_weather pushBack {

    if( (random 100) < 85 ) exitWith {};

    diag_log "<WEATHER> Heavy rain, preparing overcast";

    if( daytime < 6 || daytime > 18 ) exitWith {
        diag_log "<WEATHER> Wrong daytime";
    };

    900 setOvercast 1;
    uisleep 600;

    private _minutes = round(7 + (random 8));
    diag_log format[ "<WEATHER> Making it rain for %1 minutes", _minutes ];

    private _endTime = time + (_minutes * 60);
    while { time < _endTime } do {
        300 setOvercast 1;
        300 setRain ([0, 0.75] select (XY_ssv_enableRain isEqualTo 1));
        300 setLightnings 1;
        300 setFog 0.25;
        uisleep 300;
    };

    diag_log "<WEATHER> Removing rain";

    600 setRain 0;
    600 setLightnings 0;
    300 setFog 0;
    uisleep 300;

    diag_log "<WEATHER> Weather done";
};

_weather pushBack {

    if( (random 100) < 90 ) exitWith {};

    // thunderstorm
    diag_log "<WEATHER> Thunderstorm, preparing overcast";
    if( daytime < 7 || daytime > 18 ) exitWith {
        diag_log "<WEATHER> Wrong daytime";
    };

    900 setOvercast 1;
    uisleep 600;

    private _minutes = round(5 + (random 10));
    diag_log format[ "<WEATHER> Making thunderstorm for %1 minutes", _minutes ];

    XY_enableRandomWind = false;

    private _endTime = time + (_minutes * 60);
    while { time < _endTime } do {
        setWind [ (25 + (random 25)) * ([1,-1] select (random 1 < 0.5)), (25 + (random 25)) * ([1,-1] select (random 1 < 0.5)), true];
        300 setOvercast 1;
        300 setRain ([0, 0.8] select (XY_ssv_enableRain isEqualTo 1));
        300 setLightnings 1;
        300 setFog 0.4;
        uisleep 300;
    };

    XY_enableRandomWind = true;

    diag_log "<WEATHER> Removing thunderstorm";
    300 setLightnings 0;
    300 setRain ([0, 0.1] select (XY_ssv_enableRain isEqualTo 1));
    300 setFog 0.1;
    uisleep 300;

    diag_log "<WEATHER> Removing rain";
    600 setRain 0;
    600 setLightnings 0;
    300 setFog 0;
    uisleep 300;

    diag_log "<WEATHER> Weather done";
};

_weather pushBack {

    // Heavy nightly rain with a foggy morning
    diag_log format["<WEATHER> Heavy nightly rain with a foggy morning, Daytime: %1", daytime];
    if( daytime > 3.5 ) exitWith {
        diag_log "<WEATHER> Wrong daytime";
    };

    // Wait until 5am
    while { daytime < 5 } do {
        900 setOvercast 1;
        uisleep 300;
    };

    // Make it rain until 6 am
    while { daytime < 6 } do {

        900 setOvercast 1;
        900 setRain ([0, 1] select (XY_ssv_enableRain isEqualTo 1));
        900 setLightnings 0;

        // From 05:40 we increase the fog
        if( daytime < 5.65 ) then {
            300 setFog 0.2;
        } else {
            300 setFog 0.6;
        };

        uisleep 300;
    };

    diag_log format[ "<WEATHER> Removing overcast, increasing fog, Daytime: %1...", daytime ];
    // It is 6 am, now increase the fog and remove the clouds for a fantastic sunny morning
    300 setRain 0;
    300 setOvercast 0;
    300 setFog 1;

    uisleep 300;

    diag_log format[ "<WEATHER> Removing overcast, further increasing fog, Daytime: %1...", daytime ];
    60 setOvercast 0;
    60 setFog 1;

    uisleep 120;

    diag_log format[ "<WEATHER> Removing fog, Daytime: %1...", daytime ];
    300 setFog 0;

    diag_log "<WEATHER> Keeping it sunny for 2 hours";

    private _endTime = time + 7200;
    while { time < _endTime } do {
        300 setOvercast 0;
        300 setRain 0;
        300 setLightnings 0;
        300 setFog 0;
        uisleep 300;
    };

    diag_log "<WEATHER> Weather done";
};

// Simplified weather for snow
if( (XY_ssv_enableSnow isEqualTo 1) && (XY_ssv_enableRain isEqualTo 0) ) exitWith {
    diag_log "<WEATHER> Snow mode!";
    XY_snow = 0;
    XY_autoSnow = true;
    private _nextChange = time;
    private _weather = random 3; // 0 = fair, 1 = cloudy, 2 = snow, 3 = heavy snow
    while { true } do {

        if( time >= _nextChange ) then {
            _weather = 0 max ((_weather + (random 0.18) - 0.1) min 3);

            300 setRain 0;
            300 setLightnings 0;

            switch( round _weather ) do {
                case 0: {
                    300 setOvercast 0;
                    300 setFog random(0.05);
                };
                case 1: {
                    300 setOvercast 0.1 + (random 0.4);
                    300 setFog random(0.08);
                };
                case 2: {
                    300 setOvercast 0.4 + (random 0.4);
                    300 setFog (0.07 + (random 0.05));
                };
                case 3: {
                    300 setOvercast 0.9 + (random 0.1);
                    300 setFog (0.07 + (random 0.07));
                };
            };
            diag_log format[ "<WEATHER> Changed weather to: %1...", _weather ];
            _nextChange = time + 300;
        };

        if( XY_autoSnow ) then {
            if( _weather > 1 ) then {
                XY_snow = 1 min (XY_snow + 0.005);
            } else {
                XY_snow = 0 max (XY_snow - 0.01);
            };
            publicVariable "XY_snow";

            diag_log format[ "<WEATHER> Updated snow target to: %1...", XY_snow];
        };
        sleep 30;
    };
};

XY_enableRandomWind = true;

"RandomWind" spawn { scriptName _this;

    private _wind = [ (random 5) - 2.5, (random 5) - 2.5, true ];

    setWind _wind;
    while {true} do {

            _wind set [0, (((_wind select 0) + (random 2) - 1) max -15) min 15 ];
            _wind set [1, (((_wind select 1) + (random 2) - 1) max -15) min 15 ];

        if( XY_enableRandomWind ) then {
            diag_log format["<WEATHER> Wind direction: %1", _wind];
            setWind _wind;
        };

        uisleep 333;
    };
};

diag_log "<WEATHER> Weather initialized";
while {true} do {

    sleep 900;

    // Select random weather...
    diag_log format[ "<WEATHER> Executing random weather, daytime: %1...", daytime ];
    call selectRandom _weather;

};