// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

if( visibleMap || { !(alive player) } || { dialog } || { XY_headbag } ) exitWith {
    500 cutText["", "PLAIN"];
};

private _ui = uiNamespace getVariable ["XY_HUD_nameTags", displayNull];
if(isNull _ui) then {
    500 cutRsc["XY_HUD_nameTags", "PLAIN"];
    _ui = uiNamespace getVariable ["XY_HUD_nameTags", displayNull];
};

private _maxDistance = 10;
private _units = [_maxDistance] call XY_fnc_reachablePlayers;
private _count = count _units;
private _groupMembers = units (group player);
private _show = player isEqualTo (vehicle player);

for[ {_i = 0}, {_i <= 25}, {_i = _i + 1} ] do {

    private _idc = _ui displayCtrl (78000 + _i);
    private _visible = false;

    if( _i < _count && _show ) then {
        private _info = _units select _i;
        if( !(_info isEqualTo []) ) then {

            private _unit = _info select 0;
            private _pos = visiblePosition _unit;
            _pos = [ _pos select 0, _pos select 1, ((_unit modelToWorld (_unit selectionPosition "head")) select 2) + .5];
            private _sPos = worldToScreen _pos;

            if( !(_sPos isEqualTo []) ) then {

                private _name = (if(_unit in _groupMembers) then {
                        if( !((_info select 4) isEqualTo "") )exitWith{
                            format["[%1] %2", _info select 4, _info select 1];
                        };
                        _info select 1;
                    } else {
                        _info select 2;
                    });

                private _text = format["<t color='#%1'>%2</t>", _info select 5, _name];

                private _typing = player getVariable["typing", 0];
                if( serverTime - _typing < 3 && _unit getVariable["nextTypeSound", 0] < time ) then {
                    _unit say3D "SmartphoneType";
                    _unit setVariable["nextTypeSound", time + 0.1 + (random 0.33)];
                };
                if( _unit getVariable ["mic", false] ) then {
                    _text = format["<img image='\A3\ui_f\data\igui\rscingameui\rscdisplayvoicechat\microphone_ca.paa'></img> %1", _text];
                };

                _idc ctrlSetStructuredText parseText _text;
                _idc ctrlSetPosition [_sPos select 0, _sPos select 1, 0.4, 0.65];
                _idc ctrlSetScale 1.0;
                _idc ctrlSetFade (1.0 min ((_pos distance player) / _maxDistance));
                _idc ctrlCommit 0;
                _visible = XY_tagsON;
            };
        };
    };
    _idc ctrlShow _visible;
};