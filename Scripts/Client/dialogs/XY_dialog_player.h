class XY_dialog_player {

    idd = 2001;
    movingEnable = true;
    enableSimulation = true;

    class controlsBackground {

    class XY_RscTitleBackground : XY_RscText {
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
            idc = -1;
            x = 0.1;
            y = 0.2;
            w = 0.8;
            h = (1 / 25);
        };

        class MainBackground : XY_RscText {
            colorBackground[] = {0, 0, 0, 0.7};
            idc = -1;
            x = 0.1;
            y = 0.2 + (11 / 250);
            w = 0.8;
            h = 0.6 - (22 / 250);
        };

        class Title : XY_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = -1;
            text = "$STR_PM_Title";
            x = 0.1;
            y = 0.2;
            w = 0.8;
            h = (1 / 25);
        };

        class moneyStatusInfo : XY_RscStructuredText
        {
            idc = 2015;
            sizeEx = 0.020;
            text = "";
            x = 0.105;
            y = 0.30;
            w = 0.3; h = 0.6;
        };

        class PlayersName : Title {
            idc = 2009;
            style = 1;
            text = "";
        };
    };

    class controls {

        class itemHeader : XY_RscText
        {
            idc = -1;
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
            text = "$STR_PM_cItems";
            sizeEx = 0.04;

            x = 0.62; y = 0.26;
            w = 0.275; h = 0.04;
        };

        class licenseHeader : XY_RscText
        {
            idc = -1;
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
            text = "$STR_PM_Licenses";
            sizeEx = 0.04;

            x = 0.336; y = 0.26;
            w = 0.275; h = 0.04;
        };

        class moneySHeader : XY_RscText
        {
            idc = -1;
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
            text = "$STR_PM_MoneyStats";
            sizeEx = 0.04;

            x = 0.11; y = 0.26;
            w = 0.219; h = 0.04;
        };

        class itemList : XY_RscListBox
        {
            idc = 2005;
            sizeEx = 0.030;

            onMouseButtonDblClick = "(_this select 0) ctrlEnable false; if( (lbCurSel 2005) >= 0 ) then { [lbData[2005, lbCurSel 2005]] call XY_fnc_useItem; }; (_this select 0) ctrlEnable true;";

            x = 0.62; y = 0.30;
            w = 0.275; h = 0.3;
        };

        class moneyEdit : XY_RscEdit
        {
            idc = 2018;

            text = "1";
            sizeEx = 0.030;
            x = 0.12; y = 0.42;
            w = 0.18; h = 0.03;
        };

        class NearPlayers : XY_RscCombo
        {
            idc = 2022;

            x = 0.12; y = 0.46;
            w = 0.18; h = 0.03;
        };

        class moneyGive : RscButtonMenu
        {
            idc = 2001;
            text = "$STR_Global_Give";
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
            onButtonClick = "(_this select 0) ctrlEnable false; call XY_fnc_giveMoney; (_this select 0) ctrlEnable true;";
            sizeEx = 0.025;
            x = 0.135; y = 0.50;
            w = 0.13; h = 0.036;
        };

        class itemEdit : XY_RscEdit {

        idc = 2010;

        text = "1";
        sizeEx = 0.030;
        x = 0.62; y = 0.61;
        w = 0.275; h = 0.03;

        };
        class iNearPlayers : XY_RscCombo
        {
            idc = 2023;

            x = 0.62; y = 0.65;
            w = 0.275; h = 0.03;
        };

        class GiveItemButton : RscButtonMenu {

            idc = 2002;
            text = "$STR_Global_Give";
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
            onButtonClick = "(_this select 0) ctrlEnable false; call XY_fnc_giveItem; (_this select 0) ctrlEnable true;";

            x = 0.765;
            y = 0.70;
            w = (5.25 / 40);
            h = (1 / 25);

        };

        class UseButton : RscButtonMenu {

            text = "$STR_Global_Use";
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
            onButtonClick = "(_this select 0) ctrlEnable false; if( (lbCurSel 2005) >= 0 ) then { [lbData[2005, lbCurSel 2005]] call XY_fnc_useItem; }; (_this select 0) ctrlEnable true;";

            x = 0.62;
            y = 0.70;
            w = (5.25 / 40);
            h = (1 / 25);

        };

        class RemoveButton : RscButtonMenu {

            text = "$STR_Global_Remove";
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
            onButtonClick = "(_this select 0) ctrlEnable false; call XY_fnc_removeItem; (_this select 0) ctrlEnable true;";

            x = 0.475;
            y = 0.70;
            w = (5.25 / 40);
            h = (1 / 25);
        };

        class ButtonClose : RscButtonMenu {
            idc = -1;
            text = "$STR_Global_Close";
            onButtonClick = "closeDialog 0;";
            x = 0.1;
            y = 0.8 - (1 / 25);
            w = (6.25 / 40);
            h = (1 / 25);
        };

        class ButtonSettings : RscButtonMenu {
            idc = -1;
            text = "$STR_Global_Settings";
            onButtonClick = "[] call XY_fnc_settingsMenu;";
            x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
            y = 0.8 - (1 / 25);
            w = (6.25 / 40);
            h = (1 / 25);
        };

        class ButtonMyGang : RscButtonMenu {
            idc = 2011;
            text = "$STR_PM_MyGang";
            onButtonClick = "closeDialog 0; if( ((group player) getVariable [""owner"", """"] isEqualTo """") ) then { createDialog ""XY_dialog_createGang""; } else { [""open""] call XY_fnc_gangMenu; };";
            x = 0.1 + (6.25 / 19.8) + (1 / 250 / (safezoneW / safezoneH));
            y = 0.8 - (1 / 25);
            w = (6.25 / 40);
            h = (1 / 25);
        };

        class ButtonCallTaxi : RscButtonMenu {
            idc = 2050;
            text = "TAXI";
            onButtonClick = "closeDialog 0; [""init""] spawn XY_fnc_taxi;";
            x = 0.1 + (6.25 / 19.8) + (1 / 250 / (safezoneW / safezoneH));
            y = 0.805;
            w = (6.25 / 40);
            h = (1 / 25);
        };

        class XY_licenses : XY_RscListBox {
            idc = 2014;
            sizeEx = 0.03;
            text = "";
            x = 0.336;
            y = 0.30;
            w = 0.27;
            h = 0.385;
        };

        class ButtonGangList : RscButtonMenu {
            idc = 2012;
            text = "$STR_PM_WantedList";
            onButtonClick = "[] call XY_fnc_wantedMenu";
            x = 0.1 + (6.25 / 19.8) + (1 / 250 / (safezoneW / safezoneH));
            y = 0.8 - (1 / 25);
            w = (6.25 / 40);
            h = (1 / 25);
        };

        class ButtonKeys : RscButtonMenu {
            idc = 2013;
            text = "$STR_PM_KeyChain";
            onButtonClick = "createDialog ""XY_dialog_keychain"";";
            x = 0.26 + (6.25 / 19.8) + (1 / 250 / (safezoneW / safezoneH));
            y = 0.8 - (1 / 25);
            w = (6.25 / 40);
            h = (1 / 25);
        };

        class ButtonCell : RscButtonMenu {
            idc = 2014;
            text = "$STR_PM_CellPhone";
            onButtonClick = "createDialog ""XY_dialog_smartphone""";
            x = 0.42 + (6.25 / 19.8) + (1 / 250 / (safezoneW / safezoneH));
            y = 0.8 - (1 / 25);
            w = (6.25 / 40);
            h = (1 / 25);
        };

        class ButtonMarket : RscButtonMenu {
            idc = 9900;
            text = "Markt";
            onButtonClick = "[""init""] call XY_fnc_marketViewDialog;";
            x = 0.26 + (6.25 / 19.8) + (1 / 250 / (safezoneW / safezoneH));
            y = 0.805;
            w = (6.25 / 40);
            h = (1 / 25);
        };

        class ButtonWantedAdd : RscButtonMenu {
            idc = 9800;
            text = "Wanted +";
            onButtonClick = "createDialog ""XY_dialog_wantedAdd""";
            x = 0.42 + (6.25 / 19.8) + (1 / 250 / (safezoneW / safezoneH));
            y = 0.805;
            w = (6.25 / 40);
            h = (1 / 25);
        };
    };
};