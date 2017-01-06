class XY_dialog_spawnSelection {

    idd = 38500;

    class controlsBackground {
        class lbListHeading: RscStructuredText {

            idc = -1;
            text = "<t size='1.15' align='center'>STARTPUNKT</t>";
            colorBackground[] = { 0, 0, 0, 0.9 };
            colorText[] = { 1, 1, 1, 1};

            x = 0.800 * safezoneW + safezoneX;
            y = 0.200 * safezoneH + safezoneY;
            w = 0.195 * safezoneW;
            h = 0.033 * safezoneH;
        };
        class bgList : RscText {

            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.7 };

            x = 0.800 * safezoneW + safezoneX;
            y = 0.233 * safezoneH + safezoneY;
            w = 0.195 * safezoneW;
            h = 0.350 * safezoneH;
        };
    };

    class controls {
        class lstSpawns : RscListBox {

            idc = 38501;
            text = "";
            sizeEx = 0.045;
            colorBackground[] = { 0, 0, 0, 0.1 };
            onLBSelChanged = "[""update""] call XY_fnc_spawnMenu;";

            x = 0.805 * safezoneW + safezoneX;
            y = 0.238 * safezoneH + safezoneY;
            w = 0.185 * safezoneW;
            h = 0.300 * safezoneH;
        };
        class btnSelect : RscButtonMenu {

            idc = 38502;
            text = "START";
            onButtonClick = "[""confirm""] call XY_fnc_spawnMenu";

            x = 0.845 * safezoneW + safezoneX;
            y = 0.545 * safezoneH + safezoneY;
            w = 0.105 * safezoneW;
            h = 0.033 * safezoneH;

            class Attributes {
                align = "center";
            };
        };
    };
};