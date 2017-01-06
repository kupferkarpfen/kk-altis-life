// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _tickTime = diag_tickTime;
private _query = param[0, "", [""]];
private _returnSomething = param[1, false, [false]];
private _direct = param[2, false, [false]];

if( _query isEqualTo "" ) exitWith {
    diag_log format["invalid asyncCall(%1)", _this];
    "_INVALID_SQL_STMT";
};

if( (_query find "{") > -1 || (_query find "}") > -1 ) exitWith {
    diag_log format["<HACK SUSPECTED> dropping DB CALL: %1", _this];
};

diag_log format ["QUERY %1", _this];

private _key = if( _direct ) then {
    "extDB3" callExtension format["2:direct:%1", _query];
} else {
    "extDB3" callExtension format["2:custom:%1", _query];
};

if( !_returnSomething ) exitWith { true };

_key = (call compile format["%1", _key]) select 1;

uisleep 0.03;

private _result = "";
private _pipe = "";
while { true } do { scopeName "outer";
    _result = "extDB3" callExtension format["4:%1", _key];
    if( _result isEqualTo "[5]" ) exitWith {
        // This is a multipart message...
        _result = "";
        while{ true } do {
            _pipe = "extDB3" callExtension format["5:%1", _key];
            if( _pipe isEqualTo "") then {
                breakOut "outer";
            };
            _result = format["%1%2", _result, _pipe];
        };
    };
    if (_result isEqualTo "[3]") then {
        diag_log "waiting for extension...";
        uisleep 0.1;
    } else {
        breakOut "outer";
    };
};
diag_log format["RESULT SIZE=(%1) CONTENT=(%2)", count _result, _result];

// Detect database bottlenecks
if( (diag_tickTime - _tickTime) > 2 ) then {
    diag_log format["Duration: %1s | Query: %2", (diag_tickTime - _tickTime), _query];
};

_result = call compile _result;

if( (_result select 0) isEqualTo 0 ) then {
    diag_log format ["extDB3: Protocol Error: %1", _result select 1];
};
_result select 1;