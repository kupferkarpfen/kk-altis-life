// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
// based on work by Tonic

private["_civ","_invs","_license","_robber","_guns","_gun"];

_civ = [_this,0,Objnull,[Objnull]] call BIS_fnc_param;
_invs = [_this,1,[],[[]]] call BIS_fnc_param;
_robber = [_this,2,false,[false]] call BIS_fnc_param;

XY_actionInUse = false;

if( isNull _civ ) exitWith {};

_illegal = 0;
_inv = "";

if(count _invs > 0) then {

    {
        _config = [_x select 0] call XY_fnc_itemConfig;

        _inv = _inv + format[ "%1 %2<br/>", _x select 1, _config select 2 ];
        if( _config select 4 > 0) then {
            _illegal = _illegal + (_config select 4);
        };

    } forEach _invs;

    [0, format[ localize "STR_Cop_Contraband", (_civ getVariable["realName", name _civ]), [_illegal] call XY_fnc_numberText] ] remoteExec ["XY_fnc_broadcast", [west, 2]];

} else {
    _inv = localize "STR_Cop_NoIllegal";
};

if( !alive _civ || player distance _civ > 5 ) exitWith {
    hint format[localize "STR_Cop_CouldntSearch", _civ getVariable["realName", name _civ]]
};

hint parseText format[ "<t color='#FF0000'><t size='2'>%1</t></t><br/><t color='#FFD700'><t size='1.5'><br/>" + (localize "STR_Cop_IllegalItems") + "</t></t><br/>%2<br/><br/><br/><br/><t color='#FF0000'>%3</t>", _civ getVariable["realName", name _civ], _inv, if(_robber) then { "Hat ein Tankstellen oder Bankraub begangen." } else { "" } ];

if( _robber ) then {
    [0, format[localize "STR_Cop_Robber", _civ getVariable["realName",name _civ]]] remoteExec [ "XY_fnc_broadcast" ];
};