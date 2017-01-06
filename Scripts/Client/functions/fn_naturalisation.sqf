// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _mode = param[0, "", [""]];

if( missionNamespace getVariable ["XY_naturalisationUnderway", false] ) exitWith {};

disableSerialization;

if( _mode isEqualTo "init" ) then {
    createDialog "XY_dialog_naturalisation";
};

private _dialog = findDisplay 2675;
if( isNull _dialog ) exitWith {};

private _txtName = _dialog displayCtrl 12100;
private _txtTown = _dialog displayCtrl 12101;
private _txtAddress = _dialog displayCtrl 12102;
private _txtBirthday = _dialog displayCtrl 12103;
private _txtBirthLocation = _dialog displayCtrl 12104;
private _txtHeight = _dialog displayCtrl 12105;
private _cmbEyeColor = _dialog displayCtrl 12106;

if( _mode isEqualTo "init" ) exitWith {
    _txtName ctrlSetText profileName;
    _txtName ctrlEnable false;

    _txtTown ctrlSetText ([KV_town, ""] call XY_fnc_kvsGet);
    _txtAddress ctrlSetText ([KV_address, ""] call XY_fnc_kvsGet);
    _txtBirthday ctrlSetText ([KV_birthday, ""] call XY_fnc_kvsGet);
    _txtBirthLocation ctrlSetText ([KV_birthlocation, ""] call XY_fnc_kvsGet);
    _txtHeight ctrlSetText ([KV_height, ""] call XY_fnc_kvsGet);

    private _eyeColors = [
        "BLAU",
        "BRAUN",
        "GRAU",
        "GRÜN"
    ];

    private _fill = lbSize _cmbEyeColor <= 0;
    private _eyeColor = [KV_eyecolor, _eyeColors select 0] call XY_fnc_kvsGet;
    {
        if( _fill ) then {
            _cmbEyeColor lbAdd _x;
        };
        if( _eyeColor isEqualTo _x )then {
            _cmbEyeColor lbSetCurSel _forEachIndex;
        };
    } forEach _eyeColors;
};

if( _mode isEqualTo "typed" ) exitWith {
    [KV_town, toUpper (ctrlText _txtTown)] call XY_fnc_kvsPut;
    [KV_address, toUpper (ctrlText _txtAddress)] call XY_fnc_kvsPut;
    [KV_birthday, ctrlText _txtBirthday] call XY_fnc_kvsPut;
    [KV_birthlocation, toUpper(ctrlText _txtBirthLocation)] call XY_fnc_kvsPut;
    [KV_height, ctrlText _txtHeight] call XY_fnc_kvsPut;
    [KV_eyecolor, _cmbEyeColor lbText (lbCurSel _cmbEyeColor)] call XY_fnc_kvsPut;
};

