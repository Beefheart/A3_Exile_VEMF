/*
	Author: Jiri Wainar

	Description:
	Types a structured text on the screen, letter by letter, cursor blinking.

	Parameter(s):
	_this: array containing blocks of text with same structured text formatting

	Remarks:
	* Every text block is an array of text and formatting tag.
	* Blocks don't have to span over whole line.

	Example:

	[
		["CAMP ROGAIN,","<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t>"],
		["RESSUPLY POINT","<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"],
		["10 MINUTES LATER ...","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"]

	] spawn BIS_fnc_typeText;
*/

#define DELAY_CHARACTER	0.06;
#define DELAY_CURSOR	0.04;

private["_data","_posX","_posY","_rootFormat","_toDisplay"];
private["_blocks","_block","_blockCount","_blockNr","_blockArray","_blockText","_blockTextF","_blockTextF_","_blockFormat","_formats","_inputData","_processedTextF","_char","_cursorInvis","_blinkCounts","_blinkCount"];

_data 		= [_this, 0, [], [[]]] call BIS_fnc_param;
_posX 		= [safezoneX + 0.02 * safezoneW,safezoneW * 0.8];
_posY 		= [safezoneY + 0.15 * safezoneH, safezoneH * 0.8];
_rootFormat 	= [_this, 3, "<t >%1</t>", [""]] call BIS_fnc_param;

_blockCount = count _data;

_invisCursor = "<t color ='#00000000' shadow = '0'>_</t>";

//process the input data
_blocks 	= [];
_formats 	= [];
_blinkCounts 	= [];

{
	_inputData = _x;

	_block 		= [_inputData, 0, "", [""]] call BIS_fnc_param;
	_format 	= [_inputData, 1, "<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>", [""]] call BIS_fnc_param;
	_blinkCount 	= [_inputData, 2, 5, [123]] call BIS_fnc_param;

	//convert strings into array of chars
	_blockArray = toArray _block;
	{_blockArray set [_forEachIndex, toString [_x]]} forEach _blockArray;

	_blocks  = _blocks + [_blockArray];
	_formats = _formats + [_format];
	_blinkCounts = _blinkCounts + [_blinkCount];
}
forEach _data;

//do the printing
_processedTextF  = "";

{
	_blockArray  = _x;
	_blockNr     = _forEachIndex;
	_blockFormat = _formats select _blockNr;
	_blockText   = "";
	_blockTextF  = "";
	_blockTextF_ = "";

	{
		_char = _x;

		_blockText = _blockText + _char;

		_blockTextF  = format[_blockFormat, _blockText + _invisCursor];
		_blockTextF_ = format[_blockFormat, _blockText + "_"];

		//print the output
		_toDisplay = format[_rootFormat,_processedTextF + _blockTextF_];
		[_toDisplay, _posX, _posY, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;

		playSound "ReadoutClick";

		sleep DELAY_CHARACTER;
		_toDisplay = format[_rootFormat,_processedTextF + _blockTextF];
		[_toDisplay, _posX, _posY, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
		sleep DELAY_CURSOR;
	}
	forEach _blockArray;

	_blinkCount = _blinkCounts select _forEachIndex;

	if (_blinkCount > 0) then
	{
		for "_i" from 1 to _blinkCount do
		{
			_toDisplay = format[_rootFormat,_processedTextF + _blockTextF_];
			[_toDisplay, _posX, _posY, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
			sleep DELAY_CHARACTER;
			_toDisplay = format[_rootFormat,_processedTextF + _blockTextF];
			[_toDisplay, _posX, _posY, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
			sleep DELAY_CURSOR;
		};
	};

	//store finished block
	_processedTextF  = _processedTextF + _blockTextF;
}
forEach _blocks;
uiSleep 4;
//clean the screen
["", _posX, _posY, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;