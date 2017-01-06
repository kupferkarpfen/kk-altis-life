// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _mode = param[0, -1, [0]];
if( _mode < 0 ) exitWith {};

switch (_mode) do {
    case 0: {
        // player jailed
        license_civ_lawyer = false;
        license_civ_gun = false;
    };
    case 1: {
        // player killed with vehicle
        license_civ_driver = false;
        license_civ_truck = false;
        license_civ_air = false;
        license_civ_boat = false;
    };
    case 2: {
        license_rebel = false;
    };
    case 10: {
        license_civ_driver = false;
        hint "Dein Führerschein wurde von der Polizei beschlagnahmt";
    };
    case 11: {
        license_civ_truck = false;
        hint "Dein LKW-Führerschein wurde von der Polizei beschlagnahmt";
    };
    case 12: {
        license_civ_air = false;
        hint "Dein Flugschein wurde von der Polizei beschlagnahmt";
    };
    case 13: {
        license_civ_boat = false;
        hint "Dein Bootsschein wurde von der Polizei beschlagnahmt";
    };
    case 14: {
        license_civ_dive = false;
        hint "Dein Tauchschein wurde von der Polizei beschlagnahmt";
    };
    case 15: {
        license_civ_gun = false;
        hint "Dein Waffenschein wurde von der Polizei beschlagnahmt";
    };
    case 20: {
        license_civ_driver = false;
        license_civ_truck = false;
        license_civ_air = false;
        license_civ_boat = false;
        license_civ_gun = false;
        license_civ_dive = false;
        hint "Alle Fahr- und Waffenlizenzen wurden von der Polizei beschlagnahmt";
    };
};