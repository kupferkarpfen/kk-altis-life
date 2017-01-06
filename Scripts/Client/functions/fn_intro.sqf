// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

0 cutText["", "BLACK FADED"];
player allowDamage false;
player forceAddUniform "U_C_Poor_1";

setViewDistance 2100;
setObjectViewDistance [1250, 50];

private _timeout = time + 60;
while { time < _timeout } do {
    [ "<t size='0.8' color='#F0C010'>zzz...ZZZ...zzz...ZZZ...</t>", -1, -1, 1, 1 ] spawn BIS_fnc_dynamicText;
    uisleep 4 + (random 5);
    if( missionNamespace getVariable["XY_GLOBAL_INTRO_START", time] <= time ) exitWith {};
};
XY_GLOBAL_INTRO_START = time + 8;
publicVariable "XY_GLOBAL_INTRO_START";

private _startPos = [2780, 8245, 0];

// Randomize startpos to prevent double-spawn fuckups
_startPos set [0, (_startPos select 0) + (random 25)];
_startPos set [1, (_startPos select 1) + (random 25)];

private _wp1 = [3926, 11373, 0];
private _wp2 = [0, 0, 0];

private _plane = createVehicle [ "C_Plane_Civil_01_F", _startPos, [], 0, "FLY"];
[_plane, 90] remoteExec [ "XY_fnc_registerVehicleForDeletion", 2 ];
createVehicleCrew _plane;

_plane allowDamage false;
_plane flyInHeight 30;
_plane flyInHeightASL [90, 90, 90];
_plane limitSpeed 160;

private _group = group (driver _plane);
{
    _x allowDamage false;
} forEach (units _group);

_group addWaypoint [ _wp1, 100  ];
_group addWaypoint [ _wp2, 100  ];

private _planeLight = "#lightpoint" createVehicleLocal _startPos;
_planeLight setLightBrightness 75;
_planeLight setLightAmbient [1, 0.8, 0.6];
_planeLight setLightColor [1, 0.8, 0.6];
_planeLight lightAttachObject [_plane, [0, 0, 200]];

XY_introCamera  = "CAMERA" camCreate (getPosATL _plane);
XY_introCamera camSetTarget _plane;
XY_introCamera cameraEffect ["internal", "BACK"];
XY_introCamera camSetRelPos [15, 90, 1];
XY_introCamera camCommit 0;

showCinemaBorder true;

[ "<t size='0.8' color='#F0C010'>Der Pilot weckt dich...</t>", -1, -1, 4, 1 ] spawn BIS_fnc_dynamicText;
0 cutText ["", "BLACK IN", 5];

playSound "intro";

uisleep 8;

XY_introCamera camSetRelPos [8, -5, 3];
XY_introCamera camCommit 2;

uisleep 2;

[ "<t size='0.8' color='#F0C010'>Dein Charter-Flug nach Altis wird in Kürze landen</t>", -1, -1, 4, 1 ] spawn BIS_fnc_dynamicText;

XY_introCameraFollow = true;

"IntroCameraFollow" spawn { scriptName _this;
    while { XY_introCameraFollow } do {
        XY_introCamera camSetRelPos [8, 2, 4];
        XY_introCamera camCommit 1;
    };
    XY_introCameraFollow = nil;
};

uisleep 14;

[ "<t size='0.8' color='#F0C010'>Du erinnerst dich an dein altes Leben...</t>", -1, -1, 4, 1 ] spawn BIS_fnc_dynamicText;

uisleep 9;

[ "<t size='0.8' color='#F0C010'>...an die Probleme, die hinter dir liegen...</t>", -1, -1, 4, 1 ] spawn BIS_fnc_dynamicText;

uisleep 9;

[ "<t size='0.8' color='#F0C010'>...und bist dir sicher, dass du die richtige Entscheidung getroffen hast...</t>", -1, -1, 4, 1 ] spawn BIS_fnc_dynamicText;

uisleep 9;

[ "<t size='0.8' color='#F0C010'>...ein neues Leben auf Altis zu beginnen</t>", -1, -1, 4, 1 ] spawn BIS_fnc_dynamicText;

uisleep 9;

XY_introCameraFollow = false;

uisleep 2;
0 cutText ["", "BLACK OUT", 5];
uisleep 3;

[ format ["<t size='0.8' color='#F0C010'>Willkommen in deiner neuen Heimat %1!</t>", profileName], -1, -1, 4, 1 ] spawn BIS_fnc_dynamicText;

uisleep 8;

disableUserInput false;

