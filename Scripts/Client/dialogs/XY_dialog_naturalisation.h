class XY_dialog_naturalisation {
    idd = 2675;
    onLoad = "";

    class controlsBackground {
        class bgHead: XY_RscText {
            idc = -1;
            x = 0.300 * safezoneW + safezoneX;
            y = 0.250 * safezoneH + safezoneY;
            w = 0.400 * safezoneW;
            h = 0.025 * safezoneH;
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
        };
        class bgMain: XY_RscText {
            idc = -1;
            x = 0.300 * safezoneW + safezoneX;
            y = 0.275 * safezoneH + safezoneY;
            w = 0.400 * safezoneW;
            h = 0.425 * safezoneH;
            colorBackground[] = {0, 0, 0, 0.8};
        };
        class lbHeading: RscStructuredText {
            idc = -1;
            text = "<t size='1.15' align='center'>EINBÜRGERUNGSANTRAG</t>";
            x = 0.300 * safezoneW + safezoneX;
            y = 0.250 * safezoneH + safezoneY;
            w = 0.400 * safezoneW;
            h = 0.025 * safezoneH;
            colorBackground[] = {0, 0, 0, 0};
        };
        class lbName: RscStructuredText {
            idc = -1;
            text = "<t size='1.0' align='right'>NAME:</t>";
            x = 0.300 * safezoneW + safezoneX;
            y = 0.290 * safezoneH + safezoneY;
            w = 0.195 * safezoneW;
            h = 0.025 * safezoneH;
            colorBackground[] = {0, 0, 0, 0};
        };
        class lbTown : RscStructuredText {
            idc = -1;
            text = "<t size='1.0' align='right'>WOHNORT:</t>";
            x = 0.300 * safezoneW + safezoneX;
            y = 0.330 * safezoneH + safezoneY;
            w = 0.195 * safezoneW;
            h = 0.025 * safezoneH;
            colorBackground[] = {0, 0, 0, 0};
        };
        class lbAddress : RscStructuredText {
            idc = -1;
            text = "<t size='1.0' align='right'>STRASSE:</t>";
            x = 0.300 * safezoneW + safezoneX;
            y = 0.370 * safezoneH + safezoneY;
            w = 0.195 * safezoneW;
            h = 0.025 * safezoneH;
            colorBackground[] = {0, 0, 0, 0};
        };
        class lbBirthday : RscStructuredText {
            idc = -1;
            text = "<t size='1.0' align='right'>GEBURTSTAG:</t>";
            x = 0.300 * safezoneW + safezoneX;
            y = 0.410 * safezoneH + safezoneY;
            w = 0.195 * safezoneW;
            h = 0.025 * safezoneH;
            colorBackground[] = {0, 0, 0, 0};
        };
        class lbBirthdayHint : RscStructuredText {
            idc = -1;
            text = "<t size='1.0' align='center' color='#DD0000'>(Achtung: Wir haben das Jahr 2035)</t>";
            x = 0.300 * safezoneW + safezoneX;
            y = 0.450 * safezoneH + safezoneY;
            w = 0.400 * safezoneW;
            h = 0.025 * safezoneH;
            colorBackground[] = {0, 0, 0, 0};
        };
        class lbBirthLocation : RscStructuredText {
            idc = -1;
            text = "<t size='1.0' align='right'>GEBURTSORT:</t>";
            x = 0.300 * safezoneW + safezoneX;
            y = 0.490 * safezoneH + safezoneY;
            w = 0.195 * safezoneW;
            h = 0.025 * safezoneH;
            colorBackground[] = {0, 0, 0, 0};
        };
        class lbHeight: RscStructuredText {
            idc = -1;
            text = "<t size='1.0' align='right'>[ in Zentimetern, z.B.: 183 ] GROESSE:</t>";
            x = 0.300 * safezoneW + safezoneX;
            y = 0.530 * safezoneH + safezoneY;
            w = 0.195 * safezoneW;
            h = 0.025 * safezoneH;
            colorBackground[] = {0, 0, 0, 0};
        };
        class lbEyecolor: RscStructuredText {
            idc = -1;
            text = "<t size='1.0' align='right'>AUGENFARBE:</t>";
            x = 0.300 * safezoneW + safezoneX;
            y = 0.570 * safezoneH + safezoneY;
            w = 0.195 * safezoneW;
            h = 0.025 * safezoneH;
            colorBackground[] = {0, 0, 0, 0};
        };
    };
    class controls {
        class txtName : XY_RscEdit {
            idc = 12100;
            text = "";
            onKeyUp = "[""typed""] call XY_fnc_naturalisation;";
            x = 0.505 * safezoneW + safezoneX;
            y = 0.290 * safezoneH + safezoneY;
            w = 0.185 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class txtTown : XY_RscEdit {
            idc = 12101;
            text = "";
            onKeyUp = "[""typed""] call XY_fnc_naturalisation;";
            x = 0.505 * safezoneW + safezoneX;
            y = 0.330 * safezoneH + safezoneY;
            w = 0.185 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class txtAddress : XY_RscEdit {
            idc = 12102;
            text = "";
            onKeyUp = "[""typed""] call XY_fnc_naturalisation;";
            x = 0.505 * safezoneW + safezoneX;
            y = 0.370 * safezoneH + safezoneY;
            w = 0.185 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class txtBirthday : XY_RscEdit {
            idc = 12103;
            text = "";
            onKeyUp = "[""typed""] call XY_fnc_naturalisation;";
            x = 0.505 * safezoneW + safezoneX;
            y = 0.410 * safezoneH + safezoneY;
            w = 0.080 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class txtBirthLocation : XY_RscEdit {
            idc = 12104;
            text = "";
            onKeyUp = "[""typed""] call XY_fnc_naturalisation;";
            x = 0.505 * safezoneW + safezoneX;
            y = 0.490 * safezoneH + safezoneY;
            w = 0.185 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class txtHeight : XY_RscEdit {
            idc = 12105;
            text = "";
            onKeyUp = "[""typed""] call XY_fnc_naturalisation;";
            x = 0.505 * safezoneW + safezoneX;
            y = 0.530 * safezoneH + safezoneY;
            w = 0.185 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class txtEyecolor : XY_RscCombo {
            idc = 12106;
            text = "";
            onLBSelChanged = "[""typed""] call XY_fnc_naturalisation;";
            x = 0.505 * safezoneW + safezoneX;
            y = 0.570 * safezoneH + safezoneY;
            w = 0.185 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class btnSubmit : RscButtonMenu {
            idc = -1;
            text = "BEANTRAGEN";
            onButtonClick = "[""confirm""] spawn XY_fnc_naturalisation;";
            x = 0.450 * safezoneW + safezoneX;
            y = 0.667 * safezoneH + safezoneY;
            w = 0.070 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class btnCancel : RscButtonMenu {
            idc = -1;
            text = "ABBRECHEN";
            x = 0.530 * safezoneW + safezoneX;
            y = 0.667 * safezoneH + safezoneY;
            w = 0.070 * safezoneW;
            h = 0.025 * safezoneH;
            onButtonClick = "closeDialog 0;";
        };
    };
};