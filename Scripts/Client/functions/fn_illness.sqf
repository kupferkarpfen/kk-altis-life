// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _symptoms = [
    // 0 = Virus
    [ 
        "Du fühlst dich sehr erschöpft",
        "Dein Kopf schmerzt",
        "Deine Gelenke schmerzen",
        "Dir ist sehr übel",
        "Du schwitzt fürchterlich",
        "Dir ist kalt"
    ],  
    // 1 = Bacteria
    [ 
        "Du musst niesen",
        "Dein Hals kratzt",
        "Deine Nase läuft",
        "Du hast Schnupfen",
        "Du hast Halsschmerzen",
        "Das Atmen fällt dir schwer"
    ],  
    // 2 = Fungus
    [ 
        "Du hast Blähungen",
        "Dein Bauch schmerzt",
        "Du fühlst dich überfressen",
        "Du musst dringend auf die Toilette",
		"Du fühlst dich sehr niedergeschlagen",
		"Dein Kopf schmerzt wenn du ins Licht schaust"
    ],    
    // 3 = Parasite
    [ 
		"Dein Kopf juckt",
		"Du musst dich ständig kratzen",
		"Du hast dir blutige Kratzer"
	]
];

private _infectionType = -1;
waitUntil { uisleep 30; _infectionType = (player getVariable ["infection.type", -1]); _infectionType >= 0 };

diag_log format["<INFECTION> Client infection code started, infection type: %1", _infectionType];


while { (player getVariable ["infection.infected", false]) } do {
    uisleep 30;

};