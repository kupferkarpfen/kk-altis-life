class XY_dialog_help {

    idd = 9700;
    movingEnabled = 0;

    class controlsBackground {

        class lbHeading: RscStructuredText {

            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.9 };
            colorText[] = { 1, 1, 1, 1 };
            text = "<t size='1.15' align='center'>HILFE</t>";

            x = 0.3 * safezoneW + safezoneX;
            y = 0.3 * safezoneH + safezoneY;
            w = 0.4 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class bgMain : RscText {

            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.7 };

            x = 0.3 * safezoneW + safezoneX;
            y = 0.3 * safezoneH + safezoneY;
            w = 0.4 * safezoneW;
            h = 0.4 * safezoneH;
        };
    };

    class controls {

        class TopicList : RscListBox {
            idc = 9701;
            text = "";
            sizeEx = 0.03;
            colorBackground[] = { 0, 0, 0, 0.1 };
            onLBSelChanged = "[""selectTopic""] call XY_fnc_helpMenu;";

            x = 0.305 * safezoneW + safezoneX;
            y = 0.330 * safezoneH + safezoneY;
            w = 0.125 * safezoneW;
            h = 0.360 * safezoneH;
        };

        class TopicWrapper : RscControlsGroup {
            idc = 9703;

            x = 0.435 * safezoneW + safezoneX;
            y = 0.330 * safezoneH + safezoneY;
            w = 0.260 * safezoneW;
            h = 0.360 * safezoneH;
            
            class HScrollbar : HScrollbar {
				height = 0;
			};

            class controls {
                class TopicContent : RscStructuredText {
                    idc = 9702;
                    text = "";
                    colorBackground[] = { 0, 0, 0, 0.1 };

                    x = 0;
                    y = 0;
                    w = 0.250 * safezoneW;
                    h = 1 * safezoneH;
                };
            };
        };

        class btnClose : RscButtonMenu
        {
            idc = -1;
            text = "X";
            onButtonClick = "closeDialog 0;";

            x = 0.675 * safezoneW + safezoneX;
            y = 0.300 * safezoneH + safezoneY;
            w = 0.025 * safezoneW;
            h = 0.025 * safezoneH;

            class Attributes {
                align = "center";
            };
        };
    };
};