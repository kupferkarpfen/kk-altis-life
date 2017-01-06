// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

XY_announceBounty = false;

while { true } do {

    uisleep 1800;

    if( XY_announceBounty && { playersNumber civilian > 30 } ) then {
        private _highestBounty = [];
        {
            private _player = _x;
            {
                if( (_x select 0) isEqualTo (getPlayerUID _player) ) exitWith {
                    private _total = 0;
                    {
                        _total = _total + (_x select 1);
                    } forEach (_x select 1);
                    if( _highestBounty isEqualTo [] || { _total > (_highestBounty select 0) )then {
                        private _name = _player getVariable["realName", ""];
                        if( !(_name isEqualTo "") ) then {
                            _highestBounty = [ _total, _name ];
                        };
                    };
                };
            } forEach XY_wantedList;
        } forEach allPlayers;

        if( !(_highestBounty isEqualTo []) ) then {
            [1, format["<t color='#FF0000' size ='1.15' align='center'>ALTIS MOST WANTED</t><br/>Der meistgesuchte Kriminelle ist zur Zeit %1 mit einem Kopfgeld von %2€", _highestBounty select 1, _highestBounty select 0 ]] remoteExec ["XY_fnc_broadcast"];
            [0, format["ALTIS MOST WANTED: Der meistgesuchte Kriminelle ist zur Zeit %1 mit einem Kopfgeld von %2€", _highestBounty select 1, _highestBounty select 0 ]] remoteExec ["XY_fnc_broadcast"];
        };
    };
};