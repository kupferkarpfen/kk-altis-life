//Grid macros
#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

#define UI_GRID_W (pixelW * pixelGrid)
#define UI_GRID_H (pixelH * pixelGrid)
#define UI_GAP_W (pixelW * 2)
#define UI_GAP_H (pixelH * 2)

// Market dialog 60x50 grid
#define POS_W UI_GRID_W * 60
#define POS_H UI_GRID_H * 50
#define POS_X safezoneX + safezoneW - safezoneW / 2 - POS_W / 2
#define POS_Y safezoneY + safezoneH - safezoneH / 2 - POS_H / 2

class XY_dialog_marketView
{
	idd = 39500;
	movingEnabled = false;
	enableSimulation = true;

	class controlsBackground {

		class bgFrame: RscText
		{
			idc = -1;
            colorBackground[] = {0, 0, 0, 0.7};
			x = POS_X;
			y = POS_Y;
			w = POS_W;
			h = POS_H;
		};

		class lbHeading: RscStructuredText {
			idc = -1;
            colorBackground[] = {0,0,0,0.8};
			text = "<t size='1.1' align='center'>J4FG Markt</t>";

			x = POS_X;
			y = POS_Y;
			w = POS_W;
			h = 3 * UI_GRID_H;
		};
        
		class lbMarketData: RscStructuredText {
			idc = 1501;
            colorBackground[] = {0,0,0,0.3};
			text = "";

			x = POS_X + 25 * UI_GRID_W + UI_GAP_W;
			y = POS_Y + 3 * UI_GRID_H + UI_GAP_H;
			w = 35 * UI_GRID_W - UI_GAP_W * 2;
			h = 47 * UI_GRID_H - 2 * UI_GAP_H;
		};
	};

	class controls {
		class listResources: RscListbox {
			idc = 1500;
            onLBSelChanged = "[""refresh""] call XY_fnc_marketViewDialog";

			x = POS_X + UI_GAP_W;
			y = POS_Y + 3 * UI_GRID_H + UI_GAP_H;
			w = 25 * UI_GRID_W;
			h = 47 * UI_GRID_H - 2 * UI_GAP_H;
		};

		class btnClose : RscButtonMenu {
			idc = -1;
			text = "X";
            onButtonClick = "closeDialog 0";
            
            class Attributes {
                align = "center";
            };

			x = POS_X + POS_W - UI_GAP_W - 3 * UI_GRID_W;
			y = POS_Y + UI_GAP_H;
			w = 3 * UI_GRID_W - 2 * UI_GAP_W;
			h = 3 * UI_GRID_H - 2 * UI_GAP_H;
		};
	};
};