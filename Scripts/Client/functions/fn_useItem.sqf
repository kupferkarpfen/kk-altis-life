// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

disableSerialization;

private _item = param[ 0, "", [""] ];

if( _item isEqualTo "" ) exitWith {};

switch (_item) do {
    case "water";
    case "coffee": {
        if( [_item, 1] call XY_fnc_removeItemFromTrunk ) then {
            XY_thirst = 0 max (XY_thirst - 0.25 - (random 0.5));
        };
    };
    case "apple";
    case "grape";
    case "salema";
    case "ornate";
    case "mackerel";
    case "tuna";
    case "mullet";
    case "catshark";
    case "applepie";
    case "rabbit";
    case "donuts";
    case "tbacon";
    case "peach";
    case "rusk";
    case "doner";
    case "cookie": {
        [_item] call XY_fnc_eatFood;
    };
    // Everything below cannot be used when jailed
    case XY_isArrested: {
        hint "Das kannst du im Knast nicht benutzen";
    };
    case "boltcutter": {
        [cursorTarget] spawn XY_fnc_boltcutter;
    };
    case "chip0";
    case "chip1";
    case "chip2";
    case "chip3";
    case "chip4";
    case "chip5": {
        [_item] spawn XY_fnc_chiptune;
    };
    case "radarwarner": {
        [] spawn XY_fnc_radarwarner;
    };
    case "tracker": {
        [] spawn XY_fnc_tracker;
    };
    case "fishnet": {
        [] spawn XY_fnc_dropFishingNet;
    };
    case "sarin": {
        hint parseText "<t size='1.5' color='#FF0000'>Das hättest du nicht benutzen sollen!</t>";
        [0, format["%1 hat am Sarin geschnüffelt: Das ging nicht gut für ihn aus...", profileName] ] remoteExec ["XY_fnc_broadcast"];
        [] spawn {
            uisleep 3;
            player setDamage 1;
        };
    };
    case "blastingcharge": {
        if( {side _x == west} count playableUnits < 10 ) then {
        hint localize "STR_Civ_NotEnoughCops"
    }else{
        player reveal fed_bank;
        [cursorTarget] spawn XY_fnc_blastingCharge;
        };
    };
    case "bottledwhiskey";
    case "bottledbeer";
    case "brandy";
    case "moonshine": {
        if( [_item, 1] call XY_fnc_removeItemFromTrunk ) then {
            [_item] call XY_fnc_useAlcohol;
        };
    };
    case "amadol";
    case "morphin";
    case "metamizol";
    case "oxycodon": {
        if( [_item, 1] call XY_fnc_removeItemFromTrunk ) then {
            [_item] call XY_fnc_usePainkiller;
        };
    };
    case "radx": {
        if( [_item, 1] call XY_fnc_removeItemFromTrunk ) then {

            if( XY_radx > 0 && { XY_radx > time - 300 } ) then {
                hint "Rad-X ist bei übermäßiger Einnahme giftig";
                [] spawn {
                    while { true } do {
                        sleep 30 + (random 90);
                        if( XY_radx > time ) then {
                            titleCut [" ", "WHITE IN", random 30];
                        };
                    };
                };
            } else {
                hint "Du bist jetzt für 15 Minuten immun gegen radioaktive Strahlung";
            };

            XY_radx = time + 900;
            titleCut [" ", "WHITE IN", 1];
        };
    };
    case "marijuana";
    case "cocainep";
    case "heroinp";
    case "methp";
    case "frogslsd": {
        if( [_item, 1] call XY_fnc_removeItemFromTrunk ) then {
            [_item] call XY_fnc_useDrugs;
        };
    };
    case "defusekit": {
        player reveal fed_bank;
        [cursorTarget] spawn XY_fnc_defuseKit;
    };
    case "storagebig": {
        [_item] call XY_fnc_storageBox;
    };
    case "redgull": {
        if( [_item, 1] call XY_fnc_removeItemFromTrunk ) then {
            closeDialog 0;

            XY_thirst = 0 max (XY_thirst - 0.1 - (random 0.33));

            // Check if there is a redgull thread active...
            if( XY_redgullEffectTimeout < time ) then {
                player enableStamina false;
                // Nope, spawn one:
                [] spawn {
                    waitUntil { sleep 5; !(alive player) || (time > XY_redgullEffectTimeout) };
                    player enableStamina true;
                };
            };
            XY_redgullEffectTimeout = time + 120;

            titleCut [" ", "WHITE IN", 1];
        };
    };
    case "spikeStrip": {
        if( !(isNull XY_spikeStrip) ) exitWith {};
        if( [_item, 1] call XY_fnc_removeItemFromTrunk ) then {
            [] spawn XY_fnc_spikeStrip;
        };
    };
    case "fuelF": {
        [] spawn XY_fnc_jerryRefuel;
    };
    case "fuelE": {
        [] spawn XY_fnc_refuelFuelcan;
    };
    case "lockpick": {
        [] spawn XY_fnc_lockpick;
    };
    case "pickaxe": {
        hint "Bitte benutze die Windows-Taste um dieses Item zu verwenden";
    };
    default {

        if( (_item find "medicine_") > -1 ) exitWith {
            if( [_item, 1] call XY_fnc_removeItemFromTrunk ) then {
                private _config = [ _item ] call XY_fnc_itemConfig;
                hint format["Du hast ein(e) %1 benutzt", _config select 2];
                player setDamage ((damage player) - 0.2);
            };
        };
        hint "Dieses Item ist nicht benutzbar";
    };
};

[] call XY_fnc_p_updateMenu;
[] call XY_fnc_updateHUD;