XY_introCamera cameraEffect ["TERMINATE","BACK"];
camDestroy XY_introCamera;
XY_introCamera = nil;

_plane spawn { scriptName "IntroVehicleDeletion";
    uisleep 60;
    {
        deleteVehicle _x;
    } forEach (crew _this);
    deleteVehicle _this;
};

player setPosATL [3842, 17437, 4];

[nearestBuilding player, true] call XY_fnc_lightHouse;

[ format ["<t size='0.8' color='#F0C010'>Bitte nimm dir etwas Zeit für die Einreise-Formalitäten</t>", profileName], -1, -1, 4, 1 ] spawn BIS_fnc_dynamicText;
uisleep 2;
0 cutText ["", "BLACK IN", 5];

uisleep 6;
hint parseText "<t size='1.8' color='#F0C010'>Tipp</t><br/><t size='1.3' color='#FFFFFF'>Gehe zum Laptop und benutze das Scrollrad, um den Einbürgerungsantrag auszufüllen</t>";

waitUntil { !(isNull findDisplay 2675) };
hint parseText "<t size='1.8' color='#CC0000'>Achtung</t><br/><t size='1.3' color='#FFFFFF'>Bitte trage keine echten Daten ein</t>";

waitUntil { missionNamespace getVariable ["XY_naturalisationUnderway", false] };

uisleep 9;
hint parseText "<t size='1.8' color='#F0C010'>Tutorial</t><br/><t size='1.3' color='#FFFFFF'>Das Wichtigste auf unserer Insel ist die Kommunikation mit deinen Mitbürgern</t>";

uisleep 10;
hint parseText "<t size='1.8' color='#F0C010'>Tutorial</t><br/><t size='1.3' color='#FFFFFF'>Sprechen kannst du mit der Taste 'Caps-Lock'</t>";

uisleep 10;
hint parseText "<t size='1.8' color='#F0C010'>Tutorial</t><br/><t size='1.3' color='#FFFFFF'>Achte auf den Kommunikations-Kanal: Mit den Tasten ',' und '.' kannst du diesen umschalten</t>";

uisleep 15;
hint parseText "<t size='1.8' color='#F0C010'>Tutorial</t><br/><t size='1.3' color='#FFFFFF'>Zur Interaktion mit Fahrzeugen oder Häusern, sowie zum Sammeln von Rohstoffen musst du die 'Windows-Taste' drücken</t>";

uisleep 15;
hint parseText "<t size='1.8' color='#F0C010'>Tutorial</t><br/><t size='1.3' color='#FFFFFF'>Den Kofferraum von Fahrzeugen und den Speicherplatz von Häusern öffnest du mit der Taste 'T'</t>";

uisleep 15;
hint parseText "<t size='1.8' color='#F0C010'>Tutorial</t><br/><t size='1.3' color='#FFFFFF'>Mit Händlern und Verarbeitern kannst du mit dem Mausrad-Menü interagieren</t>";

uisleep 15;
hint parseText "<t size='1.8' color='#F0C010'>Tutorial</t><br/><t size='1.3' color='#FFFFFF'>Dein Einbürgerungsantrag müsste inzwischen genehmigt sein. Hole dir deinen Pass am Drucker ab...</t>";

XY_naturalisationCompleted = true;
// Wait until id card is taken from laptop...
waitUntil { !(missionNamespace getVariable ["XY_naturalisationCompleted", false]) };

hint parseText "<t size='1.8' color='#F0C010'>Dein Ausweis</t><br/><t size='1.3' color='#FFFFFF'>Dein Einbürgerungsantrag wurde genehmigt, deinen Pass kannst du künftig mit 'Alt'+'O' vorzeigen</t>";

uisleep 10;
hint parseText format["<t size='1.8' color='#F0C010'>Begrüßungsgeld</t><br/><t size='1.3' color='#FFFFFF'>Das Einbürgerungsamt hat dir ein Begrüßungsgeld von %1€ genehmigt und auf dein Konto überwiesen</t>", [XY_ssv_startMoney] call XY_fnc_numberText];

uisleep 15;
hint parseText "<t size='1.8' color='#F0C010'>Willkommen</t><br/><t size='1.3' color='#FFFFFF'>Du wirst jetzt in die Hafenstadt Kavala gefahren, wo du dich erstmal in Ruhe umsehen solltest</t>";

uisleep 5;
0 cutFadeOut 9999999;

player addItem "Map";
player assignItem "Map";

setViewDistance 900;
setObjectViewDistance [750, 50];

uisleep 3;