//Grid macros
#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

class XY_dialog_radioMessage
{
	idd = 39600;
	movingEnabled = false;
	enableSimulation = true;
	
	class controlsBackground {

        class IGUIBack_2200: XY_RscText
        {
            idc = 2200;
            colorBackground[] = {0, 0, 0, 0.7};
            x = 5.5 * GUI_GRID_W + GUI_GRID_X;
            y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 29.5 * GUI_GRID_W;
            h = 9.5 * GUI_GRID_H;
        };
        class RscText_1000: RscText
        {
            idc = 1000;
            text = "Nachricht verbreiten";
            x = 5.5 * GUI_GRID_W + GUI_GRID_X;
            y = 5 * GUI_GRID_H + GUI_GRID_Y;
            w = 29.5 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
            colorBackground[] = {0,0,0,0.8};
        };
        class RscText_1001: RscText
        {
            idc = 1001;
            text = "ACHTUNG: Bei Missbrauch der Funktion wird ein Ban ausgesprochen!";
            x = 6 * GUI_GRID_W + GUI_GRID_X;
            y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 28.5 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
            sizeEx = 0.8 * GUI_GRID_H;
        };
        class RscText_1002: RscText
        {
            idc = 1002;
            text = "Headline:";
            x = 9.5 * GUI_GRID_W + GUI_GRID_X;
            y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 4 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
        class RscText_1003: RscText
        {
            idc = 1003;
            text = "Ticker-Meldung:";
            x = 6.5 * GUI_GRID_W + GUI_GRID_X;
            y = 10 * GUI_GRID_H + GUI_GRID_Y;
            w = 7 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
        class RscText_1004: RscText
        {
            idc = 1004;
            text = "Kosten: 1.000€";
            x = 6.5 * GUI_GRID_W + GUI_GRID_X;
            y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 11 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
	};

	class controls {

        class RscEdit_1400: RscEdit
        {
            idc = 1400;
            x = 14 * GUI_GRID_W + GUI_GRID_X;
            y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 20.5 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
            text = "";
        };
        class RscEdit_1401: RscEdit
        {
            idc = 1401;
            x = 14 * GUI_GRID_W + GUI_GRID_X;
            y = 10 * GUI_GRID_H + GUI_GRID_Y;
            w = 20.5 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
            text = "";
        };
        class RscButtonMenu_2400: RscButtonMenu
        {
            x = 30 * GUI_GRID_W + GUI_GRID_X;
            y = 12 * GUI_GRID_H + GUI_GRID_Y;
            w = 4 * GUI_GRID_W;
            h = 2.5 * GUI_GRID_H;
            text = "OK";
            onButtonClick="[] call XY_fnc_radioMessage;";
        };
        class RscButtonMenu_2401: RscButtonMenu
        {
            x = 23.5 * GUI_GRID_W + GUI_GRID_X;
            y = 12 * GUI_GRID_H + GUI_GRID_Y;
            w = 6 * GUI_GRID_W;
            h = 2.5 * GUI_GRID_H;
            text = "ABBRECHEN";
            onButtonClick="closeDialog 0;";
        };
	};
};

