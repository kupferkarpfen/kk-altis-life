// by ALIAS
// nul = [_lansspark,_ro,_ve,_bl,_h] execvm "ALfireworks\alias_sparks.sqf";

	private ["_ro","_ve","_bl","_h"];
	
	_xspark = _this select 0;
	_ro = _this select 1;
	_ve = _this select 2;
	_bl = _this select 3;
	_h  = _this select 4;
	_pozspark = getpos _xspark;
	_lanssparkmulti = "land_helipadempty_f" createVehicleLocal _pozspark;
	_lanssparkmulti setPos [(getPos _lanssparkmulti select 0) ,(getPos _lanssparkmulti select 1) , (getPos _lanssparkmulti select 2)+ _h];

//===================================================================	
		[_pozspark,_ro,_ve,_bl,_h] spawn {
			private ["_xx","_yy","_zz","_poztemp","_micspark","_poc_mic ","_nr"];
			_xx = -30;
			_poztemp = _this select 0;
			_ro = _this select 1;
			_ve = _this select 2;
			_bl = _this select 3;
			_hh = _this select 4;

			_nr=0;
			_micspark = "land_helipadempty_f" createVehicleLocal _poztemp;
			_micspark setPos [(getPos _micspark select 0) ,(getPos _micspark select 1) , (getPos _micspark select 2)+ _hh];
			_poc_mic = "#particlesource" createVehicleLocal _poztemp;
			while {_nr<5} do {
			_poc_mic setParticleCircle [0, [0, 0, 30]];
			_poc_mic setParticleRandom [0.5, [0, 0, 0], [0, 0, 0], 0, 0.5, [_ro, _ve,_bl, 1], 1, 0];
			_poc_mic setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 2, [0, 0, 0], [_xx, 0, 30], 0, 70, 0, 0, [0.5,1], [[_ro, _ve,_bl, 1],[_ro, _ve, _bl, 0.5]], [0.08], 1, 0, "", "",_micspark];
			_poc_mic setDropInterval 0.01;			
			_nr=_nr+1;
			sleep 0.1;
			};
			deleteVehicle _poc_mic;
			deleteVehicle _micspark;
		};
//===================================================================
		[_pozspark,_ro,_ve,_bl,_h] spawn {
			private ["_xx","_yy","_zz","_poztemp","_micspark","_poc_mic ","_nr"];
			_xx = -20;
			_poztemp = _this select 0;
			_ro = _this select 1;
			_ve = _this select 2;
			_bl = _this select 3;
			_hh = _this select 4;

			_nr=0;
			_micspark = "land_helipadempty_f" createVehicleLocal _poztemp;
			_micspark setPos [(getPos _micspark select 0) ,(getPos _micspark select 1) , (getPos _micspark select 2)+ _hh];
			_poc_mic = "#particlesource" createVehicleLocal _poztemp;
			while {_nr<5} do {
			_poc_mic setParticleCircle [0, [0, 0, 30]];
			_poc_mic setParticleRandom [0.5, [0, 0, 0], [0, 0, 0], 0, 0.5, [_ro, _ve,_bl, 1], 1, 0];
			_poc_mic setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 2, [0, 0, 0], [_xx, 0, 1], 0, 20, 0, 0, [1,0.5], [[_ro, _ve,_bl, 1],[_ro, _ve, _bl, 0.5]], [0.08], 1, 0, "", "",_micspark];
			_poc_mic setDropInterval 0.01;			
			_nr=_nr+1;
			sleep 0.1;
			};
			deleteVehicle _poc_mic;
			deleteVehicle _micspark;
		};
