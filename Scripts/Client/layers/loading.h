class XY_loading {
    name = "XY_loading";
    idd = 44200;
    fadein = 0;
    duration = 99999999999;
    fadeout = 0;
    movingEnable = 0;
    onLoad="uiNamespace setVariable ['XY_loading', _this select 0]";

    class controlsBackground {

        class FullBackground : XY_RscPicture {
            idc = -1;
            text = "images\kavala.paa";

            x = safezoneX;
            y = safezoneY;
            w = safezoneW;
            h = safezoneH;
        };

        class ProgressBar : XY_RscProgress {
            idc = 44201;

            colorBar[] = { 0.9, 0.9, 0.9, 0.5 };
            colorBackground[] = { 0, 0, 0, 0.5};
            colorFrame[] = { 0, 0, 0, 0.8 };

            x = 0.250 * safezoneW + safezoneX;
            y = 0.650 * safezoneH + safezoneY;
            w = 0.500 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class ProgressText : XY_RscStructuredText {
            idc = 44202;
            text = "Lade...";
            x = 0.250 * safezoneW + safezoneX;
            y = 0.650 * safezoneH + safezoneY;
            w = 0.500 * safezoneW;
            h = 0.025 * safezoneH;
        };
    };
};