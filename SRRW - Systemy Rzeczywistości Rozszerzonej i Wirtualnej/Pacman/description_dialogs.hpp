/*==================================================================
This file sets up standard dialog control base classes and defines,
using the default VBS2 color / font theme

Include it at the top of description.ext's using this line:

	#include "description_dialogs.hpp"

==================================================================*/

//---------------------------------
// Common defines
//---------------------------------
#define true 1
#define false 0

//---------------------------------
// Control types
//---------------------------------
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUT_BUTTON  16 
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102
#define CT_SELECT_SCROLLBAR 110
#define CT_STATEBOX         112
#define CT_SECTION_VIEWER   113

//---------------------------------
// Control styles
//---------------------------------
// Static styles
#define ST_LEFT                  0  // Left aligned text
#define ST_RIGHT                 1  // Right aligned text
#define ST_CENTER                2  // Center aligned text

#define ST_SINGLE                0  // Single line textbox
#define ST_MULTI                16  // Multi-line textbox (text will wrap, and newline character can be used). There is no scrollbar, but mouse wheel/arrows can scroll it. Control will be outlined with a line (color = text color).
#define ST_TITLE_BAR            32  // Light gray background with 3D border
#define ST_PICTURE              48  // 'Text' property is interpreted as an image path.
#define ST_FRAME                64  // Transparent background with 2D border and text in upper left edge.
#define ST_BACKGROUND           80  // Gray background with 3D border.
#define ST_GROUP_BOX            96  // Light gray with with 2D border.
#define ST_GROUP_BOX2          112  // Gray with with 2D border .
#define ST_HUD_BACKGROUND      128  // Light green background with rounded corners (like a hint box).
#define ST_WITH_RECT           160  // Transparent background with 2D border.
#define ST_LINE                176  // A line is drawn between the top left and bottom right of the control (color = text color), with transparent Background.

#define ST_SHADOW              256  // Text or image is given a shadow (V1.x).
#define ST_NO_RECT             512  // When combined with ST_MULTI, border is suppressed.
#define ST_KEEP_ASPECT_RATIO  2048  // Used with pictures, to keep its aspect ratio.

// Slider styles
#define SL_VERT                  0  // Vertical
#define SL_HORZ               1024  // Horizontal 

// Listbox styles
#define LB_TEXTURES             16   // Removes all extra border lines from listbox, leaving only a gradient scrollbar. Useful when LB has a painted background behind it.
#define LB_MULTI                32   // Allows multiple elements of the LB to be selected (by holding Shift / Ctrl)



//---------------------------------
// Default control parameters
//---------------------------------
// Default font
#define FontMAIN "TahomaB"

//Base colors
#define Color_Invisible {0, 0, 0,  0}
#define Color_Black {0, 0, 0,  1}
#define Color_BlackTransparent {0, 0, 0,  0.3}
#define Color_White {1, 1, 1,  1}
#define Color_WhiteTransparent {1, 1, 1,  0.3}
#define Color_Orange {1, 0.5, 0,  1}
#define Color_Gray {0.3, 0.3, 0.3,  1}

// Procedural colors
#define ProcTextInvisible "#(argb,8,8,3)color(0,0,0,0)"
#define ProcTextWhite "#(argb,8,8,3)color(1,1,1,1)"
#define ProcTextBlack "#(argb,8,8,3)color(0,0,0,1)"
#define ProcTextGray "#(argb,8,8,3)color(0.3,0.3,0.3,1)"
#define ProcTextRed "#(argb,8,8,3)color(1,0,0,1)"
#define ProcTextGreen "#(argb,8,8,3)color(0,1,0,1)"
#define ProcTextBlue "#(argb,8,8,3)color(0,0,1,1)"
#define ProcTextOrange "#(argb,8,8,3)color(1,0.5,0,1)"


//---------------------------------
// Base classes for controls
//---------------------------------
// Scrollbar definition to be included in several controls

