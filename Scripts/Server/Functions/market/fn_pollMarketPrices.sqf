// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private["_unit"];

if( !params[ ["_unit", objNull, [objNull]] ]) exitWith {};

// Publish
(owner _unit) publicVariableClient "XY_marketPrices";