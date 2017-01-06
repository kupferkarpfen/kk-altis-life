// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
// First test of using a grid macro :)

#define X0 ((0.3625 * safezoneW) + safezoneX)
#define Y0 ((0.3 * safezoneH) + safezoneY)
#define GW (0.025 * safezoneW)
#define GH (0.025 * safezoneH)

class XY_dialog_virtualShop {

    idd = 8100;

    class controlsBackground {

        class lbHeading : RscStructuredText {

            idc = 8110;
            colorBackground[] = { 0, 0, 0, 0.9 };
            colorText[] = { 1, 1, 1, 1 };
            text = "";

            x = X0;
            y = Y0;
            w = 11 * GW;
            h = GH;
        };

        class bgMain : RscText {

            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.7 };

            x = X0;
            y = Y0;
            w = 11 * GW;
            h = 15.5 * GH;
        };

        class lbShopItems : RscStructuredText {

            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.9 };
            colorText[] = { 1, 1, 1, 1};
            text = "<t size='1' align='center'>VERKÄUFER</t>";

            x = X0 + GW * 0.5;
            y = Y0 + GH * 1.5;
            w = 4.5 * GW;
            h = GH;
        };

        class lbPlayerItems : RscStructuredText {

            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.9 };
            colorText[] = { 1, 1, 1, 1};
            text = "<t size='1' align='center'>DEINE WAREN</t>";

            x = X0 + GW * 6;
            y = Y0 + GH * 1.5;
            w = 4.5 * GW;
            h = GH;
        };

        class lbBuyInfo : RscStructuredText {

            idc = 8140;
            colorBackground[] = { 0, 0, 0, 0 };
            text = "";

            x = X0 + GW * 0.5;
            y = Y0 + GH * 13;
            w = 4.5 * GW;
            h = GH;
        };

        class lbSellInfo : RscStructuredText {

            idc = 8141;
            colorBackground[] = { 0, 0, 0, 0 };
            text = "";

            x = X0 + GW * 6;
            y = Y0 + GH * 13;
            w = 4.5 * GW;
            h = GH;
        };
    };

    class controls {

        class btnClose : RscButtonMenu {

            idc = -1;
            text = "X";
            sizeEx = 0.05;
            onButtonClick = "[""exit""] call XY_fnc_virtualShopMenu;";

            x = X0 + 10 * GW;
            y = Y0;
            w = GW;
            h = GH;

            class Attributes {
                align = "center";
            };
        };

        class lstShopItems : RscListBox {
            idc = 8120;
            sizeEx = 0.04;
            colorBackground[] = { 0, 0, 0, 0.4 };
            onLBSelChanged = "[""selection_shop""] call XY_fnc_virtualShopMenu;";

            x = X0 + 0.5 * GW;
            y = Y0 + 2.5 * GH;
            w = 4.5 * GW;
            h = 9 * GH;
        };

        class lstPlayerItems : RscListBox {
            idc = 8121;
            sizeEx = 0.04;
            colorBackground[] = { 0, 0, 0, 0.4 };
            onLBSelChanged = "[""selection_player""] call XY_fnc_virtualShopMenu;";

            x = X0 + 6 * GW;
            y = Y0 + 2.5 * GH;
            w = 4.5 * GW;
            h = 9 * GH;
        };

        class sliderShop : XY_RscXSliderH {
            idc = 8130;
            onSliderPosChanged = "[""slider_shop""] call XY_fnc_virtualShopMenu;";

            x = X0 + 0.5 * GW;
            y = Y0 + 12 * GH;
            w = 4.5 * GW;
            h = 0.5 * GH;
        };

        class sliderPlayer : XY_RscXSliderH {
            idc = 8131;
            onSliderPosChanged = "[""slider_player""] call XY_fnc_virtualShopMenu;";

            x = X0 + 6 * GW;
            y = Y0 + 12 * GH;
            w = 4.5 * GW;
            h = 0.5 * GH;
        };

        class btnBuy : RscButtonMenu {

            idc = 8150;
            text = "KAUFEN";
            sizeEx = 0.05;
            onButtonClick = "[""buy""] call XY_fnc_virtualShopMenu;";

            x = X0 + 0.5 * GW;
            y = Y0 + 14 * GH;
            w = 4.5 * GW;
            h = GH;

            class Attributes {
                align = "center";
            };
        };

        class btnSell : RscButtonMenu {

            idc = 8151;
            text = "VERKAUFEN";
            sizeEx = 0.05;
            onButtonClick = "[""sell""] call XY_fnc_virtualShopMenu;";

            x = X0 + 6 * GW;
            y = Y0 + 14 * GH;
            w = 4.5 * GW;
            h = GH;

            class Attributes {
                align = "center";
            };
        };
    };
};