// Author: Bryan "Tonic" Boardwine
// Rewritten by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _unit = param[0, objNull, [objNull]];
private _bool = param[1, false, [false]];
private _side = param[2, sideUnknown, [sideUnknown]];

if( _unit isEqualTo objNull || _side isEqualTo sideUnknown ) exitWith {};

private _channel = switch (_side) do {
	case west: { life_radio_west };
	case civilian: { life_radio_civ };
	case independent: { life_radio_indep };
	case east: { life_radio_east };
};

if( _bool ) then {
    _channel radioChannelAdd [_unit];
} else {
    _channel radioChannelRemove [_unit];
};