#define SCROLLBAR \
	class ScrollBar { \
		color[] = {1,1,1,0.6}; \
		colorActive[] = Color_White; \
		colorDisabled[] = Color_WhiteTransparent; \
		thumb="\vbs2\ui\data\ui_scrollbar_thumb_ca.paa"; \
		arrowEmpty="\vbs2\ui\data\ui_arrow_top_ca.paa"; \
		arrowFull="\vbs2\ui\data\ui_arrow_top_active_ca.paa"; \
		border="\vbs2\ui\data\ui_border_scroll_ca.paa"; \
		shadow = 0;\
	};	\
	class VScrollbar {	\
		color[] = Color_White;	\
		width = 0.0210;	\
		autoScrollSpeed = .1;	\
		autoScrollDelay = .1;	\
		autoScrollRewind = true;	\
		shadow = 0;	\
	};	\
	class HScrollbar {	\
		color[] = Color_White;	\
		height = 0.0280;	\
	};	\



//Standard static text.
class RscText {
	type = CT_STATIC;
	style = ST_LEFT;
	idc = -1;
	w = 0.10;
	h = 0.0350;
	colorText[] = Color_Black;
	colorSelect[] = Color_Black;
	colorBackground[] = Color_Invisible;
	shadow = 0;
	lineSpacing = 1;
	maxHistoryDelay = 1.0;
	soundSelect[] = {"", 0.1, 1};
	font = FontMAIN;
	sizeEx = 0.028;
	text = "";
};

//Multi-line text.
class RscTextMulti: RscText {
	linespacing = 1;
	style = ST_LEFT + ST_MULTI + ST_NO_RECT;
};

//Standard active text (text that can be clicked like a button)
class RscActiveText {
	type = CT_ACTIVETEXT;
	style = ST_CENTER;
	idc = -1;
	w = 0.15;
	h = 0.0350;
	color[] = Color_Black;
	colortext[] = Color_Black;
	colorActive[] = Color_Orange;
	soundEnter[] = {"", 0.10, 1};
	soundPush[] = {"", 0.10, 1};
	soundClick[] = {"", 0.10, 1};
	soundEscape[] = {"", 0.10, 1};
	font = FontMAIN;
	sizeEx = 0.028;
	default = false;
	text = "";
};

//Standard picture.
class RscPicture {
	type = CT_STATIC;
	style = ST_PICTURE;
	idc = -1;
	colorText[] = Color_White;
	colorBackground[] = Color_Invisible;
	lineSpacing = 0;
	font = FontMAIN;
	sizeEx = 0;
	text = "";
};

//Picture that maintains its aspect ratio instead of stretching.
class RscPictureKeepAspect: RscPicture {
	style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
};

//Standard button.
class RscButton{
	type = CT_BUTTON;
	style = ST_LEFT;
	idc = -1;
	w = 0.0975;
	h = 0.04;
	colorText[] = Color_Black;
	colorDisabled[] = {0.40, 0.40, 0.40, 1};
	colorBackground[] = Color_White;
	colorBackgroundDisabled[] = {0.70, 0.70, 0.70, 0.80};
	colorBackgroundActive[] = Color_Orange;
	colorFocused[] = Color_Orange;
	colorShadow[] = {0.72, 0.36, 0, 0.80};
	colorBorder[] = {0.72, 0.36, 0, 0};
	soundEnter[] = {"", 0.10, 1};
	soundPush[] = {"", 0.10, 1};
	soundClick[] = {"", 0.10, 1};
	soundEscape[] = {"", 0.10, 1};
	offsetX = 0.0030;
	offsetY = 0.0030;
	offsetPressedX = 0.0020;
	offsetPressedY = 0.0020;
	borderSize = 0.0;
	font = FontMAIN;
	sizeEx = 0.028;
	text = "";
};

//Invisible button
class RscInvisButton: RscActiveText {
	style = ST_PICTURE;
	text = ProcTextInvisible; //invisible procedural texture to fill the entire control
};

