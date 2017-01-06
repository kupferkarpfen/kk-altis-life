/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Turns on and displays a security cam like feed via PiP to the laptop display.
*/
_laptop = _this select 0;
_mode = _this select 3;

if(!isPiPEnabled) exitWith {hint localize "STR_Cop_EnablePiP";};
if(isNil "XY_fedCam") then {
	XY_fedCam = "camera" camCreate [0,0,0];
	XY_fedCam camSetFov 0.5;
	XY_fedCam camCommit 0;
	"rendertarget0" setPiPEffect [0];
	XY_fedCam cameraEffect ["INTERNAL", "BACK", "rendertarget0"];
	_laptop setObjectTexture [0,"#(argb,256,256,1)r2t(rendertarget0,1.0)"];
};

switch (_mode) do {
	case "side": {
		XY_fedCam camSetPos [20927.6,19173.6,25.08817];
		XY_fedCam camSetTarget [20906.4,19202.3,0.00146008];
		XY_fedCam camCommit 0;
	};
	
	case "vault": {
		XY_fedCam camSetPos [20913.4,19220.1,10.287];
		XY_fedCam camSetTarget [20890.5,19238.6,0.00146008];
		XY_fedCam camCommit 0;
	};
	
	case "front": {
		XY_fedCam camSetPos [20941.1,19251.5,23.6492] ;
		XY_fedCam camSetTarget [20917.9,19239.4,0.00145817];
		XY_fedCam camCommit 0;
	};
	
	case "back": {
		XY_fedCam camSetPos [20847.2,19208.2,15.71753];
		XY_fedCam camSetTarget [20869.8,19214.7,0.00146866];
		XY_fedCam camCommit 0;
	};
	
	case "off" :{
		XY_fedCam cameraEffect ["terminate", "back"];
		camDestroy XY_fedCam;
		_laptop setObjectTexture [0,""];
		XY_fedCam = nil;
	};
};