//===================================================================	
		[_pozspark,_ro,_ve,_bl,_h] spawn {
			private ["_xx","_yy","_zz","_poztemp","_micspark","_poc_mic ","_nr"];
			_xx = -20;
			_poztemp = _this select 0;
			_ro = _this select 1;
			_ve = _this select 2;
			_bl = _this select 3;
			_hh = _this select 4;

			_nr=0;
			_micspark = "land_helipadempty_f" createVehicleLocal _poztemp;
			_micspark setPos [(getPos _micspark select 0) ,(getPos _micspark select 1) , (getPos _micspark select 2)+ _hh];
			_poc_mic = "#particlesource" createVehicleLocal _poztemp;
			while {_nr<5} do {
			_poc_mic setParticleCircle [0, [0, 0, 30]];
			_poc_mic setParticleRandom [0.5, [0, 0, 0], [0, 0, 0], 0, 0.5, [_ro, _ve,_bl, 1], 1, 0];
			_poc_mic setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 2, [0, 0, 0], [_xx, 0, -20], 0, 70, 0, 0, [1,0.5], [[_ro, _ve,_bl, 1],[_ro, _ve, _bl, 0.5]], [0.08], 1, 0, "", "",_micspark];
			_poc_mic setDropInterval 0.01;			
			_nr=_nr+1;
			sleep 0.1;
			};
			deleteVehicle _poc_mic;
			deleteVehicle _micspark;
		};
//===================================================================	
		[_pozspark,_ro,_ve,_bl,_h] spawn {
			private ["_xx","_yy","_zz","_poztemp","_micspark","_poc_mic ","_nr"];
			_xx = 0;
			_poztemp = _this select 0;
			_ro = _this select 1;
			_ve = _this select 2;
			_bl = _this select 3;
			_hh = _this select 4;

			_nr=0;
			_micspark = "land_helipadempty_f" createVehicleLocal _poztemp;
			_micspark setPos [(getPos _micspark select 0) ,(getPos _micspark select 1) , (getPos _micspark select 2)+ _hh];
			_poc_mic = "#particlesource" createVehicleLocal _poztemp;
			while {_nr<5} do {
			_poc_mic setParticleCircle [0, [0, 0, 30]];
			_poc_mic setParticleRandom [0.5, [0, 0, 0], [0, 0, 0], 0, 0.5, [_ro, _ve,_bl, 1], 1, 0];
			_poc_mic setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 2, [0, 0, 0], [_xx, 0, -20], 0, 70, 0, 0, [1,0.5], [[_ro, _ve,_bl, 1],[_ro, _ve, _bl, 0.5]], [0.08], 1, 0, "", "",_micspark];
			_poc_mic setDropInterval 0.01;			
			_nr=_nr+1;
			sleep 0.1;
			};
			deleteVehicle _poc_mic;
			deleteVehicle _micspark;
		};
//===================================================================
		[_pozspark,_ro,_ve,_bl,_h] spawn {
			private ["_xx","_yy","_zz","_poztemp","_micspark","_poc_mic ","_nr"];
			_xx = 35;
			_poztemp = _this select 0;
			_ro = _this select 1;
			_ve = _this select 2;
			_bl = _this select 3;
			_hh = _this select 4;

			_nr=0;
			_micspark = "land_helipadempty_f" createVehicleLocal _poztemp;
			_micspark setPos [(getPos _micspark select 0) ,(getPos _micspark select 1) , (getPos _micspark select 2)+ _hh];
			_poc_mic = "#particlesource" createVehicleLocal _poztemp;
			while {_nr<5} do {
			_poc_mic setParticleCircle [0, [0, 0, 30]];
			_poc_mic setParticleRandom [0.5, [0, 0, 0], [0, 0, 0], 0, 0.5, [_ro, _ve,_bl, 1], 1, 0];
			_poc_mic setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 2, [0, 0, 0], [_xx, 0, -20], 0, 70, 0, 0, [1,0.5], [[_ro, _ve,_bl, 1],[_ro, _ve, _bl, 0.5]], [0.08], 1, 0, "", "",_micspark];
			_poc_mic setDropInterval 0.01;			
			_nr=_nr+1;
			sleep 0.1;
			};
			deleteVehicle _poc_mic;
			deleteVehicle _micspark;
		};
