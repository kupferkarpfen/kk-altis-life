// by ALIAS
// nul = [obj_pozition,duration] execvm "ALfireworks\alias_rock.sqf";

		_objf= _this select 0;
		_hi= _this select 1;
		_sunetf= _this select 2;
		_li = "#lightpoint" createVehiclelocal (getPos _objf);
		_li setLightBrightness 10;
		_li setLightAttenuation [/*start*/ 5, /*constant*/0, /*linear*/ 5000, /*quadratic*/ 500, /*hardlimitstart*/200,/* hardlimitend*/500]; 
		_li setLightUseFlare true;
		_li setLightFlareSize 0.07;
		_li setLightFlareMaxDistance 2000;	
		_li setLightAmbient[1,1,1];
		_li setLightColor[1,1,1];
		
		_objf say3D _sunetf;

		// Smoke
		_ps1 = "#particlesource" createVehicleLocal getpos _objf;
		_ps1 setParticleCircle [0, [0, 0, 0]];
		_ps1 setParticleRandom [2, [0, 0, 0], [0.2, 0.2, 0.5], 0.3, 0.5, [0, 0, 0, 0.5], 0, 0];
		_ps1 setDropInterval 0.002;
		
		_hlum = 0;
		while {_hi-_hlum>100} do {
			_li lightAttachObject [_objf, [0,0,_hlum]];
			_ps1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 7,48,1], "", "Billboard", 1, 0.5+random 1, [0, 0, 0], [0, 0, 0.5], 0, 10.1, 7.9, 0.01, [1, 2, 3], [[0.1,0.1,0.1,0.9], [0.6,0.6,0.6,0.6], [0.8,0.8,0.8,0.4],[0.9,0.9,0.9,0.3],[1,1,1,0.1]], [0.125], 1, 0, "", "", _li];
			_hlum = _hlum+3;
			sleep 0.001;
		};
		
		deletevehicle _li;
		sleep 1;			