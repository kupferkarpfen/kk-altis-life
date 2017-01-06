// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// ---

private _taxiEject = {
    private _taxi = param[0, objNull, [objNull]];

    {
        if (isPlayer _x) then {
            _x action ["eject", _taxi];
        };
    } forEach (crew _taxi);
};

private _taxiReturn = {
    private _taxi = param[0, objNull, [objNull]];

    [ _taxi ] call _taxiEject;
    _taxi lock 2;

    uisleep 4;

    (group _taxi) move [15500, 30000, 15];
    _taxi flyInHeight 300;

    private _iterations = 0;
    while { ((getPos _taxi) select 1) < 28000 && _iterations < 15 } do {
        _iterations = _iterations + 1;
        uisleep 30;
    };

    {
        deleteVehicle _x;
    } forEach (crew _taxi);

    deleteVehicle _taxi;
};

// ---

private _player = param[0, objNull, [objNull]];
private _destination = param[1, "", [""]];
private _price = param[2, -1, []];

private _pos = getPos _player;

diag_log format["<TAXI> Called taxi %1 @ %2 => %3", _player, _pos, _destination ];

private _spawnPos = [0,0,0];
{
    if( (_player distance2D _x) < (_player distance2D _spawnPos) ) then {
        _spawnPos = _x;
    };
} forEach [
    [6754, 9580, 0],
    [2968, 15152, 0],
    [2071, 18690, 0],
    [2199, 21020, 0],
    [3560, 23014, 0],
    [6378, 23414, 0],
    [8195, 24174, 0],
    [10397, 23238, 0],
    [13359, 23782, 0],
    [16097, 22893, 0],
    [17378, 21132, 0],
    [19316, 20139, 0],
    [20965, 21484, 0],
    [22286, 23030, 0],
    [25280, 24527, 0],
    [28634, 23094, 0],
    [27137, 19643, 0],
    [25000, 17713, 0],
    [23150, 14903, 0],
    [22134, 12526, 0],
    [22086, 10108, 0],
    [17378, 8371, 0],
    [13479, 84999, 0],
    [13997, 9000, 0],
    [15725, 12087, 0],
    [15353, 14583, 0]
];

// Randomize spawn a bit
_spawnPos set[0, (_spawnPos select 0) + (random 50)];
_spawnPos set[1, (_spawnPos select 1) + (random 50)];

// Spawn Taxi
private _taxi = createVehicle ["C_Heli_Light_01_civil_F", _spawnPos, [], 0, "FLY"];
[_plane, 900] remoteExec [ "XY_fnc_registerVehicleForDeletion", 2 ];

createVehicleCrew _taxi;
_taxi setObjectTextureGlobal[0, "#(argb,8,8,3)color(0.9,0.15,0.01,0.7)"];
_taxi allowDamage false;
_taxi lock 0;

clearWeaponCargoGlobal _taxi;
clearMagazineCargoGlobal _taxi;
clearItemCargoGlobal _taxi;
clearBackpackCargoGlobal _taxi;

{
    _x allowDamage false;
    _x forceAddUniform "U_B_HeliPilotCoveralls";
    _x addHeadgear "H_PilotHelmetHeli_B";

} forEach( crew _taxi );

private _group = group _taxi;

// Set waypoint
_group move _pos;
uisleep 3;

[ 1, "<t color='#BBBB00' size ='2' align='center'>TAXI</t><br/><t size='1'>Dein Taxi ist unterwegs, bitte warten</t>" ] remoteExec ["XY_fnc_broadcast", _player];

while { ( (alive _taxi) && !(unitReady _taxi) ) } do {
   uisleep 1;
};

[ 1, "<t color='#BBBB00' size ='2' align='center'>TAXI</t><br/><t size='1'>Dein Taxi landet</t>" ] remoteExec ["XY_fnc_broadcast", _player];

_taxi land "LAND";

waitUntil { uisleep 1; !(alive _taxi) || !(isEngineOn _taxi) };

if( !(alive _taxi) ) exitWith {
    [ 1, "<t color='#BBBB00' size ='2' align='center'>ACHTUNG</t><br/><t size='1'>Irgendwas ist mit dem Taxi passiert, so dass es dich nicht erreichen wird</t>" ] remoteExec ["XY_fnc_broadcast", _player];
};

[ 1, "<t color='#BBBB00' size ='2' align='center'>TAXI</t><br/><t size='1'>Dein Taxi ist gelandet, bitte einsteigen</t>" ] remoteExec ["XY_fnc_broadcast", _player];

private _timeout = time + 90;

_taxi lock 0;
while { (vehicle _player) != _taxi && _timeout > time } do {
    sleep 1;

    if( _player distance _taxi < 2.5 && (alive _player) && !(_player getVariable["restrained", false]) ) exitWith {
        _player action ["GetInCargo", _taxi];
    };
};

if( _timeout < time ) exitWith {

    [ 1, "<t color='#BBBB00' size ='2' align='center'>TAXI</t><br/><t size='1'>Dein Taxi musste zu lange warten und startet wieder</t>" ] remoteExec ["XY_fnc_broadcast", _player];
    [ _taxi] call _taxiReturn;
};

[ 1, "<t color='#BBBB00' size ='2' align='center'>TAXI</t><br/><t size='1'>Dein Taxi startet gleich</t>" ] remoteExec ["XY_fnc_broadcast", _player];
uisleep 5;

_group move (getMarkerPos _destination);
uisleep 2;
_taxi lock 2;
_taxi flyInHeight 80;

while { ( (alive _taxi) && !(unitReady _taxi) ) } do {
   uisleep 1;
};
_taxi land "LAND";

waitUntil { uisleep 1; !(alive _taxi) || !(isEngineOn _taxi) };
_taxi lock 0;

if( !(alive _taxi) ) exitWith {};

[ 1, "<t color='#BBBB00' size ='2' align='center'>TAXI</t><br/><t size='1'>Dein Taxi ist gelandet, bitte aussteigen</t>" ] remoteExec ["XY_fnc_broadcast", _player];

uisleep 5;

// Make the player pay
if( _price > 0 ) then {
    [_price] remoteExec [ "XY_fnc_pay", _player ];
};

[_taxi] call _taxiReturn;