//===================================================================
		[_pozspark,_ro,_ve,_bl,_h] spawn {
			private ["_xx","_yy","_zz","_poztemp","_micspark","_poc_mic ","_nr"];
			_xx = 35;
			_poztemp = _this select 0;
			_ro = _this select 1;
			_ve = _this select 2;
			_bl = _this select 3;
			_hh = _this select 4;

			_nr=0;
			_micspark = "land_helipadempty_f" createVehicleLocal _poztemp;
			_micspark setPos [(getPos _micspark select 0) ,(getPos _micspark select 1) , (getPos _micspark select 2)+ _hh];
			_poc_mic = "#particlesource" createVehicleLocal _poztemp;
			while {_nr<5} do {
			_poc_mic setParticleCircle [0, [0, 0, 30]];
			_poc_mic setParticleRandom [0.5, [0, 0, 0], [0, 0, 0], 0, 0.5, [_ro, _ve,_bl, 1], 1, 0];
			_poc_mic setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 2, [0, 0, 0], [_xx, 0, 1], 0, 20, 0, 0, [1,0.5], [[_ro, _ve,_bl, 1],[_ro, _ve, _bl, 0.5]], [0.08], 1, 0, "", "",_micspark];
			_poc_mic setDropInterval 0.01;			
			_nr=_nr+1;
			sleep 0.1;
			};
			deleteVehicle _poc_mic;
			deleteVehicle _micspark;
		};
//===================================================================
		[_pozspark,_ro,_ve,_bl,_h] spawn {
			private ["_xx","_yy","_zz","_poztemp","_micspark","_poc_mic ","_nr"];
			_xx = 35;
			_poztemp = _this select 0;
			_ro = _this select 1;
			_ve = _this select 2;
			_bl = _this select 3;
			_hh = _this select 4;

			_nr=0;
			_micspark = "land_helipadempty_f" createVehicleLocal _poztemp;
			_micspark setPos [(getPos _micspark select 0) ,(getPos _micspark select 1) , (getPos _micspark select 2)+ _hh];
			_poc_mic = "#particlesource" createVehicleLocal _poztemp;
			while {_nr<5} do {
			_poc_mic setParticleCircle [0, [0, 0, 30]];
			_poc_mic setParticleRandom [0.5, [0, 0, 0], [0, 0, 0], 0, 0.5, [_ro, _ve,_bl, 1], 1, 0];
			_poc_mic setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 2, [0, 0, 0], [_xx, 0, 30], 0, 70, 0, 0, [1,0.5], [[_ro, _ve,_bl, 1],[_ro, _ve, _bl, 0.5]], [0.08], 1, 0, "", "",_micspark];
			_poc_mic setDropInterval 0.01;			
			_nr=_nr+1;
			sleep 0.1;
			};
			deleteVehicle _poc_mic;
			deleteVehicle _micspark;
		};
//===================================================================
		[_pozspark,_ro,_ve,_bl,_h] spawn {
			private ["_xx","_yy","_zz","_poztemp","_micspark","_poc_mic ","_nr"];
			_xx = 0;
			_poztemp = _this select 0;
			_ro = _this select 1;
			_ve = _this select 2;
			_bl = _this select 3;
			_hh = _this select 4;

			_nr=0;
			_micspark = "land_helipadempty_f" createVehicleLocal _poztemp;
			_micspark setPos [(getPos _micspark select 0) ,(getPos _micspark select 1) , (getPos _micspark select 2)+ _hh];
			_poc_mic = "#particlesource" createVehicleLocal _poztemp;
			while {_nr<5} do {
			_poc_mic setParticleCircle [0, [0, 0, 30]];
			_poc_mic setParticleRandom [0.5, [0, 0, 0], [0, 0, 0], 0, 0.5, [_ro, _ve,_bl, 1], 1, 0];
			_poc_mic setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 2, [0, 0, 0], [_xx, 0, 40], 0, 70, 0, 0, [1,0.5], [[_ro, _ve,_bl, 1],[_ro, _ve, _bl, 0.5]], [0.08], 1, 0, "", "",_micspark];
			_poc_mic setDropInterval 0.01;			
			_nr=_nr+1;
			sleep 0.1;
			};
			deleteVehicle _poc_mic;
			deleteVehicle _micspark;
		};
//===================================================================

