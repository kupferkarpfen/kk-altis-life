class XY_dialog_vehicleShop {

    idd = 9300;
    movingEnabled = 0;

    class controlsBackground {

        class lbListHeading: RscStructuredText {

            idc = 9301;
            colorBackground[] = { 0, 0, 0, 0.9 };
            colorText[] = { 1, 1, 1, 1};
            text = "";

            x = safezoneX;
            y = 0.2 * safezoneH + safezoneY;
            w = 0.2 * safezoneW;
            h = 0.033 * safezoneH;
        };
        
        class lbSkinHeading: RscStructuredText {

            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.9 };
            colorText[] = { 1, 1, 1, 1};
            text = "<t size='1' align='center'>LACKIERUNG</t>";

            x = safezoneX;
            y = 0.510 * safezoneH + safezoneY;
            w = 0.2 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class bgList : RscText {

            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.7 };

            x = safezoneX;
            y = 0.233 * safezoneH + safezoneY;
            w = 0.2 * safezoneW;
            h = 0.42 * safezoneH;
        };

        class lbInfoHeading: RscStructuredText {

            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.9 };
            colorText[] = { 1, 1, 1, 1};
            text = "<t size='1.15' align='center'>FAHRZEUG-INFO</t>";

            x = (safezoneX + safezoneW) - (0.2 * safezoneW);
            y = 0.375 * safezoneH + safezoneY;
            w = 0.2 * safezoneW;
            h = 0.033 * safezoneH;
        };

        class bgInfo : RscText {

            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.7 };

            x = (safezoneX + safezoneW) - (0.2 * safezoneW);
            y = 0.375 * safezoneH + safezoneY;
            w = 0.200 * safezoneW;
            h = 0.250 * safezoneH;
        };
    };

    class controls {

        class VehicleList : RscListBox {
            idc = 9310;
            text = "";
            sizeEx = 0.04;
            colorBackground[] = { 0, 0, 0, 0.1 };
            onLBSelChanged = "[""selectVehicle""] call XY_fnc_vehicleShopMenu;";

            x = 0.005 * safezoneW + safezoneX;
            y = 0.238 * safezoneH + safezoneY;
            w = 0.190 * safezoneW;
            h = 0.270 * safezoneH;
        };

        class SkinList : RscListBox {
            idc = 9311;
            text = "";
            sizeEx = 0.04;
            colorBackground[] = { 0, 0, 0, 0.1 };
            onLBSelChanged = "[""selectSkin""] call XY_fnc_vehicleShopMenu;";

            x = 0.005 * safezoneW + safezoneX;
            y = 0.540 * safezoneH + safezoneY;
            w = 0.190 * safezoneW;
            h = 0.105 * safezoneH;
        };

        class VehicleInfo : RscStructuredText {
            idc = 9302;
            text = "";
            colorBackground[] = { 0, 0, 0, 0.1 };

            x = (safezoneX + safezoneW) - (0.195 * safezoneW);
            y = 0.410 * safezoneH + safezoneY;
            w = 0.190 * safezoneW;
            h = 0.210 * safezoneH;
        };

        class btnRent : RscButtonMenu
        {
            idc = 9320;
            text = "MIETEN";
            onButtonClick = "[""rent""] call XY_fnc_vehicleShopMenu";

            x = 0.005 * safezoneW + safezoneX;
            y = 0.670 * safezoneH + safezoneY;
            w = 0.090 * safezoneW;
            h = 0.033 * safezoneH;

            class Attributes {
                align = "center";
            };
        };

        class btnBuy : RscButtonMenu
        {
            idc = 9321;
            text = "KAUFEN";
            onButtonClick = "[""buy""] spawn XY_fnc_vehicleShopMenu";

            x = 0.100 * safezoneW + safezoneX;
            y = 0.670 * safezoneH + safezoneY;
            w = 0.090 * safezoneW;
            h = 0.033 * safezoneH;

            class Attributes {
                align = "center";
            };
        };

        class btnClose : RscButtonMenu
        {
            idc = -1;
            text = "ABBRECHEN";
            onButtonClick = "[""exit""] call XY_fnc_vehicleShopMenu";

            x = 0.005 * safezoneW + safezoneX;
            y = 0.710 * safezoneH + safezoneY;
            w = 0.185 * safezoneW;
            h = 0.033 * safezoneH;

            class Attributes {
                align = "center";
            };
        };
    };
};