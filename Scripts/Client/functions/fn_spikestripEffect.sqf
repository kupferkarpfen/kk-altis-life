// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

while { true } do {

    private _vehicle = objNull;
    waitUntil { uisleep 1; _vehicle = vehicle player; !(_vehicle isEqualTo player) && { player isEqualTo (driver _vehicle) } && { _vehicle isKindOf "Car" } };

    // Solange der Spieler der Fahrer ist...
    while { alive player && { (vehicle player) isEqualTo _vehicle } && { player isEqualTo (driver _vehicle) } } do {

        private _spikeStrips = nearestObjects[ player, ["Land_Razorwire_F"], 5 ];
        if( !(_spikeStrips isEqualTo []) ) exitWith {
            _vehicle setHitPointDamage["HitLFWheel", (0.65 + (random 1)) min 1 ];
            _vehicle setHitPointDamage["HitLF2Wheel", (0.55 + (random 1)) min 1 ];
            _vehicle setHitPointDamage["HitRFWheel", (0.6 + (random 1)) min 1 ];
            _vehicle setHitPointDamage["HitRF2Wheel", (0.75 + (random 1)) min 1 ];
            [_vehicle, "Explowheel"] remoteExecCall ["say3D", playableUnits select { isPlayer _x && { _x distance player < 100 } }];
            deleteVehicle (_spikeStrips select 0);
        };
    };
};