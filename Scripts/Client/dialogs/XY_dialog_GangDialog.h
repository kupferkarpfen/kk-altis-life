class XY_dialog_GangDialog {
    idd = 2620;

    movingEnable = true;
    enableSimulation = true;
    onLoad = "";

    class controlsBackground {

        class bgMain: XY_RscText {
            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.7 };
            x = 0.245 * safezoneW + safezoneX;
            y = 0.250 * safezoneH + safezoneY;
            w = 0.510 * safezoneW;
            h = 0.450 * safezoneH;
        };

        class lbHeading: RscStructuredText {
            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.9 };
            text = "<t size='1.15' align='center'>GANGVERWALTUNG</t>";
            x = 0.245 * safezoneW + safezoneX;
            y = 0.250 * safezoneH + safezoneY;
            w = 0.510 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class lbMembers: RscStructuredText {
            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.9 };
            text = "<t size='1.0' align='center'>MITGLIEDER</t>";
            x = 0.250 * safezoneW + safezoneX;
            y = 0.290 * safezoneH + safezoneY;
            w = 0.252 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class lbInvite: RscStructuredText {
            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.9 };
            text = "<t size='1.0' align='center'>EINLADEN</t>";
            x = 0.250 * safezoneW + safezoneX;
            y = 0.630 * safezoneH + safezoneY;
            w = 0.252 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class lbBank: RscStructuredText {
            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.9 };
            text = "<t size='1.0' align='center'>GANGKASSE</t>";
            x = 0.510 * safezoneW + safezoneX;
            y = 0.290 * safezoneH + safezoneY;
            w = 0.240 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class lbBankAmount: RscStructuredText {
            idc = 2200;
            text = "";
            x = 0.510 * safezoneW + safezoneX;
            y = 0.320 * safezoneH + safezoneY;
            w = 0.240 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class lbSlots: RscStructuredText {
            idc = -1;
            colorBackground[] = { 0, 0, 0, 0.9 };
            text = "<t size='1.0' align='center'>SLOTS</t>";
            x = 0.510 * safezoneW + safezoneX;
            y = 0.400 * safezoneH + safezoneY;
            w = 0.240 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class lbMemberSlotsHeader: RscStructuredText {
            idc = -1;
            colorBackground[] = { 0, 0, 0, 0 };
            text = "<t size='1.0' align='center'>GANGSLOTS</t>";
            x = 0.510 * safezoneW + safezoneX;
            y = 0.430 * safezoneH + safezoneY;
            w = 0.070 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class lbMemberSlots : RscStructuredText {
            idc = 2300;
            text = "<t size='1.3' align='center'>4</t>";
            x = 0.510 * safezoneW + safezoneX;
            y = 0.450 * safezoneH + safezoneY;
            w = 0.070 * safezoneW;
            h = 0.025 * safezoneH;
            colorBackground[] = {0, 0, 0, 0};
        };
    };
    class controls {

        class lstMembers: RscListbox {
            idc = 1500;
            x = 0.250 * safezoneW + safezoneX;
            y = 0.330 * safezoneH + safezoneY;
            w = 0.200 * safezoneW;
            h = 0.295 * safezoneH;
            sizeEx = 0.035;
            colorBackground[] = {0, 0, 0, 0.2};
        };

        class btnKick: RscButtonMenu {
            idc = 1100;
            text = "KICK";
            x = 0.452 * safezoneW + safezoneX;
            y = 0.330 * safezoneH + safezoneY;
            w = 0.050 * safezoneW;
            h = 0.020 * safezoneH;
            onButtonClick = "[""kick""] spawn XY_fnc_gangMenu";

            class Attributes {
                align = "center";
            };
        };

        class btnMod: RscButtonMenu {
            idc = 1101;
            text = "MOD";
            x = 0.452 * safezoneW + safezoneX;
            y = 0.355 * safezoneH + safezoneY;
            w = 0.050 * safezoneW;
            h = 0.020 * safezoneH;
            onButtonClick = "[""moderator""] spawn XY_fnc_gangMenu";

            class Attributes {
                align = "center";
            };
        };

        class btnLead: RscButtonMenu {
            idc = 1102;
            text = "LEAD";
            x = 0.452 * safezoneW + safezoneX;
            y = 0.380 * safezoneH + safezoneY;
            w = 0.050 * safezoneW;
            h = 0.020 * safezoneH;
            onButtonClick = "[""leader""] spawn XY_fnc_gangMenu";

            class Attributes {
                align = "center";
            };
        };

        class cmbPlayers: RscCombo {
            idc = 2100;
            x = 0.250 * safezoneW + safezoneX;
            y = 0.665 * safezoneH + safezoneY;
            w = 0.148 * safezoneW;
            h = 0.025 * safezoneH;
        };

        class btnInvTemp: RscButtonMenu {
            idc = 1103;
            text = "TEMP";
            x = 0.400 * safezoneW + safezoneX;
            y = 0.667 * safezoneH + safezoneY;
            w = 0.050 * safezoneW;
            h = 0.020 * safezoneH;
            onButtonClick = "[""invite"", false] spawn XY_fnc_gangMenu";

            class Attributes {
                align = "center";
            };
        };

        class btnInvPerm: RscButtonMenu {
            idc = 1104;
            text = "PERM";
            x = 0.452 * safezoneW + safezoneX;
            y = 0.667 * safezoneH + safezoneY;
            w = 0.050 * safezoneW;
            h = 0.020 * safezoneH;
            onButtonClick = "[""invite"", true] spawn XY_fnc_gangMenu";

            class Attributes {
                align = "center";
            };
        };

        class btnBankWithdraw: RscButtonMenu {
            idc = 1105;
            text = "ABHEBEN";
            x = 0.510 * safezoneW + safezoneX;
            y = 0.355 * safezoneH + safezoneY;
            w = 0.070 * safezoneW;
            h = 0.020 * safezoneH;
            onButtonClick = "[""withdraw""] spawn XY_fnc_gangMenu";

            class Attributes {
                align = "center";
            };
        };

        class btnBankDeposit: RscButtonMenu {
            idc = -1;
            text = "EINZAHLEN";
            x = 0.595 * safezoneW + safezoneX;
            y = 0.355 * safezoneH + safezoneY;
            w = 0.070 * safezoneW;
            h = 0.020 * safezoneH;
            onButtonClick = "[""deposit""] spawn XY_fnc_gangMenu";

            class Attributes {
                align = "center";
            };
        };

        class btnBankLog: RscButtonMenu {
            idc = -1;
            text = "LOG";
            x = 0.680 * safezoneW + safezoneX;
            y = 0.355 * safezoneH + safezoneY;
            w = 0.070 * safezoneW;
            h = 0.020 * safezoneH;
            onButtonClick = "[""log""] spawn XY_fnc_gangMenu";

            class Attributes {
                align = "center";
            };
        };

        class btnExpandSlots : RscButtonMenu {
            idc = 1106;
            text = "ERWEITERN";
            x = 0.510 * safezoneW + safezoneX;
            y = 0.475 * safezoneH + safezoneY;
            w = 0.070 * safezoneW;
            h = 0.020 * safezoneH;
            onButtonClick = "[""expandSlots""] spawn XY_fnc_gangMenu";

            class Attributes {
                align = "center";
            };
        };

        class btnDisband : RscButtonMenu {
            idc = 1107;
            text = "AUFLÖSEN";
            x = 0.595 * safezoneW + safezoneX;
            y = 0.475 * safezoneH + safezoneY;
            w = 0.070 * safezoneW;
            h = 0.020 * safezoneH;
            onButtonClick = "[""disband""] spawn XY_fnc_gangMenu";

            class Attributes {
                align = "center";
            };
        };

        class btnLeave : RscButtonMenu {
            idc = -1;
            text = "GANG VERLASSEN";
            x = 0.645 * safezoneW + safezoneX;
            y = 0.667 * safezoneH + safezoneY;
            w = 0.100 * safezoneW;
            h = 0.020 * safezoneH;
            onButtonClick = "[""leave""] spawn XY_fnc_gangMenu";

            class Attributes {
                align = "center";
            };
        };

        class btnExit : RscButtonMenu {
            idc = -1;
            text = "X";
            x = 0.730 * safezoneW + safezoneX;
            y = 0.250 * safezoneH + safezoneY;
            w = 0.025 * safezoneW;
            h = 0.025 * safezoneH;
            onButtonClick = "closeDialog 0";

            class Attributes {
                align = "center";
            };
        };
    };
};