class XY_dialog_Clothing {

	idd = 3100;
	movingEnable = true;
	enableSimulation = true;
	
	class controlsBackground {

		class XY_RscTitleBackground:XY_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.150 * safezoneW + safezoneX;
			y = 0.200 * safezoneH + safezoneY;
			w = 0.250 * safezoneW;
			h = 0.025 * safezoneH;
		};
		
		class MainBackground:XY_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.150 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.250 * safezoneW;
			h = 0.515 * safezoneH;
		};
	};
	
	class controls 
	{
		class Title : XY_RscTitle 
		{
			colorBackground[] = {0, 0, 0, 0};
			idc = 3103;
			text = "Kleidungskauf";
            moving = true;
			x = 0.150 * safezoneW + safezoneX;
			y = 0.200 * safezoneH + safezoneY;
			w = 0.250 * safezoneW;
			h = 0.025 * safezoneH;
		};
        
		class FilterList : XY_RscCombo
		{
			idc = 3105;
			colorBackground[] = {0,0,0,0.7};
			onLBSelChanged  = "_this call XY_fnc_clothingFilter";
			x = 0.150 * safezoneW + safezoneX;
			y = 0.230 * safezoneH + safezoneY;
			w = 0.250 * safezoneW;
			h = 0.020 * safezoneH;
		};
		
		class ClothingList : XY_RscListBox 
		{
			idc = 3101;
			text = "";
			sizeEx = 0.035;
			onLBSelChanged = "[_this] call XY_fnc_changeClothes;";
			
			x = 0.150 * safezoneW + safezoneX;
			y = 0.251 * safezoneH + safezoneY;
			w = 0.250 * safezoneW;
			h = 0.345 * safezoneH;
		};
        

        
        class CAPACITY : XY_RscProgress {
            idc = 3300;

			x = 0.150 * safezoneW + safezoneX;
			y = 0.610 * safezoneH + safezoneY;
			w = 0.250 * safezoneW;
			h = 0.018 * safezoneH;

            colorBar[] = { 0.20, 0.24, 0.68, 1 };
            colorBackground[] = {-1, -1, -1, -1};
            colorFrame[] = {1, 1, 1, 0.25};
        };
		class TEXT_CAPACITY : XY_RscText {
			idc = 3301;
			text = "Kapazität";
			x = 0.150 * safezoneW + safezoneX;
			y = 0.610 * safezoneH + safezoneY;
			w = 0.250 * safezoneW;
			h = 0.018 * safezoneH;

            sizeEx = 0.035;

			class Attributes {
				align = "center";
				color = "#FFFFFF";
			};
		};        
        
        class WEIGHT : XY_RscProgress {
            idc = 3400;

			x = 0.150 * safezoneW + safezoneX;
			y = 0.635 * safezoneH + safezoneY;
			w = 0.250 * safezoneW;
			h = 0.018 * safezoneH;

            colorBar[] = { 0.20, 0.24, 0.68, 1 };
            colorBackground[] = {-1, -1, -1, -1};
            colorFrame[] = {1, 1, 1, 0.25};
        };
		class TEXT_WEIGHT: XY_RscText {
			idc = 3401;
			text = "Gewicht";
			x = 0.150 * safezoneW + safezoneX;
			y = 0.635 * safezoneH + safezoneY;
			w = 0.250 * safezoneW;
			h = 0.018 * safezoneH;

            sizeEx = 0.035;

			class Attributes {
				align = "center";
				color = "#FFFFFF";
			};
		};
		
		class PriceTag : XY_RscStructuredText
		{
			idc = 3102;
			text = "";
			sizeEx = 0.035;
			
			x = 0.150 * safezoneW + safezoneX;
			y = 0.660 * safezoneH + safezoneY;
			w = 0.250 * safezoneW;
			h = 0.020 * safezoneH;
		};
		
		class TotalPrice : XY_RscStructuredText
		{
			idc = 3106;
			text = "";
			sizeEx = 0.035;
			
			x = 0.150 * safezoneW + safezoneX;
			y = 0.685 * safezoneH + safezoneY;
			w = 0.250 * safezoneW;
			h = 0.020 * safezoneH;
		};
		
		class CloseButtonKey : RscButtonMenu 
		{
			idc = -1;
			text = "SCHLIEßEN";
			onButtonClick = "closeDialog 0;";
			x = 0.155 * safezoneW + safezoneX;
			y = 0.710 * safezoneH + safezoneY;
			w = 0.090 * safezoneW;
			h = 0.025 * safezoneH;
		};
		
		class BuyButtonKey : RscButtonMenu 
		{
			idc = -1;
			text = "KAUFEN";
			onButtonClick = "[] call XY_fnc_buyClothes;";
			x = 0.305 * safezoneW + safezoneX;
			y = 0.710 * safezoneH + safezoneY;
			w = 0.090 * safezoneW;
			h = 0.025 * safezoneH;
		};
	};
};