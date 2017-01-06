//Grid macros
#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

class XY_dialog_repaintVehicle {

    idd = 2300;
    movingEnable = true;
    enableSimulation = true;

    class controlsBackground {
        class MainBackground:XY_RscText {
            colorBackground[] = {0, 0, 0, 0.7};
            idc = -1;
            x = 4 * GUI_GRID_W + GUI_GRID_X;
            y = 6.1 * GUI_GRID_H + GUI_GRID_Y;
            w = 32 * GUI_GRID_W;
            h = 12.8 * GUI_GRID_H;
        };

        class Title : XY_RscTitle {
            colorBackground[] = {0,0,0,0.8};
            idc = -1;
            text = "Fahrzeug umlackieren";
            moving = 1;
            x = 4 * GUI_GRID_W + GUI_GRID_X;
            y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 32 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
    };

    class controls {

        class VehicleList : XY_RscListBox
        {
            idc = 2302;
            text = "";
            sizeEx = 0.035;
            colorBackground[] = {0,0,0,0};
            x = 4.8 * GUI_GRID_W + GUI_GRID_X;
            y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 30.5 * GUI_GRID_W;
            h = 9.5 * GUI_GRID_H;
        };

        class CloseButton : RscButtonMenu {
            idc = -1;
            text = "$STR_Global_Close";
            onButtonClick = "closeDialog 0;";
            x = 25 * GUI_GRID_W + GUI_GRID_X;
            y = 16.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 6 * GUI_GRID_W;
            h = 2 * GUI_GRID_H;
        };

        class OKButton : RscButtonMenu {
            idc = -1;
            text = "OK";
            onButtonClick = "[XY_currentInteraction] spawn XY_fnc_repaintVehicle;";
            x = 31.5 * GUI_GRID_W + GUI_GRID_X;
            y = 16.5 * GUI_GRID_H + GUI_GRID_Y;
            w = 4 * GUI_GRID_W;
            h = 2 * GUI_GRID_H;
        };
    };
};