// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

XY_helpContents = [];

XY_helpContents pushBack ["ALLGEMEIN"];
XY_helpContents pushBack ["Regeln",
    "<t align='center'>Die Serverregeln findest du in unserem Forum:",
    "<a href='http://just4fungaming24.de/index.php?thread/10-regelwerk-aktualisiert-01-07-2016/'>www.Just4FunGaming24.de</a>",
    "<t size='1.1'>Die allerwichtigsten Regeln in Kürze: Dies ist ein RP Server, bleib <t underline='1'>immer</t> in deiner Rolle. Out-of-RP reden kannst du im Teamspeak.",
    "Respektiere das RP der anderen Spieler, zerstöre ihnen nicht den <t underline='1'>Spaß am Spiel</t> und bleib <t underline='1'>fair</t>.",
    "Behandle andere Spieler nur so, wie du auch selbst behandelt werden möchtest.</t>"
];
XY_helpContents pushBack ["P+R Parkplatz",
    "Der P+R Parkplatz kann zum Abstellen deines LKW benutzt werden. Die Polizei wird dort abgestellte LKW nicht abschleppen. Die Polizei kann jedoch eine Razzia durchführen, um illegale Waren zu beschlagnahmen. Abstellen erfolgt also auf eigene Gefahr: Dieser Parkplatz ist ein Service und nicht risikofrei!"
];
XY_helpContents pushBack ["PvP-Zone",
    "Die PvP-Zone ermöglicht dir bei regelmäßigen Events viel Geld oder seltene Waffen zu ergattern. Das Risiko dort getötet werden ist jedoch sehr hoch. Beachte bitte folgende Hinweise:",
    "1. Du darfst dort ohne RP auf alles und jeden schießen",
    "2. Es gilt dort keine Newlife-Regelung",
    "3. ALLE anderen Regeln sind zu befolgen, insbesondere:",
    "4. Keine Spieler überfahren",
    "5. Keine Fahrzeuge mutwillig zerstören",
    "6. Keine Spieler oder fremde Fahrzeuge dorthin verschleppen"
];
XY_helpContents pushBack ["Teamspeak",
    "<t align='center'>Klicke einfach auf den Link, um dich mit unserem TS zu verbinden:",
    "<a href='http://www.teamspeak.com/invite/ts.just4fungaming24.de'>ts.Just4FunGaming24.de</a></t>"
];
XY_helpContents pushBack ["Forum",
    "<t align='center'>Unser Forum findest du hier:",
    "<a href='http://www.Just4FunGaming24.de/'>www.Just4FunGaming24.de</a></t>"
];
XY_helpContents pushBack ["Vorraussetzungen",
    "<t align='center'>Für folgende Aktionen wird eine Mindestanzahl Polizisten benötigt:",
    "Staatsbank aufbrechen: Ab 10 Polizisten",
    "Angriff auf eine Stadt: Ab 10 Polizisten",
    "Gefängnis aufbrechen: Ab 6 Polizisten",
    "ATMs aufbrechen: Ab 6 Polizisten",
    "Tankstellen ausrauben: Ab 4 Polizisten",
    "</t>"
];

