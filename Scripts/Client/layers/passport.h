#define _X (0.2 * safezoneW + safezoneX)
#define _Y (0.1 * safezoneH + safezoneY)

class XY_PASSPORT {

    idd = 8800;
    fadein = 1;
    duration = 6;
    fadeout = 1;
    onLoad = "uiNamespace setVariable ['XY_PASSPORT' ,_this select 0];";
    onUnload = "uiNamespace setVariable ['XY_PASSPORT', displayNull];";

    class controlsBackground {

        class lbBackground : XY_RscPicture {
            idc = 8801;

            style = 48 + 0x800;
            text = "";

            x = _X;
            y = _Y;
            w = 0.35 * safezoneW;
            h = 0.35 * safezoneH;
        };

        class lbName: RscStructuredText {
            idc = 8810;
            colorBackground[] = { 0, 0, 0, 0 };
            colorText[] = { 1, 1, 1, 1};
            text = "";

            x = _X + 0.18 * safezoneW;
            y = _Y + 0.033 * safezoneH;
            w = 0.175 * safezoneW;
            h = 0.03 * safezoneH;
        };
        class lbNameHeading : RscStructuredText {
            idc = -1;
            colorBackground[] = { 0, 0, 0, 0 };
            colorText[] = { 1, 1, 1, 1};
            text = "<t size='0.6'>NAME</t>";

            x = _X + 0.18 * safezoneW;
            y = _Y + 0.05 * safezoneH;
            w = 0.175 * safezoneW;
            h = 0.03 * safezoneH;
        };

        class lbAddress: RscStructuredText {
            idc = 8811;
            colorBackground[] = { 0, 0, 0, 0 };
            colorText[] = { 1, 1, 1, 1};
            text = "";

            x = _X + 0.18 * safezoneW;
            y = _Y + 0.063 * safezoneH;
            w = 0.175 * safezoneW;
            h = 0.03 * safezoneH;
        };
        class lbAddressHeading : RscStructuredText {
            idc = -1;
            colorBackground[] = { 0, 0, 0, 0 };
            colorText[] = { 1, 1, 1, 1};
            text = "<t size='0.6'>ADRESSE</t>";

            x = _X + 0.18 * safezoneW;
            y = _Y + 0.08 * safezoneH;
            w = 0.175 * safezoneW;
            h = 0.03 * safezoneH;
        };

        class lbTown: RscStructuredText {
            idc = 8812;
            colorBackground[] = { 0, 0, 0, 0 };
            colorText[] = { 1, 1, 1, 1};
            text = "";

            x = _X + 0.18 * safezoneW;
            y = _Y + 0.093 * safezoneH;
            w = 0.175 * safezoneW;
            h = 0.03 * safezoneH;
        };
        class lbTownHeading : RscStructuredText {
            idc = -1;
            colorBackground[] = { 0, 0, 0, 0 };
            colorText[] = { 1, 1, 1, 1};
            text = "<t size='0.6'>WOHNORT</t>";

            x = _X + 0.18 * safezoneW;
            y = _Y + 0.11 * safezoneH;
            w = 0.175 * safezoneW;
            h = 0.03 * safezoneH;
        };

        class lbBirthday: RscStructuredText {
            idc = 8813;
            colorBackground[] = { 0, 0, 0, 0 };
            colorText[] = { 1, 1, 1, 1};
            text = "";

            x = _X + 0.18 * safezoneW;
            y = _Y + 0.123 * safezoneH;
            w = 0.175 * safezoneW;
            h = 0.03 * safezoneH;
        };
        class lbBirthdayHeading : RscStructuredText {
            idc = -1;
            colorBackground[] = { 0, 0, 0, 0 };
            colorText[] = { 1, 1, 1, 1};
            text = "<t size='0.6'>GEBURTSTAG</t>";

            x = _X + 0.18 * safezoneW;
            y = _Y + 0.14 * safezoneH;
            w = 0.175 * safezoneW;
            h = 0.03 * safezoneH;
        };

        class lbBirthLocation: RscStructuredText {
            idc = 8814;
            colorBackground[] = { 0, 0, 0, 0 };
            colorText[] = { 1, 1, 1, 1};
            text = "";

            x = _X + 0.223 * safezoneW;
            y = _Y + 0.123 * safezoneH;
            w = 0.175 * safezoneW;
            h = 0.03 * safezoneH;
        };
        class lbBirthLocationHeading : RscStructuredText {
            idc = -1;
            colorBackground[] = { 0, 0, 0, 0 };
            colorText[] = { 1, 1, 1, 1};
            text = "<t size='0.6'>GEBURTSORT</t>";

            x = _X + 0.223 * safezoneW;
            y = _Y + 0.14 * safezoneH;
            w = 0.175 * safezoneW;
            h = 0.03 * safezoneH;
        };

        class lbHeight: RscStructuredText {
            idc = 8815;
            colorBackground[] = { 0, 0, 0, 0 };
            colorText[] = { 1, 1, 1, 1};
            text = "";

            x = _X + 0.18 * safezoneW;
            y = _Y + 0.163 * safezoneH;
            w = 0.175 * safezoneW;
            h = 0.03 * safezoneH;
        };
        class lbHeightHeading : RscStructuredText {
            idc = -1;
            colorBackground[] = { 0, 0, 0, 0 };
            colorText[] = { 1, 1, 1, 1};
            text = "<t size='0.6'>GROESSE</t>";

            x = _X + 0.18 * safezoneW;
            y = _Y + 0.18 * safezoneH;
            w = 0.175 * safezoneW;
            h = 0.03 * safezoneH;
        };

        class lbEyecolor: RscStructuredText {
            idc = 8816;
            colorBackground[] = { 0, 0, 0, 0 };
            colorText[] = { 1, 1, 1, 1};
            text = "";

            x = _X + 0.18 * safezoneW;
            y = _Y + 0.193 * safezoneH;
            w = 0.175 * safezoneW;
            h = 0.03 * safezoneH;
        };
        class lbEyecolorHeading : RscStructuredText {
            idc = -1;
            colorBackground[] = { 0, 0, 0, 0 };
            colorText[] = { 1, 1, 1, 1};
            text = "<t size='0.6'>AUGENFARBE</t>";

            x = _X + 0.18 * safezoneW;
            y = _Y + 0.21 * safezoneH;
            w = 0.175 * safezoneW;
            h = 0.03 * safezoneH;
        };
    };
};