/*
    File: fn_setupActions.sqf

    Description:
    Master addAction file handler for all client-based actions.
*/
switch (playerSide) do {
    case civilian: {

        player addAction[ localize "STR_pAct_RobPerson", XY_fnc_robAction, "", 0, false, true, "", '!(isNull cursorObject) && { isPlayer cursorObject } && { player distance cursorObject < 3 } && { cursorObject getVariable["allowRob", false] }'];

        player addAction["Bombenweste aktivieren", { [] spawn XY_fnc_suicideBomb }, "", 0, false, true, "", '(vest player) isEqualTo "V_HarnessOGL_brn" && { alive player } && { !XY_isTazed }'];

        player addAction["Niere klauen", { [] spawn XY_fnc_takeOrgans }, "", 0, false, true, "", ' !(isNull cursorTarget) && { cursorTarget isKindOf "Man" } && { isPlayer cursorTarget } && { alive cursorTarget } && { cursorTarget distance player < 3.5 } && { !(cursorTarget getVariable ["missingOrgan", false]) } && { (animationState cursorTarget) isEqualTo "incapacitated" }'];
    };

    default {

        player addAction["Fahrer", { private _vehicle = cursorTarget; _vehicle lock false; player action ["GetInDriver", _vehicle]; _vehicle lock true; }, "", 9, false, true, "", '!(isNull cursorTarget) && { (vehicle player) isEqualTo player } && { cursorTarget distance player < 3.5 } && { (locked cursorTarget) != 0 } && { cursorTarget getVariable["side", sideUnknown] isEqualTo playerSide }'];

        player addAction["Passagier", { private _vehicle = cursorTarget; _vehicle lock false; player action ["GetInCargo", _vehicle]; _vehicle lock true; }, "", 8, false, true, "", '!(isNull cursorTarget) && { (vehicle player) isEqualTo player } && { cursorTarget distance player < 3.5 } && { (locked cursorTarget) != 0 } && { cursorTarget getVariable["side", sideUnknown] isEqualTo playerSide }'];

        player addAction["Schütze", { private _vehicle = cursorTarget; _vehicle lock false; player action ["GetInGunner", _vehicle]; _vehicle lock true; }, "", 7, false, true, "", '!(isNull cursorTarget) && { (vehicle player) isEqualTo player } && { cursorTarget distance player < 3.5 } && { (locked cursorTarget) != 0 } && { cursorTarget getVariable["side", sideUnknown] isEqualTo playerSide }'];

        player addAction["Kommandant", { private _vehicle = cursorTarget; _vehicle lock false; player action ["GetInCommander", _vehicle]; _vehicle lock true; }, "", 6, false, true,"", '!(isNull cursorTarget) && { (vehicle player) isEqualTo player } && { cursorTarget distance player < 3.5 } && { (locked cursorTarget) != 0 } && { cursorTarget getVariable["side", sideUnknown] isEqualTo playerSide }'];

        player addAction["Aussteigen", { private _vehicle = vehicle player; _vehicle lock false; player action ["GetOut", _vehicle]; _vehicle lock true; }, "", 5, false, true, "", '(vehicle player) != player && { (locked(vehicle player) != 0) } && { (vehicle player) getVariable["side", sideUnknown] isEqualTo playerSide } && { !(player getVariable["restrained", false]) }'];
    };
};