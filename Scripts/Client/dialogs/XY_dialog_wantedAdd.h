class XY_dialog_wantedAdd {

    idd = 9900;
    movingEnable = false;
    enableSimulation = true;
    onLoad = "[] spawn XY_fnc_initWantedAdd;";

    class controlsBackground {
        class XY_RscTitleBackground:XY_RscText {
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
            idc = -1;
            x = 0.283437 * safezoneW + safezoneX;
            y = 0.247 * safezoneH + safezoneY;
            w = 0.433125 * safezoneW;
            h = 0.033 * safezoneH;
        };

        class MainBackground:XY_RscText {
            colorBackground[] = {0, 0, 0, 0.7};
            idc = -1;
            x = 0.283437 * safezoneW + safezoneX;
            y = 0.28 * safezoneH + safezoneY;
            w = 0.433125 * safezoneW;
            h = 0.462 * safezoneH;
        };
    };

    class controls {

        class Title : XY_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = 2901;
            text = "POLIZEICOMPUTER :: VERBRECHEN REGISTRIEREN";
            x = 0.283437 * safezoneW + safezoneX;
            y = 0.2514 * safezoneH + safezoneY;
            w = 0.433125 * safezoneW;
            h = 0.022 * safezoneH;
        };

        class PlayerList : XY_RscListBox
        {
            idc = 9902;
            text = "";
            sizeEx = 0.035;

            x = 0.29375 * safezoneW + safezoneX;
            y = 0.302 * safezoneH + safezoneY;
            w = 0.185625 * safezoneW;
            h = 0.396 * safezoneH;
        };


        class RSUCombo_2101: XY_RscListBox
        {
            idc = 9991;
            text = "";
            sizeEx = 0.035;
            x = 0.484531 * safezoneW + safezoneX;
            y = 0.302 * safezoneH + safezoneY;
            w = 0.221719 * safezoneW;
            h = 0.396 * safezoneH;
        };

        class CloseButtonKey : RscButtonMenu {
            idc = -1;
            text = "Schliessen";
            onButtonClick = "closeDialog 0;";
            x = 0.29375 * safezoneW + safezoneX;
            y = 0.7025 * safezoneH + safezoneY;
            w = 0.080 * safezoneW;
            h = 0.023 * safezoneH;
        };


        class AddWanted : RscButtonMenu {
            idc = -1;
            text = "Hinzufügen";
            onButtonClick = "[] call XY_fnc_wantedAdd;";
            x = 0.625 * safezoneW + safezoneX;
            y = 0.7025 * safezoneH + safezoneY;
            w = 0.080 * safezoneW;
            h = 0.023 * safezoneH;
        };
    };
};