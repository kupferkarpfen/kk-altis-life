class XY_dialog_interaction {

	idd = 37400;
	movingEnabled = false;
	enableSimulation = true;
	
	class controlsBackground {
		class RscTitleBackground:XY_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.4000 * safezoneW + safezoneX;
			y = 0.3000 * safezoneH + safezoneY;
			w = 0.2000 * safezoneW;
			h = 0.0250 * safezoneH;
		};
		
		class MainBackground : XY_RscText {
			idc = -1;
			colorBackground[] = {0,0,0,0.7};
			x = 0.4000 * safezoneW + safezoneX;
			y = 0.3250 * safezoneH + safezoneY;
			w = 0.2000 * safezoneW;
			h = 0.4250 * safezoneH;
		};
		
		class Title : XY_RscTitle {
			colorBackground[] = {0,0,0,0};
			idc = 37401;
			text = "";
			x = 0.4000 * safezoneW + safezoneX;
			y = 0.3000 * safezoneH + safezoneY;
			w = 0.2000 * safezoneW;
			h = 0.0250 * safezoneH;
			class Attributes {
				align = "center";
			};
		};
	};
	
	class controls {
		
		class ButtonOne : RscButtonMenu
		{
			idc = 37450;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.4050 * safezoneW + safezoneX;
			y = 0.3375 * safezoneH + safezoneY;
			w = 0.1900 * safezoneW;
			h = 0.0250 * safezoneH;
            class Attributes {
				align = "center";
			};
		};
		
		class ButtonTwo : RscButtonMenu
		{
			idc = 37451;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.4050 * safezoneW + safezoneX;
			y = 0.3750 * safezoneH + safezoneY;
			w = 0.1900 * safezoneW;
			h = 0.0250 * safezoneH;
            class Attributes {
				align = "center";
			};
		};
		
		class ButtonThree : RscButtonMenu
		{
			idc = 37452;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.4050 * safezoneW + safezoneX;
			y = 0.4125 * safezoneH + safezoneY;
			w = 0.1900 * safezoneW;
			h = 0.0250 * safezoneH;
            class Attributes {
				align = "center";
			};
		};
		
		class ButtonFour : RscButtonMenu
		{
			idc = 37453;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.4050 * safezoneW + safezoneX;
			y = 0.4500 * safezoneH + safezoneY;
			w = 0.1900 * safezoneW;
			h = 0.0250 * safezoneH;
            class Attributes {
				align = "center";
			};
		};
		
		class ButtonFive : RscButtonMenu
		{
			idc = 37454;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.4050 * safezoneW + safezoneX;
			y = 0.4875 * safezoneH + safezoneY;
			w = 0.1900 * safezoneW;
			h = 0.0250 * safezoneH;
            class Attributes {
				align = "center";
			};
		};
		
		class ButtonSix : RscButtonMenu
		{
			idc = 37455;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.4050 * safezoneW + safezoneX;
			y = 0.5250 * safezoneH + safezoneY;
			w = 0.1900 * safezoneW;
			h = 0.0250 * safezoneH;
            class Attributes {
				align = "center";
			};
		};
		
		class ButtonSeven : RscButtonMenu
		{
			idc = 37456;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.4050 * safezoneW + safezoneX;
			y = 0.5625 * safezoneH + safezoneY;
			w = 0.1900 * safezoneW;
			h = 0.0250 * safezoneH;
            class Attributes {
				align = "center";
			};
		};
		class ButtonEight : RscButtonMenu
		{
			idc = 37457;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.4050 * safezoneW + safezoneX;
			y = 0.6000 * safezoneH + safezoneY;
			w = 0.1900 * safezoneW;
			h = 0.0250 * safezoneH;
            class Attributes {
				align = "center";
			};
		};
		class ButtonNine : RscButtonMenu
		{
			idc = 37458;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.4050 * safezoneW + safezoneX;
			y = 0.6375 * safezoneH + safezoneY;
			w = 0.1900 * safezoneW;
			h = 0.0250 * safezoneH;
            class Attributes {
				align = "center";
			};
		};
		class ButtonTen : RscButtonMenu
		{
			idc = 37459;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "";
			sizeEx = 0.025;
			x = 0.4050 * safezoneW + safezoneX;
			y = 0.6750 * safezoneH + safezoneY;
			w = 0.1900 * safezoneW;
			h = 0.0250 * safezoneH;
            class Attributes {
				align = "center";
			};
		};
		class ButtonClose : RscButtonMenu {
			idc = -1;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.4050 * safezoneW + safezoneX;
			y = 0.7200 * safezoneH + safezoneY;
			w = 0.1900 * safezoneW;
			h = 0.0250 * safezoneH;
            class Attributes {
				align = "center";
			};
		};
	};
};