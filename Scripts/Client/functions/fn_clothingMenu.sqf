/*
    File: fn_clothingMenu.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Opens and initializes the clothing store menu.
    Started clean, finished messy.
*/
//Cop / Civ Pre Check
if( (_this select 3) in ["civ", "reb", "kart"] && playerSide != civilian ) exitWith {
    hint localize "STR_Shop_NotaCiv";
};

if( (_this select 3) isEqualTo "reb" && !(missionNamespace getVariable["license_rebel", false]) ) exitWith {
    hint localize "STR_Shop_NotaReb";
};

if( (_this select 3) isEqualTo "cop" && playerSide != west ) exitWith {
    hint localize "STR_Shop_NotaCop";
};

if( (_this select 3) isEqualTo "med" && playerSide != independent ) exitWith {
    hint "Du bist kein Sanitäter";
};

private _pos = getPos player;

private _previewCameraFocusObject = "Land_HelipadEmpty_F" createVehicleLocal [0, 0, 0];
_previewCameraFocusObject setPos [_pos select 0, _pos select 1, 1];
_previewCameraFocusObject enableSimulation false;
_previewCameraFocusObject allowDamage false;

[_previewCameraFocusObject, true, [3, 3, 3], 0.8, 30] spawn XY_fnc_rotatingCamera;

createDialog "XY_dialog_clothing";
disableSerialization;

XY_clothingStore = _this select 3;
XY_cMenuLock = false;

if( isNull (findDisplay 3100) ) exitWith {};
private _list = (findDisplay 3100) displayCtrl 3101;
private _filter = (findDisplay 3100) displayCtrl 3105;
lbClear _filter;
lbClear _list;

_filter lbAdd "Uniformen";
_filter lbAdd "Kopfbedeckungen";
_filter lbAdd "Brillen und Masken";
_filter lbAdd "Westen";
_filter lbAdd "Rucksäcke";
_filter lbSetCurSel 0;

XY_oldClothes = uniform player;
XY_oldUniformItems = uniformItems player;
XY_oldBackpack = backpack player;
XY_oldVest = vest player;
XY_oldVestItems = vestItems player;
XY_oldBackpackItems = backpackItems player;
XY_oldGlasses = goggles player;
XY_oldHat = headgear player;

waitUntil {isNull (findDisplay 3100)};

deleteVehicle _previewCameraFocusObject;

XY_clothingFilter = 0;

if( isNil "XY_clothesPurchased" ) exitWith {

    XY_clothingPurchase = [-1,-1,-1,-1,-1];

    if(XY_oldClothes != "") then {
        player addUniform XY_oldClothes;
    } else {
        removeUniform player
    };

    if(XY_oldHat != "") then {
        player addHeadgear XY_oldHat
    } else {
        removeHeadgear player;
    };
    if(XY_oldGlasses != "") then {
        player addGoggles XY_oldGlasses;
    } else {
        removeGoggles player
    };
    if(backpack player != "") then {
        if(XY_oldBackpack == "") then {
            removeBackpack player;
        } else {
            removeBackpack player;
            player addBackpack XY_oldBackpack;
            clearAllItemsFromBackpack player;
            if(count XY_oldBackpackItems > 0) then {
                {
                    [_x,true,true] call XY_fnc_handleItem;
                } forEach XY_oldBackpackItems;
            };
        };
    };

    if(count XY_oldUniformItems > 0) then {
        {[_x,true,false,false,true] call XY_fnc_handleItem;} forEach XY_oldUniformItems;
    };

    if(vest player != "") then {
        if(XY_oldVest == "") then {
            removeVest player;
        } else {
            player addVest XY_oldVest;
            if(count XY_oldVestItems > 0) then {
                {[_x,true,false,false,true] call XY_fnc_handleItem;} forEach XY_oldVestItems;
            };
        };
    };
};
XY_clothesPurchased = nil;

//Check uniform purchase.
if((XY_clothingPurchase select 0) == -1) then {
    if(XY_oldClothes != uniform player) then {
        player addUniform XY_oldClothes;
    };
};
//Check hat
if((XY_clothingPurchase select 1) == -1) then {
    if(XY_oldHat != headgear player) then {
        if(XY_oldHat == "") then {
            removeHeadGear player;
        } else {
            player addHeadGear XY_oldHat;
        };
    };
};
//Check glasses
if((XY_clothingPurchase select 2) == -1) then {
    if(XY_oldGlasses != goggles player) then {
        if(XY_oldGlasses == "") then {
            removeGoggles player;
        } else {
            player addGoggles XY_oldGlasses;
        };
    };
};
//Check Vest
if((XY_clothingPurchase select 3) == -1) then {
    if(XY_oldVest != vest player) then {
        if(XY_oldVest == "") then {removeVest player;} else {
            player addVest XY_oldVest;
            {[_x,true,false,false,true] call XY_fnc_handleItem;} forEach XY_oldVestItems;
        };
    };
};

//Check Backpack
if((XY_clothingPurchase select 4) == -1) then {
    if(XY_oldBackpack != backpack player) then {
        if(XY_oldBackpack == "") then {
            removeBackpack player;
        } else {
            removeBackpack player;
            player addBackpack XY_oldBackpack;
            {[_x,true,true] call XY_fnc_handleItem;} forEach XY_oldBackpackItems;
        };
    };
};

XY_clothingPurchase = [-1, -1, -1, -1, -1];