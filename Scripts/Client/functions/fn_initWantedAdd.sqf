// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private["_list", "_name"];

disableSerialization;

waitUntil {!isNull (findDisplay 9900)};

_list = (findDisplay 9900) displayCtrl 9902;
lbClear _list;
{
    if( (side _x) isEqualTo civilian ) then {
        _name = _x getVariable["realName", ""];
        if( !(_name isEqualTo "") ) then {
            _list lbAdd format["%1", _name];
            _list lbSetdata [(lbSize _list) - 1, str(_x)];
        };
    };
} forEach playableUnits;

_list = (findDisplay 9900) displayCtrl 9991;
lbClear _list;

_list lbAdd "Dauerhaft störendes Hupen (50€)";
_list lbSetData [ (lbSize _list) - 1, "100"];

_list lbAdd "Fahren ohne Licht (75€)";
_list lbSetData [ (lbSize _list) - 1, "101"];

_list lbAdd "Fahren ohne Führerschein (250€)";
_list lbSetData [ (lbSize _list) - 1, "102"];

_list lbAdd "Gefährliche Fahrweise (250€)";
_list lbSetData [ (lbSize _list) - 1, "103"];

_list lbAdd "Geblitzt bis 15 km/h zu schnell (50€)";
_list lbSetData [ (lbSize _list) - 1, "104"];

_list lbAdd "Geblitzt bis 30 km/h zu schnell (100€)";
_list lbSetData [ (lbSize _list) - 1, "105"];

_list lbAdd "Geblitzt bis 45 km/h zu schnell (150€)";
_list lbSetData [ (lbSize _list) - 1, "106"];

_list lbAdd "Geblitzt bis 60 km/h zu schnell (200€)";
_list lbSetData [ (lbSize _list) - 1, "107"];

_list lbAdd "Geblitzt bis 75 km/h zu schnell (250€)";
_list lbSetData [ (lbSize _list) - 1, "108"];

_list lbAdd "Geblitzt bis 90 km/h zu schnell (300€)";
_list lbSetData [ (lbSize _list) - 1, "109"];

_list lbAdd "Geblitzt bis 105 km/h zu schnell (400€)";
_list lbSetData [ (lbSize _list) - 1, "110"];

_list lbAdd "Geblitzt über 105 km/h zu schnell (500€)";
_list lbSetData [ (lbSize _list) - 1, "111"];

_list lbAdd "Fahren unter Alkohol-/Drogeneinfluss (500€)";
_list lbSetData [ (lbSize _list) - 1, "112"];

_list lbAdd "Fahrerflucht nach Unfall (1500€)";
_list lbSetData [ (lbSize _list) - 1, "114"];

_list lbAdd "Fahren von illegalen Fahrzeugen (1500€)";
_list lbSetData [ (lbSize _list) - 1, "116"];

_list lbAdd "Fliegen ohne Fluglizenz (400€)";
_list lbSetData [ (lbSize _list) - 1, "117"];

_list lbAdd "Fliegen/Schweben unterhalb 300m der Stadt (500€)";
_list lbSetData [ (lbSize _list) - 1, "118"];

_list lbAdd "(Versuchtes) Landen in einer Flugverbotszone (750€)";
_list lbSetData [ (lbSize _list) - 1, "119"];

_list lbAdd "Tankstellenraub (300€)";
_list lbSetData [ (lbSize _list) - 1, "120"];

_list lbAdd "ATM Raub (800€)";
_list lbSetData [ (lbSize _list) - 1, "121"];

_list lbAdd "Überfall auf Personen/Raub (1.000€)";
_list lbSetData [ (lbSize _list) - 1, "122"];

_list lbAdd "Beamtenbeleidigung (300€)";
_list lbSetData [ (lbSize _list) - 1, "126"];

_list lbAdd "Nicht befolgen e.pol.Anordnung (300€)";
_list lbSetData [ (lbSize _list) - 1, "127"];

_list lbAdd "Belästigung eines Polizisten (300€)";
_list lbSetData [ (lbSize _list) - 1, "128"];

_list lbAdd "Betreten der pol.Sperrzone (300€)";
_list lbSetData [ (lbSize _list) - 1, "129"];

_list lbAdd "Widerstand gegen die Staatsgewalt (500€)";
_list lbSetData [ (lbSize _list) - 1, "130"];

_list lbAdd "Beschuss auf Polizei/Beamte/Eigentum (1.000€)";
_list lbSetData [ (lbSize _list) - 1, "131"];

_list lbAdd "Angriff/Belagerung von Hauptstädten (1.500€)";
_list lbSetData [ (lbSize _list) - 1, "132"];

_list lbAdd "Mit gez.Waffe durch Stadt (400€)";
_list lbSetData [ (lbSize _list) - 1, "133"];

_list lbAdd "Schusswaffengebrauch innerhalb Stadt (800€)";
_list lbSetData [ (lbSize _list) - 1, "139"];

_list lbAdd "Waffenbesitz ohne Lizenz (1.000€)";
_list lbSetData [ (lbSize _list) - 1, "140"];

_list lbAdd "Besitz einer verbotenen Waffe (1000€)";
_list lbSetData [ (lbSize _list) - 1, "141"];

_list lbAdd "Drogendelikte (1.500€)";
_list lbSetData [ (lbSize _list) - 1, "142"];

_list lbAdd "Illegale Strassensperren (2.500€)";
_list lbSetData [ (lbSize _list) - 1, "143"];

_list lbAdd "Geiselnahme (2.500€)";
_list lbSetData [ (lbSize _list) - 1, "144"];

_list lbAdd "(Versuchter) Staatsbankraub (3.000€)";
_list lbSetData [ (lbSize _list) - 1, "145"];

_list lbAdd "Kreditbetrug (500€)";
_list lbSetData [ (lbSize _list) - 1, "148"];