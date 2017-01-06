// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _mode = param[0, "", [""]];

if( _mode isEqualTo "" ) exitWith {};

if( _mode isEqualTo "init" ) then {
    createDialog "XY_dialog_help";
};

private _display = findDisplay 9700;
if( isNull _display ) exitWith {};

private _lstTopics = _display displayCtrl 9701;
private _lbContents = _display displayCtrl 9702;

if( _mode isEqualTo "init" ) exitWith {

    // Populate topics...
    lbClear _lstTopics;
    {
        private _topic = _x select 0;
        if( count _x == 1 ) then {
            _topic = format["--- %1 ---", _topic];
        };
        _lstTopics lbAdd _topic;

    } forEach XY_helpContents;

    _lstTopics lbSetCurSel 0;
};

private _index = lbCurSel _lstTopics;
if( _index < 0 ) exitWith {};

if( _mode isEqualTo "selectTopic" ) exitWith {

    private _entry = XY_helpContents select _index;

    private _contents = format["<t size='1.3' align='center'>%1</t>", _entry select 0];
    if( count _entry > 1 ) then {
        {
            if( _forEachIndex > 0 ) then {
                _contents = format["%1<br/><br/>%2", _contents, _x];
            };
        } forEach _entry;
    };
    _lbContents ctrlSetStructuredText parseText _contents;

    private _position = ctrlPosition _lbContents;

    _position set[3, (ctrlTextHeight _lbContents) + safezoneH * 0.01];

    _lbContents ctrlSetPosition _position;
    _lbContents ctrlCommit 0;
};