class XY_dialog_smartphone {

    idd = 88888;
    movingEnable = false;
    enableSimulation = true;
    onLoad = "[] spawn XY_fnc_smartphone;";

    class controlsBackground {
        class XY_RscTitleBackground:XY_RscText {
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
            idc = -1;
            x = 0.1;
            y = 0.2;
            w = 0.95;
            h = (1 / 25);
        };

    class MainBackground:XY_RscText {
            colorBackground[] = {0, 0, 0, 0.7};
            idc = -1;
            x = 0.1;
            y = 0.2 + (11 / 250);
            w = 0.95;
            h = 0.7 - (22 / 250);
        };

    class PlayerListTitleBackground:XY_RscText {
            colorBackground[] = {0.588, 0.424, 0.145, 1.0};
            idc = -1;
            x = 0.11;
            y = 0.25;
            w = 0.2;
            h = (1 / 25);
        };

    class MessageTitleBackground:XY_RscText {
            colorBackground[] = {0.588, 0.424, 0.145, 1.0};
            idc = -1;
            x = 0.325;
            y = 0.25;
            w = 0.7;
            h = (1 / 25);
        };

    class RandomTitleBackground:XY_RscText {
            colorBackground[] = {0.588, 0.424, 0.145, 1.0};
            idc = -1;
            x = 0.325;
            y = 0.25 + 0.3 + (1 / 25);
            w = 0.7;
            h = (1 / 25);
        };
    };

    class controls {

        class MessageTitle : XY_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = 88886;
            text = "";
            sizeEx = "(         (           (           ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)";
            x = 0.325;
            y = 0.25;
            w = 0.7;
            h = (1 / 25);
        };

        class RandomTitle : XY_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = 88890;
            text = "Nachricht zum Lesen auswählen";
            sizeEx = "(         (           (           ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)";
            x = 0.325;
            y = 0.25 + 0.3 + (1 / 25);
            w = 0.7;
            h = (1 / 25);
        };

        class PlayerList : XY_RscListBox
        {
            idc = 88881;
            onLBSelChanged = "[2] spawn XY_fnc_smartphone;";
            sizeEx = "(         (           (           ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
            x = 0.11;
            y = 0.25 + (1 / 25);
            w = 0.2;
            h = 0.5;
        };

        class MessageList : XY_RscListNBox
        {
            idc = 88882;
            onLBSelChanged = "[(lbCurSel 88882)] call XY_fnc_showMsg;";
            //sizeEx = 0.04;
            sizeEx = "(         (           (           ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
            colorBackground[] = {0, 0, 0, 0.0};
            columns[] = {0,0.3};
            x = 0.325;
            y = 0.25 + (1 / 25);
            w = 0.7;
            h = 0.3;
        };

        class TextShow : XY_RscControlsGroup {
            x = 0.325;
            y =  0.25 + 0.3 + (1 / 25) + (1 / 25);
            w =  0.7;
            h =  0.15;
            class HScrollbar : HScrollbar {
                height = 0;
            };
            class controls {
                class showText : XY_RscStructuredText {
                    idc = 88887;
                    text = "";
                    colorBackground[] = {0.28,0.28,0.28,0.28};
                    size = "(           (           (           ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
                    shadow = 0;
                    x = 0;
                    y = 0;
                    w = 0.69;//w = 0.7;
                    h = 1;//h = 2.15;
                };
            };
        };

        class Schreiben : RscButtonMenu {
            idc = 887892;
            text = "SCHREIBEN";
            onButtonClick = "[4] call XY_fnc_smartphone;";
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 1.0};
            x = 0.11;
            y = 0.25 + (1 / 25) + 0.51;
            w = 0.2;
            h = (1 / 25);
        };

        class Title : XY_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = -1;
            text = "$STR_SMARTPHONE_TITLE";
            sizeEx = "(         (           (           ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
            x = 0.1;
            y = 0.2;
            w = 0.95;
            h = (1 / 25);
        };

        class PlayerListTitle : XY_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = -1;
            text = "$STR_SMARTPHONE_PLAYERLISTTITLE";
            sizeEx = "(         (           (           ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)";
            x = 0.11;
            y = 0.25;
            w = 0.2;
            h = (1 / 25);
        };

        class CloseLoadMenu : RscButtonMenu {
            idc = -1;
            text = "$STR_Global_Close";
            onButtonClick = "closeDialog 0;";
            x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
            y = 0.9 - (1 / 25);
            w = (6.25 / 40);
            h = (1 / 25);
        };

        class Notruf : RscButtonMenu {
            idc = -1;
            text = "$STR_SMARTPHONE_NOTRUF";
            onButtonClick = "createDialog ""XY_dialog_smartphoneEmergency"";";
            colorBackground[] = {0.584, 0.086, 0.086,1.0};
            x = 0.325 + 0.7 - (6.25 / 40);
            y = 0.25 + (1 / 25) + 0.51;
            w = (6.25 / 40);
            h = (1 / 25);
        };
    };

};

class XY_dialog_smartphoneWrite
{
    idd = 88883;
    movingEnable = false;
    enableSimulation = true;
    onLoad = "";

    class controlsBackground {
        class XY_RscTitleBackground:XY_RscText {
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
            idc = -1;
            x = 0.1;
            y = 0.2;
            w = 0.6;
            h = (1 / 25);
        };

        class MainBackground:XY_RscText {
            colorBackground[] = {0, 0, 0, 0.7};
            idc = -1;
            x = 0.1;
            y = 0.2 + (11 / 250);
            w = 0.6;
            h = 0.1;
        };

    };
    class controls {
        class Title : XY_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = 88886;
            text = "$STR_SMARTPHONE_NACHRICHTTITLE";
            x = 0.1;
            y = 0.2;
            w = 0.95;
            h = (1 / 25);
        };

