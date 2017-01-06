// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

diag_log format["validatePlayerName(%1)", _this];

private _owner = param[0, -1, [0]];
private _name = param[1, "", [""]];
private _uid = param[2, "", [""]];

if( _owner < 0 || _name isEqualTo "" || _uid isEqualTo "" ) exitWith {};

private _validName = true;
private _validCharacters = "abcdefghijklmnopqrstuvwxyzäöüABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜ. ";
private _upperCaseCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜ";

// Check if name is valid rp name
private _hasClan = (_name find "[") >= 0 || (_name find "]") >= 0;
private _splittedName = _name splitString " ";

// Check if clantag is valid
if( _hasClan )then {
    diag_log format["<PNAME> Invalid name: Clanname not allowed: %1", _name];
    _validName = false;
};
// Check if playername contains valid characters
if( _validName )then {
    {
            {
                if( _validCharacters find _x < 0 ) exitWith {
                    diag_log format["<PNAME> Invalid playername: %1 -> %2", _name, _x];
                    _validName = false;
                };
            } forEach( _x splitString "" );

    } forEach _splittedName;
};
// Check if it matches the pattern "Name Surname"
if( _validName ) then {
    _validName = (count _splittedName) >= 2 && (count _splittedName) <= 4;
};
// Check if all name parts are long enough
if( _validName )then {
    {
        if( _forEachIndex == 0 && { !(_upperCaseCharacters find _x < 0) } ) exitWith {
            _validName = false;
        };
        if( (count _x) < 2 ) exitWith {
            _validName = false;
        };
    } forEach _splittedName;
};
// Check if it has double spaces
if( (_name find "  ") >= 0 ) then {
    diag_log format["<PNAME> (%1) has double spaces", _name];
    _validName = false;
};

_validName;