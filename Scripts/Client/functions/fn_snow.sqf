waitUntil { uisleep 1; !(isNil "XY_snow") };

diag_log format["<SNOW> started snow support, initial level %1", XY_snow];
private _intensity = XY_snow;

private _flakes = [];
private _previousVehicle = objNull;
private _nextRefresh = time;

XY_RUN_SNOW = true;
while { XY_RUN_SNOW } do {

    _intensity = XY_snow;

    private _ccContrast = (1.1 min (0.9 + (_intensity * 0.75)));
    private _ccBlend = 0.15 * _intensity;
    private _ccColorize = 1 - (0.4 * _intensity);
    private _ccDesaturate = 0.2 + _intensity;

    private _cc = ppEffectCreate ["ColorCorrections", 1111];
    _cc ppEffectAdjust [1.0, _ccContrast, 0.0, [0.3, 0.3, 0.6, _ccBlend], [0.8, 0.8, 0.85, _ccColorize], [_ccDesaturate, _ccDesaturate, _ccDesaturate, 0]];
    _cc ppEffectEnable true;
    _cc ppEffectCommit 10;

    if( time >= _nextRefresh || !((vehicle player) isEqualTo _previousVehicle) ) then {
        _previousVehicle = vehicle player;
        _nextRefresh = time + 30;

        while { (count _flakes) > 0 } do {
            deleteVehicle (_flakes deleteAt 0);
        };

        if( _intensity > 0 ) then {

            private _wind = wind;

            private _ps = "#particlesource" createVehicleLocal (getPos player);
            _ps setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 12, 2, 0], "", "Billboard", 1, 15, [0, 0, 0], [(_wind select 0) * 0.2, (_wind select 1) * 0.2, 0 ], 2, 1.5, 1, 3, [0.2, 0.1], [[1, 1, 1, 0], [1, 1, 1, 0.8], [1, 1, 1, 0] ], [1], 0.01, 0.08, "", "", _previousVehicle, 0, false, -1, [[1,1,1,0]]];
            _ps setParticleRandom [2, [33, 33, 15], [10, 10, 15], 6, 0.4, [0, 0, 0, 0], 0.1, 0];
            _ps setDropInterval 0.001 / _intensity;
            _ps attachTo [_previousVehicle];
            _flakes pushBack _ps;

            _ps = "#particlesource" createVehicleLocal (getPos player);
            _ps setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 12, 2, 0], "", "Billboard", 1, 15, [0, 0, 0], [(_wind select 0) * 0.4, (_wind select 1) * 0.4, 0 ], 1, 1.75, 1, 1, [0.05], [[1, 1, 1, 0], [1, 1, 1, 0.8], [1, 1, 1, 0] ], [1], 0.01, 0.08, "", "", _previousVehicle, 0, false, -1, [[1,1,1,0]]];
            _ps setParticleRandom [2, [33, 33, 15], [10, 10, 15], 6, 0.5, [0, 0, 0, 0], 0.1, 0];
            _ps setDropInterval 0.005 / _intensity;
            _ps attachTo [_previousVehicle];
            _flakes pushBack _ps;

            if( _intensity > 0.5 ) then {
                private _ps = "#particlesource" createVehicleLocal (getPos player);
                _ps setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 12, 3, 1], "", "Billboard", 1, 5, [0, 0, 0], [(_wind select 0) * 0.1, (_wind select 1) * 0.1, 0 ], 1, 1.5, 1, 2, [0.025, 0.06], [[1, 1, 1, 0.2], [1, 1, 1, 0.6], [1, 1, 1, 0] ], [1], 0.01, 0.08, "", "", _previousVehicle, 0, false, -1, [[1,1,1,0]]];
                _ps setParticleRandom [1, [5, 5, 10], [0, 0, 0], 1, 0.05, [0, 0, 0, 0], 0.1, 0];
                _ps setDropInterval 0.001;
                _ps attachTo [_previousVehicle];
                _flakes pushBack _ps;
            };
            if( _intensity > 0.75 ) then {
                private _ps = "#particlesource" createVehicleLocal (getPos player);
                _ps setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 12, 2, 0], "", "Billboard", 1, 12, [0, 0, 0], [_wind select 0, _wind select 1, 0 ], 10, 2.5, 1.5, 1, [0.5, 0.4], [[1, 1, 1, 0], [1, 1, 1, 0.8], [1, 1, 1, 0] ], [1], 0.01, 0.08, "", "", _previousVehicle, 0, false, -1, [[1,1,1,0]]];
                _ps setParticleRandom [1, [33, 33, 15], [0, 0, 0], 1, 5, [0, 0, 0, 0], 0.1, 0];
                _ps setDropInterval 0.1;
                _ps attachTo [_previousVehicle];
                _flakes pushBack _ps;
            };
        };
    };
    uisleep 1;
};