if( playerSide isEqualTo civilian ) then {
    XY_helpContents pushBack ["Tastenkürzel",
        "Z: Spieler-Menü",
        "U: Fahrzeuge auf-/zuschließen",
        "T: Kofferraum öffnen",
        "Windows-Taste: Interaktionstaste + Farmen",
        "Strg + R: Magazine umpacken",
        "Alt + R: RedGull verwenden",
        "Alt + O: Ausweis zeigen",
        "Strg + O: Gesehenen Ausweis erneut anzeigen",
        "Shift + H: Waffe holstern",
        "Shift + F: Bewusstlos schlagen (Benötigt Waffe)",
        "Shift + R: Festnehmen (Benötigt Handschellen)",
        "Shift + P: Ohrstöpsel einstellen",
        "Shift + B: Hände über den Kopf heben",
        "1, 2 oder 3: Begrüßen (Geste)",
        "Strg oder Alt + NumBlock: Verschiedene Gesten",
        "F5: PANIC BUTTON - Protokolliert die Namen aller Spieler in der Umgebung (für Support-Fälle)"
    ];
};
if( playerSide isEqualTo west ) then {
    XY_helpContents pushBack ["Tastenkürzel",
        "Z: Spieler-Menü",
        "T: Kofferraum öffnen",
        "Windows-Taste: Interaktionstaste",
        "Shift + H: Waffe holstern",
        "K: EMP (GhostHawk oder Hellcat)",
        "Q: Yelp (Im Fahrzeug)",
        "F: Polizeisirene (Im Fahrzeug)",
        "Alt + O: Ausweis zeigen",
        "Strg + O: Gesehenen Ausweis erneut anzeigen",
        "Alt + B: Waffen beschlagnahmen",
        "Alt + R: RedGull verwenden",
        "Strg + R: Magazine umpacken",
        "Strg + F: Polizeidurchsage (Im Fahrzeug)",
        "Shift + F: Polizeisirene 2 (Im Fahrzeug)",
        "Shift + L: Blaulicht (Im Fahrzeug)",
        "Shift + R: Festnehmen",
        "Shift + P: Ohrstöpsel benutzen",
        "Shift + O: Tore öffnen",
        "Shift + B: Hände über den Kopf heben",
        "1, 2 oder 3: Begrüßen (Geste)",
        "Strg oder Alt + NumBlock: Verschiedene Gesten",
        "F5: PANIC BUTTON - Protokolliert die Namen aller Spieler in der Umgebung (für Support-Fälle)"
    ];
};
if( playerSide isEqualTo independent ) then {
    XY_helpContents pushBack ["Tastenkürzel",
        "Z: Spieler-Menü",
        "T: Kofferraum öffnen",
        "Windows-Taste: Interaktionstaste / Wiederbeleben",
        "F: Sirene (Im Fahrzeug)",
        "Shift + F: Sirene 2 (Im Fahrzeug)",
        "Shift + L: Blaulicht (Im Fahrzeug)",
        "Alt + O: Ausweis zeigen",
        "Strg + O: Gesehenen Ausweis erneut anzeigen",
        "Alt + R: RedGull verwenden",
        "Shift + P: Ohrstöpsel benutzen",
        "Shift + O: Tore öffnen",
        "1, 2 oder 3: Begrüßen (Geste)",
        "Strg oder Alt + NumBlock: Verschiedene Gesten",
        "F5: PANIC BUTTON - Protokolliert die Namen aller Spieler in der Umgebung (für Support-Fälle)"
    ];
/*
    XY_helpContents pushBack ["KRANKHEITEN"];
    XY_helpContents pushBack ["Influenca",
        "<t align='center'>Eigenschaften</t>",
        "- Hoch ansteckend",
        "- Inkubationszeit: ca. 10 Tage",
        "<t align='center'>Symptome</t>",
        "- Müdigkeit",
        "- Gelenkschmerzen",
        "- Kopfschmerzen",
        "- Übelkeit",
        "- Bauchschmerzen",
        "- Fieber",
        "<t align='center'>Therapie</t>",
        "- Vorbeugung: Grippeschutzimpfung",
        "- Neuraminidase-Inhibitoren (Relenza, Tamiflu)"
    ];
    XY_helpContents pushBack ["Mononukleose",
        "<t align='center'>Eigenschaften</t>",
        "- Ansteckend bei engem Kontakt",
        "- Inkubationszeit: ca. 30 Tage",
        "<t align='center'>Symptome</t>",
        "- Starke Halsschmerzen",
        "- Geschwollene Mandeln",
        "- Fieber",
        "- Schwellung der Lymphknoten",
        "- Fauliger Mundgeruch",
        "- Muskelschmerzen",
        "<t align='center'>Therapie</t>",
        "- Vorbeugung: Keine Impfung möglich",
        "- Keine medikamentöse Therapie möglich",
        "- Viel Trinken",
        "- Fiebersenkende Mittel (Paracetamol, Aspirin, Ibuprof)",
        "- Bei schweren Krankheitsverläufen gegen zusätzliche bakterielle Infektion ein Antibiotikum verabreichen"
    ];
    XY_helpContents pushBack ["Akute Diarrhoe ",
        "<t align='center'>Eigenschaften</t>",
        "- Ansteckend bei engem Kontakt",
        "- Inkubationszeit: ca. 30 Tage",
        "<t align='center'>Symptome</t>",
        "- Starke Halsschmerzen",
        "- Geschwollene Mandeln",
        "- Fieber",
        "- Schwellung der Lymphknoten",
        "- Fauliger Mundgeruch",
        "- Muskelschmerzen",
        "<t align='center'>Therapie</t>",
        "- Vorbeugung: Keine Impfung möglich",
        "- Keine medikamentöse Therapie möglich",
        "- Viel Trinken",
        "- Fiebersenkende Mittel (Paracetamol, Aspirin, Ibuprof)",
        "- Bei schweren Krankheitsverläufen gegen zusätzliche bakterielle Infektion ein Antibiotikum verabreichen"
    ];
    */
};

