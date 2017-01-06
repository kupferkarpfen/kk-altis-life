class XY_dialog_weaponShop
{
    idd = 38400;
    movingEnabled = false;
    enableSimulation = true;

    class controlsBackground
    {
        class RscTitleBackground : XY_RscText
        {
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
            idc = -1;
            x = 0.1; y = 0.2;
            w = 0.5; h = (1 / 25);
        };

        class Mainbackground : XY_RscText
        {
            colorBackground[] = {0,0,0,0.7};
            idc = -1;
            x = 0.1; y = 0.2 + (11 / 250);
            w = 0.5; h = 0.6 - (22 / 250);
        };

        class Title : XY_RscTitle
        {
            colorBackground[] = {0,0,0,0};
            idc = -1;
            text = "SHOP";
            x = 0.1; y = 0.2;
            w = 0.5; h = (1 / 25);
        };

        class itemInfo : XY_RscStructuredText
        {
            idc = 38404;
            text = "";
            sizeEx = 0.035;
            x = 0.11; y = 0.68;
            w = 0.35; h = 0.2;
        };
    };

    class controls
    {
        class itemList : XY_RscListBox
        {
            idc = 38403;
            onLBSelChanged = "_this call XY_fnc_weaponShopSelection";
            sizeEx = 0.035;
            x = 0.11; y = 0.25;
            w = 0.48; h = 0.415;
        };

        class ButtonBuySell : RscButtonMenu
        {
            idc = 38405;
            text = "$STR_Global_Buy";
            onButtonClick = "(_this select 0) ctrlEnable false; [] call XY_fnc_weaponShopBuySell; (_this select 0) ctrlEnable true; XY_actionInUse = false;";
            x = 0.1 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
            y = 0.8 - (1 / 25);
            w = (6.25 / 40);
            h = (1 / 25);
        };

        class ButtonClose : RscButtonMenu
        {
            idc = -1;
            text = "$STR_Global_Close";
            onButtonClick = "closeDialog 0;";
            x = 0.1;
            y = 0.8 - (1 / 25);
            w = (6.25 / 40);
            h = (1 / 25);
        };
    };
};