//Standard edit text field.
class RscEdit {
	type = CT_EDIT;
	style = ST_LEFT;
	idc = -1;
	h = 0.04;
	colorText[] = Color_Black;
	colorBackground[] = Color_BlackTransparent;
	colorSelection[] = Color_Orange;
	autocomplete = "";
	size = 0.20;
	sizeEx = 0.028;
	font = FontMAIN;
	text = "";
};

//Standard listbox.
class RscListBox {
	type = CT_LISTBOX;
	style = LB_TEXTURES;
	idc = -1;
	w = 0.40;
	h = 0.40;
	color[] = Color_White;
	colorText[] = Color_Black;
	colorScrollbar[] = Color_BlackTransparent;
	colorSelect[] = Color_Black;
	colorSelect2[] = Color_Black;
	colorSelectBackground[] = {0, 0, 0, 0.20};
	colorSelectBackground2[] = {0.90, 0.45, 0, 0.60};
	colorBackground[] = Color_Black;
	highlightColorBackground[] = {0.1, 0.4, 0.4, 1};
	soundSelect[] = {"", 0.10, 1};
	period = 0;
	font = FontMAIN;
	sizeEx = 0.028;
	rowHeight = 0;
	canDrag = false;
	disableFiltering = false;
	maxHistoryDelay = 1.0;
	shadow = 0;
	SCROLLBAR
};

// single row listbox
class RscXListBox {
	type = CT_XLISTBOX;
	style = SL_HORZ;
	idc = -1;
	w = 0.3;
	h = 0.05;
	color[] = {1, 1, 1, 0.6};
	colorActive[] = Color_White;
	colorDisabled[] = Color_WhiteTransparent;
	arrowEmpty = ProcTextWhite;
	arrowFull = ProcTextOrange;
	border = ProcTextBlack;
	colorSelect[] = Color_White;
	colorText[] = {1, 1, 1, 0.8};
	font = FontMAIN;
	sizeEx = 0.04;
	soundSelect[] = {"", 0.1, 1};
};

// multi-column listbox
class RscListNBox {
	type = CT_LISTNBOX;
	style = ST_MULTI;
	idc = -1;
	w = 0.4;
	h = 0.4;
	font = FontMAIN; 
	sizeEx = 0.028;
	colorText[] = Color_Black; 
	colorBackground[] = Color_Black; 
	columns[] = {0.0, 0.3, 0.6}; // number of columns used, and their left positions 
	color[] = Color_White; 
	colorScrollbar[] = {0.95, 0.95, 0.95, 1}; 
	colorSelect[] = Color_Black;
	colorSelect2[] = Color_Black;
	colorSelectBackground[] = {0, 0, 0, 0.20};
	colorSelectBackground2[] = {0.90, 0.45, 0, 0.60};
	drawSideArrows = 0; 
	idcLeft = -1; 
	idcRight = -1; 
	rowHeight = .03; // height of each row
	colorPlayerItem[] = {0.8784,0.8471,0.651,1}; // ???
	soundSelect[] = {"", 0.1, 1}; 
	period = 1; 
	shadow = 0; 
	SCROLLBAR
};
  
//Standard combo box.
class RscCombo {
	type = CT_COMBO;
	style = ST_LEFT;
	idc = -1;
	h = 0.0350;
	wholeHeight = 0.25;
	colorSelect[] = Color_Black;
	colorText[] = Color_Black;
	colorBackground[] = Color_White;
	colorScrollbar[] = Color_Black;
	soundSelect[] = {"", 0.10, 1};
	soundExpand[] = {"", 0.10, 1};
	soundCollapse[] = {"", 0.10, 1};
	maxHistoryDelay = 1.0;
	shadow = 0;
	colorSelectBackground[] = {0.90, 0.45, 0, 0.60};
	font = FontMAIN;
	sizeEx = 0.028;
	arrowFull="\vbs2\ui\data\ui_arrow_down_active_ca.paa";
	arrowEmpty="\vbs2\ui\data\ui_arrow_down_ca.paa";
	SCROLLBAR
};

