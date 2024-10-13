if (isServer) then {
	
};

if (!isDedicated) then {	
	//Add your custom or override functions here
	//fnc_usec_selfActions = compile preprocessFileLineNumbers "dayz_code\compile\fn_selfActions.sqf";
    
	//Bandage
	combineBandage = compile preprocessFileLineNumbers "scripts\additions\combineBandage.sqf";
	unpackBandage = compile preprocessFileLineNumbers "scripts\additions\unpackBandage.sqf";
	fnc_use_item = compile preprocessFileLineNumbers "scripts\additions\use_item.sqf";
    
    //epoch-right-click-actions for Epoch 1.0.7+
    player_selectSlot = compile preprocessFileLineNumbers "dayz_code\compile\ui_selectSlot.sqf";
    
};