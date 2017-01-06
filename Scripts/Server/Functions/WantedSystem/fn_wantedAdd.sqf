// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _uid = param[0, "", [""]];
private _type = param[1, "", [""]];

if( _uid isEqualTo "" || _type isEqualTo "" ) exitWith {};

private _customBounty = param [ 2, -1, [0] ];
private _extra = param [ 3, "", [""] ];

private _crime = switch(_type) do {

    case "100": { ["Dauerhaft störendes Hupen", 50] };
    case "101": { ["Fahren ohne Licht", 75] };
    case "102": { ["Fahren ohne Führerschein", 250] };
    case "103": { ["Gefährliche Fahrweise", 250] };
    case "104": { [ format["Geblitzt bis 15 km/h zu schnell (%1)", _extra], 50] };
    case "105": { [ format["Geblitzt bis 30 km/h zu schnell (%1)", _extra], 100] };
    case "106": { [ format["Geblitzt bis 45 km/h zu schnell (%1)", _extra], 150] };
    case "107": { [ format["Geblitzt bis 60 km/h zu schnell (%1)", _extra], 200] };
    case "108": { [ format["Geblitzt bis 75 km/h zu schnell (%1)", _extra], 250] };
    case "109": { [ format["Geblitzt bis 90 km/h zu schnell (%1)", _extra], 300] };
    case "110": { [ format["Geblitzt bis 105 km/h zu schnell (%1)", _extra], 400] };
    case "111": { [ format["Geblitzt über 105 km/h zu schnell (%1)", _extra], 500] };
    case "112": { ["Fahren unter Alkohol-/Drogeneinfluss", 500] };

    case "114": { ["Fahrerflucht nach Unfall", 1500] };
    case "115": { ["Autounfall mit Todesfolge", 1500] };
    case "116": { ["Fahren von illegalen Fahrzeugen", 1500] };
    case "117": { ["Fliegen ohne Fluglizenz", 400] };
    case "118": { ["Fliegen/Schweben unterhalb 300m der Stadt", 500] };
    case "119": { ["(Versuchtes) Landen in einer Flugverbotszone", 750] };

    case "120": { ["Tankstellenraub", 300] };
    case "121": { ["ATM Raub", 800] };
    case "122": { ["Überfall auf Personen/Raub", 1000] };
    case "123": { ["(Versuchter) Hauseinbruch", 1000] };
    case "124": { ["(Versuchter) Fahrzeugdiebstahl", 1000] };

    case "126": { ["Beamtenbeleidigung", 300] };
    case "127": { ["Nicht befolgen e.pol.Anordnung", 300] };
    case "128": { ["Belästigung eines Polizisten", 300] };
    case "129": { ["Betreten der pol.Sperrzone", 300] };
    case "130": { ["Widerstand gegen die Staatsgewalt", 500] };
    case "131": { ["Beschuss auf Polizei/Beamte/Eigentum", 1000] };
    case "132": { ["Angriff/Belagerung von Hauptstädten", 1500] };
    case "133": { ["Mit gez.Waffe durch Stadt", 400] };

    case "135": { ["Organhandel", 600] };
    case "136": { ["Besitz illegaler Ware", 600] };
    case "138": { ["Handel mit illegaler Ware", 1500] };

    case "139": { ["Schusswaffengebrauch innerhalb Stadt", 800] };
    case "140": { ["Waffenbesitz ohne Lizenz", 1000] };
    case "141": { ["Besitz einer verbotenen Waffe", 1000] };
    case "142": { ["Drogendelikte", 1500] };
    case "143": { ["Illegale Strassensperren", 2500] };
    case "144": { ["Geiselnahme", 2500] };
    case "145": { ["(Versuchter) Bankraub/Gefängnisaufbruch", 2000] };
    case "146": { [ format["Mord an %1", _extra], 3000] };
    case "147": { ["Ausbruch aus dem Gefängnis", 10000] };
    case "148": { ["Kreditbetrug", 500] };
    default { [] };
};

if( _crime isEqualTo [] ) exitWith {};

//Is there a custom bounty being sent? Set that as the pricing.
if( _customBounty != -1 ) then {
    _crime set[1, _customBounty];
};

private _found = false;
{
    if( (_x select 0) isEqualTo _uid ) exitWith {
        _found = true;
        (_x select 1) pushBack _crime;
    };
} forEach XY_wantedList;

if( !_found ) then {
    XY_wantedList pushBack [_uid, [_crime]];
};

// Insert crime into database
[format["insertWanted:%1:%2:%3", _uid, _crime select 0, _crime select 1]] remoteExec ["XYDB_fnc_asyncCall", XYDB];