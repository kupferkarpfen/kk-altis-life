#define BaseIconID 78000

class XY_HUD_nameTags {

	idd = -1;
	duration = 1e+011;
	name = "XY_HUD_nameTags";
	onLoad = "uiNamespace setVariable['XY_HUD_nameTags',_this select 0]";
	objects[] = {};
	
	class controls {
		class BaseIcon {
			idc = -1;
			type = 13;
			style = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			font = "PuristaMedium";
			text = "";
			size = 0.04;
			shadow = 1.5;
			w = 0; h = 0;
			x = 0.1; y = 0.1;
		};
		
		class p1 : BaseIcon {idc = BaseIconID;};
		class p2 : BaseIcon {idc = BaseIconID + 1;};
		class p3 : BaseIcon {idc = BaseIconID + 2;};
		class p4 : BaseIcon {idc = BaseIconID + 3;};
		class p5 : BaseIcon {idc = BaseIconID + 4;};
		class p6 : BaseIcon {idc = BaseIconID + 5;};
		class p7 : BaseIcon {idc = BaseIconID + 6;};
		class p8 : BaseIcon {idc = BaseIconID + 7;};
		class p9 : BaseIcon {idc = BaseIconID + 8;};
		class p10 : BaseIcon {idc = BaseIconID + 9;};
		class p11 : BaseIcon {idc = BaseIconID + 10;};
		class p12 : BaseIcon {idc = BaseIconID + 11;};
		class p13 : BaseIcon {idc = BaseIconID + 12;};
		class p14 : BaseIcon {idc = BaseIconID + 13;};
		class p15 : BaseIcon {idc = BaseIconID + 14;};
		class p16 : BaseIcon {idc = BaseIconID + 15;};
		class p17 : BaseIcon {idc = BaseIconID + 16;};
		class p18 : BaseIcon {idc = BaseIconID + 17;};
		class p19 : BaseIcon {idc = BaseIconID + 18;};
		class p20 : BaseIcon {idc = BaseIconID + 19;};
		class p21 : BaseIcon {idc = BaseIconID + 20;};
		class p22 : BaseIcon {idc = BaseIconID + 21;};
		class p23 : BaseIcon {idc = BaseIconID + 22;};
		class p24 : BaseIcon {idc = BaseIconID + 23;};
		class p25 : BaseIcon {idc = BaseIconID + 24;};
		class p26 : BaseIcon {idc = BaseIconID + 25;};
	};
};