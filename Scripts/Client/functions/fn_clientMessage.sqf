// Client Message
// 0 = private message
// 1 = police message
// 2 = message to admin
// 3 = message from admin
// 4 = admin message to all

if( !hasInterface || !(missionNamespace getVariable["XY_gameRunning", false]) ) exitWith {};

private _msg = param[0, "", [""]];
private _from = param[1, "", [""]];
private _type = param[2, -1, [0]];

if( _msg isEqualTo "" || _from isEqualTo "" || _type < 0 ) exitWith {};

private _message = "";
private _plainMessage = "";

switch (_type) do {
    case 0: {
        _plainMessage = format["Nachricht von %1: %2", _from, _msg];
        _message = format ["<t color='#FFCC00'><t size='2'><t align='center'>Neue Nachricht<br/><br/><t color='#33CC33'><t align='left'><t size='1'>An: <t color='#ffffff'>Dich<br/><t color='#33CC33'>Von: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>Nachricht:<br/><t color='#ffffff'>%2", _from, _msg];

        if( !(isObjectHidden player) ) then {
            [player, "SmartphoneSMS"] remoteExecCall ["say3D", playableUnits select { isPlayer _x && { (_x distance player) < 9 } }];
        };
    };
    case 1: {
        if(side player != west) exitWith {};
        _plainMessage = format["Notruf von %1: %2", _from, _msg];
        player createDiaryRecord["calllog", [ _from, _msg ]];
        _message = format["<t color='#316dff'><t size='2'><t align='center'>Neuer Notruf<br/><br/><t color='#33CC33'><t align='left'><t size='1'>An: <t color='#ffffff'>Alle Polizisten<br/><t color='#33CC33'>Von: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>Nachricht:<br/><t color='#ffffff'>%2", _from, _msg];
    };
    case 2: {
        if( XY_showAdminMessages ) then {
            _plainMessage = format["ADMIN Anfrage von %1: %2", _from, _msg];
            if( !(player diarySubjectExists "adminlog") ) then {
                player createDiarySubject ["adminlog", "Admin-Anfragen"];
            };
            player createDiaryRecord["adminlog", [ _from, _msg ]];
            _message = format ["<t color='#ffcefe'><t size='2'><t align='center'>Admin Anfrage<br/><br/><t color='#33CC33'><t align='left'><t size='1'>An: <t color='#ffffff'>Admins<br/><t color='#33CC33'>Von: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>Nachricht:<br/><t color='#ffffff'>%2", _from, _msg];
        };
    };
    case 3: {
        _plainMessage = format["ADMIN NACHRICHT: %1", _msg];
        _message = format ["<t color='#FF0000'><t size='2'><t align='center'>Admin Nachricht<br/><br/><t color='#33CC33'><t align='left'><t size='1'>An: <t color='#ffffff'>Dich<br/><t color='#33CC33'>Von: <t color='#ffffff'>An Admin<br/><br/><t color='#33CC33'>Nachricht:<br/><t color='#ffffff'>%1", _msg];

        if( XY_showAdminMessages ) then {
            _plainMessage = format["%1 - gesendet von %2", _plainMessage, _from];
        };
    };
    case 4: {
        _plainMessage = format["Medic Anfrage: %1", _msg];
        player createDiaryRecord["calllog", [ _from, _msg ]];
        _message = format ["<t color='#FFCC00'><t size='2'><t align='center'>Medic Anfrage<br/><br/><t color='#33CC33'><t align='left'><t size='1'>An: <t color='#ffffff'>Dich<br/><t color='#33CC33'>Von: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>Nachricht:<br/><t color='#ffffff'>%2", _from, _msg];
    };
    case 5: {
        _plainMessage = format["ADMIN NACHRICHT: %1", _msg];
        _message = format ["<t color='#FF0000'><t size='2'><t align='center'>Admin Nachricht<br/><br/><t color='#33CC33'><t align='left'><t size='1'>An: <t color='#ffffff'>Alle Spieler<br/><t color='#33CC33'>Von: <t color='#ffffff'>Den Admins<br/><br/><t color='#33CC33'>Nachricht:<br/><t color='#ffffff'>%1", _msg];

        if( XY_showAdminMessages ) then {
            _plainMessage = format["%1 - gesendet von %2", _plainMessage, _from];
        };
    };
    case 7: {
        _plainMessage = format["POLIZEIMELDUNG: %1", _msg];
        _message = format ["<t color='#0000FF'><t size='2'><t align='center'>POLIZEIMELDUNG<br/><br/><t color='#33CC33'><t align='left'><t size='1'>An: <t color='#ffffff'>Alle Spieler<br/><br/><br/><t color='#33CC33'>Nachricht:<br/><t color='#ffffff'>%1", _msg];
        if( XY_showAdminMessages ) then {
            _plainMessage = format["%1 - gesendet von %2", _plainMessage, _from];
        };
    };
    case 8: {
        _plainMessage = format["SANITÄTER-RUNDNACHRICHT: %1", _msg];
        _message = format ["<t color='#0000FF'><t size='2'><t align='center'>SANITÄTER-<br/>RUNDNACHRICHT<br/><br/><t color='#33CC33'><t align='left'><t size='1'>An: <t color='#ffffff'>Alle Spieler<br/><br/><br/><t color='#33CC33'>Nachricht:<br/><t color='#ffffff'>%1", _msg];
        if( XY_showAdminMessages ) then {
            _plainMessage = format["%1 - gesendet von %2", _plainMessage, _from];
        };
    };
};

if( !(_plainMessage isEqualTo "") ) then {
    hint parseText _message;
    systemChat _plainMessage;
};