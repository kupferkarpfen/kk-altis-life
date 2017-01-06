// TODO: Arrest time
class XY_dialog_jailTime {
	idd = 26500;
	movingEnabled = false;
	enableSimulation = true;
	
	class controlsBackground {
		class XY_RscTitleBackground:XY_RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			idc = -1;
			x = 0.3;
			y = 0.2;
			w = 0.47;
			h = (1 / 25);
		};
		
		class MainBackground:XY_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.3;
			y = 0.2 + (11 / 250);
			w = 0.47;
			h = 0.3 - (22 / 250);
		};
	};
	
	class controls 
	{
		class Title : XY_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = 2651;
			text = "Inhaftieren";
			x = 0.3;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};
		
		class InfoMsg : XY_RscStructuredText
		{
			idc = 2601;
			sizeEx = 0.020;
			text = "Zeit in Minuten:";
			x = 0.287;
			y = 0.2 + (11 / 250);
			w = 0.45; 
			h = 0;
		};
		
		class moneyEdit : XY_RscEdit 
		{
			idc = 1400;
			text = "15";
			sizeEx = 0.030;
			x = 0.40; y = 0.30;
			w = 0.25; h = 0.03;
		};
 
		class ConfirmArrest: RscButtonMenu {
			idc = 2402;
			text = "OK";
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			onButtonClick="[] spawn XY_fnc_arrestDialog_Arrest;";
			x = 0.45;
			y = 0.35;
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class CloseButtonKey : RscButtonMenu {
			idc = 2400;
			text = "$STR_Global_Close";
			onButtonClick = "closeDialog 0;";
			x = 0.45;
			y = 0.40;
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};
};