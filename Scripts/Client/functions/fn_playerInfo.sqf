// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// return player name (internal + external) + rank, important for various menues

private _player = param [ 0, objNull, [objNull] ];

if( isNull _player ) exitWith { [] };
if( !(alive _player) || !(isPlayer _player) ) exitWith { [] };

// first check if we have a cached entry (~4x faster when using cached results)
private _cacheLine = [];
private _return = [];
{
    if( (_x select 0) isEqualTo _player ) exitWith {
        _cacheLine = _x;
        if( time < (_x select 1) ) exitWith {
            _return = _x select 2;
        };
    };
} forEach XY_infoCache;

// cache hit!
if( !(_return isEqualTo []) ) exitWith { _return };

// cache miss
private _friendsName = _player getVariable["realName", "ERROR"];
private _externalName = "ERROR";
private _rank = "";
private _rankShort = "";
private _color = "";
private _isFriend = _player in (units (group player));

switch( side _player ) do {
    case civilian: {
        _externalName = [_friendsName, "Maskiert"] select ([_player] call XY_fnc_playerMasked);

        private _karma = _player getVariable["karma", XY_ssv_karmaBase];
        _color = switch( true ) do {
            case( _karma < XY_ssv_karmaBase * 0.1 ): { "FF1111" };
            case( _karma < XY_ssv_karmaBase * 0.5 ): { "AF3A0C" };
            case( _karma > XY_ssv_karmaMax * 0.85 ): { "98EA98" };
            case( _karma > XY_ssv_karmaMax * 0.99 ): { "40E840" };
            case( _isFriend ): { "7FD9AC" };
            default { "ECECEC" };
        };
    };
    case west: {
        private _masked = [_player] call XY_fnc_playerMasked;
        _externalName = ["Polizist", "Maskiert"] select _masked;
        _color = ["004D7F", "ECECEC"] select _masked;

        _rank = switch(_player getVariable["copLevel", 0]) do {
            case 1:  { _rankShort = "P";   "Praktikant"        };
            case 2:  { _rankShort = "A";   "Anwärter"          };
            case 3:  { _rankShort = "WM";  "Wachtmeister"      };
            case 4:  { _rankShort = "OWM"; "Oberwachtmeister"  };
            case 5:  { _rankShort = "HWM"; "Hauptwachtmeister" };
            case 6:  { _rankShort = "PK";  "Kommissar"         };
            case 7:  { _rankShort = "POK"; "Oberkommissar"     };
            case 8:  { _rankShort = "PHK"; "Hauptkommissar"    };
            case 9:  { _rankShort = "PL";  "Polizeileutnant"   };
            case 10: { _rankShort = "PD";  "Polizei-Direktor"  };
        };
    };
    case east: {
        _externalName = "THW";
        _color = "003399";
        _rank = switch(_player getVariable["thwLevel", 0]) do {
            case 1:  { _rankShort = "J";   "THW-Jugend"          };
            case 2:  { _rankShort = "H";   "Helfer"              };
            case 3:  { _rankShort = "TF";  "Truppführer"         };
            case 4:  { _rankShort = "GF";  "Gruppenführer"       };
            case 5:  { _rankShort = "ZF";  "Zugführer"           };
            case 6:  { _rankShort = "A";   "Ausbilder"           };
            case 7:  { _rankShort = "DSL"; "Dienststellenleiter" };
        };
    };
    case independent: {

        _externalName = "Sanitäter";
        _color = "E81B1B";
        _rank = switch(_player getVariable["medicLevel", 0]) do {
            case 1:  { _rankShort = "E";   "Ersthelfer"       };
            case 2:  { _rankShort = "S";   "Sanitäter"        };
            case 3:  { _rankShort = "NA";  "Notarzt"          };
            case 4:  { _rankShort = "SA";  "Stationsarzt"     };
            case 5:  { _rankShort = "OA";  "Oberarzt"         };
            case 6:  { _rankShort = "AA"; "Amtsarzt" };
            case 7:  { _rankShort = "CA";  "Chefarzt"         };
        };
    };
};
_return = [_player, _friendsName, _externalName, _rank, _rankShort, _color, _isFriend];

if( _cacheLine isEqualTo [] ) then {
    // was not cached, add it...
    XY_infoCache pushBack [ _player, time + 6, _return ];
} else {
    // update cache
    _cacheLine set[2, _return];
    _cacheLine set[1, time + 6];
};
_return;