//===================================================================	
		[_pozspark,_ro,_ve,_bl,_h] spawn {
			private ["_xx","_yy","_zz","_poztemp","_micspark","_poc_mic ","_nr"];
			_xx = -30;
			_poztemp = _this select 0;
			_ro = _this select 1;
			_ve = _this select 2;
			_bl = _this select 3;
			_hh = _this select 4;

			_nr=0;
			_micspark = "land_helipadempty_f" createVehicleLocal _poztemp;
			_micspark setPos [(getPos _micspark select 0) ,(getPos _micspark select 1) , (getPos _micspark select 2)+ _hh];
			_poc_mic = "#particlesource" createVehicleLocal _poztemp;
			while {_nr<5} do {
			_poc_mic setParticleCircle [0, [0, 0, 30]];
			_poc_mic setParticleRandom [0.5, [0, 0, 0], [0, 0, 0], 0, 0.5, [_ro, _ve,_bl, 1], 1, 0];
			_poc_mic setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 2, [0, 0, 0], [0, _xx, 30], 0, 70, 0, 0, [0.5,1], [[_ro, _ve,_bl, 1],[_ro, _ve, _bl, 0.5]], [0.08], 1, 0, "", "",_micspark];
			_poc_mic setDropInterval 0.01;			
			_nr=_nr+1;
			sleep 0.1;
			};
			deleteVehicle _poc_mic;
			deleteVehicle _micspark;
		};
//===================================================================
		[_pozspark,_ro,_ve,_bl,_h] spawn {
			private ["_xx","_yy","_zz","_poztemp","_micspark","_poc_mic ","_nr"];
			_xx = -20;
			_poztemp = _this select 0;
			_ro = _this select 1;
			_ve = _this select 2;
			_bl = _this select 3;
			_hh = _this select 4;

			_nr=0;
			_micspark = "land_helipadempty_f" createVehicleLocal _poztemp;
			_micspark setPos [(getPos _micspark select 0) ,(getPos _micspark select 1) , (getPos _micspark select 2)+ _hh];
			_poc_mic = "#particlesource" createVehicleLocal _poztemp;
			while {_nr<5} do {
			_poc_mic setParticleCircle [0, [0, 0, 30]];
			_poc_mic setParticleRandom [0.5, [0, 0, 0], [0, 0, 0], 0, 0.5, [_ro, _ve,_bl, 1], 1, 0];
			_poc_mic setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 2, [0, 0, 0], [0, _xx, 1], 0, 20, 0, 0, [1,0.5], [[_ro, _ve,_bl, 1],[_ro, _ve, _bl, 0.5]], [0.08], 1, 0, "", "",_micspark];
			_poc_mic setDropInterval 0.01;			
			_nr=_nr+1;
			sleep 0.1;
			};
			deleteVehicle _poc_mic;
			deleteVehicle _micspark;
		};
//===================================================================	
		[_pozspark,_ro,_ve,_bl,_h] spawn {
			private ["_xx","_yy","_zz","_poztemp","_micspark","_poc_mic ","_nr"];
			_xx = -20;
			_poztemp = _this select 0;
			_ro = _this select 1;
			_ve = _this select 2;
			_bl = _this select 3;
			_hh = _this select 4;

			_nr=0;
			_micspark = "land_helipadempty_f" createVehicleLocal _poztemp;
			_micspark setPos [(getPos _micspark select 0) ,(getPos _micspark select 1) , (getPos _micspark select 2)+ _hh];
			_poc_mic = "#particlesource" createVehicleLocal _poztemp;
			while {_nr<5} do {
			_poc_mic setParticleCircle [0, [0, 0, 30]];
			_poc_mic setParticleRandom [0.5, [0, 0, 0], [0, 0, 0], 0, 0.5, [_ro, _ve,_bl, 1], 1, 0];
			_poc_mic setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 2, [0, 0, 0], [0, _xx, -20], 0, 70, 0, 0, [1,0.5], [[_ro, _ve,_bl, 1],[_ro, _ve, _bl, 0.5]], [0.08], 1, 0, "", "",_micspark];
			_poc_mic setDropInterval 0.01;			
			_nr=_nr+1;
			sleep 0.1;
			};
			deleteVehicle _poc_mic;
			deleteVehicle _micspark;
		};
