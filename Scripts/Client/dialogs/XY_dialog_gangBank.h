class XY_dialog_gangBank {

    idd = 2526;
    movingEnable = false;
    enableSimulation = true;

    class controlsBackground {
        class bgTitle : XY_RscText {
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
            idc = -1;
            x = 0.400 * safezoneW + safezoneX;
            y = 0.375 * safezoneH + safezoneY;
            w = 0.200 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class bgMain : XY_RscText {
            colorBackground[] = {0, 0, 0, 0.8};
            idc = -1;
            x = 0.400 * safezoneW + safezoneX;
            y = 0.400 * safezoneH + safezoneY;
            w = 0.200 * safezoneW;
            h = 0.160 * safezoneH;
        };
    };

    class controls {

        class lblTitle : XY_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = 2500;
            x = 0.400 * safezoneW + safezoneX;
            y = 0.375 * safezoneH + safezoneY;
            w = 0.200 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class lblInfo : XY_RscStructuredText
        {
            idc = 2501;
            x = 0.400 * safezoneW + safezoneX;
            y = 0.410 * safezoneH + safezoneY;
            w = 0.200 * safezoneW;
            h = 0.050 * safezoneH;
        };

        class txtDeposit : XY_RscEdit
        {
            idc = 2502;
            text = "100";
            x = 0.450 * safezoneW + safezoneX;
            y = 0.465 * safezoneH + safezoneY;
            w = 0.100 * safezoneW;
            h = 0.020 * safezoneH;
        };

        class btnClose : RscButtonMenu {
            idc = -1;
            text = "$STR_Global_Close";
            onButtonClick = "closeDialog 0";
            x = 0.405 * safezoneW + safezoneX;
            y = 0.515 * safezoneH + safezoneY;
            w = 0.060 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class btnDeposit : RscButtonMenu {
            idc = 2503;
            text = "Einzahlen";
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
            onButtonClick = "[""postDeposit""] call XY_fnc_gangMenu";
            x = 0.535 * safezoneW + safezoneX;
            y = 0.515 * safezoneH + safezoneY;
            w = 0.060 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class btnWithdraw : RscButtonMenu {
            idc = 2504;
            text = "Abheben";
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
            onButtonClick = "[""postWithdrawal""] call XY_fnc_gangMenu";
            x = 0.535 * safezoneW + safezoneX;
            y = 0.515 * safezoneH + safezoneY;
            w = 0.060 * safezoneW;
            h = 0.025 * safezoneH;
        };
    };
};