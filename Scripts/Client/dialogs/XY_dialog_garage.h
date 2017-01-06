class XY_dialog_garage {

    idd = 2800;
    movingEnabled = 0;

    class controlsBackground {

        class lbListHeading: RscStructuredText {

            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.9 };
            colorText[] = { 1, 1, 1, 1};
            text = "<t size='1.15' align='center'>GARAGE</t>";

            x = safezoneX;
            y = 0.2 * safezoneH + safezoneY;
            w = 0.2 * safezoneW;
            h = 0.033 * safezoneH;
        };

        class bgList : RscText {

            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.7 };

            x = safezoneX;
            y = 0.233 * safezoneH + safezoneY;
            w = 0.2 * safezoneW;
            h = 0.42 * safezoneH;
        };
        
        class lbInsureText : RscStructuredText {

            idc = -1;
            colorBackground[] = { 0, 0, 0, 0 };
            colorText[] = { 1, 1, 1, 1};
            text = "<t size='1'>Fahrzeug versichern</t>";

            x = 0.020 * safezoneW + safezoneX;
            y = 0.626 * safezoneH + safezoneY;
            w = 0.170 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class lbInfoHeading: RscStructuredText {

            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.9 };
            colorText[] = { 1, 1, 1, 1};
            text = "<t size='1.15' align='center'>FAHRZEUG-INFO</t>";

            x = (safezoneX + safezoneW) - (0.2 * safezoneW);
            y = 0.2 * safezoneH + safezoneY;
            w = 0.2 * safezoneW;
            h = 0.033 * safezoneH;
        };

        class bgInfo : RscText {

            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.7 };

            x = (safezoneX + safezoneW) - (0.2 * safezoneW);
            y = 0.233 * safezoneH + safezoneY;
            w = 0.200 * safezoneW;
            h = 0.500 * safezoneH;
        };
    };

    class controls {

        class VehicleList : RscListBox {
            idc = 2801;
            text = "";
            sizeEx = 0.04;
            colorBackground[] = { 0, 0, 0, 0.1 };
            onLBSelChanged = "[""update""] call XY_fnc_garageMenu;";

            x = 0.005 * safezoneW + safezoneX;
            y = 0.238 * safezoneH + safezoneY;
            w = 0.190 * safezoneW;
            h = 0.385 * safezoneH;
        };

        class InsureCheckbox : RscCheckBox {
            idc = 2802;
            checked = 1;
            onCheckedChanged = "[""update""] call XY_fnc_garageMenu;";

            x = 0.005 * safezoneW + safezoneX;
            y = 0.627 * safezoneH + safezoneY;
            w = 0.015 * safezoneW;
            h = 0.022 * safezoneH;
        };

        class VehicleInfo : RscStructuredText {
            idc = 2803;
            text = "";
            colorBackground[] = { 0, 0, 0, 0.1 };

            x = (safezoneX + safezoneW) - (0.195 * safezoneW);
            y = 0.238 * safezoneH + safezoneY;
            w = 0.190 * safezoneW;
            h = 0.485 * safezoneH;
        };

        class btnUnimpound : RscButtonMenu
        {
            idc = 2810;
            text = "AUSPARKEN";
            onButtonClick = "[""unimpound""] call XY_fnc_garageMenu";

            x = 0.005 * safezoneW + safezoneX;
            y = 0.670 * safezoneH + safezoneY;
            w = 0.090 * safezoneW;
            h = 0.033 * safezoneH;

            class Attributes {
                align = "center";
            };
        };

        class btnSell : RscButtonMenu
        {
            idc = 2811;
            text = "VERKAUFEN";
            onButtonClick = "[""sell""] spawn XY_fnc_garageMenu";

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
            onButtonClick = "[""exit""] call XY_fnc_garageMenu";

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