//===================================================================	
		[_pozspark,_ro,_ve,_bl,_h] spawn {
			private ["_xx","_yy","_zz","_poztemp","_micspark","_poc_mic ","_nr"];
			_xx = 0;
			_poztemp = _this select 0;
			_ro = _this select 1;
			_ve = _this select 2;
			_bl = _this select 3;
			_hh = _this select 4;

			_nr=0;
			_micspark = "land_helipadempty_f" createVehicleLocal _poztemp;
			_micspark setPos [(getPos _micspark select 0) ,(getPos _micspark select 1) , (getPos _micspark select 2)+ _hh];
			_poc_mic = "#particlesource" createVehicleLocal _poztemp;
			while {_nr<5} do {
			_poc_mic setParticleCircle [0, [0, 0, 30]];
			_poc_mic setParticleRandom [0.5, [0, 0, 0], [0, 0, 0], 0, 0.5, [_ro, _ve,_bl, 1], 1, 0];
			_poc_mic setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 2, [0, 0, 0], [0, _xx, -20], 0, 70, 0, 0, [1,0.5], [[_ro, _ve,_bl, 1],[_ro, _ve, _bl, 0.5]], [0.08], 1, 0, "", "",_micspark];
			_poc_mic setDropInterval 0.01;			
			_nr=_nr+1;
			sleep 0.1;
			};
			deleteVehicle _poc_mic;
			deleteVehicle _micspark;
		};
//===================================================================
		[_pozspark,_ro,_ve,_bl,_h] spawn {
			private ["_xx","_yy","_zz","_poztemp","_micspark","_poc_mic ","_nr"];
			_xx = 35;
			_poztemp = _this select 0;
			_ro = _this select 1;
			_ve = _this select 2;
			_bl = _this select 3;
			_hh = _this select 4;

			_nr=0;
			_micspark = "land_helipadempty_f" createVehicleLocal _poztemp;
			_micspark setPos [(getPos _micspark select 0) ,(getPos _micspark select 1) , (getPos _micspark select 2)+ _hh];
			_poc_mic = "#particlesource" createVehicleLocal _poztemp;
			while {_nr<5} do {
			_poc_mic setParticleCircle [0, [0, 0, 30]];
			_poc_mic setParticleRandom [0.5, [0, 0, 0], [0, 0, 0], 0, 0.5, [_ro, _ve,_bl, 1], 1, 0];
			_poc_mic setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 2, [0, 0, 0], [0, _xx, -20], 0, 70, 0, 0, [1,0.5], [[_ro, _ve,_bl, 1],[_ro, _ve, _bl, 0.5]], [0.08], 1, 0, "", "",_micspark];
			_poc_mic setDropInterval 0.01;			
			_nr=_nr+1;
			sleep 0.1;
			};
			deleteVehicle _poc_mic;
			deleteVehicle _micspark;
		};
//===================================================================
		[_pozspark,_ro,_ve,_bl,_h] spawn {
			private ["_xx","_yy","_zz","_poztemp","_micspark","_poc_mic ","_nr"];
			_xx = 35;
			_poztemp = _this select 0;
			_ro = _this select 1;
			_ve = _this select 2;
			_bl = _this select 3;
			_hh = _this select 4;

			_nr=0;
			_micspark = "land_helipadempty_f" createVehicleLocal _poztemp;
			_micspark setPos [(getPos _micspark select 0) ,(getPos _micspark select 1) , (getPos _micspark select 2)+ _hh];
			_poc_mic = "#particlesource" createVehicleLocal _poztemp;
			while {_nr<5} do {
			_poc_mic setParticleCircle [0, [0, 0, 30]];
			_poc_mic setParticleRandom [0.5, [0, 0, 0], [0, 0, 0], 0, 0.5, [_ro, _ve,_bl, 1], 1, 0];
			_poc_mic setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 2, [0, 0, 0], [0, _xx, 1], 0, 20, 0, 0, [1,0.5], [[_ro, _ve,_bl, 1],[_ro, _ve, _bl, 0.5]], [0.08], 1, 0, "", "",_micspark];
			_poc_mic setDropInterval 0.01;			
			_nr=_nr+1;
			sleep 0.1;
			};
			deleteVehicle _poc_mic;
			deleteVehicle _micspark;
		};
