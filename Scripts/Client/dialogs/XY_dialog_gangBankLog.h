class XY_dialog_gangBankLog {

    idd = 2527;
    movingEnable = false;
    enableSimulation = true;

    class controlsBackground {
        class bgTitle : XY_RscText {
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
            idc = -1;
            x = 0.330 * safezoneW + safezoneX;
            y = 0.275 * safezoneH + safezoneY;
            w = 0.340 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class bgMain : XY_RscText {
            colorBackground[] = {0, 0, 0, 0.8};
            idc = -1;
            x = 0.330 * safezoneW + safezoneX;
            y = 0.300 * safezoneH + safezoneY;
            w = 0.340 * safezoneW;
            h = 0.410 * safezoneH;
        };
    };

    class controls {

        class lblTitle : RscStructuredText {
            colorBackground[] = {0, 0, 0, 0};
            idc = -1;
            text = "<t size='1.0' align='center'>Log Gangkonto</t>";
            x = 0.330 * safezoneW + safezoneX;
            y = 0.275 * safezoneH + safezoneY;
            w = 0.340 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class lstMembers: RscListbox {
            idc = 1550;
            x = 0.335 * safezoneW + safezoneX;
            y = 0.305 * safezoneH + safezoneY;
            w = 0.330 * safezoneW;
            h = 0.360 * safezoneH;
            sizeEx = 0.035;
            colorBackground[] = {0, 0, 0, 0.2};
        };

        class btnClose : RscButtonMenu {
            idc = -1;
            text = "SCHLIESSEN";
            onButtonClick = "closeDialog 0";
            x = 0.335 * safezoneW + safezoneX;
            y = 0.675 * safezoneH + safezoneY;
            w = 0.070 * safezoneW;
            h = 0.025 * safezoneH;
        };
    };
};