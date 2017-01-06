// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

disableSerialization;

0 cutRsc ["XY_loading", "PLAIN"];
XY_startupDone = false;

"StartProgress" spawn { scriptName _this;
    disableSerialization;

    private _ui = uiNamespace getVariable "XY_loading";
    private _progressBar = _ui displayCtrl 44201;
    private _titleText = _ui displayCtrl 44202;

    private _messages = [];
    _messages pushBack "Resourcen verbuddeln";
    _messages pushBack "Verarbeiter platzieren";
    _messages pushBack "Shops bestücken";
    _messages pushBack "Gras mähen";
    _messages pushBack "Gefängnis abschließen";
    _messages pushBack "Rebellen böse machen";
    _messages pushBack "Polizisten knuddeln";
    _messages pushBack "Sanitäter mit Medikamenten versorgen";
    _messages pushBack "Fahrzeuge sabotieren";
    _messages pushBack "Stromleitungen aufstellen";
    _messages pushBack "Fische aus dem Hafen scheuchen";
    _messages pushBack "Radioturm platzieren";
    _messages pushBack "PvP-Zone abstecken";
    _messages pushBack "Safezones konfigurieren";
    _messages pushBack "Staatsbank mit Gold beladen";
    _messages pushBack "Marktpreise auswürfeln";
    _messages pushBack "Balancing optimieren";
    _messages pushBack "Blackfoot verstecken";
    _messages pushBack "Gehaltschecks vorbereiten";
    _messages pushBack "Häuser platzieren";
    _messages pushBack "Schießerei vorbereiten";
    _messages pushBack "Nagelbänder legen";
    _messages pushBack "Drogen anpflanzen";
    _messages pushBack "Meth-Küche putzen";
    _messages pushBack "Hasen verjagen";
    _messages pushBack "Bäume und Helikopter versöhnen";
    _messages pushBack "Desyncs vorbereiten";
    _messages pushBack "Waffenkiste bestücken";
    _messages pushBack "Hauskisten verbuggen";
    _messages pushBack "Mietfahrzeuge anschaffen";
    _messages pushBack "Zufällige Bugs generieren";
    _messages pushBack "Spawnpunkte entfernen";
    _messages pushBack "Spritverbrauch erhöhen";

    _messages = [_messages] call XY_fnc_shuffle;

    private _index = 0;
    private _count = count _messages;
    private _loops = 0;

    private _cp = 0;
    private _nextMessage = time;
    while { true } do { scopeName "ProgressLoop";

        if( _nextMessage < time ) then {
            _titleText ctrlSetStructuredText parseText format["<t align='center'>%1...</t>", _messages select _index];
            _index = _index + 1;
            if( _index >= _count ) then {
                _index = 0;
            };
            _nextMessage = time + 2 + (random 2);
        };
        _cp = _cp + 0.001;
        if( XY_startupDone ) then {
            _cp = _cp + (random 0.0125);
        } else {
            if( _cp > 0.9 ) then {
                _cp = _cp - 0.00075;
            };
        };
        if( _cp > 0.25 ) then {
            disableUserInput false;
        };
        if( _cp > 1 ) then {
            if( XY_startupDone ) exitWith {
                breakOut "ProgressLoop";
            };
            ["ServerError", false, true] call BIS_fnc_endMission;
        };
        _progressBar progressSetPosition _cp;

        uisleep 0.03;
    };

    // Add a veil below to allow fade-in when everything is setup
    cutText["", "BLACK FADED"];
    // Remove startup screen
    0 cutText ["", "PLAIN"];

    XY_startupDone = nil;
};