// Standard slider
class RscSlider {
	type = CT_SLIDER;
	style = SL_HORZ;
	idc = -1;
	w = 0.30;
	h = 0.0250;
	color[] = Color_Black;
	colorActive[] = Color_Black;
};

// Bar slider
class RscXSliderH {
	type = CT_XSLIDER;
	style = SL_DIR;
	idc = -1;
	h = .05;
	color[] = {1, 1, 1, 0.6};
	colorActive[] = Color_White;
	colorDisable[] = Color_WhiteTransparent;
	arrowEmpty = ProcTextWhite;
	arrowFull = ProcTextWhite;
	border = ProcTextWhite;
	thumb = ProcTextWhite;
	shadow = 0;
};

// Structured text 
class RscStructuredText {
	type = CT_STRUCTURED_TEXT;
	style = ST_LEFT;
	idc = -1;
	h = 0.05;
	colorText[] = Color_White;
	shadow = 1;
	class Attributes {
		font = FontMAIN;
		color = "#ffffff";
		align = "center";
		shadow = true;
	};
	size = 0.020833;
	text = "";
};

// HTML control.
class RscHTML {
	type = CT_HTML;
	style = ST_LEFT;
	idc = -1;
	colorText[] = Color_White;
	colorBold[] = Color_Black;
	colorLink[] = {0.05, 0.20, 0.05, 1};
	colorLinkActive[] = {0, 0, 0.20, 1};
	colorBackground[] = Color_Invisible;
	colorPicture[] = Color_White;
	colorPictureLink[] = Color_White;
	colorPictureSelected[] = Color_White;
	colorPictureBorder[] = Color_Invisible;
	tooltipColorText[] = Color_Black;
	tooltipColorBox[] = {0, 0, 0, 0.50};
	tooltipColorShade[] = {1, 1, 0.70, 1};
	align="left";
	filename = "";

	class H1 {
		font = "Zeppelin32";
		fontBold = "Zeppelin33";
		sizeEx = 0.030;
	};
	class H2 {
		font = "Zeppelin32";
		fontBold = "Zeppelin33";
		sizeEx = 0.028;
	};
	class H3 {
		font = "Zeppelin32";
		fontBold = "Zeppelin33";
		sizeEx = 0.026;
	};
	class H4 {
		font = "Zeppelin33Italic";
		fontBold = "Zeppelin33";
		sizeEx = 0.024;
	};
	class H5 {
		font = "Zeppelin32";
		fontBold = "Zeppelin33";
		sizeEx = 0.022;
	};
	class H6 {
		font = "Zeppelin32";
		fontBold = "Zeppelin33";
		sizeEx = 0.020;
	};
	class P {
		font = "Zeppelin32";
		fontBold = "Zeppelin33";
		sizeEx = 0.020;
	};
	prevPage = "\ca\ui\data\arrow_left_ca.paa";
	nextPage = "\ca\ui\data\arrow_right_ca.paa";
};

// Controls group.
class RscControlsGroup {
	type = CT_CONTROLS_GROUP;
	style = ST_LEFT;
	idc = -1;
	x = 0;
	y = 0;
	w = 1;
	h = 1;
	class Controls {
		//place controls of this group in here
	};
};

// Toolbox
class RscToolbox {
	type = CT_TOOLBOX;
	style = ST_CENTER;
	idc = -1;
	color[] = Color_Black;
	colorText[] = Color_Black;
	colorTextSelect[] = Color_Black;
	colorSelect[] = Color_Black;
	colorTextDisable[] = {0.40, 0.40, 0.40, 1};
	colorDisable[] = {0.40, 0.40, 0.40, 1};
	coloSelectedBg[] = Color_White;
	font = FontMAIN;
	SizeEx = 0.028;
	strings[]= {""};
	rows=1;
	columns=3;
};