//===================================================================
		[_pozspark,_ro,_ve,_bl,_h] spawn {
			private ["_xx","_yy","_zz","_poztemp","_micspark","_poc_mic ","_nr"];
			_xx = 35;
			_poztemp = _this select 0;
			_ro = _this select 1;
			_ve = _this select 2;
			_bl = _this select 3;
			_hh = _this select 4;

			_nr=0;
			_micspark = "land_helipadempty_f" createVehicleLocal _poztemp;
			_micspark setPos [(getPos _micspark select 0) ,(getPos _micspark select 1) , (getPos _micspark select 2)+ _hh];
			_poc_mic = "#particlesource" createVehicleLocal _poztemp;
			while {_nr<5} do {
			_poc_mic setParticleCircle [0, [0, 0, 30]];
			_poc_mic setParticleRandom [0.5, [0, 0, 0], [0, 0, 0], 0, 0.5, [_ro, _ve,_bl, 1], 1, 0];
			_poc_mic setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 2, [0, 0, 0], [0, _xx, 30], 0, 70, 0, 0, [1,0.5], [[_ro, _ve,_bl, 1],[_ro, _ve, _bl, 0.5]], [0.08], 1, 0, "", "",_micspark];
			_poc_mic setDropInterval 0.01;			
			_nr=_nr+1;
			sleep 0.1;
			};
			deleteVehicle _poc_mic;
			deleteVehicle _micspark;
		};
//===================================================================
		[_pozspark,_ro,_ve,_bl,_h] spawn {
			private ["_xx","_yy","_zz","_poztemp","_micspark","_poc_mic ","_nr"];
			_xx = 0;
			_poztemp = _this select 0;
			_ro = _this select 1;
			_ve = _this select 2;
			_bl = _this select 3;
			_hh = _this select 4;

			_nr=0;
			_micspark = "land_helipadempty_f" createVehicleLocal _poztemp;
			_micspark setPos [(getPos _micspark select 0) ,(getPos _micspark select 1) , (getPos _micspark select 2)+ _hh];
			_poc_mic = "#particlesource" createVehicleLocal _poztemp;
			while {_nr<5} do {
			_poc_mic setParticleCircle [0, [0, 0, 30]];
			_poc_mic setParticleRandom [0.5, [0, 0, 0], [0, 0, 0], 0, 0.5, [_ro, _ve,_bl, 1], 1, 0];
			_poc_mic setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 2, [0, 0, 0], [0, _xx, 40], 0, 70, 0, 0, [1,0.5], [[_ro, _ve,_bl, 1],[_ro, _ve, _bl, 0.5]], [0.08], 1, 0, "", "",_micspark];
			_poc_mic setDropInterval 0.01;			
			_nr=_nr+1;
			sleep 0.1;
			};
			deleteVehicle _poc_mic;
			deleteVehicle _micspark;
		};
//===================================================================

	sleep 0.2;
	_poc = "#particlesource" createVehicleLocal getpos _lanssparkmulti;

	_xx = [-30,20] call BIS_fnc_selectRandom;
	_yy = [-30,20] call BIS_fnc_selectRandom; 
	_zz = [30,30] call BIS_fnc_selectRandom;
	
	_poc setParticleCircle [0, [_xx, _yy, _zz]];
	_poc setParticleRandom [0, [0, 0, 0], [_xx, _yy, _zz], 0, 0.5, [_ro, _ve,_bl, 1], 1, 0];
	_poc setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 1.5, [0, 0, 0], [_xx, _yy, _zz], 0, 50, 0, 0, [0.5,1], [[_ro, _ve,_bl, 1],[_ro, _ve, _bl, 0.5]], [0.08], 1, 0, "", "",_lanssparkmulti];
	_poc setDropInterval 0.0005;
	
	sleep 0.5+random 1;
	deleteVehicle _poc;