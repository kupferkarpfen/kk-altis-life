// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

// Anti-Side-Talking Script
// Inspired by http://www.armaholic.com/page.php?id=28897

private _fncCheckVoice = {
    if( !(isNull findDisplay 55) && { !(isNull findDisplay 63) } ) then {

        // User is speaking, check channel...
        if( !(currentChannel in [3, 4, 5]) ) then {
            titleCut [" BITTE NICHT IM SIDECHAT REDEN ", "BLACK IN", 15];
            // Talking side/globally/command, switch to direct:
            setCurrentChannel 5;
        };

        if( currentChannel == 5 && { !(player getVariable["mic", false]) } ) then {
            player setVariable["mic", true, true];
            [] spawn {
                waitUntil { sleep 0.5; isNull (findDisplay 55) || isNull (findDisplay 63) };
                player setVariable["mic", false, true];
            };
        };
    };
    false
};

waitUntil { sleep 1; !(isNull (findDisplay 46)) };
(findDisplay 46) displayAddEventHandler ["KeyDown", _fncCheckVoice];
(findDisplay 46) displayAddEventHandler ["KeyUp", _fncCheckVoice];