// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

class XY_HUD {

    idd = -1;
    duration = 999999999;

    fadein = 1;
    fadeout = 1;
    onLoad = "uiNamespace setVariable ['XY_HUD',_this select 0]; [] call XY_fnc_updateHUD;";
    onUnload = "uiNamespace setVariable ['XY_HUD', displayNull];";

    class controlsBackground {

        class Watermark : XY_RscPicture {
            idc = -1;
            text = "icons\watermark.paa";
            style = 48 + 0x800;

            x = safezoneX;
            y = safezoneY;
            w = 0.12 * safezoneW;
            h = 0.12 * safezoneH;
        };

        class Background : XY_RscText {
            idc = -1;

            x = safezoneX;
            y = safezoneY + safezoneH - safezoneH * 0.05;
            w = safezoneW;
            h = 0.05 * safezoneH;

            colorBackground[] = { 0, 0, 0, 0.15 };
        };

        class ICON_THIRST : XY_RscPicture {
            idc = -1;
            text = "icons\water.paa";
            style = 48 + 0x800;

            x = 0.20000 * safezoneW + safezoneX;
            y = 0.95500 * safezoneH + safezoneY;
            w = 0.02500 * safezoneW;
            h = 0.02500 * safezoneH;

            colorBackground[] = {-1, -1, -1, -1};
        };
        class THIRST : XY_RscProgress {
            idc = 5100;

            x = 0.23000 * safezoneW + safezoneX;
            y = 0.96300 * safezoneH + safezoneY;
            w = 0.10000 * safezoneW;
            h = 0.01250 * safezoneH;

            colorBar[] = { 0.20, 0.24, 0.68, 1 };
            colorBackground[] = {-1, -1, -1, -1};
            colorFrame[] = {0, 0, 0, 0.75};
        };
        class TEXT_THIRST : XY_RscText {
            idc = 5200;
            text = "100";
            x = 0.23000 * safezoneW + safezoneX;
            y = 0.96300 * safezoneH + safezoneY;
            w = 0.10000 * safezoneW;
            h = 0.01250 * safezoneH;

            sizeEx = 0.0225;

            class Attributes {
                align = "center";
                color = "#FFFFFF";
            };
        };

        class ICON_HUNGER : XY_RscPicture {
            idc = -1;
            text = "icons\food.paa";
            style = 48 + 0x800;

            x = 0.35000 * safezoneW + safezoneX;
            y = 0.95500 * safezoneH + safezoneY;
            w = 0.02500 * safezoneW;
            h = 0.02500 * safezoneH;
        };
        class HUNGER : XY_RscProgress {
            idc = 5101;

            x = 0.38000 * safezoneW + safezoneX;
            y = 0.96300 * safezoneH + safezoneY;
            w = 0.10000 * safezoneW;
            h = 0.01250 * safezoneH;

            colorBar[] = { 0.78, 0.52, 0.30, 1 };
            colorBackground[] = {-1, -1, -1, -1};
            colorFrame[] = {0, 0, 0, 0.75};
        };
        class TEXT_HUNGER : XY_RscText {
            idc = 5201;
            text = "100";
            x = 0.38000 * safezoneW + safezoneX;
            y = 0.96300 * safezoneH + safezoneY;
            w = 0.10000 * safezoneW;
            h = 0.01250 * safezoneH;

            sizeEx = 0.0225;

            class Attributes {
                align = "center";
                color = "#FFFFFF";
            };
        };

        class ICON_HEALTH : XY_RscPicture {
            idc = -1;
            text = "icons\heart.paa";
            style = 48 + 0x800;

            x = 0.50000 * safezoneW + safezoneX;
            y = 0.95500 * safezoneH + safezoneY;
            w = 0.02500 * safezoneW;
            h = 0.02500 * safezoneH;
        };
        class HEALTH : XY_RscProgress {
            idc = 5102;

            x = 0.53000 * safezoneW + safezoneX;
            y = 0.96300 * safezoneH + safezoneY;
            w = 0.10000 * safezoneW;
            h = 0.01250 * safezoneH;

            colorBar[] = { 0.83, 0.10, 0, 1 };
            colorBackground[] = {-1, -1, -1, -1};
            colorFrame[] = {0, 0, 0, 0.75};
        };
        class TEXT_HEALTH : XY_RscText {

            idc = 5202;
            text = "100";
            x = 0.53000 * safezoneW + safezoneX;
            y = 0.96300 * safezoneH + safezoneY;
            w = 0.10000 * safezoneW;
            h = 0.01250 * safezoneH;

            sizeEx = 0.0225;

            class Attributes {
                align = "center";
                color = "#FFFFFF";
            };
        };

        class ICON_FATIGUE : XY_RscPicture {
            idc = -1;
            text = "icons\running.paa";
            style = 48 + 0x800;

            x = 0.65000 * safezoneW + safezoneX;
            y = 0.95500 * safezoneH + safezoneY;
            w = 0.02500 * safezoneW;
            h = 0.02500 * safezoneH;
        };
        class FATIGUE : XY_RscProgress {
            idc = 5103;

            x = 0.68000 * safezoneW + safezoneX;
            y = 0.96300 * safezoneH + safezoneY;
            w = 0.10000 * safezoneW;
            h = 0.01250 * safezoneH;

            colorBar[] = { 0.05, 0.55, 0.45, 1 };
            colorBackground[] = {-1, -1, -1, -1};
            colorFrame[] = {0, 0, 0, 0.75};
        };
        class TEXT_FATIGUE : XY_RscText {
            idc = 5203;
            text = "100";
            x = 0.68000 * safezoneW + safezoneX;
            y = 0.96300 * safezoneH + safezoneY;
            w = 0.10000 * safezoneW;
            h = 0.01250 * safezoneH;

            sizeEx = 0.0225;

            class Attributes {
                align = "center";
                color = "#FFFFFF";
            };
        };
		
        class ICON_MASKED : XY_RscPicture {
            idc = 5204;
            text = "icons\masked.paa";
            style = 48 + 0x800;

            x = 0.80000 * safezoneW + safezoneX;
            y = 0.95500 * safezoneH + safezoneY;
            w = 0.02500 * safezoneW;
            h = 0.02500 * safezoneH;
        };

        class StatusBar {
            idc = 5104;

            x = safezoneX;
            y = safezoneY + safezoneH - 0.0325;
            w = safezoneW;
            h = 0.035;

            text = "";
            font = "PuristaLight";
            type = 13;
            style = 1;
            size = 0.0285;

            class Attributes {
                align = "center";
                color = "#FFFFFF";
            };

            colorBackground[] = {0, 0, 0, 0};
        };
    };
};