if( playerSide isEqualTo civilian ) then {

    XY_helpContents pushBack ["SPAWNPUNKTE"];
    XY_helpContents pushBack ["Spawnsystem",
        "Standardmäßig kannst du nur in Kavala spawnen. Sobald du deine ersten Euro verdient hast möchtest du sicherlich mehr Auswahl bei der Wahl deines Spawnpunktes haben:",
        "Du kannst die Spawnpunkte in den Städten Pyrgos, Athira und Sofia gegen eine Gebühr von 300.000€ freischalten. Hinweise, wo sich die Schilder zum Freischalten der Spawnpunkte befinden, findet ihr in den weiteren Unterkategorien."
    ];

    XY_helpContents pushBack ["Pyrgos",
        "<t align='center'>Hinweis zum Freischalten des Spawnpunktes:",
        "Suche das Vermächtnis vergangener Herrscher</t>"
    ];
    XY_helpContents pushBack ["Athira",
        "<t align='center'>Hinweis zum Freischalten des Spawnpunktes:",
        "Hoch in Trümmern</t>"
    ];
    XY_helpContents pushBack ["Sofia",
        "<t align='center'>Hinweis zum Freischalten des Spawnpunktes:",
        "Befrage eine höhere Macht</t>"
    ];
    XY_helpContents pushBack ["Garagen mit [*]",
        "Die Garagen mit [*] müssen an versteckten Schildern freigeschaltet werden",
        "Diese Schilder befinden sich in der Umgebung (auch in Gebäuden) der Garagen (Bis zu 1.5km)",
        "Die Schilder sind für jeden Spieler an anderen Positionen und müssen aktiv gesucht werden",
        "Der Ort wechselt regelmäßig, es lohnt sich also das Gebiet mehrfach zu durchsuchen"
    ];
};


XY_helpContents pushBack ["LEGALE FARMTOUREN"];
XY_helpContents pushBack ["Diamanten",
    "1. Farmen an der Diamantenmine",
    "2. Verarbeiten am Diamantenschleifer",
    "3. Verkaufen am Diamanten-Ankauf"
];
XY_helpContents pushBack ["Eisenbarren",
    "1. Farmen an der Eisenerzmine",
    "2. Verarbeiten an der Eisenschmelze",
    "3. Verkaufen am Eisen- und Kupfer-Ankauf"
];
XY_helpContents pushBack ["Kupferbarren",
    "1. Farmen an der Kupfermine",
    "2. Verarbeiten an der Kupferschmelze",
    "3. Verkaufen am Eisen- und Kupfer-Ankauf"
];
XY_helpContents pushBack ["Salz",
    "1. Farmen an der Salzmine",
    "2. Verarbeiten an der Salzaufbereitung",
    "3. Verkaufen am Salz-Ankauf"
];
XY_helpContents pushBack ["Zement",
    "1. Farmen am Steinbruch",
    "2. Verarbeiten am Zementwerk",
    "3. Verkaufen am Zement-Ankauf"
];
XY_helpContents pushBack ["Goldbarren",
    "1. Farmen an der Goldmine",
    "2. Verarbeiten an der Goldschmiede",
    "3. Verkaufen am Juwelier"
];
XY_helpContents pushBack ["Silberbarren",
    "1. Farmen an der Silbermine",
    "2. Verarbeiten an der Silberschmiede",
    "3. Verkaufen am Silber-Ankauf"
];
XY_helpContents pushBack ["Bretter",
    "1. Farmen am Wald",
    "2. Verarbeiten am Sägewerk",
    "3. Verkaufen beim Schreiner"
];
XY_helpContents pushBack ["Bier",
    "1. Farmen am Hopfenfeld",
    "2. Verarbeiten an der Brauerei",
    "3. Verkaufen am Bierhändler"
];
XY_helpContents pushBack ["Brandy",
    "1. Farmen am Traubenfeld",
    "2. Verarbeiten an der staatl. Brennerei",
    "3. Verkaufen am Schnappshändler"
];
XY_helpContents pushBack ["Müll",
    "1. Farmen an der Mülldeponie",
    "2. Verarbeiten an Mülltrennung",
    "3. Verkaufen am Export-Hafen"
];
XY_helpContents pushBack ["Müllsäcke",
    "1. Farmen beim Plastikabfall",
    "2. Verarbeiten bei Plastik-Verarbeitung",
    "3. Verkaufen am Export-Hafen"
];