// Statebox
class RscStatebox {
	type = CT_STATEBOX;
	style = ST_LEFT;
	idc = -1;
	colorText[]         = Color_White;     // Regular color of the text
	colorTextActive[]   = {1,1,0,1};       // Color of the text when mouse is over this control
	colorTextFocused[]  = {1,0.5,0,1};     // Color of the text when control has focus
	colorTextDisabled[] = {0.8,0.8,0.8,1}; // Color of the text when control is disabled
	colorIcon[]         = Color_White;     // Regular color of the icon
	colorIconActive[]   = {1,1,0,1};       // Color of the icon when mouse is over this control
	colorIconFocused[]  = {1,0.5,0,1};     // Color of the icon when control has focus
	colorIconDisabled[] = {0.8,0.8,0.8,1}; // Color of the icon when control is disabled
	iconH = .04;  // height of icon 
	iconW = .03;  // width of icon  
	iconLeft = 1; // 1: icon on left, 0: icon on right
	sizeEx = 0.036;
	text = "";
	font = FontMAIN;
	stateIcons[] = {}; 
};

// Progress bar 
class RscProgress {
	type = CT_PROGRESS;
	style = ST_LEFT;
	idc = -1;
	x = 0.0;
	y = 0.91;
	w = 1;
	h = 0.08;
	colorFrame[] = Color_Invisible;
	colorBar[] = Color_Orange;
	texture = ProcTextWhite;
};

// Advanced Tree
class RscAdvTree {
	type = CT_ADV_TREE;
	style = ST_LEFT;  // TR_AUTOCOLLAPSE:2 | ST_DYNAMIC_HEIGHT:224
	idc = -1; 
	
	colorText[] = Color_Black; // connection line color 
	colorBorder[] = Color_Black; 
	colorBackground[] = {0.2, 0.2, 0.2, 1};
	
	// odd rows
	rowColorBackground1[] = {0.7, 0.7, 0.7, 1};
	rowColorBackgroundSelected1[] = {1, 0.8, 0.3, 1};
	rowColorText1[] = Color_Black;
	rowColorTextSelected1[] = Color_Black;
	// even rows
	rowColorBackground2[] = {0.8, 0.8, 0.8, 1};
	rowColorBackgroundSelected2[] = {1, 0.8, 0.3, 1};
	rowColorText2[] = Color_Black;
	rowColorTextSelected2[] = Color_Black;
	font = FontMAIN;
	sizeEx = .026;
	SCROLLBAR       
};	  

// Section view (floor plan)
class RscSectionView {
	type = CT_SECTION_VIEWER;
	style = ST_LEFT;
	idc = -1;
};

// Map
class RscMapControl {
	type = CT_MAP_MAIN;
	style = ST_PICTURE;
	idc = -1;
	colorBackground[] = Color_White;
	colorOutside[] = {1, 0, 0, 1};
	colorText[] = Color_Black;
	sizeEx = 0.04;
	colorSea[] = {0.56, 0.80, 0.98, 0.50};
	colorForest[] = {0.60, 0.80, 0.20, 0.50};
	colorRocks[] = {0.60, 0.45, 0.27, 0.40};
	colorCountlines[] = {0.70, 0.55, 0.30, 0.60};
	colorMainCountlines[] = {0.65, 0.45, 0.27, 1};
	colorCountlinesWater[] = {0, 0.53, 1, 0.30};
	colorMainCountlinesWater[] = {0, 0.53, 1, 0.50};
	colorForestBorder[] = {0.40, 0.80, 0, 1};
	colorRocksBorder[] = {0.60, 0.45, 0.27, 0.40};
	colorPowerLines[] = Color_Black;
	colorBuildings[] = {0, 0, 0, 0.50};
	colorRailway[] = Color_Black;
	colorNames[] = Color_Black;
	colorInactive[] = {1, 1, 1, 0.50};
	colorLevels[] = {0.65, 0.45, 0.27, 1};

