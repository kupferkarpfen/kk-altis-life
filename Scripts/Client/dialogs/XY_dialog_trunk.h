// Written by Kupferkarpfens
// License: CC BY-NC-SA 4.0

#define X0 ((0.3625 * safezoneW) + safezoneX)
#define Y0 ((0.3 * safezoneH) + safezoneY)
#define GW (0.025 * safezoneW)
#define GH (0.025 * safezoneH)

class XY_dialog_trunk {

	idd = 3500;

    class controlsBackground {

        class lbHeading : RscStructuredText {

            idc = 3510;
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

        class lbTrunkItems : RscStructuredText {

            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.9 };
            colorText[] = { 1, 1, 1, 1};
            text = "<t size='1' align='center'>KOFFERRAUM</t>";

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

            idc = 3540;
            colorBackground[] = { 0, 0, 0, 0 };
            text = "";

            x = X0 + GW * 0.5;
            y = Y0 + GH * 13;
            w = 4.5 * GW;
            h = GH;
        };

        class lbSellInfo : RscStructuredText {

            idc = 3541;
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
            onButtonClick = "[""exit""] call XY_fnc_trunkMenu;";

            x = X0 + 10 * GW;
            y = Y0;
            w = GW;
            h = GH;

            class Attributes {
                align = "center";
            };
        };

        class lstTrunkItems : RscListBox {
            idc = 3520;
            sizeEx = 0.04;
            colorBackground[] = { 0, 0, 0, 0.4 };
            onLBSelChanged = "[""selection_trunk""] call XY_fnc_trunkMenu;";

            x = X0 + 0.5 * GW;
            y = Y0 + 2.5 * GH;
            w = 4.5 * GW;
            h = 9 * GH;
        };

        class lstPlayerItems : RscListBox {
            idc = 3521;
            sizeEx = 0.04;
            colorBackground[] = { 0, 0, 0, 0.4 };
            onLBSelChanged = "[""selection_player""] call XY_fnc_trunkMenu;";

            x = X0 + 6 * GW;
            y = Y0 + 2.5 * GH;
            w = 4.5 * GW;
            h = 9 * GH;
        };

        class sliderTrunk : XY_RscXSliderH {
            idc = 3530;
            onSliderPosChanged = "[""slider_trunk""] call XY_fnc_trunkMenu;";

            x = X0 + 0.5 * GW;
            y = Y0 + 12 * GH;
            w = 4.5 * GW;
            h = 0.5 * GH;
        };

        class sliderPlayer : XY_RscXSliderH {
            idc = 3531;
            onSliderPosChanged = "[""slider_player""] call XY_fnc_trunkMenu;";

            x = X0 + 6 * GW;
            y = Y0 + 12 * GH;
            w = 4.5 * GW;
            h = 0.5 * GH;
        };

        class btnTake : RscButtonMenu {

            idc = 3550;
            text = "NEHMEN";
            sizeEx = 0.05;
            onButtonClick = "[""take""] call XY_fnc_trunkMenu;";

            x = X0 + 0.5 * GW;
            y = Y0 + 14 * GH;
            w = 4.5 * GW;
            h = GH;

            class Attributes {
                align = "center";
            };
        };

        class btnStore : RscButtonMenu {

            idc = 3551;
            text = "LAGERN";
            sizeEx = 0.05;
            onButtonClick = "[""store""] call XY_fnc_trunkMenu;";

            x = X0 + 6 * GW;
            y = Y0 + 14 * GH;
            w = 4.5 * GW;
            h = GH;

            class Attributes {
                align = "center";
            };
        };
        
        class lbVeil : RscStructuredText {

            idc = 3560;
            colorBackground[] = { 0, 0, 0, 1 };
            colorText[] = { 1, 1, 1, 1};
            text = "<t size='1.5' align='center'>WARTE AUF DATEN</t>";

            x = X0;
            y = Y0 + GH;
            w = 11 * GW;
            h = 14.5 * GH;
        };
    };
};