XY_helpContents pushBack ["ILLEGALE FARMTOUREN"];
XY_helpContents pushBack ["Schwarzgebrannter",
    "1. Farmen am Traubenfeld",
    "2. Verarbeiten an der Schwarzbrennerei",
    "3. Verkaufen am Schwarzmarkt"
];
XY_helpContents pushBack ["Marihuana",
    "1. Farmen an der Hanf-Plantage",
    "2. Verarbeiten am Marihuanaverarbeiter",
    "3. Verkaufen beim Drogen-Dealer"
];
XY_helpContents pushBack ["Kokain",
    "1. Farmen an der Kokastrauch-Plantage",
    "2. Verarbeiten an der Kokainverarbeitung",
    "3. Verkaufen beim Drogen-Dealer"
];
XY_helpContents pushBack ["Heroin",
    "1. Farmen am Schlafmohnfeld",
    "2. Verarbeiten an der Heroinverarbeitung",
    "3. Verkaufen beim Drogen-Dealer"
];
XY_helpContents pushBack ["LSD",
    "1. Farmen beim Mutterkornpilz",
    "2. Verarbeiten an der LSD-Verarbeitung",
    "3. Verkaufen beim Drogen-Dealer"
];
XY_helpContents pushBack ["Methamphetamin",
    "1. Farmen beim Pseudoephidrin",
    "2. Verarbeiten in der Meth-Küche",
    "3. Verkaufen beim Drogen-Dealer"
];