	stickX[] = {0.2, {"Gamma", 1, 1.5}};
	stickY[] = {0.2, {"Gamma", 1, 1.5}};

	fontLabel = FontMAIN;
	sizeExLabel = 0.028;
	text = "#(argb,8,8,3)color(1,1,1,1,co)";
	font = FontMAIN;
	size = 0.028;
	fontGrid = FontMAIN;
	sizeExGrid = 0.018;
	fontUnits = FontMAIN;
	sizeExUnits = 0.04;
	fontNames = FontMAIN;
	sizeExNames = 0.04;
	fontInfo = FontMAIN;
	sizeExInfo = 0.04;
	fontLevel = FontMAIN;
	sizeExLevel = 0.018;

	// Map drawing quality coefficients:
	//  units - the width of the screen == 800
	//  limits - size of the landscape square on screen when objects are drawn or single square content is drawn

	//@{ coefficients which determine rendering density / threshold
	ptsPerSquareSea = 0.1; // seas
	ptsPerSquareTxt = 8;   // textures
	ptsPerSquareCLn = 8;   // count-lines
	ptsPerSquareExp = 8;   // exposure
	ptsPerSquareCost = 8;  // cost
	//@}

	//@{ coefficients which determine when rendering of given type is done
	ptsPerSquareFor = 1;           // forests
	ptsPerSquareForEdge = "10.0f"; // forest edges
	ptsPerSquareRoad = "0.1f";     // roads
	ptsPerSquareObj = 5;           // other objects
	//@}

	showCountourInterval = "true"; // legend in upper right corner, with scaling information

	// _scale is % of map you can see;  satellite map alpha is
	// if map (_scale < alphaFadeStartScale) -> alpha = 1.0 * maxSatelliteAlpha;
	// else map (_scale > alphaFadeEndScale) -> alpha = 0.0;
	// else -> alpha = ((alphaFadeEndScale - _scale) / (alphaFadeEndScale - alphaFadeStartScale)) * maxSatelliteAlpha;  
	maxSatelliteAlpha = 0.66;
	alphaFadeStartScale = 0.05;
	alphaFadeEndScale = 0.15;

	class Legend {
		colorBackground[] = {0.9060, 0.9010, 0.88, 0.80};
		color[] = Color_Black;
		x = 0.7290;
		y = 0.05;
		w = 0.2370;
		h = 0.1270;
		font = FontMAIN;
		sizeEx = 0.021;
	};
	class ActiveMarker {
		color[] = {0.30, 0.10, 0.90, 1};
		size = 50;
	};
	class Task {
		icon = ProcTextGreen;
		iconCreated = ProcTextWhite;
		iconCanceled = ProcTextBlue;
		iconDone = ProcTextBlack;
		iconFailed = ProcTextRed;

		colorCreated[] = Color_White;
		colorCanceled[] = Color_White;
		colorDone[] = Color_White;
		colorFailed[] = Color_White;

