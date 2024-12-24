private ["_messages","_timeout"];

_messages = [
	["DayZ Epoch", "Welcome "+(name player)],
	["World", worldName],
	["@", "epoch@posteo.de"],
	["WWW", "epoch.bplaced.net"],
    ["INFO", "PRESS F3 FOR HIDING ORIGINS MENU!"],
	["INFO", "The hiding will be saved in your profile"],
	["?", "Do you want more slots?"], 
	["?", "You want to keep the server alive?"],
	["?", "Visit: epoch.bplaced.net"],    
	["Server Rules", "PVE-Server! Respect others! Play fair!"],
	["Restarts", "Every 6 Hours! Starting 0:00 AM CEST!"],
	["Restarts", "Every 6 Hours! Starting 0:00 AM CEST!"],    
	["Restarts", "Every 6 Hours! Starting 0:00 AM CEST!"]
];
 
_timeout = 5;
{
	private ["_title","_content","_titleText"];
	uiSleep 2;
	_title = _x select 0;
	_content = _x select 1;
	_titleText = format[("<t font='TahomaB' size='0.40' color='#a81e13' align='right' shadow='1' shadowColor='#000000'>%1</t><br /><t shadow='1'shadowColor='#000000' font='TahomaB' size='0.60' color='#FFFFFF' align='right'>%2</t>"), _title, _content];
	[
		_titleText,
		[safezoneX + safezoneW - 0.8,0.50],     //DEFAULT: 0.5,0.35
		[safezoneY + safezoneH - 0.8,0.7],      //DEFAULT: 0.8,0.7
		_timeout,
		0.5
	] spawn BIS_fnc_dynamicText;
	uiSleep (_timeout * 1.1);
} forEach _messages;