if( _mode isEqualTo "confirm" ) exitWith {

    scopeName "ConfirmScope";

    // Do one more update...
    ["typed"] call XY_fnc_naturalisation;

    private _validChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ ";
    private _validNumbers = "01234567890";

    // Validate data
    private _birthDay = [KV_birthday, ""] call XY_fnc_kvsGet;
    {
        if( (_validNumbers find _x) < 0 && ("." find _x) < 0 ) exitWith {
            hint parseText format[XY_hintError, "Dein Geburtstag darf nur Zahlen und Punkte enthalten"];
            breakOut "ConfirmScope";
        };
    } forEach (_birthDay splitString "");

    _birthDay = (_birthDay splitString ".");
    if( (count _birthDay) != 3 || { count (_birthDay select 0) != 2 } || { count (_birthDay select 1) != 2 } || { count (_birthDay select 2) != 4 } || { !([_birthDay select 0] call XY_fnc_isNumber) } || { !([_birthDay select 1] call XY_fnc_isNumber) } || { !([_birthDay select 2] call XY_fnc_isNumber) } ) exitWith {
        hint parseText format[XY_hintError, "Geburtstag muss im Format DD.MM.YYYY sein"];
    };
    if( (parseNumber(_birthDay select 0)) < 0 || (parseNumber(_birthDay select 0)) > 31 ) exitWith {
        hint parseText format[XY_hintError, "Der Geburtstag darf nicht kleiner 0 oder größer 31 sein"];
    };
    if( (parseNumber(_birthDay select 1)) < 0 || (parseNumber(_birthDay select 1)) > 12 ) exitWith {
        hint parseText format[XY_hintError, "Der Geburtsmonat darf nicht kleiner 0 oder größer 12 sein"];
    };
    if( (parseNumber(_birthDay select 2)) < 1960 || (parseNumber(_birthDay select 2)) > 2019 ) exitWith {
        hint parseText format[XY_hintError, "Das Geburtsjahr darf nicht kleiner 1960 oder größer 2019 sein"];
    };

    private _birthLocation = [KV_birthlocation, ""] call XY_fnc_kvsGet;
    {
        if( (_validChars find _x) < 0 ) exitWith {
            hint parseText format[XY_hintError, "Dein Geburtsort darf nur die Buchstaben A-Z enthalten"];
            breakOut "ConfirmScope";
        };
    } forEach (_birthLocation splitString "");

    if( (count _birthLocation) < 3 || (count _birthLocation) > 20 ) exitWith {
        hint parseText format[XY_hintError, "Dein Geburtsort muss mindestens 3 und maximal 20 Zeichen haben"];
    };

    private _address = [KV_address, ""] call XY_fnc_kvsGet;
    {
        if( (_validChars find _x) < 0 && (_validNumbers find _x) < 0 ) exitWith {
            hint parseText format[XY_hintError, "Deine Straße darf nur die Buchstaben A-Z und Zahlen enthalten"];
            breakOut "ConfirmScope";
        };
    } forEach (_address splitString "");
    if( (count _address) < 3 || (count _address) > 25 ) exitWith {
        hint parseText format[XY_hintError, "Deine Straße muss mindestens 3 und maximal 25 Zeichen haben"];
    };

    private _town = [KV_town, ""] call XY_fnc_kvsGet;
    {
        if( (_validChars find _x) < 0 ) exitWith {
            hint parseText format[XY_hintError, "Dein Wohnort darf nur die Buchstaben A-Z enthalten"];
            breakOut "ConfirmScope";
        };
    } forEach (_town splitString "");
    if( (count _town) < 3 || (count _town) > 20 ) exitWith {
        hint parseText format[XY_hintError, "Deine Wohnort muss mindestens 3 und maximal 20 Zeichen haben"];
    };

    private _height = [KV_height, ""] call XY_fnc_kvsGet;
    {
        if( (_validNumbers find _x) < 0 ) exitWith {
            hint parseText format[XY_hintError, "Deine Größe darf nur Zahlen enthalten"];
            breakOut "ConfirmScope";
        };
    } forEach (_height splitString "");

    if( !([_height] call XY_fnc_isNumber) ) exitWith {
        hint parseText format[XY_hintError, "Deine Größe ist keine Nummer"];
    };
    _height = parseNumber _height;
    if( _height < 140 || _height > 220 ) exitWith {
        hint parseText format[XY_hintError, "Deine Größe muss zwischen 140 und 220cm sein"];
    };

    private _action = [
        "Bitte kontrolliere deinen Antrag auf Tippfehler: Du kannst deine Angaben später nicht mehr ändern und sie stehen in deinem Ausweis! Du musst künftig immer mit diesem Namen verbinden, wenn du den Antrag bestätigst.",
        "Antrag abgeben?",
        "OK",
        "KORRIGIEREN"
    ] call XY_fnc_showQuestionbox;

    if( !_action ) exitWith {};

    closeDialog 0;

    [KV_name, profileName] call XY_fnc_kvsPut;

    // Full sync to server...
    [true] call XY_fnc_persistKVS;

    XY_naturalisationUnderway = true;
    hint parseText "<t size='1.5' color='#F0C010'>Vielen Dank</t><br/><t size='1.0' color='#FFFFFF'>Dein Einbürgerungsantrag wird jetzt bearbeitet</t>";
};