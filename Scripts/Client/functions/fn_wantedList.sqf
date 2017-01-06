// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _wantedList = param[0, [], [[]]];

disableSerialization;
private _list = (findDisplay 2400) displayctrl 2401;

{
    private _entry = _x;
    {
        if( (side _x) isEqualTo civilian && { (_entry select 0) isEqualTo (getPlayerUID _x) } && { !((_entry select 1) isEqualTo []) } ) then {
            private _name = _x getVariable["realName", ""];
            if( !(_name isEqualTo "") ) then {
                _list lbAdd format[ "%1", _name ];
                _list lbSetData [ (lbSize _list) - 1, str(_entry) ];
            };
        };
    } forEach allPlayers;
} forEach _wantedList;

ctrlSetText[2404, "Verbindung hergestellt"];

if( ((lbSize _list) - 1) == -1 ) then {
	_list lbAdd "Keine Einträge";
};