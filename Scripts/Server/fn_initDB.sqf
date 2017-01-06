diag_log "INIT DB";

// Kupferkarpfens pseudo-mutex...

createCriticalSection = {
    [true, true];
};

enterCriticalSection = {
    private _mutex = _this;

    waitUntil { _mutex select 0; };
    _mutex set [0, false];

    waitUntil { _mutex select 1; };
    _mutex set [1, false];
    _mutex set [0, false];
};

leaveCriticalSection = {
    private _mutex = _this;
    _mutex set [1, true];
    _mutex set [0, true];
};

MUTEX_GARAGE = call createCriticalSection;
MUTEX_CTF = call createCriticalSection;
MUTEX_MARKET = call createCriticalSection;
MUTEX_RACING = call createCriticalSection;
MUTEX_UIDRESOLVER = call createCriticalSection;
MUTEX_GANGBANK = call createCriticalSection;

XY_playerSides = [ civilian, west, independent, east ];

//Only need to setup extDB once
if( uiNamespace getVariable ["database_initialized", false] ) exitWith {
    // This is an unsupported state and should not happen!!
    diag_log "extDB: Still connected to database, infinite loop to prevent harm";
    waitUntil { false };
};
uiNamespace setVariable ["database_initialized", true];

_result = "extDB3" callExtension "9:VERSION";
diag_log format ["extDB3: Version: %1", _result];
if( _result isEqualTo "" ) exitWith {
    // This is an unsupported state and should not happen!!
    diag_log "extDB: Init failed, infinite loop";
    waitUntil { false };
};

// Initialize the database
_result = "extDB3" callExtension "9:ADD_DATABASE:AltisLife";
if( !(_result isEqualTo "[1]") ) exitWith { diag_log "EXTDB ERROR: FAILED TO ADD DATABASE"; };

_result = "extDB3" callExtension "9:ADD_DATABASE_PROTOCOL:AltisLife:SQL_CUSTOM:custom:AltisLife.ini";
if( !(_result isEqualTo "[1]") ) exitWith { diag_log "EXTDB ERROR: FAILED TO ADD SQL_CUSTOM"; };

_result = "extDB3" callExtension "9:ADD_DATABASE_PROTOCOL:AltisLife:SQL:direct:TEXT-NULL";
if( !(_result isEqualTo "[1]") ) exitWith { diag_log "EXTDB ERROR: FAILED TO ADD SQL"; };

"extDB3" callExtension "9:LOCK";