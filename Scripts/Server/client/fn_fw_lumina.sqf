// by ALIAS
// nul = [_obj,_ro,_ve,_bl,_h] execvm "ALfireworks\alias_lumina.sqf";
	
	private ["_ro","_ve","_bl","_h"];
	
	_lu = _this select 0;
	_ro = _this select 1;
	_ve = _this select 2;
	_bl = _this select 3;
	_h  = _this select 4;	
	
	_lolx = "#lightpoint" createVehiclelocal [(getPos _lu select 0)-50 ,(getPos _lu select 1)-50, _h];
	_lolx setLightBrightness 60;
	_lolx setLightDayLight true;
	_lolx setLightAmbient[_ro, _ve,_bl];
	_lolx setLightColor[_ro, _ve,_bl];	
	
	_bri = 60;	
	while {_bri>0} do {
	_lolx setLightBrightness _bri;
	_bri = _bri-1;
	sleep 0.05;
	};
	
	deleteVehicle _lolx;