        class Absenden : RscButtonMenu {
            idc = 88885;
            text = "$STR_SMARTPHONE_ABSENDEN";
            onButtonClick = "[1,-1,(ctrlText 88884)] call XY_fnc_newMsg;";
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 1.0};
            x = 0.6 - (6.25 / 40) + 0.088;
            y = 0.3 + (1 / 25)  - 0.048;
            w = (6.25 / 40);
            h = (1 / 25);
        };

        class AdminMsg : RscButtonMenu
        {
            idc = 888897;
            text = "$STR_CELL_AdminMsg";
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 1.0};
            onButtonClick = "[5,-1,(ctrlText 88884)] call XY_fnc_newMsg;";

            x = 0.6 - (6.25 / 40) - 0.121;
            y = 0.3 + (1 / 25)  - 0.048;
            w = 0.2;
            h = (1 / 25);
        };

        class Close : RscButtonMenu {
            idc = -1;
            text = "$STR_Global_Close";
            onButtonClick = "closeDialog 0;";
            colorBackground[] = {0.584, 0.086, 0.086,1.0};
            x = 0.11;
            y = 0.3 + (1 / 25)  - 0.048;
            w = (6.25 / 40);
            h = (1 / 25);
        };

        class textEdit : XY_RscEdit {
            idc = 88884;
            onKeyUp = "[5] call XY_fnc_smartphone;";
            text = "";
            sizeEx = 0.030;
            x = 0.11;
            y = 0.3 - 0.048;
            w = 0.58;
            h = 0.03;
        };
    };
};

class XY_dialog_smartphoneEmergency {

    idd = 887890;
    movingEnable = false;
    enableSimulation = true;
    onLoad = "[6] spawn XY_fnc_newMsg;";

    class controlsBackground {
        class XY_RscTitleBackground:XY_RscText {
            colorBackground[] = {0.584, 0.086, 0.086,1.0};
            idc = -1;
            x = 0.1;
            y = 0.2;
            w = 0.85;
            h = (1 / 25);
        };

        class MainBackground:XY_RscText {
            colorBackground[] = {0, 0, 0, 0.7};
            idc = -1;
            x = 0.1;
            y = 0.2 + (11 / 250);
            w = 0.85;
            h = 0.15 - (5 / 250);
        };
    };

    class controls {


        class Title : XY_RscTitle {
            colorBackground[] = {0, 0, 0, 0};
            idc = 888892;
            text = "NOTRUFE";
            x = 0.1;
            y = 0.2;
            w = 0.6;
            h = (1 / 25);
        };

        class textEdit : XY_RscEdit {
            idc = 888894;

            onKeyUp = "[5] call XY_fnc_smartphone;";

            text = "";
            sizeEx = 0.030;
            x = 0.11;
            y = 0.25;
            w = 0.83;
            h = 0.03;
        };

        class TxtCopButton : RscButtonMenu
        {
            idc = 888895;
            text = "$STR_CELL_TextPolice";
            colorBackground[] = {0.129, 0.152, 0.450,1.0};
            onButtonClick = "[2,-1,(ctrlText 888894)] call XY_fnc_newMsg;";

            x = 0.11;
            y = 0.30;
            w = 0.2;
            h = (1 / 25);
        };

        class TxtAdminButton : RscButtonMenu
        {
            idc = 888896;
            text = "$STR_CELL_TextAdmins";
            colorBackground[] = {0.022, 0.627, 0.022,1.0};
            onButtonClick = "[3,-1,(ctrlText 888894)] call XY_fnc_newMsg;";

            x = 0.74;
            y = 0.30;
            w = 0.2;
            h = (1 / 25);
        };


        class AdminMsgAll : RscButtonMenu
        {
            idc = 888898;
            text = "$STR_CELL_AdminMSGAll";
            colorBackground[] = {0.022, 0.627, 0.022,1.0};
            onButtonClick = "[7,-1,(ctrlText 888894)] call XY_fnc_newMsg;";

            x = 0.74;
            y = 0.30;
            w = 0.2;
            h = (1 / 25);
        };

        class EMSReq : RscButtonMenu
        {
            idc = 888899;
            text = "Sanitäter";
            colorBackground[] = {0.988, 0, 0,1.0};
            onButtonClick = "[4,-1,(ctrlText 888894)] call XY_fnc_newMsg;";

            x = 0.32;
            y = 0.30;
            w = 0.2;
            h = (1 / 25);
        };

        class CloseButton : RscButtonMenu {
            idc = -1;
            text = "$STR_Global_Close";
            onButtonClick = "closeDialog 0;";
            x = -0.06 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH));
            y = 0.36 + (1 / 50);
            w = (6.25 / 40);
            h = (1 / 25);
        };

        class policeBroadcast : RscButtonMenu {
            idc = 888901;
            text = "POLIZEI-MELDUNG";
            colorBackground[] = {0.129, 0.152, 0.450,1.0};
            onButtonClick = "[9,-1,(ctrlText 888894)] call XY_fnc_newMsg; closeDialog 0;";
            x = 0.70;
            y = 0.36 + (1 / 50);
            w = 0.2;
            h = (1 / 25);
        };

        class MedicBroadcast : RscButtonMenu {
            idc = 888902;
            text = "MEDIC-MELDUNG";
            colorBackground[] = {0.129, 0.152, 0.450,1.0};
            onButtonClick = "[10,-1,(ctrlText 888894)] call XY_fnc_newMsg; closeDialog 0;";
            x = 0.70;
            y = 0.36 + (1 / 50);
            w = 0.2;
            h = (1 / 25);
        };
    };
};