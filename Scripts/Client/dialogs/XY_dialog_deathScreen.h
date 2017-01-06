// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

class XY_dialog_deathScreen {

    idd = 7300;

    class controlsBackground {

        class lbHeading : RscStructuredText {

            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.9 };
            colorText[] = { 1, 1, 1, 1};
            text = "<t size='1' align='center'>DU BIST VERSTORBEN</t>";

            x = 0.795 * safezoneW + safezoneX;
            y = 0.17 * safezoneH + safezoneY;
            w = 0.2 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class bgButtons : RscText {

            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.7 };

            x = 0.795 * safezoneW + safezoneX;
            y = 0.195 * safezoneH + safezoneY;
            w = 0.2 * safezoneW;
            h = 0.405 * safezoneH;
        };

        class lbInfoText : RscStructuredText {

            idc = -1;
            colorBackground[] = { 0, 0, 0, 0 };
            colorText[] = { 1, 1, 1, 1};
            text = "<t size='1'><t align='center'>Was bedeutet ""Neues Leben""?</t><br/>Du bekommst ein neues Leben geschenkt: Deine Straftaten werden dir vergeben und du vergisst was zu deinem Tod geführt hat. Du erinnerst dich nicht wer dich wo getötet hat. Kehre binnen der nächsten 15 Minuten nicht zum Ort deines Todes zurück. Das gilt auch, wenn sich das Geschehen mittlerweile wo anders hin verlagert hat.</t>";

            x = 0.8 * safezoneW + safezoneX;
            y = 0.2 * safezoneH + safezoneY;
            w = 0.19 * safezoneW;
            h = 0.22 * safezoneH;
        };

        class lblMedicsOnline : RscText {
            idc = 7310;

            x = 0.8 * safezoneW + safezoneX;
            y = 0.44 * safezoneH + safezoneY;
            w = 0.5 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class lblMedicsNearby : RscText {
            idc = 7311;

            x = 0.8 * safezoneW + safezoneX;
            y = 0.47 * safezoneH + safezoneY;
            w = 0.5 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class lblRespawnTime : RscText {
            idc = 7312;

            x = 0.8 * safezoneW + safezoneX;
            y = 0.54 * safezoneH + safezoneY;
            w = 0.5 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class lbKiller : RscStructuredText {
            idc = 7313;

            colorBackground[] = { 0, 0, 0, 0 };
            colorText[] = { 1, 1, 1, 1};
            text = "";

            x = safezoneX;
            y = (safezoneH + safezoneY) - (0.1 * safezoneH);
            w = safezoneW;
            h = 0.1 * safezoneH;
        };
    };

    class controls {
        class btnMedic : RscButtonMenu {
            idc = 7320;

            x = 0.8 * safezoneW + safezoneX;
            y = 0.50 * safezoneH + safezoneY;
            w = 0.19 * safezoneW;
            h = 0.025 * safezoneH;

            text = "SANITÄTER RUFEN";

            onLoad = "(_this select 0) ctrlEnable false;";
            onButtonClick = "[""request""] call XY_fnc_deathScreen;";

            class Attributes {
                align = "center";
            };
        };
        class btnRespawn : RscButtonMenu {
            idc = 7321;

            x = 0.8 * safezoneW + safezoneX;
            y = 0.57 * safezoneH + safezoneY;
            w = 0.19 * safezoneW;
            h = 0.025 * safezoneH;

            text = "NEUES LEBEN";

            onLoad = "(_this select 0) ctrlEnable false;";
            onButtonClick = "[""respawn""] call XY_fnc_deathScreen;";

            class Attributes {
                align = "center";
            };
        };
    };
};