		color[] = Color_White;
		size = 18;
		importance = 1; // not used
		coefMin = 1; // not used
		coefMax = 1; // not used
	};
	class CustomMark {
		icon = ProcTextOrange;
		color[] = Color_White;
		size = 18;
		importance = 1; // not used
		coefMin = 1; // not used
		coefMax = 1; // not used
	};
	class Command {
		color[] = {0, 0.90, 0, 1};
		icon = "#(argb,8,8,3)color(1,1,1,1,co)";
		size = 18;
		importance = 1; // not used
		coefMin = 1; // not used
		coefMax = 1; // not used
	};
	class Tree {
		color[] = {0.55, 0.64, 0.43, 1};
		icon = "\vbs2\ui\data\map\map_tree_ca.paa";
		size = 8;
		importance = "0.9 * 16 * 0.05"; // limit for map scale
		coefMin = 0.0010;
		coefMax = 8;
	};
	class SmallTree {
		color[] = {0.55, 0.64, 0.43, 1};
		icon = "\vbs2\ui\data\map\map_smalltree_ca.paa";
		size = 8;
		importance = "0.6 * 12 * 0.05";
		coefMin = 0.0010;
		coefMax = 4;
	};
	class Bush {
		color[] = {0.55, 0.64, 0.43, 1};
		icon = "\vbs2\ui\data\map\map_bush_ca.paa";
		size = 14;
		importance = "0.2 * 14 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Church {
		color[] = Color_Black;
		icon = "\vbs2\ui\data\map\map_church_ca.paa";
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Chapel {
		color[] = Color_Black;
		icon = "\vbs2\ui\data\map\map_chapel_ca.paa";
		size = 16;
		importance = "1 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Cross {
		color[] = Color_Black;
		icon = "\vbs2\ui\data\map\map_cross_ca.paa";
		size = 16;
		importance = "0.7 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Rock {
		color[] = Color_Black;
		icon = "\vbs2\ui\data\map\map_rock_ca.paa";
		size = 12;
		importance = "0.5 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Bunker {
		color[] = Color_Black;
		icon = "\vbs2\ui\data\map\map_bunker_ca.paa";
		size = 14;
		importance = "1.5 * 14 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Fortress {
		color[] = Color_Black;
		icon = "\vbs2\ui\data\map\map_bunker_ca.paa";
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Fountain {
		color[] = {0, 0.35, 0.70, 1};
		icon = "\vbs2\ui\data\map\map_fountain_ca.paa";
		size = 12;
		importance = "1 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class ViewTower {
		color[] = Color_Black;
		icon = "\vbs2\ui\data\map\map_viewtower_ca.paa";
		size = 16;
		importance = "2.5 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Lighthouse {
		color[] = {0.78, 0, 0.05, 1};
		icon = "\vbs2\ui\data\map\map_lighthouse_ca.paa";
		size = 20;
		importance = "3 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Quay {
		color[] = Color_Black;
		icon = "\vbs2\ui\data\map\map_quay_ca.paa";
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Fuelstation {
		color[] = Color_Black;
		icon = "\vbs2\ui\data\map\map_fuelstation_ca.paa";
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Hospital {
		color[] = {0.78, 0, 0.05, 1};
		icon = "\vbs2\ui\data\map\map_hospital_ca.paa";
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class BusStop {
		color[] = {0, 0, 1, 1};
		icon = "\vbs2\ui\data\map\map_busstop_ca.paa";
		size = 10;
		importance = "1 * 10 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Transmitter {
		color[] = {0, 0, 1, 1};
		icon = "\vbs2\ui\data\map\map_transmitter_ca.paa";
		size = 20;
		importance = "2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Stack {
		color[] = {0, 0, 1, 1};
		icon = "\vbs2\ui\data\map\map_stack_ca.paa";
		size = 20;
		importance = "2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Ruin {
		color[] = {0.78, 0, 0.05, 1};
		icon = "\vbs2\ui\data\map\map_ruin_ca.paa";
		size = 16;
		importance = "1.2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Tourism {
		color[] = {0.78, 0, 0.05, 1};
		icon = "\vbs2\ui\data\map\map_tourism_ca.paa";
		size = 16;
		importance = "1 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 8;
	};
	class Watertower {
		color[] = {0, 0.35, 0.70, 1};
		icon = "\vbs2\ui\data\map\map_watertower_ca.paa";
		size = 32;
		importance = "1.2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Waypoint {
		color[] = Color_Black;
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		icon = "\vbs2\ui\data\map\map_waypoint_ca.paa";
	};
	class WaypointCompleted {
		color[] = Color_Black;
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		icon = "\vbs2\ui\data\map\map_waypoint_completed_ca.paa";
	};
};

// 3D object (p3d model)
class RscObject {
	type = CT_OBJECT;
	idc = -1;
	position[] = {0, 0, .5};
	direction[] = {0, 0, 1};
	up[] = {0, 1, 0};
	scale = 1.0;
};