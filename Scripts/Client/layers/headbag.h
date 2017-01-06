class XY_HEADBAG {

    idd = -1;
    name="XY_HEADBAG";
    duration = 999999;

    fadein = 0.5;
    fadeout = 0.5;
    onLoad = "uiNamespace setVariable ['XY_HEADBAG',_this select 0];";
    onUnload = "uiNamespace setVariable ['XY_HEADBAG', displayNull];";

    class controlsBackground {
        class Bag : XY_RscPicture {
            idc = -1;
            text = "icons\headbag.paa";

            x = safezoneX;
            y = safezoneY;
            w = safezoneW;
            h = safezoneH;
        };

        class Message {
            idc = -1;

            x = safezoneX;
            y = ((safezoneY + safezoneH) / 2) - 0.0025;
            w = safezoneW;
            h = 0.05;

            text = "Dir wurden die Augen verbunden";
            font = "PuristaSemibold";
            type = 13;
            style = 1;
            size = 0.04;

            class Attributes {
                align = "center";
                color = "#FFFFFF";
            };
        };
    };
};