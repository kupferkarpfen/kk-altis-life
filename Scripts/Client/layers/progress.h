class XY_progressBar
{
    name = "XY_progressBar";
    idd = 38200;
    fadein=0;
    duration = 99999999999;
    fadeout=0;
    movingEnable = 0;
    onLoad="uiNamespace setVariable ['XY_progressBar',_this select 0]";
    objects[]={};

    class controlsBackground {

        class ProgressBackground : RscText {
            idc = -1;

            colorBackground[] = { 0, 0, 0, 0.7};

            x = 0.299 * safezoneW + safezoneX;
            y = 0.099 * safezoneH + safezoneY;
            w = 0.402 * safezoneW;
            h = 0.027 * safezoneH;
        };
        class ProgressBar : XY_RscProgress {
            idc = 38201;

            x = 0.3 * safezoneW + safezoneX;
            y = 0.1 * safezoneH + safezoneY;
            w = 0.4 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class ProgressText : RscStructuredText {
            idc = 38202;

            text = "<t size='1.1' align='center'>Fortschritt...</t>";

            x = 0.3 * safezoneW + safezoneX;
            y = 0.1 * safezoneH + safezoneY;
            w = 0.4 * safezoneW;
            h = 0.025 * safezoneH;
        };
    };
};

class XY_timer {
    name = "XY_timer";
    idd = 38300;
    fadeIn = 1;
    duration = 99999999999;
    fadeout = 1;
    movingEnable = 0;
    onLoad = "uiNamespace setVariable['XY_timer',_this select 0]";
    objects[] = {};

    class controlsBackground {
        class TimerIcon : XY_RscPicture {
            idc = -1;
            text = "\a3\ui_f\data\IGUI\RscTitles\MPProgress\timer_ca.paa";
            x = 0.00499997 * safezoneW + safezoneX;
            y = 0.291 * safezoneH + safezoneY;
            w = 0.04;
            h = 0.045;
        };
        class TimerText : XY_RscText {
            colorBackground[] = {0,0,0,0};
            idc = 38301;
            text = "";
            x = 0.0204688 * safezoneW + safezoneX;
            y = 0.2778 * safezoneH + safezoneY;
            w = 0.09125 * safezoneW;
            h = 0.055 * safezoneH;
        };
    };
};