XY_helpContents pushBack ["SPEZIAL-FARMTOUREN"];
XY_helpContents pushBack ["Illegale Daten",
    "(Nur als PvP-Event)",
    "1. HackBook Pro und USB-Sticks im Rebellen-HQ kaufen",
    "2. USB-Sticks an der abgestürzten Drohne bespielen",
    "3. An der Entschlüsselungsstation verarbeiten",
    "4. Verkaufen beim Darknet-Händler"
];
XY_helpContents pushBack ["Uran",
    "Für das Betreten aller Uran-Stationen ist eine Schutzausrüstung, bestehend aus Strahlenschutzanzug und -helm erforderlich!",
    "Uran kann legal oder illegal gefarmt werden. Der erste Schritt ist immer mit Uranit zum Uranwäscher zu fahren. Danach kann man sich für den legalen oder illegalen Weg entscheiden.",
    "Legaler Weg: Nach dem Auswaschen weiter zur Kernbrennstoffherstellung, anschließend verkaufen am Export-Hafen.",
    "Illegaler Weg: Nach dem Auswaschen mit Uran zur Anreicherung fahren. Uran 238 kann dann direkt verkauft werden, oder es wird im Brutreaktor zu Plutonium weiterverarbeitet. Verkauft wird beides am Schwarzmarkt.",
    "ACHTUNG: Alle Uran-End- und Zwischen-Produkte können nicht in Häuser eingelagert werden und werden auch nicht im Kofferraum der Fahrzeuge oder dem Spielerinventar zwischen Restarts gespeichert!"
];
XY_helpContents pushBack ["Schmuck",
    "(TEAMJOB, LEGAL)",
    "1. Benötigt Gold (verarbeitet)",
    "2. Benötigt Diamant (verarbeitet)",
    "3. Verarbeiten bei der Schmuckfabrik",
    "4. Verkaufen beim Juwelier"
];
XY_helpContents pushBack ["Verbrennbarer Müll",
    "(TEAMJOB, LEGAL)",
    "1. Benötigt Müll (verarbeitet)",
    "2. Benötigt Plastik (verarbeitet)",
    "3. Verarbeiten bei der Müllverpackung",
    "4. Verkaufen beim Kraftwerk"
];
XY_helpContents pushBack ["Fässer",
    "(TEAMJOB, LEGAL)",
    "1. Benötigt Eisen (verarbeitet)",
    "2. Benötigt Kupfer (verarbeitet)",
    "3. Verarbeiten bei der Fassmanufaktur",
    "4. Verkaufen beim Export-Hafen"
];
XY_helpContents pushBack ["Öl",
    "(TEAMJOB, LEGAL)",
    "1. Benötigt Fässer",
    "2. Befüllen auf der Öl-Bohrinsel",
    "3. Verkaufen beim Ölankauf"
];
XY_helpContents pushBack ["Sarin",
    "(TEAMJOB, ILLEGAL)",
    "1. Benötigt 2-Propanol (Farmen beim Schwarzbrenner)",
    "2. Benötigt Methylphosphonsäuredifluorid",
    "3. Verarbeiten beim Sarinhersteller",
    "4. Verkaufen am Schwarzmarkt"
];
XY_helpContents pushBack ["Crocodile",
    "(TEAMJOB, ILLEGAL)",
    "1. Benötigt Heroin (verarbeitet)",
    "2. Benötigt Ölschlamm",
    "3. Benötigt 2-Propanol (Farmen beim Schwarzbrenner)",
    "4. Verarbeiten bei Crocodileverarbeitung",
    "5. Verkaufen am Drogen-Dealer"
];
if( playerSide isEqualTo civilian ) then {
    XY_helpContents pushBack ["LIZENZEN"];
    XY_helpContents pushBack ["Allgemein",
        "Basis-Lizenzen wie Führerschein, Flugschein, etc. werden von den Händlern eingefordert, bevor sie euch die entsprechenden Fahrzeuge verkaufen dürfen.",
        "Die Genehmigungen bei allen Verarbeitern sind optional, allerdings dauert das Verarbeiten ohne Genehmigung ungefähr dreimal so lange."
    ];

    private _prices = ["Preise"];
    private _textLicenses = "";
    {
        if( (_x select 1) isEqualTo "civ" ) then {
            _textLicenses = format["%1%2: %3€<br/>", _textLicenses, _x select 2, [_x select 3] call XY_fnc_numberText];
        };
    } forEach XY_licenses;

    private _textTraining = "";
    {
        _textTraining = format["%1%2: %3€<br/>", _textTraining, _x select 2, [_x select 3] call XY_fnc_numberText];
    } forEach XY_training;

    XY_helpContents pushBack ["Preise", _textLicenses, _textTraining];
};

XY_helpContents pushBack ["SONSTIGES"];

XY_helpContents pushBack ["Credits",
    "Vielen Dank an die vielen Helfer, die dieses Projekt erst möglich gemacht haben und auch mit der Treue bewiesen haben, dass wir eine Community sind. Dank euch kann unser Projekt unter anderem Namen weiterlaufen. Vielen Dank an unsere Supporter, Direktoren und Chefärzte. Ebenfalls vielen Dank an alle Spieler, die jeden Tag mithelfen dass dieser Server noch besser wird.",
    "Einige Icons von http://icons8.com/, Sounds von Kjell Persson, Jamius, IanStarGem, Freezeman, Die drei Lenore, Scott Holmes - Vielen Dank!"
];