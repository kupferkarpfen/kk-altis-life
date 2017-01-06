class XY_dialog_wantedList {

    idd = 2400;
    movingEnable = false;
    enableSimulation = true;

    class controlsBackground {
        class XY_RscTitleBackground:XY_RscText {
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
            idc = -1;
            x = 0.200 * safezoneW + safezoneX;
            y = 0.100 * safezoneH + safezoneY;
            w = 0.600 * safezoneW;
            h = 0.030 * safezoneH;
        };

        class MainBackground:XY_RscText {
            colorBackground[] = {0, 0, 0, 0.7};
            idc = -1;
            x = 0.200 * safezoneW + safezoneX;
            y = 0.130 * safezoneH + safezoneY;
            w = 0.600 * safezoneW;
            h = 0.600 * safezoneH;
        };
    };

    class controls {

        class Title : XY_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = -1;
            text = "Fahndungscomputer";
            x = 0.200 * safezoneW + safezoneX;
            y = 0.100 * safezoneH + safezoneY;
            w = 0.600 * safezoneW;
            h = 0.030 * safezoneH;
        };

        class WantedConnection : Title {
            idc = 2404;
            style = 1;
            text = "";
        };

        class WantedList : XY_RscListBox
        {
            idc = 2401;
            text = "";
            sizeEx = 0.035;
            onLBSelChanged = "[] call XY_fnc_wantedInfo";

            x = 0.200 * safezoneW + safezoneX;
            y = 0.135 * safezoneH + safezoneY;
            w = 0.200 * safezoneW;
            h = 0.550 * safezoneH;
        };

        class WantedDetails : XY_RscListBox
        {
            idc = 2402;
            text = "";
            sizeEx = 0.035;
            colorBackground[] = {0, 0, 0, 0};

            x = 0.425 * safezoneW + safezoneX;
            y = 0.16 * safezoneH + safezoneY;
            w = 0.20 * safezoneW;
            h = 0.55 * safezoneH;
        };

        class BountyPrice : XY_RscText
        {
            idc = 2403;
            text = "";
            x = 0.425 * safezoneW + safezoneX;
            y = 0.135 * safezoneH + safezoneY;
            w = 0.200 * safezoneW;
            h = 0.025 * safezoneH;
        };
        
        class PardonButtonKey : RscButtonMenu {
            idc = 2405;
            text = "LÖSCHEN";
            onButtonClick = "[] spawn XY_fnc_pardon;";
            x = 0.55 * safezoneW + safezoneX;
            y = 0.70 * safezoneH + safezoneY;
            w = 0.08 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class CloseButtonKey : RscButtonMenu {
            idc = -1;
            text = "SCHLIESSEN";
            onButtonClick = "closeDialog 0;";
            
            x = 0.70 * safezoneW + safezoneX;
            y = 0.70 * safezoneH + safezoneY;
            w = 0.08 * safezoneW;
            h = 0.025 * safezoneH;
        };


    };
};