// CTF server-side module
// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Receives CTF request from clients

private _source = param[0, objNull, [objNull]];
private _flag =   param[1, objNull, [objNull]];
private _type =   param[2, "", [""]];
private _city =   param[3, "", [""]];

diag_log format[ "<CTF> XY_fnc_ctf(%1)", _this ];

if( isNull _source || isNull _flag || _type isEqualTo "" || _city isEqualTo "" ) exitWith {};

MUTEX_CTF call enterCriticalSection;

private _error = "";

if( "start" isEqualTo _type ) then {

    if( _flag getVariable["ctfHappened", false] ) exitWith {
        _error = "Diese Stadt wurde bereits angegriffen";
    };

    if( XY_ctfActive ) then {
        _error = "Es ist bereits ein Stadtangriff aktiv";
    } else {
        XY_ctfActive = true;
    };
};
if( "capture" isEqualTo _type ) then {
    if( XY_ctfActive ) then {
        // City captured!
        XY_ctfActive = false;

        _flag setVariable["ctfCaptured", true, true];
        [ 1, "<t color='#FF0000' size ='3' align='center'>ACHTUNG</t><br/><t size='1'>Stadtangriff auf " + _city + " wurde beendet: Die Stadt wurde erobert und ist in Rebellenhand" ] remoteExec ["XY_fnc_broadcast", -2];

    } else {
        _error = "Es ist kein Stadtangriff aktiv";
    };
};

MUTEX_CTF call leaveCriticalSection;

if ( !(_error isEqualTo "") ) exitWith {
    [1, _error] remoteExec ["XY_fnc_broadcast", _source];
};

if( !XY_ctfActive ) exitWith {};

_flag setVariable["ctfHappened", true, true];
_flag setVariable["ctfActive", true, true];

private _pos = getPos _flag;

if( _city isEqualTo "Kavala" ) then {
    // Special treatment for Kavala, as there is a safezone-marker around it!
    "other_safezone_kavala" setMarkerSize [1, 1];
};
if( _city isEqualTo "Pyrgos" ) then {
    // Special treatment for Pyrgos, as there is a safezone-marker around it!
    "other_safezone_pyrgos" setMarkerSize [1, 1];
};

private _marker = createMarker ["other_CTF_MARKER", _pos];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [1250, 1250];
_marker setMarkerColor "ColorRed";

["update"] remoteExec [ "XY_fnc_markerManager", -2 ];

{
    [_x, "sirencivil"] remoteExec ["say3D", _x];
} forEach ( _pos nearEntities ["Man", 3000] );

private _startTime = time;
private _endTime = time + 3600;

private _nextWarning = 0;
while{ XY_ctfActive } do {

    if ( time >= _nextWarning) then {

        private _countdown = floor( _endTime - time );
        if( _countdown < 0 ) exitWith {
            XY_ctfActive = false;
            deleteMarker _marker;
            [ 1, "<t color='#FF0000' size ='3' align='center'>ACHTUNG</t><br/><t size='1'>Stadtangriff auf " + _city + " wurde beendet: Die Stadt bleibt in der Hand des Staates" ] remoteExec ["XY_fnc_broadcast", -2];
            if( _city isEqualTo "Kavala" ) then {
                "other_safezone_kavala" setMarkerSize [1100, 1100];
            };
            if( _city isEqualTo "Pyrgos" ) then {
                "other_safezone_pyrgos" setMarkerSize [50, 50];
            };
        };

        private _m = floor(_countdown / 60);
        private _timeLeft = format[ "%1 Minute", _m ];
        if( _m > 1 ) then {
            _timeLeft = _timeLeft + "n";
        };

        {
            [ 1, "<t color='#FF0000' size ='3' align='center'>ACHTUNG</t><br/><t size='1'> " + _city + " wird angegriffen: Alle Zivilisten müssen die Stadt umgehend verlassen! Verbleibende Zeit: " + _timeLeft ] remoteExec ["XY_fnc_broadcast", _x];
        } forEach ( _pos nearEntities ["Man", 4000] );

        _nextWarning = time + 300;
    };

    uisleep 10;
};

_flag setVariable["ctfActive", false, true];