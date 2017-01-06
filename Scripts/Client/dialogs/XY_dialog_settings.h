class XY_dialog_settings
{
    idd = 2900;
    movingEnabled = 1;
    enableSimulation = 1;

    class controlsBackground
    {
        class RscTitleBackground : XY_RscText
        {
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
            idc = -1;
            x = 0.3;
            y = 0.2;
            w = 0.5;
            h = (1 / 25);
        };

        class RscMainBackground : XY_RscText
        {
            colorBackground[] = {0,0,0,0.7};
            idc = -1;
            x = 0.3;
            y = 0.2 + (11 / 250);
            w = 0.5;
            h = 0.43 - (22 / 250);
        };

        class PlayerTagsHeader : XY_RscText
        {
            idc = -1;
            text = "Spielernamen anzeigen";
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};

            x = 0.30;
            y = 0.43;
            w = 0.35;
            h = (1 / 25);
        };

        class SideChatHeader : PlayerTagsHeader
        {
            idc = -1;
            text = "Sidechat anzeigen";

            y = 0.48;
        };

        class HUDHeader : PlayerTagsHeader
        {
            idc = -1;
            text = "HUD anzeigen";

            y = 0.53;
        };

        class Title : XY_RscTitle
        {
            idc = -1;
            colorBackground[] = {0,0,0,0};
            text = "$STR_SM_Title";
            x = 0.3;
            y = 0.2;
            w = 0.5;
            h = (1 / 25);
        };
    };

    class controls
    {
        class VDonFoot : XY_RscText
        {
            idc = -1;
            text = "$STR_SM_onFoot";

            x = 0.32; y = 0.258;
            w = 0.275; h = 0.04;
        };

        class VDinCar : XY_RscText
        {
            idc = -1;
            text = "$STR_SM_inCar";

            x = 0.32; y = 0.305;
            w = 0.275; h = 0.04;
        };

        class VDinAir : XY_RscText
        {
            idc = -1;
            text = "$STR_SM_inAir";

            x = 0.32; y = 0.355;
            w = 0.275; h = 0.04;
        };

        class VD_onfoot_slider : XY_RscXSliderH
        {
            idc = 2901;
            text = "";
            onSliderPosChanged = "[0,_this select 1] call XY_fnc_s_onSliderChange;";
            tooltip = "$STR_SM_ToolTip1";
            x = 0.42;
            y = 0.30 - (1 / 25);

            w = "9 *            (           ((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1 *            (           (           ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };

        class VD_onfoot_value : XY_RscText
        {
            idc = 2902;
            text = "";

            x = 0.70; y = 0.258;
            w = 0.275; h = 0.04;
        };

        class VD_car_slider : XY_RscXSliderH
        {
            idc = 2911;
            text = "";
            onSliderPosChanged = "[1,_this select 1] call XY_fnc_s_onSliderChange;";
            tooltip = "$STR_SM_ToolTip2";
            x = 0.42;
            y = 0.35 - (1 / 25);

            w = "9 *            (           ((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1 *            (           (           ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };

        class VD_car_value : XY_RscText
        {
            idc = 2912;
            text = "";

            x = 0.70; y = 0.31;
            w = 0.275; h = 0.04;
        };

        class VD_air_slider : XY_RscXSliderH
        {
            idc = 2921;
            text = "";
            onSliderPosChanged = "[2,_this select 1] call XY_fnc_s_onSliderChange;";
            tooltip = "$STR_SM_ToolTip3";
            x = 0.42;
            y = 0.40 - (1 / 25);

            w = "9 *            (           ((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1 *            (           (           ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };

        class VD_air_value : XY_RscText
        {
            idc = 2922;
            text = "";

            x = 0.70; y = 0.36;
            w = 0.275; h = 0.04;
        };

        class PlayerTagsONOFF : XY_RscActiveText
        {
            text = "AN";
            idc = 2970;
            sizeEx = 0.04;
            action = "XY_tagsON = !XY_tagsON; [] call XY_fnc_settingsMenu;";
            x = 0.65;
            y = 0.43;
            w = 0.275;
        };

        class SideChatONOFF : PlayerTagsONOFF
        {
            idc = 2971;
            tooltip = "";
            action = "[] call XY_fnc_sidechat;";
            y = 0.48;
        };

        class HUDONOFF : PlayerTagsONOFF
        {
            idc = 2972;
            tooltip = "";
            action = "[] call XY_fnc_toggleHUD;";
            y = 0.53;
        };

        class ButtonClose : RscButtonMenu {
            idc = -1;
            //shortcuts[] = {0x00050000 + 2};
            text = "$STR_Global_Close";
            onButtonClick = "closeDialog 0;";
            x = 0.48;
            y = 0.63 - (1 / 25);
            w = (6.25 / 40);
            h = (1 / 25);
        };
    };
};