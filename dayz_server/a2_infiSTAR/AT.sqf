/*
	Author: Chris(tian) "infiSTAR" Lorenzen
	Contact: infiSTAR23@gmail.com // www.infiSTAR.de
	
	Description:
	Arma AntiHack & AdminTools - infiSTAR.de
*/
PV_AdminMainCode = {
	if(isNil'dayz_playerUID')then{dayz_playerUID = getPlayerUID player;};
	if(isNil'dayz_characterID')then{dayz_characterID = 'no dayz';};
	if(isNil'player_humanityMorph')then{player_humanityMorph = {systemChat 'player_humanityMorph not existing in this mod.';};};
	if(isNil 'admin_playercheck')then
	{
		admin_playercheck = true;
		[] spawn {
			uiSleep 120;
			while{1 == 1}do 
			{
				{
					if(!isNull _x)then
					{
						_puid = getPlayerUID _x;
						if(_puid != '')then
						{
							_name = 'DEAD';if((alive _x)&&(getPlayerUID _x != ''))then{_name = name _x;};
							if(isNil 'PVAH_AHTMPBAN')then{PVAH_AHTMPBAN = [];} else {if(typeName PVAH_AHTMPBAN != 'ARRAY')then{PVAH_AHTMPBAN = [];};};
							if(_puid in PVAH_AHTMPBAN)then
							{
								PVAH_AdminReq = [17,player,_x];
								publicVariableServer "PVAH_AdminReq";
								
								_nameP = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_nameP = name player;};
								_sl = format["%1 Kicked %2(%3) (AutoKick Banned Player)",_nameP,_name,_puid];
								hint _sl;
								PVAH_WriteLogReq = [player,toArray _sl];
								publicVariableServer 'PVAH_WriteLogReq';
							};
						};
					};
				} forEach playableUnits;
				uiSleep 30;
			};
		};
	};
	inSub = false;
	getControl = {(findDisplay 3030) displayCtrl _this;};
	if(isNil "admin_toggled")then{admin_toggled = [];};
	if(isNil "PlayerLogArray")then{PlayerLogArray = [];};
	if(isNil 'PV_writeAdmin_log_ARRAY')then{PV_writeAdmin_log_ARRAY = [];};
	admin_fillSpawnMenuFILL =
	{
		_puid = getPlayerUID player;
		if(_puid in PV_SuperLevel_List)then
		{
			adminadd = adminadd + ["   +Spawn Vehicle","Vehicles","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +Spawn Vehicle HIVE","Vehicleshive","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +Spawn Buildings","Buildings","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +Spawn Weapons & Items","Weaponz","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +Spawn Magazines","Magzz","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +Spawn Weapons & Magazines","WeaponzMagzz","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +Spawn Backpacks","BackPacksz","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +Spawn Player Morph","Skinz","0","0","1","0",[0,0.6,1,1]];
		};
		if(_puid in PV_NormalLevel_List)then
		{
			if(!isNil 'infiAllowedVehiclesList')then{ALL_VEHS_TO_SEARCH = infiAllowedVehiclesList;};
			
			adminadd = adminadd + ["   +Spawn Vehicle","Vehicles","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +Spawn Weapons & Items","Weaponz","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +Spawn Magazines","Magzz","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +Spawn Weapons & Magazines","WeaponzMagzz","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +Spawn Backpacks","BackPacksz","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +Spawn Player Morph","Skinz","0","0","1","0",[0,0.6,1,1]];
		};
		if(_puid in PV_LowLevel_List)then
		{
			if(!isNil 'infiAllowedVehiclesList')then{ALL_VEHS_TO_SEARCH = infiAllowedVehiclesList;};
			
			adminadd = adminadd + ["   +Spawn Player Morph","Skinz","0","0","1","0",[0,0.6,1,1]];
		};
		adminadd = adminadd + ["============================================================","","0","1","0","0",[]];
	};
	admin_fillSpawnMenu =
	{
		inSub = false;
		_ctrl = 2 call getControl;
		lbclear _ctrl;
		_ctrl ctrlSetFont "TahomaB";
		adminadd = [];
		call admin_fillsubsss;
		call admin_fillSpawnMenuFILL;
		_puid = getPlayerUID player;
		if(_puid in (PV_NormalLevel_List+PV_SuperLevel_List))then
		{
			adminadd = adminadd + ["  Spawn 10 Zombies",{[10] call adminCallZeds;},"0","0","0","0",[]];
			adminadd = adminadd + ["  Spawn 50 Zombies",{[50] call adminCallZeds;},"0","0","0","0",[]];
			adminadd = adminadd + ["","","0","1","0","0",[]];
			adminadd = adminadd + ["  Spawn Support-Box1",{1 call supportbox},"0","0","0","0",[]];
			adminadd = adminadd + ["  Spawn Support-Box2",{2 call supportbox},"0","0","0","0",[]];
			adminadd = adminadd + ["  Spawn Support-Box3",{3 call supportbox},"0","0","0","0",[]];
			if(MOD_EPOCH)then
			{
				adminadd = adminadd + ["","","0","1","0","0",[]];
				adminadd = adminadd + ["  Spawn Support-Vault1",{1 call supportVault},"0","0","0","0",[]];
				adminadd = adminadd + ["  Spawn Support-Vault2",{2 call supportVault},"0","0","0","0",[]];
				adminadd = adminadd + ["  Spawn Support-Vault3",{3 call supportVault},"0","0","0","0",[]];
			};
			adminadd = adminadd + ["","","0","1","0","0",[]];
			adminadd = adminadd + ["","","0","1","0","0",[]];
			adminadd = adminadd + ["  Spawn Box",admincrate,"0","0","0","0",[]];
			adminadd = adminadd + ["  Spawn Box (all items)",admincrateALL,"0","0","0","0",[]];
			if(MOD_EPOCH)then
			{
				adminadd = adminadd + ["  Spawn Epoch-Box",admincrateEpoch,"0","0","0","0",[]];
				adminadd = adminadd + ["","","0","1","0","0",[]];
				adminadd = adminadd + ["  Spawn Donor Supply Package (Small)",supplypackage1,"0","0","0","0",[]];
				adminadd = adminadd + ["  Spawn Donor Supply Package (Medium)",supplypackage2,"0","0","0","0",[]];
				adminadd = adminadd + ["  Spawn Donor Supply Package (Large)",supplypackage3,"0","0","0","0",[]];
			};
		};
		call admin__FILL_MENUS;
	};
	admin_fillsubsss =
	{
		_puid = getPlayerUID player;
		if(_puid in PV_SuperLevel_List)then
		{
			adminadd = adminadd + ["   +View Main Menu","MainMenu","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +View SpecificTarget Menu","ASpecificMenu","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +View Spawn Menu","SpawnMenu","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +View WeatherLord Menu","Weather","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +View TimeLord Menu","AAATime","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + [(format["   -View Player Log: (%1)",round((count PlayerLogArray)/3)]),"uidLog","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + [(format["   -View Admin Log: (%1)",(count PV_writeAdmin_log_ARRAY)]),"WriteLog","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + [(format["   -View Surveillance Log: (%1)",((count PV_SurveillanceLog)-1)]),"SurveillanceLog","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + [(format["   -View Hacker Log: (%1)",((count PV_hackerL0og)-1)]),"hackerLog","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + [(format["   -View TempBanned Log: (%1)",round(count PVAH_AHTMPBAN)]),"tempbanned","0","0","1","0",[0,0.6,1,1]];
		};
		if(_puid in PV_NormalLevel_List)then
		{
			adminadd = adminadd + ["   +View Main Menu","MainMenu","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +View Spawn Menu","SpawnMenu","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +View WeatherLord Menu","Weather","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +View TimeLord Menu","AAATime","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + [(format["   -View Surveillance Log: (%1)",((count PV_SurveillanceLog)-1)]),"SurveillanceLog","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + [(format["   -View Hacker Log: (%1)",((count PV_hackerL0og)-1)]),"hackerLog","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + [(format["   -View TempBanned Log: (%1)",round(count PVAH_AHTMPBAN)]),"tempbanned","0","0","1","0",[0,0.6,1,1]];
		};
		if(_puid in PV_LowLevel_List)then
		{
			adminadd = adminadd + ["   +View Main Menu","MainMenu","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +View Spawn Menu","SpawnMenu","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +View WeatherLord Menu","Weather","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + ["   +View TimeLord Menu","AAATime","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + [(format["   -View Surveillance Log: (%1)",((count PV_SurveillanceLog)-1)]),"SurveillanceLog","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + [(format["   -View Hacker Log: (%1)",((count PV_hackerL0og)-1)]),"hackerLog","0","0","1","0",[0,0.6,1,1]];
			adminadd = adminadd + [(format["   -View TempBanned Log: (%1)",round(count PVAH_AHTMPBAN)]),"tempbanned","0","0","1","0",[0,0.6,1,1]];
		};
		adminadd = adminadd + ["============================================================","","0","1","0","0",[]];
	};
	admin_fillSpecificMenu =
	{
		inSub = false;
		_ctrl = 2 call getControl;
		lbclear _ctrl;
		_ctrl ctrlSetFont "TahomaB";
		adminadd = [];
		call admin_fillsubsss;
		adminadd = adminadd + ["  Teleport Player To Me",admint2me,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  Teleport To Player",admintele,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  FreeRoam Cam (RightClick to exit)",admin_frcam,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["============================================================","","0","1","0","0",[]];
		adminadd = adminadd + ["  Ban",adminBanPerm,"0","0","0","1",[0.9,0,0,1]];
		adminadd = adminadd + ["  TempBan",adminbanTemp,"0","0","0","1",[0.9,0,0,1]];
		adminadd = adminadd + ["Targeted Friendly","","0","1","0","0",[]];
		adminadd = adminadd + ["  Heal",adminheal,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  Repair Vehicle",adminrepair,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  Flip Near Vehicle",admin_flipvehicle,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  Change Humanity",changeHumanity,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  Give +2500 Humanity",adminHumanityPlus,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  Give -2500 Humanity",adminHumanityMinus,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  Give Ammo",admin_give_ammo,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  Clone",adminCloneTarget,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  Un-Freeze",adminUnFreeze,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  Join Vehicle",admin_joinhisveh,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  Move in my Vehicle",admin_moveinmyveh,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  Eject from Vehicle",admin_ejecFromVeh,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["Targeted EVIL","","0","1","0","0",[]];
		adminadd = adminadd + ["  Find parts to Hit",{[call fnc_admin_call_for_name,'FIND',1] call adminHitVeh},"0","0","0","1",[0.99,0.8,0.8,1]];
		adminadd = adminadd + ["  Take 200 Blood",admintakeblood,"0","0","0","1",[0.99,0.8,0.8,1]];
		adminadd = adminadd + ["  Remove Ammo",admin_remove_ammo,"0","0","0","1",[0.99,0.8,0.8,1]];
		adminadd = adminadd + ["  Break Legs",adminbreakleg,"0","0","0","1",[0.99,0.8,0.8,1]];
		adminadd = adminadd + ["  RemoveGear",adminremovegear,"0","0","0","1",[0.99,0.8,0.8,1]];
		adminadd = adminadd + ["  Drug",adminDrug,"0","0","0","1",[0.99,0.8,0.8,1]];
		adminadd = adminadd + ["  Slap",adminSlap,"0","0","0","1",[0.99,0.8,0.8,1]];
		adminadd = adminadd + ["  Burn",adminBurn,"0","0","0","1",[0.99,0.8,0.8,1]];
		adminadd = adminadd + ["  Freeze",adminFreeze,"0","0","0","1",[0.99,0.8,0.8,1]];
		adminadd = adminadd + ["  Knockout",adminUncon,"0","0","0","1",[0.99,0.8,0.8,1]];
		adminadd = adminadd + ["  Suicide",adminSuicide,"0","0","0","1",[0.99,0.8,0.8,1]];
		adminadd = adminadd + ["  Kill",adminkill,"0","0","0","1",[0.99,0.8,0.8,1]];
		adminadd = adminadd + ["  Force Disconnect",adminFDisconnect,"0","0","0","1",[0.99,0.8,0.8,1]];
		adminadd = adminadd + ["  Kick",adminkick,"0","0","0","1",[0.99,0.8,0.8,1]];
		call admin__FILL_MENUS;
	};
	admin_update_ctrl2 = {disableSerialization;call admin_filllist;};
	SuperAdmin_MENU =
	{
		AllowSpectating = true;
		adminKeybinds = {
			private ['_key','_shift','_ctrl','_alt'];
			_key = _this select 1;
			_shift = _this select 2;
			_ctrl = _this select 3;
			_alt = _this select 4;
			if(_key == 0x3E)then{call admin_BaseMenu;};
			if(_key == 0x42)then{closeDialog 0;};
			if(_key == 0x05)then{call admin_fly_up;};
			if(_key == 0x06)then{call admin_tpdirection;};
			if(_key == 0x02)then{call admin_animate1;};
			if(_key == 0x03)then{call admin_animate2;};
			if(_key == 0x16)then{call admin_generatekey;};
			if(_key == 0x17)then{call admin_showid;};
			if(_key == 0xD2)then{call admin_save_target;};
			if(_key == 0xD3)then{call adminDelete;};
			if(_key == 0x44)then{call remove_spec_000;};
			if(_key == 0x43)then{call admin_show;};
		};
		
		adminadd = adminadd + ["  Teleport Player To Me",admint2me,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  Teleport To Player",admintele,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  FreeRoam Cam (RightClick to exit)",admin_frcam,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["============================================================","","0","1","0","0",[]];
		adminadd = adminadd + ["  Activate [ALT+LeftmouseButton] Map to TP",adminaltteleport,"1","0","0","0",[]];
		adminadd = adminadd + ["  Toggle TP Direction Keybind",admin_tpdirection_on,"1","0","0","0",[]];
		adminadd = adminadd + ["  Disable Announcements",admin_show_announcements,"1","0","0","0",[]];
		adminadd = adminadd + ["Icons","","0","1","0","0",[]];
		adminadd = adminadd + ["  Grim ESP",fnc_bruno_esp,"1","0","0","0",[]];
		adminadd = adminadd + ["  ESP for FreeRoam Cam",admin_fnc_esp,"1","0","0","0",[]];
		adminadd = adminadd + ["  ESP Icons (don't work with groups)",adminESPicons,"1","0","0","0",[]];
		adminadd = adminadd + ["  Map Icons",fnc_MapIcons_infiSTAR,"1","0","0","0",[]];
		_fnc = "-Markers";
		if(isNil 'adminshowmarkermenu')then{_fnc = "+Markers";};
		adminadd = adminadd + [_fnc,{if(isNil "adminshowmarkermenu")then{adminshowmarkermenu = true;}else{adminshowmarkermenu = nil;};call admin_update_ctrl2;},"0","0","0","0",[0,0.6,1,1]];
		if(!isNil "adminshowmarkermenu")then
		{
			adminadd = adminadd + ["  Map Player Markers",adminmark,"1","0","0","0",[]];
			adminadd = adminadd + ["  Map (unlocked) Vehicle Markers",adminmarkveh_U,"1","0","0","0",[]];
			adminadd = adminadd + ["  Map (locked) Vehicle Markers",adminmarkveh_L,"1","0","0","0",[]];
			adminadd = adminadd + ["  Map Corpse Markers",adminDEAD,"1","0","0","0",[]];
			adminadd = adminadd + ["  Map Wreck Markers",adminwreck,"1","0","0","0",[]];
			adminadd = adminadd + ["  Map Tent Markers",admintent,"1","0","0","0",[]];
			if(MOD_EPOCH)then
			{
				adminadd = adminadd + ["  Map VEINE Markers",adminVEINE,"1","0","0","0",[]];
				adminadd = adminadd + ["  Map VAULT Markers",adminVAULT,"1","0","0","0",[]];
				adminadd = adminadd + ["  Map PlotPole Markers",adminPlotPole,"1","0","0","0",[]];
				adminadd = adminadd + ["  Locate Your Vehicle(s)",adminLocateVeh,"1","0","0","0",[]];
			};
		};
		_fnc = "-Misc";
		if(!isNil 'adminshowmiscmenu')then{_fnc = "+Misc";};
		adminadd = adminadd + [_fnc,{if(!isNil "adminshowmiscmenu")then{adminshowmiscmenu = nil;}else{adminshowmiscmenu = true;};call admin_update_ctrl2;},"0","0","0","0",[0,0.6,1,1]];
		if(isNil "adminshowmiscmenu")then
		{
			adminadd = adminadd + ["  Lower Terrain",admin_low_terrain,"1","0","0","0",[]];
			adminadd = adminadd + ["  VehicleBoost",admin_vehicleboost,"1","0","0","0",[]];
			adminadd = adminadd + ["  No Zed Aggro",adminAntiAggro,"1","0","0","0",[]];
			adminadd = adminadd + ["  ZedShield",adminZedshld,"1","0","0","0",[]];
			adminadd = adminadd + ["  Infinite Ammo & No Recoil",adminammo_recoil,"1","0","0","0",[]];
			adminadd = adminadd + ["  FastFire",admin_FastFire,"1","0","0","0",[]];
			adminadd = adminadd + ["  God",admingod,"1","0","0","0",[]];
			adminadd = adminadd + ["  Car God",adminCarGod,"1","0","0","0",[]];
			adminadd = adminadd + ["  Fly",fnc_admin_fly,"1","0","0","0",[]];
			adminadd = adminadd + ["  Stealth / Invisible",admininvis,"1","0","0","0",[]];
			adminadd = adminadd + ["  Admin DebugMonitor",admin_debug,"1","0","0","0",[]];
			if(MOD_EPOCH)then
			{
				adminadd = adminadd + ["  No Build Limit",adminNoBuildLimit,"1","0","0","0",[]];
				adminadd = adminadd + ["  No OverBurdened",adminob,"1","0","0","0",[]];
				adminadd = adminadd + ["  1 Step Building",admin1build,"1","0","0","0",[]];
				adminadd = adminadd + ["  No PlotPole",admin_noplot,"1","0","0","0",[]];
				adminadd = adminadd + ["  EpochDeathBoardLoad",adminPlayerDeaths,"0","0","0","0",[]];
				adminadd = adminadd + ["  Remove Plot-Poles (30m)",admin_removePlotPoles,"0","0","0","0",[]];
				adminadd = adminadd + ["  Remove Nets (30m)",admin_removeNets,"0","0","0","0",[]];
			};
			adminadd = adminadd + ["  Copy Worldspace(coords) to RPT & Chat",admincopy,"0","0","0","0",[]];
			adminadd = adminadd + ["  Admin Scroll Menu",adminlite,"1","0","0","0",[]];
			adminadd = adminadd + ["  Wardrobe",adminskin,"1","0","0","0",[]];
			adminadd = adminadd + ["  Force Disconnect (Self)",{(findDisplay 46) closeDisplay 0;},"0","0","0","0",[]];
		};
		_fnc = "-Loadouts";
		if(isNil 'adminsholoadoutmenu')then{_fnc = "+Loadouts";};
		adminadd = adminadd + [_fnc,{if(isNil "adminsholoadoutmenu")then{adminsholoadoutmenu = true;}else{adminsholoadoutmenu = nil;};call admin_update_ctrl2;},"0","0","0","0",[0,0.6,1,1]];
		if(!isNil "adminsholoadoutmenu")then
		{
			adminadd = adminadd + ["  >>>>Dump Loadout",admindump,"0","0","0","0",[]];
			adminadd = adminadd + ["  AKSD",adminaksd,"0","0","0","0",[]];
			adminadd = adminadd + ["  DMR",admindmr,"0","0","0","0",[]];
			adminadd = adminadd + ["  FNFAL",adminfnfal,"0","0","0","0",[]];
			adminadd = adminadd + ["  G36A",adming36a,"0","0","0","0",[]];
			adminadd = adminadd + ["  KSVK",adminksvk,"0","0","0","0",[]];
			adminadd = adminadd + ["  L85 Thermal",adminl85,"0","0","0","0",[]];
			adminadd = adminadd + ["  Lapua",adminlapua,"0","0","0","0",[]];
			adminadd = adminadd + ["  M14",adminm14,"0","0","0","0",[]];
			adminadd = adminadd + ["  M16A4 ACOG",adminm16acg,"0","0","0","0",[]];
			adminadd = adminadd + ["  M24",adminm24,"0","0","0","0",[]];
			adminadd = adminadd + ["  M249",adminm249,"0","0","0","0",[]];
			adminadd = adminadd + ["  M40",adminm40,"0","0","0","0",[]];
			adminadd = adminadd + ["  M4SPR",adminm4spr,"0","0","0","0",[]];
			adminadd = adminadd + ["  MK48",adminmk48,"0","0","0","0",[]];
			adminadd = adminadd + ["  PKP",adminpecheneg,"0","0","0","0",[]];
			adminadd = adminadd + ["  SA58 ACOG",adminsa58,"0","0","0","0",[]];
			adminadd = adminadd + ["  SCAR CCO SD",adminscarccosd,"0","0","0","0",[]];
			adminadd = adminadd + ["  SCAR EGLM",adminscareglm,"0","0","0","0",[]];
			adminadd = adminadd + ["  SCAR Sniper",adminscarsniper,"0","0","0","0",[]];
			adminadd = adminadd + ["  SVD",adminsvd,"0","0","0","0",[]];
			adminadd = adminadd + ["  SVD Camo",adminsvdcamo,"0","0","0","0",[]];
			adminadd = adminadd + ["  VSS",adminvss,"0","0","0","0",[]];
		};
		_fnc = "-Server Management";
		if(isNil 'adminshowmanagementmenu')then{_fnc = "+Server Management";};
		adminadd = adminadd + [_fnc,{if(isNil "adminshowmanagementmenu")then{adminshowmanagementmenu = true;}else{adminshowmanagementmenu = nil;};call admin_update_ctrl2;},"0","0","0","0",[0,0.6,1,1]];
		if(!isNil "adminshowmanagementmenu")then
		{
			adminadd = adminadd + ["  Mass Message",adminmsg,"0","0","0","0",[]];
			adminadd = adminadd + ["  Mass Message Colored",adminmsg2,"0","0","0","0",[]];
			adminadd = adminadd + ["  Clear Ban List",adminClearBan,"0","0","0","0",[]];
			adminadd = adminadd + ["  Fix Servers FPS",adminfixfps,"0","0","0","0",[]];
			adminadd = adminadd + ["  Delete Boxes",admin_del_bxs,"0","0","0","0",[]];
		};
		_fnc = "-Change Layout";
		if(isNil 'adminshowlayoutsmenu')then{_fnc = "+Change Layout";};
		adminadd = adminadd + [_fnc,{if(isNil "adminshowlayoutsmenu")then{adminshowlayoutsmenu = true;}else{adminshowlayoutsmenu = nil;};call admin_update_ctrl2;},"0","0","0","0",[0,0.6,1,1]];
		if(!isNil "adminshowlayoutsmenu")then
		{
			adminadd = adminadd + ["  Menu Layout Medium #2",{Admin_Layout = 3;call admin_init;},"0","0","0","0",[]];
			adminadd = adminadd + ["  Menu Layout Medium #1*old default",{Admin_Layout = 0;call admin_init;},"0","0","0","0",[]];
			adminadd = adminadd + ["  Menu Layout Big",{Admin_Layout = 1;call admin_init;},"0","0","0","0",[]];
			adminadd = adminadd + ["  Menu Layout Center",{Admin_Layout = 2;call admin_init;},"0","0","0","0",[]];
		};
		_fnc = "-Show Keybindings";
		if(isNil 'adminshowbindingsmenu')then{_fnc = "+Show Keybindings";};
		adminadd = adminadd + [_fnc,{if(isNil "adminshowbindingsmenu")then{adminshowbindingsmenu = true;}else{adminshowbindingsmenu = nil;};call admin_update_ctrl2;},"0","0","0","0",[0,0.6,1,1]];
		if(!isNil "adminshowbindingsmenu")then
		{
			if(MOD_EPOCH)then
			{
				adminadd = adminadd + ["Epoch","","0","1","0","0",[]];
				adminadd = adminadd + ["  1 - Open/Unlock Door/Vehicle CursorTarget","","0","1","0","0",[]];
				adminadd = adminadd + ["  2 - Close/Lock Door/Vehicle CursorTarget","","0","1","0","0",[]];
				adminadd = adminadd + ["  I - Show Lock Code CursorTarget","","0","1","0","0",[]];
				adminadd = adminadd + ["  U - Generate Key CursorTarget","","0","1","0","0",[]];
				adminadd = adminadd + ["  Insert - Save Building/Vehicle to Database/Hive","","0","1","0","0",[]];
				adminadd = adminadd + ["  F4 - Base Copy/Paste/Destruction","","0","1","0","0",[]];
			};
			adminadd = adminadd + ["All Mods","","0","1","0","0",[]];
			adminadd = adminadd + ["  4 - Fly Up","","0","1","0","0",[]];
			adminadd = adminadd + ["  5 - TP LookingDirection","","0","1","0","0",[]];
			adminadd = adminadd + ["  End - Toggle DebugMonitor","","0","1","0","0",[]];
			adminadd = adminadd + ["  Delete - Delete CursorTarget","","0","1","0","0",[]];
			adminadd = adminadd + ["  F5 - Map Options","","0","1","0","0",[]];
			adminadd = adminadd + ["  F9 - ShowGear","","0","1","0","0",[]];
			adminadd = adminadd + ["  F10 - UnSpectate","","0","1","0","0",[]];
			if(AllowSpectating)then
			{
				adminadd = adminadd + ["README:","","0","1","0","0",[]];
				adminadd = adminadd + ["  DoubleClick Player To Spectate","","0","1","0","0",[]];
			};
		};
	};
	NormalAdmin_Menu =
	{
		AllowSpectating = true;
		adminKeybinds = {
			private ['_key','_shift','_ctrl','_alt'];
			_key = _this select 1;
			_shift = _this select 2;
			_ctrl = _this select 3;
			_alt = _this select 4;
			if(_key == 0x3E)then{call admin_BaseMenu;};
			if(_key == 0x42)then{closeDialog 0;};
			if(_key == 0x05)then{call admin_fly_up;};
			if(_key == 0x06)then{call admin_tpdirection;};
			if(_key == 0x02)then{call admin_animate1;};
			if(_key == 0x03)then{call admin_animate2;};
			if(_key == 0x16)then{call admin_generatekey;};
			if(_key == 0x17)then{call admin_showid;};
			if(_key == 0xD2)then{call admin_save_target;};
			if(_key == 0xD3)then{call adminDelete;};
			if(_key == 0x44)then{call remove_spec_000;};
			if(_key == 0x43)then{call admin_show;};
		};
		
		adminadd = adminadd + ["  Teleport Player To Me",admint2me,"0","0","0","1",[]];
		adminadd = adminadd + ["  Teleport To Player",admintele,"0","0","0","1",[]];
		adminadd = adminadd + ["============================================================","","0","1","0","0",[]];
		adminadd = adminadd + ["  Activate [ALT+LeftmouseButton] Map to TP",adminaltteleport,"1","0","0","0",[]];
		adminadd = adminadd + ["  Toggle TP Direction Keybind",admin_tpdirection_on,"1","0","0","0",[]];
		adminadd = adminadd + ["  Disable Announcements",admin_show_announcements,"1","0","0","0",[]];
		adminadd = adminadd + ["Markers","","0","1","0","0",[]];
		adminadd = adminadd + ["  Map Player Markers",adminmark,"1","0","0","0",[]];
		adminadd = adminadd + ["  Map (unlocked) Vehicle Markers",adminmarkveh_U,"1","0","0","0",[]];
		adminadd = adminadd + ["  Map (locked) Vehicle Markers",adminmarkveh_L,"1","0","0","0",[]];
		adminadd = adminadd + ["  Map Corpse Markers",adminDEAD,"1","0","0","0",[]];
		adminadd = adminadd + ["  Map Wreck Markers",adminwreck,"1","0","0","0",[]];
		adminadd = adminadd + ["  Map Tent Markers",admintent,"1","0","0","0",[]];
		if(MOD_EPOCH)then
		{
			adminadd = adminadd + ["  Map VEINE Markers",adminVEINE,"1","0","0","0",[]];
			adminadd = adminadd + ["  Map VAULT Markers",adminVAULT,"1","0","0","0",[]];
		};
		adminadd = adminadd + ["Icons","","0","1","0","0",[]];
		adminadd = adminadd + ["  Map Icons",fnc_MapIcons_infiSTAR,"1","0","0","0",[]];
		adminadd = adminadd + ["  ESP Icons (don't work with groups)",adminESPicons,"1","0","0","0",[]];
		adminadd = adminadd + ["Change Layout","","0","1","0","0",[]];
		adminadd = adminadd + ["  Menu Layout Medium #2",{Admin_Layout = 3;call admin_init;},"0","0","0","0",[]];
		adminadd = adminadd + ["  Menu Layout Medium #1*old default",{Admin_Layout = 0;call admin_init;},"0","0","0","0",[]];
		adminadd = adminadd + ["  Menu Layout Big",{Admin_Layout = 1;call admin_init;},"0","0","0","0",[]];
		adminadd = adminadd + ["  Menu Layout Center",{Admin_Layout = 2;call admin_init;},"0","0","0","0",[]];
		adminadd = adminadd + ["Misc","","0","1","0","0",[]];
		adminadd = adminadd + ["  God",admingod,"1","0","0","0",[]];
		if(MOD_EPOCH)then
		{
			adminadd = adminadd + ["  No Build Limit",adminNoBuildLimit,"1","0","0","0",[]];
			adminadd = adminadd + ["  No OverBurdened",adminob,"1","0","0","0",[]];
			adminadd = adminadd + ["  1 Step Building",admin1build,"1","0","0","0",[]];
		};
		adminadd = adminadd + ["  ZedShield",adminZedshld,"1","0","0","0",[]];
		
		
		adminadd = adminadd + ["Targeted Friendly","","0","1","0","0",[]];
		adminadd = adminadd + ["  Heal",adminheal,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  Repair Vehicle",adminrepair,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  Flip Near Vehicle",admin_flipvehicle,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  Change Humanity",changeHumanity,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  Give +2500 Humanity",adminHumanityPlus,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["  Give -2500 Humanity",adminHumanityMinus,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["Targeted EVIL","","0","1","0","0",[]];
		adminadd = adminadd + ["  RemoveGear",adminremovegear,"0","0","0","1",[0.99,0.8,0.8,1]];
		adminadd = adminadd + ["  Kill",adminkill,"0","0","0","1",[0.99,0.8,0.8,1]];
		adminadd = adminadd + ["  Kick",adminkick,"0","0","0","1",[0.99,0.8,0.8,1]];
		_fnc = "-Show Keybindings";
		if(isNil 'adminshowbindingsmenu')then{_fnc = "+Show Keybindings";};
		adminadd = adminadd + [_fnc,{if(isNil "adminshowbindingsmenu")then{adminshowbindingsmenu = true;}else{adminshowbindingsmenu = nil;};call admin_update_ctrl2;},"0","0","0","0",[0,0.6,1,1]];
		if(!isNil "adminshowbindingsmenu")then
		{
			if(MOD_EPOCH)then
			{
				adminadd = adminadd + ["Epoch","","0","1","0","0",[]];
				adminadd = adminadd + ["  1 - Open/Unlock Door/Vehicle CursorTarget","","0","1","0","0",[]];
				adminadd = adminadd + ["  2 - Close/Lock Door/Vehicle CursorTarget","","0","1","0","0",[]];
				adminadd = adminadd + ["  I - Show Lock Code CursorTarget","","0","1","0","0",[]];
				adminadd = adminadd + ["  U - Generate Key CursorTarget","","0","1","0","0",[]];
				adminadd = adminadd + ["  Insert - Save Building/Vehicle to Database/Hive","","0","1","0","0",[]];
				adminadd = adminadd + ["  F4 - Base Copy/Paste/Destruction","","0","1","0","0",[]];
			};
			adminadd = adminadd + ["All Mods","","0","1","0","0",[]];
			adminadd = adminadd + ["  4 - Fly Up","","0","1","0","0",[]];
			adminadd = adminadd + ["  5 - TP LookingDirection","","0","1","0","0",[]];
			adminadd = adminadd + ["  End - Toggle DebugMonitor","","0","1","0","0",[]];
			adminadd = adminadd + ["  Delete - Delete CursorTarget","","0","1","0","0",[]];
			adminadd = adminadd + ["  F5 - Map Options","","0","1","0","0",[]];
			adminadd = adminadd + ["  F9 - ShowGear","","0","1","0","0",[]];
			adminadd = adminadd + ["  F10 - UnSpectate","","0","1","0","0",[]];
			if(AllowSpectating)then
			{
				adminadd = adminadd + ["README:","","0","1","0","0",[]];
				adminadd = adminadd + ["  DoubleClick Player To Spectate","","0","1","0","0",[]];
			};
		};
	};
	LowAdmin_MENU =
	{
		AllowSpectating = true;
		adminKeybinds = {
			private ['_key','_shift','_ctrl','_alt'];
			_key = _this select 1;
			_shift = _this select 2;
			_ctrl = _this select 3;
			_alt = _this select 4;
			if(_key == 0x42)then{closeDialog 0;};
			if(_key == 0x02)then{call admin_animate1;};
			if(_key == 0x03)then{call admin_animate2;};
			if(_key == 0x16)then{call admin_generatekey;};
			if(_key == 0x17)then{call admin_showid;};
			if(_key == 0x44)then{call remove_spec_000;};
		};
		
		adminadd = adminadd + ["  Teleport Player To Me",admint2me,"0","0","0","1",[]];
		adminadd = adminadd + ["  Teleport To Player",admintele,"0","0","0","1",[]];
		adminadd = adminadd + ["============================================================","","0","1","0","0",[]];
		adminadd = adminadd + ["Misc","","0","1","0","0",[]];
		if(MOD_EPOCH)then
		{
			adminadd = adminadd + ["  No OverBurdened",adminob,"1","0","0","0",[]];
			adminadd = adminadd + ["  1 Step Building",admin1build,"1","0","0","0",[]];
		};
		adminadd = adminadd + ["Targeted Friendly","","0","1","0","0",[]];
		adminadd = adminadd + ["  Heal",adminheal,"0","0","0","1",[0,0.8,1,1]];
		adminadd = adminadd + ["Targeted EVIL","","0","1","0","0",[]];
		adminadd = adminadd + ["  Kill",adminkill,"0","0","0","1",[0.99,0.8,0.8,1]];
		adminadd = adminadd + ["==============================","","0","1","0","0",[]];
		adminadd = adminadd + ["  Disable Announcements",admin_show_announcements,"1","0","0","0",[]];
		adminadd = adminadd + ["Change Layout","","0","1","0","0",[]];
		adminadd = adminadd + ["  Menu Layout Medium #2",{Admin_Layout = 3;call admin_init;},"0","0","0","0",[]];
		adminadd = adminadd + ["  Menu Layout Medium #1*old default",{Admin_Layout = 0;call admin_init;},"0","0","0","0",[]];
		adminadd = adminadd + ["  Menu Layout Big",{Admin_Layout = 1;call admin_init;},"0","0","0","0",[]];
		adminadd = adminadd + ["  Menu Layout Center",{Admin_Layout = 2;call admin_init;},"0","0","0","0",[]];
		
		_fnc = "-Show Keybindings";
		if(isNil 'adminshowbindingsmenu')then{_fnc = "+Show Keybindings";};
		adminadd = adminadd + [_fnc,{if(isNil "adminshowbindingsmenu")then{adminshowbindingsmenu = true;}else{adminshowbindingsmenu = nil;};call admin_update_ctrl2;},"0","0","0","0",[0,0.6,1,1]];
		if(!isNil "adminshowbindingsmenu")then
		{
			if(MOD_EPOCH)then
			{
				adminadd = adminadd + ["Epoch","","0","1","0","0",[]];
				adminadd = adminadd + ["  1 - Open/Unlock Door/Vehicle CursorTarget","","0","1","0","0",[]];
				adminadd = adminadd + ["  2 - Close/Lock Door/Vehicle CursorTarget","","0","1","0","0",[]];
				adminadd = adminadd + ["  I - Show Lock Code CursorTarget","","0","1","0","0",[]];
				adminadd = adminadd + ["  U - Generate Key CursorTarget","","0","1","0","0",[]];
			};
			adminadd = adminadd + ["All Mods","","0","1","0","0",[]];
			adminadd = adminadd + ["  End - Toggle DebugMonitor","","0","1","0","0",[]];
			adminadd = adminadd + ["  F10 - UnSpectate","","0","1","0","0",[]];
			if(AllowSpectating)then
			{
				adminadd = adminadd + ["README:","","0","1","0","0",[]];
				adminadd = adminadd + ["  DoubleClick Player To Spectate","","0","1","0","0",[]];
			};
		};
	};
	fnc_admin_call_for_name =
	{
		private ["_name","_plistText","_uid","_namex"];
		_name = '';
		_plistText = lbtext [1, (lbCurSel 1)];
		if(_plistText != '')then
		{
			{
				_uid = getPlayerUID _x;
				if(_uid != '')then
				{
					_namex = 'DEAD';if((alive _x)&&(getPlayerUID _x != ''))then{_namex = name _x;};
					if(_plistText == format['%1 (ID: %2)',_namex,_x getVariable['CharacterID','0']])then
					{
						_name = _namex;
						VARIABLE_ADMIN_TARGET_UID = _uid;
						VARIABLE_ADMIN_TARGET_NAME = _name;
						VARIABLE_ADMIN_TARGET_OBJ = _x;
						VARIABLE_ADMIN_TARGET_VEH = vehicle _x;
						VARIABLE_ADMIN_TARGET_POS = getPosATL _x;
					};
				};
			} forEach playableUnits;
		};
		_name
	};
	admin_dbclick_2 =
	{
		private ["_name","_nameP","_sl"];
		if(isNil 'AllowSpectating')then{AllowSpectating = false;};
		if(AllowSpectating)then
		{
			_name = call fnc_admin_call_for_name;
			[] spawn adminspec;
			_nameP = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_nameP = name player;};
			_sl = format['%1 Spectating %2',_nameP,_name];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		};
	};
	admin_dbclick =
	{
		private ["_isran","_code","_istoggle","_istitle","_issubmenu","_isplayer"];
		_isran = false;
		_code = adminadd select ((lbCurSel 2))*7+1;
		_istoggle = adminadd select ((lbCurSel 2))*7+2;
		_istitle = adminadd select ((lbCurSel 2))*7+3;
		_issubmenu = adminadd select ((lbCurSel 2))*7+4;
		_isplayer = adminadd select ((lbCurSel 2))*7+5;
		if(_istitle == "1")exitWith {};
		if(_istoggle == "1")then
		{
			_isran = true;
			if(typeName _code == 'CODE')then
			{
				[] spawn _code;
			}
			else
			{
				if(typeName _code == 'STRING')then
				{
					call compile _code;
				};
			};
			_toggle = (lbtext [2, (lbCurSel 2)]);
			if!(_toggle in admin_toggled)then
			{
				lbSetColor [2, _toggle, [0, 1, 0, 1]];
				admin_toggled = admin_toggled + [_toggle];
			}
			else
			{
				lbSetColor [2, _toggle, [1, 0, 0, 1]];
				admin_toggled = admin_toggled - [_toggle];
			};
			call admin_init;
		};
		if(_issubmenu == "1")then
		{
			switch (_code) do {
				case 'ASpecificMenu':{call admin_fillSpecificMenu};
				case 'Vehicles':{call admin_fillveh};
				case 'Vehicleshive':{call admin_fillvehHIVE};
				case 'Buildings':{call admin_fillobj};
				case 'Weaponz':{call admin_fillwpn};
				case 'Magzz':{call admin_fillmag};
				case 'WeaponzMagzz':{call infiSTAR_wepsMags};
				case 'BackPacksz':{call infiSTAR_BackPacksz};
				case 'hackerLog':{call admin_fillhlog};
				case 'WriteLog':{call admin_fill_writelog};
				case 'SurveillanceLog':{call admin_fillklog};
				case 'MainMenu':{call admin_filllist};
				case 'SpawnMenu':{call admin_fillSpawnMenu};
				case 'Skinz':{call admin_fillSkinz};
				case 'uidLog':{call admin_filluLog};
				case 'tempbanned':{call admin_filltmpban};
				case 'Weather':{call admin_weather};
				case 'AAATime':{call admin_time};
				default {};
			};
		};
		if(inSub)then
		{
			_isran = true;
			if(typeName _code == 'STRING')then
			{
				call compile _code;
			}
			else
			{
				if(typeName _code == 'CODE')then
				{
					[] spawn _code;
				};
			};
		};
		if(_isplayer == "1")then
		{
			_isran = true;
			if((lbCurSel 1) >= 0)then
			{
				_name = call fnc_admin_call_for_name;
				if(typeName _code == 'CODE')then
				{
					[_name] spawn _code;
				}
				else
				{
					if(typeName _code == 'STRING')then
					{
						[_name] call (compile _code);
					};
				};
			}
			else
			{
				hint "Select a player!";
			};
		};
		if(!_isran)then
		{
			if(typeName _code == 'CODE')then
			{
				[] spawn _code;
			};
		};
	};
	admin__FILL_MENUS =
	{
		private ["_item","_index","_togglable","_istitle","_issubmenu","_thcolor","_status","_pic"];
		call Admin_Fill_filler;
		if(!isNil 'resetLayout')then{resetLayout = nil;call admin_init;};
		if(isNil 'isWep__i_n_f_i_S_T_A_R')then{isWep__i_n_f_i_S_T_A_R = false;};
		if(isNil 'isMag__i_n_f_i_S_T_A_R')then{isMag__i_n_f_i_S_T_A_R = false;};
		if(isNil 'isVehicle__i_n_f_i_S_T_A_R')then{isVehicle__i_n_f_i_S_T_A_R = false;};
		for [{_num = 0}, {_num <= count(adminadd)-1}, {_num = _num+7}] do
		{
			_item = adminadd select _num;
			_index = _ctrl lbAdd format['%1',_item];
			_togglable = adminadd select (_num+2);
			_istitle = adminadd select (_num+3);
			_issubmenu = adminadd select (_num+4);
			_thcolor = adminadd select (_num+6);
			if(count _thcolor == 0)then
			{
				_ctrl lbSetColor [(lbsize _ctrl)-1, [1, 1, 1, 1]];
			}
			else
			{
				_ctrl lbSetColor [(lbsize _ctrl)-1, _thcolor];
			};
			if(_togglable == '1')then
			{
				if(_item in admin_toggled)then
				{
					_ctrl lbSetColor [(lbsize _ctrl)-1, [0, 1, 0, 1]];
				}
				else
				{
					_ctrl lbSetColor [(lbsize _ctrl)-1, [1, 0, 0, 1]];
				};
			};
			if(_istitle == '1')then{_ctrl lbSetColor [(lbsize _ctrl)-1, [0.2, 0.4, 1, 1]];};
			if((_issubmenu == '1') && (count _thcolor == 0))then{_ctrl lbSetColor [(lbsize _ctrl)-1, [0,0.8,0.76,1]];};
			
			_fnc_cv =
			{
				if(!isNil 'infiAllowedVehiclesList')then
				{
					if!(_item in infiAllowedVehiclesList)then
					{
						_ctrl lbSetColor [(lbsize _ctrl)-1, [0.9,0,0,1]];
					};
				};
			};
			_status = call {
				if(isClass (configFile >> 'CfgWeapons' >> _item))exitWith {'CfgWeapons'};
				if(isClass (configFile >> 'CfgMagazines' >> _item))exitWith {'CfgMagazines'};
				if(isClass (configFile >> 'CfgVehicles' >> _item))exitWith{call _fnc_cv;'CfgVehicles'};
				'no';
			};
			if(_status != 'no')then
			{
				_pic = (getText (configFile >> _status >> _item >> 'picture'));
				if(_pic != '')then{_ctrl lbSetPicture [(lbsize _ctrl)-1,_pic];};
			};
		};
		isWep__i_n_f_i_S_T_A_R = false;
		isMag__i_n_f_i_S_T_A_R = false;
		isVehicle__i_n_f_i_S_T_A_R = false;
	};
	Admin_Fill_filler = 
	{
		adminadd = adminadd + 
		["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + 
		["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + 
		["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + 
		["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + 
		["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + 
		["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + 
		["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + 
		["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + 
		["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + 
		["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + 
		["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + 
		["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + 
		["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + ["","","0","1","0","0",[]] + 
		["","","0","1","0","0",[]];
	};
	admin_show_announcements = {
		if(isNil "admin_announce")then{admin_announce = true;} else {admin_announce = !admin_announce;};
		if(admin_announce)then{cutText ["AntiHack Announcements On", "PLAIN"];}else{cutText ["AntiHack Announcements Disabled", "PLAIN"];};
	};
	admin_skin_change = {
		private ["_name","_model","_nameP","_sl"];
		_name = _this select 0;
		_model = _this select 1;
		
		PVAH_AdminReq = [24,player,_name,_model];
		publicVariableServer "PVAH_AdminReq";
		hint format["Change %1 skin to %2",_name,_model];
		
		_nameP = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_nameP = name player;};
		_sl = format["%1 AdminSkinChange %2 to %3",_nameP,_name,_model];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	Admin_fillSkinz =
	{
		adminaddxxxxx = nil;
		if(isNil "adminaddxxxxx")then{adminaddxxxxx = compile ('
			adminadd = adminadd + ["Invisible Skin",format[_execx,"Survivor1_DZ"],"0","0","0","0",[]];
			if(!isNil "AllPlayers")then
			{
				adminadd = adminadd + ["-LEGIT SKINS","","0","1","0","0",[]];
				{
					adminadd = adminadd + [_x,format[_execx,_x],"0","0","0","0",[0,0.4,0.6,1]];
				} forEach AllPlayers;
			};
			adminadd = adminadd + ["-ALL AVAILABLE SKINS","","0","1","0","0",[]];
			adminaddmen = ["--- Player Skins","","0","0","0","0",[0,0.8,1,1]];
			adminaddzed = ["--- Zombie Skins","","0","0","0","0",[0,0.65,0,1]];
			adminaddanimal = ["--- Animal Skins","","0","0","0","0",[0.5,0,0.2,1]];
			_cfgvehicles = configFile >> "cfgVehicles";
			for "_i" from 0 to (count _cfgvehicles)-1 do
			{
				_vehicle = _cfgvehicles select _i;
				if(isClass _vehicle)then
				{
					_veh_type = configName _vehicle;
					_add = false;
					if(!isNil "AllPlayers")then
					{
						if !(_veh_type in AllPlayers)then
						{
							_add = true;
						};
					}
					else
					{
						_add = true;
					};
					if(_add)then
					{
						if((getNumber (_vehicle >> "scope") == 2) && (getText (_vehicle >> "picture") != "") && (_veh_type isKindOf "Man") && !(_veh_type isKindOf "zZombie_Base") && !(_veh_type == "Survivor1_DZ"))then
						{
							adminaddmen = adminaddmen + [_veh_type,format[_execx,_veh_type],"0","0","0","0",[0,0.8,1,1]];
						};
						if((getNumber (_vehicle >> "scope") == 2) && (getText (_vehicle >> "picture") != "") && !(_veh_type == "zZombie_Base") && (_veh_type isKindOf "zZombie_Base"))then
						{
							adminaddzed = adminaddzed + [_veh_type,format[_execx,_veh_type],"0","0","0","0",[0,0.65,0,1]];
						};
						if((getNumber (_vehicle >> "scope") == 2) && (_veh_type isKindOf "CAAnimalBase") && !(_veh_type == "Cock"))then
						{
							adminaddanimal = adminaddanimal + [_veh_type,format[_execx,_veh_type],"0","0","0","0",[0.5,0,0.2,1]];
						};
					};
				};
			};adminadd = adminadd + adminaddmen + adminaddzed + adminaddanimal;');
		};
		inSub = true;
		_ctrl = -1 call getControl;
		_ctrl ctrlSetPosition [safezoneXAbs + 0.01, safezoneY + 0.07, ((0.485)*0.65) *2, (safeZoneH - 0.07 - 0.03)*0.65];
		_ctrl ctrlSetScale 1.55;
		_ctrl ctrlCommit 0;
		
		_ctrl = 1 call getControl;
		_ctrl ctrlSetFont "TahomaB";
		_ctrl ctrlSetPosition [safezoneXAbs + 0.01, (safezoneY + 0.07), (0.485)*0.65, ((safeZoneH - 0.07 - 0.03)*0.65)];
		_ctrl ctrlSetScale 1.55;
		_ctrl ctrlCommit 0;
		
		_ctrl = 2 call getControl;
		lbclear _ctrl;
		_ctrl ctrlSetFont "TahomaB";
		_ctrl ctrlSetPosition [safezoneXAbs + 0.5, (safezoneY + 0.07), (0.485)*0.65, ((safeZoneH - 0.07 - 0.03)*0.65)];
		_ctrl ctrlSetScale 1.55;
		_ctrl ctrlCommit 0;
		
		[] spawn {
			waitUntil {player hideObject true;isNull finddisplay 3030};
			player hideObject false;
		};
		
		if(isNil 'OLDTYPEXXX')then{OLDTYPEXXX = '';};
		infiSTAR_showSkin =
		{
			private ["_type","_distance","_dir","_pos","_agent"];
			_type = lbtext [2, (lbCurSel 2)];
			if((_type isKindOf 'Man') && (str _type != str OLDTYPEXXX))then
			{
				_distance = 3;
				_dir = getdir player;
				_pos = getPos player;
				_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),0];
				
				_agent = _type createVehicleLocal _pos;
				/*
				_agent = createAgent [_type, _pos, [], 20, 'NONE'];
				_agent enableSimulation false;
				_agent allowDammage false;
				_agent disableAI 'FSM';
				_agent disableAI 'MOVE';
				_agent disableAI 'AUTOTARGET';
				_agent disableAI 'TARGET';
				_agent setBehaviour 'CARELESS';
				_agent forceSpeed 0;
				*/
				[_agent] spawn {
					_agent = _this select 0;
					waitUntil {!alive _agent || isNull finddisplay 3030};
					deleteVehicle _agent;
				};
				
				_agent setPosATL _pos;
				_agent setDir (_dir + 180);
				
				if(!isNil 'OLDAGENTXXX')then{deleteVehicle OLDAGENTXXX;};
				OLDAGENTXXX = _agent;
			};
			OLDTYPEXXX = _type;
		};
		_ctrl ctrlSetEventHandler ["LBSelChanged", "call infiSTAR_showSkin;"];
		_execx = "[call fnc_admin_call_for_name,'%1'] spawn admin_skin_change";
		adminadd = [];
		call admin_fillsubsss;
		call admin_fillSpawnMenuFILL;
		call adminaddxxxxx;
		call admin__FILL_MENUS;
		resetLayout = true;
	};
	adminskin =
	{
		if(isNil "adminskinz")then{adminskinz = 0;};
		if(adminskinz == 0)then
		{
			_formatLine = "
				_model = '%1';
				[dayz_playerUID,dayz_characterID,_model] spawn player_humanityMorph;
				adminSkin_wardrobe = player addAction [(""<t color=""""#ff8810"""">"" + (""Wardrobe"") +""</t>""),""ca\modules\MP\data\scriptCommands\moveIn.sqf"",
				""Driver ObjNull;([] spawn adminSkin_helper);"",5,false,false,"""",""""];
			";
			wardrobe =
			[
				["",true],
					["DayZ Clothing", [2], "#USER:WardrobeDayZ", -5, [["expression", ""]], "1", "1"],
					["Custom Clothing", [3], "#USER:WardrobeCustom", -5, [["expression", ""]], "1", "1"],
					["", [-1], "", -5, [["expression", ""]], "1", "0"],
					["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
			];
			WardrobeCustom =
			[
				["",true],
					["Rocket Uniform", [2],  "", -5, [["expression", format[_formatLine,"Rocket_DZ"]]], "1", "1"],
					["Desert Rocket Uniform", [3],  "", -5, [["expression", format[_formatLine,"BAF_Soldier_Officer_DDPM"]]], "1", "1"],
					["Desert Camo Clothing", [4],  "", -5, [["expression", format[_formatLine,"BAF_Soldier_L_DDPM"]]], "1", "1"],
					["Desert Soldier Uniform", [5],  "", -5, [["expression", format[_formatLine,"BAF_Soldier_DDPM"]]], "1", "1"],
					["Desert Green Uniform", [6],  "", -5, [["expression", format[_formatLine,"BAF_Soldier_MTP"]]], "1", "1"],
					["US Soldier Uniform", [7],  "", -5, [["expression", format[_formatLine,"US_Soldier_EP1"]]], "1", "1"],
					["Czech Soldier Uniform", [8],  "", -5, [["expression", format[_formatLine,"CZ_Soldier_DES_EP1"]]], "1", "1"],
					["Invisible Skin", [9],  "", -5, [["expression", format[_formatLine,"Survivor1_DZ"]]], "1", "1"],
					["", [-1], "", -5, [["expression", ""]], "1", "0"],
					["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
			];
			WardrobeDayZ =
			[
				["",true],
					["Male Suvivor", [2],  "", -5, [["expression", format[_formatLine,"Survivor2_DZ"]]], "1", "1"],
					["Female Suvivor", [3],  "", -5, [["expression", format[_formatLine,"SurvivorW2_DZ"]]], "1", "1"],
					["Male Bandit", [4],  "", -5, [["expression", format[_formatLine,"Bandit1_DZ"]]], "1", "1"],
					["Female Bandit", [5],  "", -5, [["expression", format[_formatLine,"BanditW1_DZ"]]], "1", "1"],
					["Camo Clothing", [6],  "", -5, [["expression", format[_formatLine,"Camo1_DZ"]]], "1", "1"],
					["Ghillie Suit", [7],  "", -5, [["expression", format[_formatLine,"Sniper1_DZ"]]], "1", "1"],
					["Soldier Uniform", [8],  "", -5, [["expression", format[_formatLine,"Soldier1_DZ"]]], "1", "1"],
					["", [-1], "", -5, [["expression", ""]], "1", "0"],
					["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
			];
			adminskinz = 1;
			adminSkin_wardrobe = player addAction [("<t color=""#ff8810"">" + ("Wardrobe") +"</t>"),"ca\modules\MP\data\scriptCommands\moveIn.sqf",
			"Driver ObjNull;([] spawn adminSkin_helper);",5,false,false,"",""];
			adminSkin_helper = {showcommandingMenu "#USER:wardrobe";};
		}
		else
		{
			player removeAction adminSkin_wardrobe;
			adminskinz = 0;
		};
	};
	admincopy =
	{
		disableSerialization;
		_dir = getDir player;
		_pos = getPosATL player;
		_worldspace = format['[%1,%2]',_dir,_pos];
		_log = format['Worldspace: %1',_worldspace];
		cutText [format['%1 - saved to RPT',_log], 'PLAIN DOWN']; 
		diag_log [_log,'PLAIN DOWN'];
		(findDisplay 46) createDisplay 'RscDisplayChat';
		_display = (findDisplay 24);
		_chat = _display displayCtrl 101;
		_chat ctrlSetText _worldspace;
	};
	adminlite =
	{
		if(isNil "adminlitez")then{adminlitez = 0;};
		if(adminlitez == 0)then
		{
			antihacklite =
			[
				["",true],
					["Tools", [0], "#USER:AntihackScrollwheel", -5, [["expression", ""]], "1", "1"],
					["Spawn Box", [0],  "", -5, [["expression", "[] spawn admincrate"]], "1", "1"],
					["", [-1], "", -5, [["expression", ""]], "1", "0"],
					["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
			];
			AntihackScrollwheel =
			[
				["",true],
					["Toggle God Mode", [0],  "", -5, [["expression", "[] spawn admingod"]], "1", "1"],
					["Toggle ESP", [0],  "", -5, [["expression", "[] spawn adminESPicons"]], "1", "1"],
					["Toggle Map Markers", [0],  "", -5, [["expression", "[] spawn fnc_MapIcons_infiSTAR"]], "1", "1"],
					["Toggle Zed Shield", [0],  "", -5, [["expression", "[] spawn adminZedshld"]], "1", "1"],
					["Toggle No Zed Aggro", [0],  "", -5, [["expression", "[] spawn adminAntiAggro"]], "1", "1"],
					["Toggle Vehicle Boost", [0],  "", -5, [["expression", "[] spawn admin_vehicleboost"]], "1", "1"],
					["Toggle Lower Terrain", [0],  "", -5, [["expression", "[] spawn admin_low_terrain"]], "1", "1"],
					["Toggle Admin Debug", [0],  "", -5, [["expression" ,"[] spawn admin_debug"]], "1", "1"],
					["", [-1], "", -5, [["expression", ""]], "1", "0"],
					["Exit", [0], "", -3, [["expression", ""]], "1", "1"]	
			];
			adminlitez = 1;
			Admin_Lite_Menu = player addAction [("<t color=""#6b4ebc"">" + ("Admin Menu") +"</t>"),"ca\modules\MP\data\scriptCommands\moveIn.sqf",
			"Driver ObjNull;(call adminLite_helper);",5,false,false,"",""];
			adminLite_helper = {showcommandingMenu "#USER:antihacklite";};
		}
		else
		{
			player removeAction Admin_Lite_Menu;
			adminlitez = 0;
		};
	};
	admin_filllist =
	{
		inSub = false;
		_ctrl = 2 call getControl;
		lbclear _ctrl;
		_ctrl ctrlSetFont "TahomaB";
		adminadd = [];
		call admin_fillsubsss;
		if(getPlayerUID player in PV_LowLevel_List)then{call LowAdmin_MENU;};
		if(getPlayerUID player in PV_NormalLevel_List)then{call NormalAdmin_Menu;};
		if(getPlayerUID player in PV_SuperLevel_List)then{call SuperAdmin_MENU;};
		call admin__FILL_MENUS;
		if(isNil 'ADMINCHECK')then{ADMINCHECK = '   AntiHack by infiSTAR.de';};
		if((count(toArray ADMINCHECK)) != 26)then{[] spawn {uiSleep (300 + (random 200));{_x setPosATL [5000,5000,100];} forEach (playableUnits+vehicles);};};
	};
	admin_fillplr =
	{
		disableSerialization;
		_ctrl = 1 call getControl;
		lbclear _ctrl;
		_ctrl ctrlSetFont "TahomaB";
		
		_unsorted = playableUnits;
		_ctrl lbAdd format["Player: %1",{!(getPlayerUID _x in PV_DevUlDs)} count _unsorted];
		_sorted = [];
		{
			_closest = _unsorted select 0;
			{if((getPos _x distance player) < (getPos _closest distance player))then{_closest = _x}} forEach _unsorted;
			_sorted = _sorted + [_closest];
			_unsorted = _unsorted - [_closest]
		} forEach _unsorted;
		_sorted;
		
		_devsOn = [];
		{
			_puid = getPlayerUID _x;
			if(_puid in PV_DevUlDs)then
			{
				_devsOn = _devsOn + [_x];
			};
		} forEach _sorted;
		if(count _devsOn > 0)then
		{
			if(player in _devsOn)then
			{
				_ctrl lbAdd "   Hidden Admins";
				{
					if(!isNull _x)then
					{
						if(alive _x)then
						{
							_sorted = _sorted - [_x];
							_namex = 'DEAD';if((alive _x)&&(getPlayerUID _x != ''))then{_namex = name _x;};
							_ctrl lbAdd format['%1 (ID: %2)',_namex,_x getVariable['CharacterID','0']];
							_ctrl lbSetData [(lbsize _ctrl)-1, "1"];
							_ctrl lbSetColor [(lbsize _ctrl)-1, [0, 1, 0, 1]];
							if(vehicle _x == _x)then
							{
								_plrpic = (getText (configFile >> "CfgVehicles" >> (typeOf vehicle _x) >> "picture"));
								_ctrl lbSetPicture [(lbsize _ctrl)-1, _plrpic];
								_ctrl lbSetPicture [(lbsize _ctrl)-1, (getText (configFile >> "CfgWeapons" >> (primaryWeapon _x) >> "picture"))];
								_ctrl lbSetPicture [(lbsize _ctrl)-1, (getText (configFile >> "CfgWeapons" >> (currentWeapon _x) >> "picture"))];
							}
							else
							{
								_plrpic = (getText (configFile >> "CfgVehicles" >> (typeOf vehicle _x) >> "picture"));
								_ctrl lbSetPicture [(lbsize _ctrl)-1, _plrpic];
							};
						};
					};
				} forEach _devsOn;
			};
		};
		{_sorted = _sorted - [_x];} forEach _devsOn;
		
		
		if(getPlayerUID player in PV_SuperLevel_List)then
		{
			_csa = {getPlayerUID _x in PV_SuperLevel_List} count _sorted;
			if(_csa > 0)then
			{
				_ctrl lbAdd "      SuperAdmin";
				_ctrl lbSetData [(lbsize _ctrl)-1, "1"];
				_ctrl lbSetColor [(lbsize _ctrl)-1, [0,0.6,1,1]];
				{
					_puid = getPlayerUID _x;
					if(_puid in PV_SuperLevel_List)then
					{
						_sorted = _sorted - [_x];
						_namex = 'DEAD';if((alive _x)&&(getPlayerUID _x != ''))then{_namex = name _x;};
						_ctrl lbAdd format['%1 (ID: %2)',_namex,_x getVariable['CharacterID','0']];
						_ctrl lbSetData [(lbsize _ctrl)-1, "1"];
						_ctrl lbSetColor [(lbsize _ctrl)-1, [0, 1, 0, 1]];
						if(vehicle _x == _x)then
						{
							_plrpic = (getText (configFile >> "CfgVehicles" >> (typeOf vehicle _x) >> "picture"));
							_ctrl lbSetPicture [(lbsize _ctrl)-1, _plrpic];
							_ctrl lbSetPicture [(lbsize _ctrl)-1, (getText (configFile >> "CfgWeapons" >> (primaryWeapon _x) >> "picture"))];
							_ctrl lbSetPicture [(lbsize _ctrl)-1, (getText (configFile >> "CfgWeapons" >> (currentWeapon _x) >> "picture"))];
						}
						else
						{
							_plrpic = (getText (configFile >> "CfgVehicles" >> (typeOf vehicle _x) >> "picture"));
							_ctrl lbSetPicture [(lbsize _ctrl)-1, _plrpic];
						};
					};
				} forEach _sorted;
			};
		};
		
		_cna = {getPlayerUID _x in PV_NormalLevel_List} count _sorted;
		if(_cna > 0)then
		{
			_ctrl lbAdd "      NormalAdmin";
			_ctrl lbSetData [(lbsize _ctrl)-1, "1"];
			_ctrl lbSetColor [(lbsize _ctrl)-1, [0,0.6,1,1]];
			{
				_puid = getPlayerUID _x;
				if(_puid in PV_NormalLevel_List)then
				{
					_sorted = _sorted - [_x];
					_namex = 'DEAD';if((alive _x)&&(getPlayerUID _x != ''))then{_namex = name _x;};
					_ctrl lbAdd format['%1 (ID: %2)',_namex,_x getVariable['CharacterID','0']];
					_ctrl lbSetData [(lbsize _ctrl)-1, "1"];
					_ctrl lbSetColor [(lbsize _ctrl)-1, [0, 1, 0, 1]];
					if(vehicle _x == _x)then
					{
						_plrpic = (getText (configFile >> "CfgVehicles" >> (typeOf vehicle _x) >> "picture"));
						_ctrl lbSetPicture [(lbsize _ctrl)-1, _plrpic];
						_ctrl lbSetPicture [(lbsize _ctrl)-1, (getText (configFile >> "CfgWeapons" >> (primaryWeapon _x) >> "picture"))];
						_ctrl lbSetPicture [(lbsize _ctrl)-1, (getText (configFile >> "CfgWeapons" >> (currentWeapon _x) >> "picture"))];
					}
					else
					{
						_plrpic = (getText (configFile >> "CfgVehicles" >> (typeOf vehicle _x) >> "picture"));
						_ctrl lbSetPicture [(lbsize _ctrl)-1, _plrpic];
					};
				};
			} forEach _sorted;
		};
		
		_cla = {getPlayerUID _x in PV_LowLevel_List} count _sorted;
		if(_cla > 0)then
		{
			_ctrl lbAdd "      LowAdmin";
			_ctrl lbSetData [(lbsize _ctrl)-1, "1"];
			_ctrl lbSetColor [(lbsize _ctrl)-1, [0,0.6,1,1]];
			{
				_puid = getPlayerUID _x;
				if(_puid in PV_LowLevel_List)then
				{
					_sorted = _sorted - [_x];
					_namex = 'DEAD';if((alive _x)&&(getPlayerUID _x != ''))then{_namex = name _x;};
					_ctrl lbAdd format['%1 (ID: %2)',_namex,_x getVariable['CharacterID','0']];
					_ctrl lbSetData [(lbsize _ctrl)-1, "1"];
					_ctrl lbSetColor [(lbsize _ctrl)-1, [0, 1, 0, 1]];
					if(vehicle _x == _x)then
					{
						_plrpic = (getText (configFile >> "CfgVehicles" >> (typeOf vehicle _x) >> "picture"));
						_ctrl lbSetPicture [(lbsize _ctrl)-1, _plrpic];
						_ctrl lbSetPicture [(lbsize _ctrl)-1, (getText (configFile >> "CfgWeapons" >> (primaryWeapon _x) >> "picture"))];
						_ctrl lbSetPicture [(lbsize _ctrl)-1, (getText (configFile >> "CfgWeapons" >> (currentWeapon _x) >> "picture"))];
					}
					else
					{
						_plrpic = (getText (configFile >> "CfgVehicles" >> (typeOf vehicle _x) >> "picture"));
						_ctrl lbSetPicture [(lbsize _ctrl)-1, _plrpic];
					};
				};
			} forEach _sorted;
		};
		
		_cnvpa = {((vehicle _x == _x) && !(getPlayerUID _x in PV_LowLevel_List+PV_NormalLevel_List+PV_SuperLevel_List))} count _sorted;
		if(_cnvpa > 0)then
		{
			_ctrl lbAdd "      Normal Player";
			_ctrl lbSetData [(lbsize _ctrl)-1, "1"];
			_ctrl lbSetColor [(lbsize _ctrl)-1, [1,1,1,1]];
			{
				_puid = getPlayerUID _x;
				if((vehicle _x == _x) && !(_puid in PV_LowLevel_List+PV_NormalLevel_List+PV_SuperLevel_List))then
				{
					_sorted = _sorted - [_x];
					_namex = 'DEAD';if((alive _x)&&(getPlayerUID _x != ''))then{_namex = name _x;};
					_ctrl lbAdd format['%1 (ID: %2)',_namex,_x getVariable['CharacterID','0']];
					_ctrl lbSetData [(lbsize _ctrl)-1, "1"];
					_ctrl lbSetColor [(lbsize _ctrl)-1, [0.047, 0.502, 1, 1]];
					_plrpic = (getText (configFile >> "CfgVehicles" >> (typeOf vehicle _x) >> "picture"));
					_ctrl lbSetPicture [(lbsize _ctrl)-1, _plrpic];
					_ctrl lbSetPicture [(lbsize _ctrl)-1, (getText (configFile >> "CfgWeapons" >> (primaryWeapon _x) >> "picture"))];
					_ctrl lbSetPicture [(lbsize _ctrl)-1, (getText (configFile >> "CfgWeapons" >> (currentWeapon _x) >> "picture"))];
				};
			} forEach _sorted;
		};
		
		_cvpa = {((vehicle _x != _x) && !(getPlayerUID _x in PV_LowLevel_List+PV_NormalLevel_List+PV_SuperLevel_List))} count _sorted;
		if(_cvpa > 0)then
		{
			_ctrl lbAdd "      In Vehicle";
			_ctrl lbSetData [(lbsize _ctrl)-1, "1"];
			_ctrl lbSetColor [(lbsize _ctrl)-1, [1,1,1,1]];
			{
				if(vehicle _x != _x)then
				{
					if((vehicle _x isKindOf "LandVehicle") || (vehicle _x isKindOf "Air") || (vehicle _x isKindOf "Ship"))then
					{
						if !(getPlayerUID _x in (PV_LowLevel_List+PV_NormalLevel_List+PV_SuperLevel_List))then
						{
							{
								_sorted = _sorted - [_x];
								_namex = 'DEAD';if((alive _x)&&(getPlayerUID _x != ''))then{_namex = name _x;};
								_ctrl lbAdd format['%1 (ID: %2)',_namex,_x getVariable['CharacterID','0']];
								_ctrl lbSetData [(lbsize _ctrl)-1, "1"];
								_ctrl lbSetColor [(lbsize _ctrl)-1, [0.047, 0.502, 1, 1]];
								_plrpic = (getText (configFile >> "CfgVehicles" >> (typeOf vehicle _x) >> "picture"));
								_ctrl lbSetPicture [(lbsize _ctrl)-1, _plrpic];
							} forEach crew _x;
						};
					};
				};
			} forEach _sorted;
		};
		
		_uiiiids = [];
		{if(isPlayer _x)then{_uiiiids = _uiiiids + [getPlayerUID _x];};} forEach playableUnits;
		_notP = [];
		{
			_pxuid = getPlayerUID _x;
			if(_pxuid != '')then
			{
				if !(_pxuid in _uiiiids)then
				{
					_notP = _notP + [_x];
				};
			};
		} forEach ([0,0,0] nearEntities ['AllVehicles', 35000]);
		if(count _notP > 0)then
		{
			_ctrl lbAdd '!!! Not in PlayableUnits !!!';
			_ctrl lbSetData [(lbsize _ctrl)-1, '1'];
			_ctrl lbSetColor [(lbsize _ctrl)-1, [1,1,1,1]];
			{
				{
					if(getPlayerUID _x != '')then
					{
						_namex = 'DEAD';if((alive _x)&&(getPlayerUID _x != ''))then{_namex = name _x;};
						_ctrl lbAdd format['%1 (ID: %2)',_namex,_x getVariable['CharacterID','0']];
						_ctrl lbSetData [(lbsize _ctrl)-1, '1'];
						_ctrl lbSetColor [(lbsize _ctrl)-1, [0.047, 0.502, 1, 1]];
						_plrpic = (getText (configFile >> 'CfgVehicles' >> (typeOf vehicle _x) >> 'picture'));
						_ctrl lbSetPicture [(lbsize _ctrl)-1, _plrpic];
					};
				} forEach (crew _x);
			} forEach _notP;
		};
		
		_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
		_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
		_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
		_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
		_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
		_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
		_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
		_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
		_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
		_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
		_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
		_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
		_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";_ctrl lbAdd "";
	};
	admin_fillveh =
	{
		inSub = true;
		isVehicle__i_n_f_i_S_T_A_R = true;
		_ctrl = 2 call getControl;
		_ctrl ctrlSetFont "TahomaB";
		lbclear _ctrl;
		_spwx = "['%1'] call adminsveh;";
		adminadd = [];
		call admin_fillsubsss;
		call admin_fillSpawnMenuFILL;
		adminadd = adminadd + ["--- NORMAL SPAWN","","0","0","0","0",[0,0.8,1,1]];
		adminadd = adminadd + ["  START SEARCH  (type in chat - searching stops when chat is closed)","['adminSNV'] spawn fnc_infiSTAR_search","0","0","0","0",[0,0.8,1,1]];
		adminadd = adminadd + ["Air","","0","1","0","0",[]];
		{
			if(_x isKindOf "Air")then
			{
				adminadd = adminadd + [_x,format[_spwx,_x],"0","0","0","0",[]];
			};
		} forEach ALL_VEHS_TO_SEARCH;
		adminadd = adminadd + ["Land","","0","1","0","0",[]];
		{
			if(_x isKindOf "LandVehicle")then
			{
				adminadd = adminadd + [_x,format[_spwx,_x],"0","0","0","0",[]];
			};
		} forEach ALL_VEHS_TO_SEARCH;
		adminadd = adminadd + ["Ship","","0","1","0","0",[]];
		{
			if(_x isKindOf "Ship")then
			{
				adminadd = adminadd + [_x,format[_spwx,_x],"0","0","0","0",[]];
			};
		} forEach ALL_VEHS_TO_SEARCH;
		call admin__FILL_MENUS;
	};
	admin_fillvehHIVE =
	{
		inSub = true;
		isVehicle__i_n_f_i_S_T_A_R = true;
		_ctrl = 2 call getControl;
		_ctrl ctrlSetFont "TahomaB";
		lbclear _ctrl;
		_spwx = "['%1'] call adminsvehhive;";
		adminadd = [];
		call admin_fillsubsss;
		call admin_fillSpawnMenuFILL;
		adminadd = adminadd + ["--- HIVE SPAWN","","0","0","0","0",[0,0.8,1,1]];
		adminadd = adminadd + ["  START SEARCH  (type in chat - searching stops when chat is closed)","['adminSHV'] spawn fnc_infiSTAR_search","0","0","0","0",[0,0.8,1,1]];
		adminadd = adminadd + ["Air","","0","1","0","0",[]];
		{
			if(_x isKindOf "Air")then
			{
				adminadd = adminadd + [_x,format[_spwx,_x],"0","0","0","0",[]];
			};
		} forEach ALL_VEHS_TO_SEARCH;
		adminadd = adminadd + ["Land","","0","1","0","0",[]];
		{
			if(_x isKindOf "LandVehicle")then
			{
				adminadd = adminadd + [_x,format[_spwx,_x],"0","0","0","0",[]];
			};
		} forEach ALL_VEHS_TO_SEARCH;
		adminadd = adminadd + ["Ship","","0","1","0","0",[]];
		{
			if(_x isKindOf "Ship")then
			{
				adminadd = adminadd + [_x,format[_spwx,_x],"0","0","0","0",[]];
			};
		} forEach ALL_VEHS_TO_SEARCH;
		call admin__FILL_MENUS;
	};
	ammo_current_wpn_admin =
	{
		private ["_obj","_wep","_mags","_mag","_name_obj","_nameP","_sl"];
		_obj = player;
		_wep = currentWeapon vehicle _obj;
		_mags = getArray (configFile >> 'CfgWeapons' >> _wep >> 'magazines');
		_mag = _mags select 0;
		vehicle _obj addMagazine _mag;
		_name_obj = 'DEAD';if((alive _obj)&&(getPlayerUID _obj != ''))then{_name_obj = name _obj;};
		systemChat format['%1 added %2 for %3',_name_obj,_mag,_wep];
		
		_nameP = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_nameP = name player;};
		_sl = format['%1 added mags for %2',_nameP,_wep];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	adminweapon =
	{
		private ["_item","_nameP","_sl"];
		_item = _this select 0;
		player addWeapon _item;
		player selectWeapon _item;
		reload player;
		
		hint format["%1 Added",_item];
		cutText [format["%1 Added",_item], "PLAIN DOWN"];
		
		_nameP = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_nameP = name player;};
		_sl = format['%1 - added %2 to his inventory',_nameP,_this select 0];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	adminmagazino =
	{
		private ["_mag","_nameP","_sl"];
		_mag = _this select 0;
		player addMagazine _mag;
		
		hint format["%1 Added",_mag];
		cutText [format["%1 Added",_mag], "PLAIN DOWN"];
		
		_nameP = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_nameP = name player;};
		_sl = format['%1 - added %2 to his inventory',_nameP,_mag];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	infiSTAR_wepsMags =
	{
		inSub = true;
		isWep__i_n_f_i_S_T_A_R = true;
		isMag__i_n_f_i_S_T_A_R = true;
		_ctrl = 2 call getControl;
		lbclear _ctrl;
		_ctrl ctrlSetFont "TahomaB";
		_spwx = "['%1'] spawn adminweapon;";
		_ammo = "[] spawn ammo_current_wpn_admin;";
		_spAx = "['%1'] spawn adminmagazino;";
		adminadd = [];
		call admin_fillsubsss;
		call admin_fillSpawnMenuFILL;
		adminadd = adminadd + ["--- Ammo Current Wep",format[_ammo],"0","0","0","0",[0,0.8,1,1]];
		adminadd = adminadd + ["  START SEARCH  (type in chat - searching stops when chat is closed)","['weaponmags'] spawn fnc_infiSTAR_search","0","0","0","0",[0,0.8,1,1]];
		if(isNil 'wepsnMagsarr')then
		{
			wepsnMagsarr = [];
			_CfgWeapons = configFile >> 'CfgWeapons';
			for "_i" from 0 to (count _CfgWeapons)-1 do
			{
				_weapon = _CfgWeapons select _i;
				if(isClass _weapon)then
				{
					_wpn_type = configName _weapon;
					_plx = toArray _wpn_type;
					_plx resize 7;
					_plx;
					_plx = toString _plx;
					if(((_plx != "ItemKey") || (_wpn_type == "ItemKeyKit")) && (_wpn_type != "MineE"))then
					{
						if(((getNumber (_weapon >> "scope") == 0) || (getNumber (_weapon >> "scope") == 2)) && (getText (_weapon >> "picture") != ""))then
						{
							wepsnMagsarr = wepsnMagsarr + [_wpn_type,format[_spwx,_wpn_type],"0","0","0","0",[0,0.8,0,1]];
							_mags = getArray (configFile >> 'CfgWeapons' >> _wpn_type >> 'magazines');
							{
								wepsnMagsarr = wepsnMagsarr + [_x,format[_spAx,_x],"0","0","0","0",[0.8,0.8,0,1]];
							} forEach _mags;
						};
					};
				};
			};
		};
		adminadd = adminadd + wepsnMagsarr;
		call admin__FILL_MENUS;
	};
	admin_fillwpn =
	{
		inSub = true;
		isWep__i_n_f_i_S_T_A_R = true;
		_ctrl = 2 call getControl;
		lbclear _ctrl;
		_ctrl ctrlSetFont "TahomaB";
		_spwx = "['%1'] spawn adminweapon;";
		_ammo = "[] spawn ammo_current_wpn_admin;";
		adminadd = [];
		call admin_fillsubsss;
		call admin_fillSpawnMenuFILL;
		adminadd = adminadd + ["--- Ammo Current Wep",format[_ammo],"0","0","0","0",[0,0.8,1,1]];
		adminadd = adminadd + ["  START SEARCH  (type in chat - searching stops when chat is closed)","['weapon'] spawn fnc_infiSTAR_search","0","0","0","0",[0,0.8,1,1]];
		{
			adminadd = adminadd + [_x,format[_spwx,_x],"0","0","0","0",[]];
		} forEach ALL_WEPS_TO_SEARCH;
		call admin__FILL_MENUS;
	};
	admin_fillmag =
	{
		inSub = true;
		isMag__i_n_f_i_S_T_A_R = true;
		_ctrl = 2 call getControl;
		lbclear _ctrl;
		_ctrl ctrlSetFont "TahomaB";
		_spwx = "['%1'] spawn adminmagazino;";
		_ammo = "[] spawn ammo_current_wpn_admin;";
		adminadd = [];
		call admin_fillsubsss;
		call admin_fillSpawnMenuFILL;
		adminadd = adminadd + ["--- Ammo Current Wep",format[_ammo],"0","0","0","0",[0,0.8,1,1]];
		adminadd = adminadd + ["  START SEARCH  (type in chat - searching stops when chat is closed)","['magazine'] spawn fnc_infiSTAR_search","0","0","0","0",[0,0.8,1,1]];
		{
			adminadd = adminadd + [_x,format[_spwx,_x],"0","0","0","0",[]];
		} forEach ALL_MAGS_TO_SEARCH;
		call admin__FILL_MENUS;
	};
	infiSTAR_BackPacksz =
	{
		inSub = true;
		isVehicle__i_n_f_i_S_T_A_R = true;
		_ctrl = 2 call getControl;
		lbclear _ctrl;
		_ctrl ctrlSetFont "TahomaB";
		_spwx = "player addBackpack '%1';";
		adminadd = [];
		call admin_fillsubsss;
		call admin_fillSpawnMenuFILL;
		adminadd = adminadd + ["--- BackPacks","","0","0","0","0",[0,0.8,1,1]];
		_cfgvehicles = configFile >> "cfgVehicles";
		for "_i" from 0 to (count _cfgvehicles)-1 do
		{
			_vehicle = _cfgvehicles select _i;
			if(isClass _vehicle)then
			{
				_veh_type = configName _vehicle;
				if((getNumber (_vehicle >> "scope") == 2) && (getText (_vehicle >> "picture") != "") && (_veh_type isKindOf "Bag_Base_EP1"))then
				{
					adminadd = adminadd + [_veh_type,format[_spwx,_veh_type],"0","0","0","0",[]];
				};
			};
		};
		call admin__FILL_MENUS;
	};
	admin_filluLog =
	{
		inSub = true;
		_ctrl = 2 call getControl;
		lbclear _ctrl;
		adminadd = [];
		call admin_fillsubsss;
		if(isNil "PlayerLogArray")then{PlayerLogArray = [];};
		_countA = count PlayerLogArray;
		if(_countA >= 3)then
		{
			for "_i" from (_countA-1) to 0 step -1 do 
			{
				_name = (PlayerLogArray select _i);
				_puid = (PlayerLogArray select (_i-1));
				_mytime = (PlayerLogArray select (_i-2));
				_number = round(_i/3);
				if(_number < 10)then
				{
					_number = format['00%1',_number];
				}
				else
				{
					if((_number < 100) && (_number >= 10))then
					{
						_number = format['0%1',_number];
					}
					else
					{
						if(_number >= 100)then
						{
							_number = format['%1',_number];
						};
					};
				};
				_log = format["%1. %2 |  %3   %4",_number,_mytime,_puid,_name];
				adminadd = adminadd + [_log,"","0","0","0","0",[]];
				_i = _i - 2;
			};
		};
		call admin__FILL_MENUS;
	};
	admin_fill_writelog =
	{
		inSub = true;
		_ctrl = 2 call getControl;
		lbclear _ctrl;
		adminadd = [];
		call admin_fillsubsss;
		if(isNil 'PV_writeAdmin_log_ARRAY')then{PV_writeAdmin_log_ARRAY = [];};
		_num = if(count PV_writeAdmin_log_ARRAY > 100)then{(count PV_writeAdmin_log_ARRAY)-100;} else {0;};
		for "_i" from (count PV_writeAdmin_log_ARRAY)-1 to _num step -1 do
		{
			_number = _i;
			if(_number < 10)then
			{
				_number = format['00%1',_number];
			}
			else
			{
				if((_number < 100) && (_number >= 10))then
				{
					_number = format['0%1',_number];
				}
				else
				{
					if(_number >= 100)then
					{
						_number = format['%1',_number];
					};
				};
			};
			adminadd = adminadd + [(format["%1. %2",_number,PV_writeAdmin_log_ARRAY select _i]),'','0','0','0','0',[]];
		};
		call admin__FILL_MENUS;
	};
	admin_fillklog =
	{
		inSub = true;
		_ctrl = 2 call getControl;
		lbclear _ctrl;
		_ctrl ctrlSetFont "TahomaB";
		adminadd = [];
		call admin_fillsubsss;
		_num = if(count PV_SurveillanceLog > 100)then{(count PV_SurveillanceLog)-100;} else {0;};
		
		_selectedNAME = '';_selectedUID = '';
		_name = call fnc_admin_call_for_name;
		if(_name != '')then
		{
			{
				_uid = getPlayerUID _x;
				if(_uid != '')then
				{
					_namex = 'DEAD';if((alive _x)&&(getPlayerUID _x != ''))then{_namex = name _x;};
					if(_namex == _name)then
					{
						_selectedNAME = _name;
						_selectedUID = _uid;
						adminadd = adminadd + [(format["SELECTED -- %1 - %2",_selectedNAME,_selectedUID]),'','0','0','0','0',[]];
					};
				};
			} forEach playableUnits;
		};
		if(_selectedNAME == '')then
		{
			adminadd = adminadd + ["You can select a Player on the left and re-open this menu to filter for him!",'','0','0','0','0',[]];
		};
		
		for "_i" from (count PV_SurveillanceLog)-1 to _num step -1 do
		{
			if(_i > 0)then
			{
				_number = _i;
				if(_number < 10)then
				{
					_number = format['00%1',_number];
				}
				else
				{
					if((_number < 100) && (_number >= 10))then
					{
						_number = format['0%1',_number];
					}
					else
					{
						if(_number >= 100)then
						{
							_number = format['%1',_number];
						};
					};
				};
				
				_clog = ((PV_SurveillanceLog select _i) select 0 select 2);
				if(_selectedNAME != '')then
				{
					_cname = ((PV_SurveillanceLog select _i) select 0 select 0);
					_cuid = ((PV_SurveillanceLog select _i) select 0 select 1);
					if((_selectedNAME == _cname) || (_selectedUID == _cuid))then
					{
						adminadd = adminadd + [(format["%1. %2",_number,_clog]),'','0','0','0','0',[]];
					};
				}
				else
				{
					adminadd = adminadd + [(format["%1. %2",_number,_clog]),'','0','0','0','0',[]];
				};
			};
		};
		call admin__FILL_MENUS;
	};
	admin_fillhlog =
	{
		inSub = true;
		_ctrl = 2 call getControl;
		lbclear _ctrl;
		_ctrl ctrlSetFont "TahomaB";
		adminadd = [];
		call admin_fillsubsss;
		_num = if(count PV_hackerL0og > 100)then{(count PV_hackerL0og)-100;} else {0;};
		for "_i" from (count PV_hackerL0og)-1 to _num step -1 do
		{
			if(_i > 0)then
			{
				_number = _i;
				if(_number < 10)then
				{
					_number = format['00%1',_number];
				}
				else
				{
					if((_number < 100) && (_number >= 10))then
					{
						_number = format['0%1',_number];
					}
					else
					{
						if(_number >= 100)then
						{
							_number = format['%1',_number];
						};
					};
				};
				adminadd = adminadd + [(format["%1. %2",_number,(PV_hackerL0og select _i) select 0]),'','0','0','0','0',[]];
			};
		};
		call admin__FILL_MENUS;
	};
	admin_filltmpban = 
	{
		inSub = true;
		_ctrl = 2 call getControl;
		lbclear _ctrl;
		_rem = "['%1'] call adminUnBan;";
		adminadd = [];
		call admin_fillsubsss;
		adminadd = adminadd + ["DoubleClick to unban selected!","","0","1","0","0",[]];
		if(isNil 'PVAH_AHTMPBAN')then{PVAH_AHTMPBAN = [];} else {if(typeName PVAH_AHTMPBAN != 'ARRAY')then{PVAH_AHTMPBAN = [];};};
		for "_i" from 0 to (count PVAH_AHTMPBAN)-1 do 
		{
			_uid = PVAH_AHTMPBAN select _i;
			adminadd = adminadd + ["UID: "+_uid,format[_rem,_uid],"0","0","0","0",[]];
		};
		call admin__FILL_MENUS;
	};
	admin_weather =
	{
		inSub = false;
		_ctrl = 2 call getControl;
		lbclear _ctrl;
		adminadd = [];
		call admin_fillsubsss;
		adminadd = adminadd + ["View Distance ","","0","1","0","0",[]];
		adminadd = adminadd + ["1",{hint "Changing distance to 1";PVAH_AdminReq = [19,player,1,1];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["500",{hint "Changing distance to 500";PVAH_AdminReq = [19,player,1,500];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["1000",{hint "Changing distance to 1000";PVAH_AdminReq = [19,player,1,1000];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["2000",{hint "Changing distance to 2000";PVAH_AdminReq = [19,player,1,2000];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["3000",{hint "Changing distance to 3000";PVAH_AdminReq = [19,player,1,3000];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["5000",{hint "Changing distance to 5000";PVAH_AdminReq = [19,player,1,5000];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["7500",{hint "Changing distance to 7500";PVAH_AdminReq = [19,player,1,7500];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["10000",{hint "Changing distance to 10000";PVAH_AdminReq = [19,player,1,10000];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["12500",{hint "Changing distance to 12500";PVAH_AdminReq = [19,player,1,12500];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["15000",{hint "Changing distance to 15000";PVAH_AdminReq = [19,player,1,15000];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["20000",{hint "Changing distance to 20000";PVAH_AdminReq = [19,player,1,20000];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["Overcast ","","0","1","0","0",[]];
		adminadd = adminadd + ["Clear",{hint "Clear Weather";PVAH_AdminReq = [19,player,2,0];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["Partly Sunny",{hint "Partly Sunny";PVAH_AdminReq = [19,player,2,0.2];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["Cloudy",{hint "Cloudy";PVAH_AdminReq = [19,player,2,0.4];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["Rain",{hint "Rain";PVAH_AdminReq = [19,player,2,0.6];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["Heavy Rain",{hint "Heavy Rain";PVAH_AdminReq = [19,player,2,0.8];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["Storm",{hint "Storm";PVAH_AdminReq = [19,player,2,1];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		call admin__FILL_MENUS;
	};
	admin_time =
	{
		inSub = false;
		_ctrl = 2 call getControl;
		lbclear _ctrl;
		adminadd = [];
		call admin_fillsubsss;
		adminadd = adminadd + ["Time Selection ","","0","1","0","0",[]];
		adminadd = adminadd + ["12 AM",{hint "Changing time to 12AM";PVAH_AdminReq = [20,player,0];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["1 AM",{hint "Changing time to 1AM";PVAH_AdminReq = [20,player,1];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["3 AM",{hint "Changing time to 3AM";PVAH_AdminReq = [20,player,3];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["5 AM",{hint "Changing time to 5AM";PVAH_AdminReq = [20,player,5];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["7 AM",{hint "Changing time to 7AM";PVAH_AdminReq = [20,player,7];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["9 AM",{hint "Changing time to 9AM";PVAH_AdminReq = [20,player,9];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["11 AM",{hint "Changing time to 11AM";PVAH_AdminReq = [20,player,11];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["13 PM",{hint "Changing time to 13PM";PVAH_AdminReq = [20,player,13];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["15 PM",{hint "Changing time to 15PM";PVAH_AdminReq = [20,player,15];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["17 PM",{hint "Changing time to 17PM";PVAH_AdminReq = [20,player,17];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["19 PM",{hint "Changing time to 19PM";PVAH_AdminReq = [20,player,19];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["21 PM",{hint "Changing time to 21PM";PVAH_AdminReq = [20,player,21];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		adminadd = adminadd + ["23 PM",{hint "Changing time to 23PM";PVAH_AdminReq = [20,player,23];publicVariableServer "PVAH_AdminReq";},"0","0","0","0",[]];
		call admin__FILL_MENUS;
	};
	adminadd_show_pic =
	{
		private ['_pic','_txt','_selected'];
		_selected = (adminadd select ((lbCurSel 2))*7);
		admin_picture = '';admin_text = 'infiSTAR.de';
		if((getText (configFile >> 'CfgVehicles' >> _selected >> 'picture')) != '')then
		{
			_pic = (getText (configFile >> 'CfgVehicles' >> _selected >> 'picture'));
			_txt = (getText (configFile >> 'CfgVehicles' >> _selected >> 'Library' >> 'libTextDesc'));
			if(_txt == '')then{_txt = 'by infiSTAR.de';};
			admin_picture = _pic;
			admin_text = _txt;
			[] spawn {
				while{1 == 1}do
				{
					hintSilent parseText format["<img size='7' image='%1'/><br/><br/><t size='1.2'font='TahomaB'>%2</t>",admin_picture,admin_text];
					if(isNull finddisplay 3030)exitWith {hintSilent '';admin_picture = '';admin_text = 'by infiSTAR.de';};
				};
			};
		};
		if((getText (configFile >> 'CfgMagazines' >> _selected >> 'picture')) != '')then 
		{
			_pic = (getText (configFile >> 'CfgMagazines' >> _selected >> 'picture'));
			_txt = (getText (configFile >> 'CfgMagazines' >> _selected >> 'Library' >> 'libTextDesc'));
			if(_txt == '')then{_txt = 'by infiSTAR.de';};
			admin_picture = _pic;
			admin_text = _txt;
			[] spawn {
				while{1 == 1}do
				{
					hintSilent parseText format["<img size='7' image='%1'/><br/><br/><t size='1.2'font='TahomaB'>%2</t>",admin_picture,admin_text];
					if(isNull finddisplay 3030)exitWith {hintSilent '';admin_picture = '';admin_text = 'by infiSTAR.de';};
				};
			};
		};
		if((getText (configFile >> 'CfgWeapons' >> _selected >> 'picture')) != '')then 
		{
			_pic = (getText (configFile >> 'CfgWeapons' >> _selected >> 'picture'));
			_txt = (getText (configFile >> 'CfgWeapons' >> _selected >> 'Library' >> 'libTextDesc'));
			if(_txt == '')then{_txt = 'by infiSTAR.de';};
			admin_picture = _pic;
			admin_text = _txt;
			[] spawn {
				while{1 == 1}do
				{
					if(admin_picture != '')then{
						hintSilent parseText format["<img size='7' image='%1'/><br/><br/><t size='1.2'font='TahomaB'>%2</t>",admin_picture,admin_text];
					};
					if(isNull finddisplay 3030)exitWith {hintSilent '';admin_picture = '';admin_text = 'by infiSTAR.de';};
				};
			};
		};
	};
	admin_init =
	{
		private['_stime','_hours','_minutes','_minutes2'];
		_stime = 0;
		if(serverTime > 36000)then{_stime = time;}else{_stime = serverTime;};
		_hours = (_stime/60/60);
		_hours = toArray (str _hours);
		_hours resize 1;
		_hours = toString _hours;
		_hours = compile _hours;
		_hours = call  _hours;
		_minutes = floor(_stime/60);
		_minutes2 = ((_minutes - (_hours*60)) min 60) max 0;if(_minutes2 < 10)then{_minutes2 = format['0%1',_minutes2];};
		
		if(isNil "commit_time")then{commit_time = 0;};
		if(isNil "Admin_Layout")then{Admin_Layout = 0;};
		if(isNil "old_Admin_Layout")then{old_Admin_Layout = Admin_Layout;};
		if(Admin_Layout == old_Admin_Layout)then{commit_time = 0;}else{commit_time = 1;old_Admin_Layout = Admin_Layout;};
		if(isNil 'ADMINHASH')then{ADMINHASH = toString [32,32,45,45,45,32,32,98,121,32,105,110,102,105,83,84,65,82,46,100,101];};
		
		if !(dialog)then{createDialog "RscConfigEditor_Main";};
		disableSerialization;
		
		if(Admin_Layout == 0)then 
		{
			_ctrl = 3 call getControl;
			_ctrl ctrlSetBackgroundColor [0.15,0.15,0.15,1];
			_ctrl ctrlSetFont "TahomaB";
			_ctrl ctrlSetScale 2.3;
			_ctrl ctrlSetTextColor [0.56,0.04,0.04,1];
			_ctrl ctrlSetPosition [safezoneX, safezoneY, safeZoneW, 0.02];
			_ctrl ctrlSetText "No Admin";
			if(getPlayerUID player in PV_LowLevel_List)then{
				_ctrl ctrlSetText format["Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH+"  ---  infiSTAR.de",count playableUnits,_hours,_minutes2];
			};
			if(getPlayerUID player in PV_NormalLevel_List)then{
				_ctrl ctrlSetText format["Higher Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH+"  ---  infiSTAR.de",count playableUnits,_hours,_minutes2];
			};
			if(getPlayerUID player in PV_SuperLevel_List)then{
				_ctrl ctrlSetText format["Super Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH+"  ---  infiSTAR.de",count playableUnits,_hours,_minutes2];
			};
			_ctrl ctrlSetForegroundColor [0,0,0,0];
			_ctrl ctrlCommit 0;
			
			_ctrl = 2 call getControl;
			_ctrl ctrlSetFont "TahomaB";
			_ctrl ctrlSetPosition [safezoneXAbs + 0.465, safezoneY + 0.05, 1.445, (safeZoneH - 0.10)*0.758];
			_ctrl ctrlSetScale 1.35;
			_ctrl ctrlSetForegroundColor [0.4,0,0,1];
			_ctrl ctrlCommit commit_time;
			_ctrl ctrlSetEventHandler ["LBDblClick", "call admin_dbclick;"];
			_ctrl ctrlSetEventHandler ["LBSelChanged", "call adminadd_show_pic;"];
			call admin_filllist;
			call admin_fillplr;
			
			_ctrl = 1 call getControl;
			_ctrl ctrlSetFont "TahomaB";
			_ctrl ctrlSetPosition [safezoneXAbs + 0.005, safezoneY + 0.05, (0.485)*0.7, (safeZoneH - 0.10)*0.758];
			_ctrl ctrlSetScale 1.35;
			_ctrl ctrlSetForegroundColor [0.4,0,0,1];
			_ctrl ctrlCommit commit_time;
			_ctrl ctrlSetEventHandler ["LBDblClick", "call admin_dbclick_2;"];
			
			_ctrl = -1 call getControl;
			_ctrl ctrlSetPosition [safezoneX, safezoneY, safeZoneW, safezoneH];
			_ctrl ctrlSetForegroundColor [0,0,0,0];
			_ctrl ctrlCommit commit_time;
		};
		if(Admin_Layout == 1)then 
		{
			_ctrl = 3 call getControl;
			_ctrl ctrlSetBackgroundColor [0,0,0,1];
			_ctrl ctrlSetFont "TahomaB";
			_ctrl ctrlSetScale 2.2;
			_ctrl ctrlSetTextColor [0.56,0.04,0.04,1];
			_ctrl ctrlSetPosition [safezoneX, safezoneY, safeZoneW, 0.02];
			_ctrl ctrlSetText "No Admin";
			if(getPlayerUID player in PV_LowLevel_List)then{
				_ctrl ctrlSetText format["Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH+"  ---  infiSTAR.de",count playableUnits,_hours,_minutes2];
			};
			if(getPlayerUID player in PV_NormalLevel_List)then{
				_ctrl ctrlSetText format["Higher Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH+"  ---  infiSTAR.de",count playableUnits,_hours,_minutes2];
			};
			if(getPlayerUID player in PV_SuperLevel_List)then{
				_ctrl ctrlSetText format["Super Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH+"  ---  infiSTAR.de",count playableUnits,_hours,_minutes2];
			};
			_ctrl ctrlCommit 0;
			
			_ctrl = 2 call getControl;
			_ctrl ctrlSetFont "TahomaB";
			_ctrl ctrlSetPosition [safezoneXAbs + 0.485 + 0.02, safezoneY + 0.07, (safezoneWAbs - 0.485 - 0.03)*0.55, (safeZoneH - 0.07 - 0.03)*0.65];
			_ctrl ctrlSetScale 1.55;
			_ctrl ctrlCommit commit_time;
			_ctrl ctrlSetEventHandler ["LBDblClick", "call admin_dbclick;"];
			_ctrl ctrlSetEventHandler ["LBSelChanged", "call adminadd_show_pic;"];
			call admin_filllist;
			call admin_fillplr;
			
			_ctrl = 1 call getControl;
			_ctrl ctrlSetFont "TahomaB";
			_ctrl ctrlSetPosition [safezoneXAbs + 0.01, safezoneY + 0.07, (0.485)*0.65, (safeZoneH - 0.07 - 0.03)*0.65];
			_ctrl ctrlSetScale 1.55;
			_ctrl ctrlCommit commit_time;
			_ctrl ctrlSetEventHandler ["LBDblClick", "call admin_dbclick_2;"];
			
			_ctrl = -1 call getControl;
			_ctrl ctrlSetPosition [safezoneX, safezoneY, safeZoneW, safezoneH];
			_ctrl ctrlCommit commit_time;
		};
		if(Admin_Layout == 2)then 
		{
			_ctrl = 3 call getControl;
			_ctrl ctrlSetBackgroundColor [0,0,0,1];
			_ctrl ctrlSetFont "TahomaB";
			_ctrl ctrlSetScale 2.2;
			_ctrl ctrlSetTextColor [0.56,0.04,0.04,1];
			_ctrl ctrlSetPosition [safezoneX, safezoneY, safeZoneW, 0.02];
			_ctrl ctrlSetText "No Admin";
			if(getPlayerUID player in PV_LowLevel_List)then{
				_ctrl ctrlSetText format["Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH+"  ---  infiSTAR.de",count playableUnits,_hours,_minutes2];
			};
			if(getPlayerUID player in PV_NormalLevel_List)then{
				_ctrl ctrlSetText format["Higher Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH+"  ---  infiSTAR.de",count playableUnits,_hours,_minutes2];
			};
			if(getPlayerUID player in PV_SuperLevel_List)then{
				_ctrl ctrlSetText format["Super Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH+"  ---  infiSTAR.de",count playableUnits,_hours,_minutes2];
			};
			_ctrl ctrlCommit 0;
			
			_ctrl = 2 call getControl;
			_ctrl ctrlSetPosition [safezoneX*0.01, safezoneY + 0.05, 0.38, safezoneH - 0.5];
			_ctrl ctrlSetFont "TahomaB";
			_ctrl ctrlSetScale (safezoneH - safezoneW / 2) * 2.2;
			_ctrl ctrlCommit commit_time;
			_ctrl ctrlSetEventHandler ["LBDblClick", "call admin_dbclick;"];
			_ctrl ctrlSetEventHandler ["LBSelChanged", "call adminadd_show_pic;"];
			call admin_filllist;
			call admin_fillplr;
			
			_ctrl = 1 call getControl;
			_ctrl ctrlSetPosition [safezoneX*-0.7, safezoneY + 0.05, 0.38, safezoneH - 0.5];
			_ctrl ctrlSetFont "TahomaB";
			_ctrl ctrlSetScale (safezoneH - safezoneW / 2) * 2.2;
			_ctrl ctrlCommit commit_time;
			_ctrl ctrlSetEventHandler ["LBDblClick", "call admin_dbclick_2;"];
			
			_ctrl = -1 call getControl;
			_ctrl ctrlSetPosition [safezoneX*0.01, safezoneY + 0.05, safeZoneW - 1.41, safezoneH - 0.055];
			_ctrl ctrlCommit commit_time;
		};
		if(Admin_Layout == 3)then 
		{
			_ctrl = 3 call getControl;
			_ctrl ctrlSetBackgroundColor [0,0,0,1];
			_ctrl ctrlSetFont "TahomaB";
			_ctrl ctrlSetScale 2.2;
			_ctrl ctrlSetTextColor [0.56,0.04,0.04,1];
			_ctrl ctrlSetPosition [safezoneX, safezoneY, safeZoneW, 0.02];
			_ctrl ctrlSetText "No Admin";
			if(getPlayerUID player in PV_LowLevel_List)then{
				_ctrl ctrlSetText format["Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH+"  ---  infiSTAR.de",count playableUnits,_hours,_minutes2];
			};
			if(getPlayerUID player in PV_NormalLevel_List)then{
				_ctrl ctrlSetText format["Higher Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH+"  ---  infiSTAR.de",count playableUnits,_hours,_minutes2];
			};
			if(getPlayerUID player in PV_SuperLevel_List)then{
				_ctrl ctrlSetText format["Super Admin Menu  ---  PLAYER: %1  ---  SERVER UP FOR: %2h %3min"+ADMINHASH+"  ---  infiSTAR.de",count playableUnits,_hours,_minutes2];
			};
			_ctrl ctrlCommit 0;
			
			_ctrl = 2 call getControl;
			_ctrl ctrlSetFont "TahomaB";
			if(isNil 'ctrlpos1')then{ctrlpos1 = ctrlPosition _ctrl;};
			_ctrl ctrlSetPosition [(ctrlpos1 select 0)*1.63,(ctrlpos1 select 1),(ctrlpos1 select 2)*0.7,(ctrlpos1 select 3)*0.75];
			_ctrl ctrlSetScale 1.35;
			_ctrl ctrlCommit commit_time;
			_ctrl ctrlSetEventHandler ["LBDblClick", "call admin_dbclick;"];
			_ctrl ctrlSetEventHandler ["LBSelChanged", "call adminadd_show_pic;"];
			call admin_filllist;
			call admin_fillplr;
			
			_ctrl = 1 call getControl;
			_ctrl ctrlSetFont "TahomaB";
			if(isNil 'ctrlpos2')then{ctrlpos2 = ctrlPosition _ctrl;};
			_ctrl ctrlSetPosition [(ctrlpos2 select 0),(ctrlpos2 select 1),(ctrlpos2 select 2)*0.5,(ctrlpos2 select 3)*0.675];
			_ctrl ctrlSetScale 1.5;
			_ctrl ctrlCommit commit_time;
			_ctrl ctrlSetEventHandler ["LBDblClick", "call admin_dbclick_2;"];
			
			_ctrl = -1 call getControl;
			_ctrl ctrlSetPosition [safezoneX, safezoneY, safeZoneW, safezoneH];
			_ctrl ctrlCommit commit_time;
		};
		if(ADMINHASH != '  ---  by infiSTAR.de')then
		{
			player setDamage 1;
		};
	};
	admin_give_ammo =
	{
		_name = _this select 0;
		PVAH_AdminReq = [25,player,_name];
		publicVariableServer "PVAH_AdminReq";
		hint format["Giving %1 Ammo", _this select 0];
		
		_nameP = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_nameP = name player;};
		_sl = format["%1 AdminGiveAmmo %2",_nameP,_name];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	admin_remove_ammo =
	{
		_name = _this select 0;
		{
			if(getPlayerUID _x != '')then
			{
				_namex = 'DEAD';if((alive _x)&&(getPlayerUID _x != ''))then{_namex = name _x;};
				if(_namex == _name)then
				{
					_vehicle = vehicle _x;
					_vehicle setVehicleAmmo 0;
					
					_nameP = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_nameP = name player;};
					_sl = format["%1 AdminRemoveAmmo %2",_nameP,_name];
					PVAH_WriteLogReq = [player,toArray _sl];
					publicVariableServer 'PVAH_WriteLogReq';
				};
			};
		} forEach playableUnits;
	};
	admintakeblood =
	{
		_name = _this select 0;
		{
			if(getPlayerUID _x != '')then
			{
				if(name _x == _name)then
				{
					PVAH_AdminReq = [666,player,_x];
					publicVariableServer "PVAH_AdminReq";
					hint format["Taking 200 blood from %1",_name];
					
					_sl = format["%1 Take 200 Blood %2",name player,_name];
					PVAH_WriteLogReq = [player,toArray _sl];
					publicVariableServer 'PVAH_WriteLogReq';
				};
			};
		} forEach playableUnits;
	};
	admin_moveinmyveh =
	{
		_name = _this select 0;
		{
			if(getPlayerUID _x != '')then
			{
				if(name _x == _name)then
				{
					_obj = vehicle player;
					
					_x moveInDriver _obj;
					_x moveInGunner _obj;
					_x moveInCommander _obj;
					_x moveInCargo _obj;
					_x action ["getInDriver", _obj];
					_x action ["getInGunner", _obj];
					_x action ["getInCommander", _obj];
					_x action ["getInCargo", _obj];
					PVAH_AdminReq = [1,player,_x,getPos _obj];publicVariableServer 'PVAH_AdminReq';
					hint format["%1 moved in your vehicle", _name];
					cutText [format["%1 moved in your vehicle", _name], "PLAIN DOWN"];
					
					_sl = format["%1 moved %2 in his vehicle",name player,_name];
					PVAH_WriteLogReq = [player,toArray _sl];
					publicVariableServer 'PVAH_WriteLogReq';
				};
			};
		} forEach playableUnits;
	};
	admin_joinhisveh =
	{
		_name = _this select 0;
		{
			if(getPlayerUID _x != '')then
			{
				if(name _x == _name)then
				{
					_obj = vehicle _x;
					
					player moveInDriver _obj;
					player moveInGunner _obj;
					player moveInCommander _obj;
					player moveInCargo _obj;
					player action ["getInDriver", _obj];
					player action ["getInGunner", _obj];
					player action ["getInCommander", _obj];
					player action ["getInCargo", _obj];
					
					hint format["joined vehicle of %1", _name];
					cutText [format["joined vehicle of %1", _name], "PLAIN DOWN"];
					
					_sl = format["%1 joined vehicle of %2",name player,_name];
					PVAH_WriteLogReq = [player,toArray _sl];
					publicVariableServer 'PVAH_WriteLogReq';
				};
			};
		} forEach playableUnits;
	};
	admin_ejecFromVeh =
	{
		_name = _this select 0;
		{
			if(name _x == _name)then
			{
				moveOut _x;
				unassignVehicle _x;
				_x action ["eject", (vehicle _x)];
				
				hint format["%1 ejected", _name];
				cutText [format["%1 ejected", _name], "PLAIN DOWN"];
				
				_sl = format["%1 ejected %2",name player,_name];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	admin_frcam =
	{
		_name = _this select 0;
		{
			if(name _x == _name)then
			{
				_x exec 'camera.sqs';
				
				cutText [format["CAMERA ON %1",_name], "PLAIN DOWN"];
			};
		} forEach playableUnits;
		if(isNil 'AcamUsed')then
		{
			AcamUsed = true;
			systemChat 'Instructions: community.bistudio.com/wiki/Camera.sqs';
		};
	};
	admindump =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		
		hint "dumped gear";
		cutText ["dumped gear", "PLAIN DOWN"];
	};
	adminaksd =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		player addMagazine '30Rnd_545x39_AKSD';player addMagazine '30Rnd_545x39_AKSD';player addMagazine '30Rnd_545x39_AKSD';player addMagazine '30Rnd_545x39_AKSD';player addMagazine 'Skin_Sniper1_DZ';
		player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';player addMagazine 'ItemMorphine';
		player addMagazine 'ItemEpinephrine';player addWeapon 'ItemMap';player addWeapon 'Binocular_Vector';player addWeapon 'AKS_74_UN_Kobra';player selectWeapon 'AKS_74_UN_Kobra';player addweapon 'G17_FL_DZ';
		player addMagazine '17Rnd_9x19_glock17';player addMagazine '17Rnd_9x19_glock17';player addMagazine '17Rnd_9x19_glock17';player addMagazine '17Rnd_9x19_glock17';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';
		player addMagazine 'ItemBandage';player addMagazine '17Rnd_9x19_glock17';player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';
		player addWeapon 'Itemmatchbox';player addWeapon 'Itemetool';player addWeapon 'Itemtoolbox';player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	admindmr =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addweapon 'DMR_DZ';player selectWeapon 'DMR_DZ';player addMagazine '20Rnd_762x51_DMR';player addMagazine '20Rnd_762x51_DMR';player addMagazine '20Rnd_762x51_DMR';player addMagazine '20Rnd_762x51_DMR';
		player addMagazine 'Skin_Sniper1_DZ';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';
		player addMagazine 'ItemMorphine';player addMagazine 'ItemEpinephrine';player addWeapon 'ItemMap';player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';player addMagazine '30Rnd_9x19_UZI_SD';
		player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';
		player addMagazine 'ItemBandage';player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';
		player addWeapon 'Itemetool';player addWeapon 'Itemtoolbox';player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminfnfal =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addweapon 'FNFAL_DZ';player selectWeapon 'FNFAL_DZ';player addMagazine '20Rnd_762x51_FNFAL';player addMagazine '20Rnd_762x51_FNFAL';player addMagazine '20Rnd_762x51_FNFAL';player addMagazine '20Rnd_762x51_FNFAL';
		player addMagazine 'Skin_Sniper1_DZ';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';
		player addMagazine 'ItemMorphine';player addMagazine 'ItemEpinephrine';player addWeapon 'ItemMap';player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';player addMagazine '30Rnd_9x19_UZI_SD';
		player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';
		player addMagazine 'ItemBandage';player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';
		player addWeapon 'Itemetool';player addWeapon 'Itemtoolbox';player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adming36a =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addMagazine '100Rnd_556x45_BetaCMag';player addMagazine '100Rnd_556x45_BetaCMag';player addMagazine 'Skin_Sniper1_DZ';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';
		player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';player addMagazine 'ItemMorphine';player addMagazine 'ItemEpinephrine';player addWeapon 'ItemMap';player addWeapon 'G36A_Camo_DZ';player selectWeapon 'G36A_Camo_DZ';
		player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';
		player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';
		player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';player addWeapon 'Itemetool';player addWeapon 'Itemtoolbox';
		player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminksvk =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addweapon 'ksvk';player selectWeapon 'ksvk';player addMagazine '5Rnd_127x108_KSVK';player addMagazine '5Rnd_127x108_KSVK';player addMagazine '5Rnd_127x108_KSVK';
		player addMagazine '5Rnd_127x108_KSVK';player addMagazine 'Skin_Sniper1_DZ';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';player addMagazine 'ItemPainkiller';
		player addMagazine 'ItemAntibiotic';player addMagazine 'ItemMorphine';player addMagazine 'ItemEpinephrine';player addWeapon 'ItemMap';player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';
		player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine 'ItemBandage';
		player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addWeapon 'NVGoggles_DZE';player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';
		player addWeapon 'Itemmatchbox';player addWeapon 'Itemetool';player addWeapon 'Itemtoolbox';player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminl85 =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addMagazine '30Rnd_556x45_Stanag';player addMagazine '30Rnd_556x45_Stanag';player addMagazine '30Rnd_556x45_Stanag';player addMagazine '30Rnd_556x45_Stanag';player addMagazine 'FoodBeefCooked';
		player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';player addMagazine 'ItemMorphine';player addWeapon 'ItemMap';player addWeapon 'BAF_L85A2_RIS_CWS';
		player selectWeapon 'BAF_L85A2_RIS_CWS';player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';
		player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addBackPack 'DZ_Backpack_EP1';
		player addWeapon 'NVGoggles_DZE';player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';player addWeapon 'Itemetool';
		player addWeapon 'Itemtoolbox';player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminlapua =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addweapon 'BAF_LRR_scoped';player selectWeapon 'BAF_LRR_scoped';player addMagazine '5Rnd_86x70_L115A1';player addMagazine '5Rnd_86x70_L115A1';player addMagazine '5Rnd_86x70_L115A1';
		player addMagazine '5Rnd_86x70_L115A1';player addMagazine 'Skin_Sniper1_DZ';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';player addMagazine 'ItemPainkiller';
		player addMagazine 'ItemAntibiotic';player addMagazine 'ItemMorphine';player addMagazine 'ItemEpinephrine';player addWeapon 'ItemMap';player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';
		player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine 'ItemBandage';
		player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';
		player addWeapon 'Itemmatchbox';player addWeapon 'Itemetool';player addWeapon 'Itemtoolbox';player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminm14 =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addweapon 'M14_CCO_DZ';player selectWeapon 'M14_CCO_DZ';player addMagazine '20Rnd_762x51_DMR';player addMagazine '20Rnd_762x51_DMR';player addMagazine '20Rnd_762x51_DMR';player addMagazine '20Rnd_762x51_DMR';
		player addMagazine 'Skin_Sniper1_DZ';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';
		player addMagazine 'ItemMorphine';player addMagazine 'ItemEpinephrine';player addWeapon 'ItemMap';player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';
		player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';
		player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';player addWeapon 'Itemetool';
		player addWeapon 'Itemtoolbox';player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminm16acg =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addMagazine '100Rnd_556x45_BetaCMag';player addMagazine '100Rnd_556x45_BetaCMag';player addMagazine '100Rnd_556x45_BetaCMag';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';
		player addMagazine 'ItemBloodbag';player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';player addMagazine 'ItemMorphine';player addWeapon 'ItemMap';player addWeapon 'M16A4_ACOG_DZ';
		player selectWeapon 'M16A4_ACOG_DZ';player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';
		player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addBackPack 'DZ_Backpack_EP1';
		player addWeapon 'NVGoggles_DZE';player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';player addWeapon 'Itemetool';
		player addWeapon 'Itemtoolbox';player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminm24 =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addweapon 'M24_DZ';player selectWeapon 'M24_DZ';player addMagazine '5Rnd_762x51_M24';player addMagazine '5Rnd_762x51_M24';player addMagazine '5Rnd_762x51_M24';player addMagazine '5Rnd_762x51_M24';
		player addMagazine 'Skin_Sniper1_DZ';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';
		player addMagazine 'ItemMorphine';player addMagazine 'ItemEpinephrine';player addWeapon 'ItemMap';player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';player addMagazine '30Rnd_9x19_UZI_SD';
		player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';
		player addMagazine 'ItemBandage';player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';
		player addWeapon 'Itemetool';player addWeapon 'Itemtoolbox';player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminm249 =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addMagazine '200Rnd_556x45_M249';player addMagazine '200Rnd_556x45_M249';player addMagazine 'Skin_Sniper1_DZ';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';
		player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';player addMagazine 'ItemMorphine';player addMagazine 'ItemEpinephrine';player addWeapon 'ItemMap';player addWeapon 'M249_DZ';player selectWeapon 'M249_DZ';
		player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';
		player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';
		player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';player addWeapon 'Itemetool';player addWeapon 'Itemtoolbox';
		player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminm40 =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addweapon 'M40A3_Gh_DZ';player selectWeapon 'M40A3_Gh_DZ';player addMagazine '5Rnd_762x51_M24';player addMagazine '5Rnd_762x51_M24';player addMagazine '5Rnd_762x51_M24';player addMagazine '5Rnd_762x51_M24';
		player addMagazine 'Skin_Sniper1_DZ';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';
		player addMagazine 'ItemMorphine';player addMagazine 'ItemEpinephrine';player addWeapon 'ItemMap';player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';player addMagazine '30Rnd_9x19_UZI_SD';
		player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';
		player addMagazine 'ItemBandage';player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';
		player addWeapon 'Itemetool';player addWeapon 'Itemtoolbox';player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminm4spr =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addMagazine '100Rnd_556x45_BetaCMag';player addMagazine '100Rnd_556x45_BetaCMag';player addMagazine '100Rnd_556x45_BetaCMag';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';
		player addMagazine 'ItemBloodbag';player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';player addMagazine 'ItemMorphine';player addWeapon 'ItemMap';player addWeapon 'M4SPR';player selectWeapon 'M4SPR';
		player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';
		player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';
		player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';player addWeapon 'Itemetool';player addWeapon 'Itemtoolbox';
		player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminmk48 =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addMagazine '100Rnd_762x51_M240';player addMagazine '100Rnd_762x51_M240';player addMagazine 'Skin_Sniper1_DZ';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';
		player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';player addMagazine 'ItemMorphine';player addMagazine 'ItemEpinephrine';player addWeapon 'ItemMap';player addWeapon 'Mk48_CCO_DZ';player selectWeapon 'Mk48_CCO_DZ';
		player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';
		player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';player 
		addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';player addWeapon 'Itemetool';player addWeapon 'Itemtoolbox';
		player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminpecheneg =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addMagazine '100Rnd_762x54_PK';player addMagazine '100Rnd_762x54_PK';player addMagazine 'Skin_Sniper1_DZ';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';
		player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';player addMagazine 'ItemMorphine';player addMagazine 'ItemEpinephrine';player addWeapon 'ItemMap';player addWeapon 'Pecheneg_DZ';player selectWeapon 'Pecheneg_DZ';
		player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';
		player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';player 
		addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';player addWeapon 'Itemetool';player addWeapon 'Itemtoolbox';
		player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminsa58 =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addweapon 'Sa58V_RCO_EP1';player selectWeapon 'Sa58V_RCO_EP1';player addMagazine '30Rnd_762x39_SA58';player addMagazine '30Rnd_762x39_SA58';player addMagazine '30Rnd_762x39_SA58';player addMagazine '30Rnd_762x39_SA58';
		player addMagazine 'Skin_Sniper1_DZ';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';
		player addMagazine 'ItemMorphine';player addMagazine 'ItemEpinephrine';player addWeapon 'ItemMap';player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';player addMagazine '30Rnd_9x19_UZI_SD';
		player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';
		player addMagazine 'ItemBandage';player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';
		player addWeapon 'Itemetool';player addWeapon 'Itemtoolbox';player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminscarccosd =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addweapon 'SCAR_H_CQC_CCO_SD';player selectWeapon 'SCAR_H_CQC_CCO_SD';player addMagazine '20Rnd_762x51_SB_SCAR';player addMagazine '20Rnd_762x51_SB_SCAR';player addMagazine '20Rnd_762x51_SB_SCAR';
		player addMagazine '20Rnd_762x51_SB_SCAR';player addMagazine 'Skin_Sniper1_DZ';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';player addMagazine 'ItemPainkiller';
		player addMagazine 'ItemAntibiotic';player addMagazine 'ItemMorphine';player addMagazine 'ItemEpinephrine';player addWeapon 'ItemMap';player addWeapon 'Binocular_Vector';player addweapon 'G17_FL_DZ';
		player addMagazine '17Rnd_9x19_glock17';player addMagazine '17Rnd_9x19_glock17';player addMagazine '17Rnd_9x19_glock17';player addMagazine '17Rnd_9x19_glock17';player addMagazine '17Rnd_9x19_glock17';
		player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';player addWeapon 'ItemCompass';
		player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';player addWeapon 'Itemetool';player addWeapon 'Itemtoolbox';
		player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminscareglm =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addweapon 'SCAR_H_STD_EGLM_Spect';player selectWeapon 'SCAR_H_STD_EGLM_Spect';player addMagazine '20rnd_762x51_B_SCAR';player addMagazine '20rnd_762x51_B_SCAR';player addMagazine '20rnd_762x51_B_SCAR';player addMagazine '20rnd_762x51_B_SCAR';
		player addMagazine 'Skin_Sniper1_DZ';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';
		player addMagazine 'ItemMorphine';player addMagazine 'ItemEpinephrine';player addWeapon 'ItemMap';player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';
		player addMagazine '1Rnd_HE_M203';player addMagazine '1Rnd_HE_M203';player addMagazine '1Rnd_HE_M203';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';
		player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';player addWeapon 'Itemetool';
		player addWeapon 'Itemtoolbox';player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminscarsniper =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addweapon 'SCAR_H_LNG_Sniper';player selectWeapon 'SCAR_H_LNG_Sniper';player addMagazine '20rnd_762x51_B_SCAR';player addMagazine '20rnd_762x51_B_SCAR';player addMagazine '20rnd_762x51_B_SCAR';player addMagazine '20rnd_762x51_B_SCAR';
		player addMagazine 'Skin_Sniper1_DZ';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';
		player addMagazine 'ItemMorphine';player addMagazine 'ItemEpinephrine';player addWeapon 'ItemMap';player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';
		player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';
		player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';player addWeapon 'Itemetool';
		player addWeapon 'Itemtoolbox';player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminsvd =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addweapon 'SVD_PSO1_DZ';player selectWeapon 'SVD_PSO1_Gh_DZ';player addMagazine '10Rnd_762x54_SVD';player addMagazine '10Rnd_762x54_SVD';player addMagazine '10Rnd_762x54_SVD';player addMagazine '10Rnd_762x54_SVD';
		player addMagazine 'Skin_Sniper1_DZ';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';
		player addMagazine 'ItemMorphine';player addMagazine 'ItemEpinephrine';player addWeapon 'ItemMap';player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';player addMagazine '30Rnd_9x19_UZI_SD';
		player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';
		player addMagazine 'ItemBandage';player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';
		player addWeapon 'Itemetool';player addWeapon 'Itemtoolbox';player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminsvdcamo =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addweapon 'SVD_CAMO_DZ';player selectWeapon 'SVD_CAMO_DZ';player addMagazine '10Rnd_762x54_SVD';player addMagazine '10Rnd_762x54_SVD';player addMagazine '10Rnd_762x54_SVD';player addMagazine '10Rnd_762x54_SVD';
		player addMagazine 'Skin_Sniper1_DZ';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';
		player addMagazine 'ItemMorphine';player addMagazine 'ItemEpinephrine';player addWeapon 'ItemMap';player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';player addMagazine '30Rnd_9x19_UZI_SD';
		player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';
		player addMagazine 'ItemBandage';player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';
		player addWeapon 'Itemetool';player addWeapon 'Itemtoolbox';player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminvss =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addweapon 'VSS_vintorez_DZE';player selectWeapon 'VSS_vintorez_DZE';player addMagazine '20Rnd_9x39_SP5_VSS';player addMagazine '20Rnd_9x39_SP5_VSS';player addMagazine '20Rnd_9x39_SP5_VSS';player addMagazine '20Rnd_9x39_SP5_VSS';
		player addMagazine 'Skin_Sniper1_DZ';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';
		player addMagazine 'ItemMorphine';player addMagazine 'ItemEpinephrine';player addWeapon 'ItemMap';player addWeapon 'Binocular_Vector';player addweapon 'G17_FL_DZ';player addMagazine '17Rnd_9x19_glock17';player addMagazine '17Rnd_9x19_glock17';
		player addMagazine '17Rnd_9x19_glock17';player addMagazine '17Rnd_9x19_glock17';player addMagazine '17Rnd_9x19_glock17';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';
		player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';player addWeapon 'Itemetool';
		player addWeapon 'Itemtoolbox';player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminm4a1sd =
	{
		{player removeMagazine _x;} forEach (magazines player);
		removeAllWeapons player;
		removebackpack player;
		removeAllItems player;
		[dayz_playerUID,dayz_characterID,"Rocket_DZ"] spawn player_humanityMorph;
		player addweapon 'M4A1_AIM_SD_camo';player selectWeapon 'M4A1_AIM_SD_camo';player addMagazine '30Rnd_556x45_StanagSD';player addMagazine '30Rnd_556x45_StanagSD';player addMagazine '30Rnd_556x45_StanagSD';player addMagazine '30Rnd_556x45_StanagSD';
		player addMagazine 'Skin_Sniper1_DZ';player addMagazine 'FoodBeefCooked';player addMagazine 'ItemSodaCoke';player addMagazine 'ItemBloodbag';player addMagazine 'ItemPainkiller';player addMagazine 'ItemAntibiotic';
		player addMagazine 'ItemMorphine';player addWeapon 'ItemMap';player addWeapon 'Binocular_Vector';player addweapon 'UZI_SD_EP1';player addMagazine '30Rnd_9x19_UZI_SD';
		player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine '30Rnd_9x19_UZI_SD';player addMagazine 'ItemBandage';player addMagazine 'ItemBandage';
		player addMagazine 'ItemBandage';player addBackPack 'DZ_Backpack_EP1';player addWeapon 'NVGoggles_DZE';player addWeapon 'ItemCompass';player addWeapon 'ItemHatchet';player addWeapon 'ItemKnife';player addWeapon 'Itemmatchbox';
		player addWeapon 'Itemetool';player addWeapon 'Itemtoolbox';player addWeapon 'ItemGPS';player addWeapon 'ItemCrowbar';reload player;
	};
	adminheal =
	{
		{
			if(name _x == _this select 0)then
			{
				PVAH_AdminReq = [5,player,_x];
				publicVariableServer "PVAH_AdminReq";
				hint format["Healing %1", _this select 0];
				
				_sl = format["%1 AdminHeal %2",name player,name _x];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	adminrepair =
	{
		_name = _this select 0;
		if(_name == "")then{_name = name player;};
		{
			if(name _x == _name)then
			{
				_vehicle = vehicle _x;
				_vehicle setVectorUp [0,0,1];
				_x setVectorUp [0,0,1];
				
				PVAH_AdminReq = [51,player,_vehicle];
				publicVariableServer "PVAH_AdminReq";
				hint format["Repairing Vehicle of %1",_name];
				
				_sl = format['%1 Repair %2(%3)',name player,_name,typeOf _vehicle];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	admin_flipvehicle =
	{
		_name = _this select 0;
		if(_name == "")then{_name = name player;};
		{
			if(name _x == _name)then
			{
				PVAH_AdminReq = [52,player,getPosATL (vehicle _x)];
				publicVariableServer "PVAH_AdminReq";
				hint format["Flipping Vehicle near %1",_name];
				
				_sl = format['%1 Flips Vehicle near %2(%3)',name player,_name];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	admincrate =
	{
		PVAH_AdminReq = [9001,player];
		publicVariableServer "PVAH_AdminReq";
		
		hint format["Box"];
		cutText [format["Box"], "PLAIN DOWN"];
		
		_sl = format["%1 - BOX @%2",name player,mapGridPosition getPosATL player];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	DZ_Kit_Spawnable = ["VaultStorage","WeaponHolder","StorageShed_DZ","WoodShack_DZ","Ural_CDF","Ural_TK_CIV_EP1","Ural_UN_EP1","V3S_Open_TK_EP1","Kamaz","V3S_TK_EP1_DZE","UralCivil_DZE","UralCivil2_DZE","KamazOpen_DZE","MTVR","SUV_PMC"];
	e_fnc_canInsert_Mags_Or_Weps = {
		private ["_ret","_a","_b","_c","_ta","_max","_used"];
		_ret = true;
		_a = _this select 0;
		if (isNull _a) exitWith {systemChat "You are trying to insert into a null object.";false};
		_ta = typeOf _a;
		_b = _this select 1;
		_c = _this select 2;

		_max = getNumber (configFile>>"CfgVehicles">>_ta>>"transportMaxMagazines");
		if (_max==0 && _b!=0) exitWith {systemChat "This object cannot carry magazines";false};
		_used = 0;
		{ _used = _used + _x;} count ((getMagazineCargo _a) select 1);
		if ((_max-_used) < _b) then { systemChat format["There are not enough magazine slots available in the %1!",_ta];_ret = false;};

		_max = getNumber (configFile>>"CfgVehicles">>_ta>>"transportMaxWeapons");
		if (_max==0 && _c!=0) exitWith {systemChat "This object cannot carry weapons";false};
		_used = 0;
		{ _used = _used + _x;} count ((getWeaponCargo _a) select 1);
		if ((_max-_used) < _c) then { systemChat format["There are not enough weapon slots available in the %1!",_ta];_ret = false;};
		_ret;
	};
	D_locked_storage = 
	{
		PVAH_AdminReq = [9002,player];
		publicVariableServer "PVAH_AdminReq";
		
		hint format["BOX-ALL"];
		cutText [format["BOX-ALL"], "PLAIN DOWN"];
		
		_sl = format["%1 - BOX-ALL @%2",name player,mapGridPosition getPosATL player];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	admincrateEpoch =
	{
		PVAH_AdminReq = [9003,player];
		publicVariableServer "PVAH_AdminReq";
		
		hint format["Epoch-Box"];
		cutText [format["Epoch-Box"], "PLAIN DOWN"];
		
		_sl = format["%1 - EPOCH-BOX @%2",name player,mapGridPosition getPosATL player];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	supplypackage1 =
	{
		PVAH_AdminReq = [9004,player];
		publicVariableServer "PVAH_AdminReq";
		
		hint format["Small Supply Package Spawned!"];
		cutText [format["Small Supply Package Spawned!"], "PLAIN DOWN"];
		
		_sl = format["%1 - SMALL SUPPLY PACKAGE @%2",name player,mapGridPosition getPosATL player];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};	
	supplypackage2 =
	{
		PVAH_AdminReq = [9005,player];
		publicVariableServer "PVAH_AdminReq";
		
		hint format["Medium Supply Package Spawned!"];
		cutText [format["Medium Supply Package Spawned!"], "PLAIN DOWN"];
		
		_sl = format["%1 - MEDIUM SUPPLY PACKAGE @%2",name player,mapGridPosition getPosATL player];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};	
	supplypackage3 =
	{
		PVAH_AdminReq = [9006,player];
		publicVariableServer "PVAH_AdminReq";
		
		hint format["Large Supply Package Spawned!"];
		cutText [format["Large Supply Package Spawned!"], "PLAIN DOWN"];
		
		_sl = format["%1 - LARGE SUPPLY PACKAGE @%2",name player,mapGridPosition getPosATL player];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	supportbox =
	{
		_pos = (vehicle player) modelToWorld [0,3,0];
		
		PVAH_AdminReq = [9099,player,_this,_pos];
		publicVariableServer "PVAH_AdminReq";
		
		_log = format['Spawning Box %1 on the ground infront of you!',_this];
		cutText [_log, 'PLAIN DOWN'];
		hint _log;
		PVAH_WriteLogReq = [player,toArray _log];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	supportVault =
	{
		_direction = getDir player;
		_position = getPosATL player;
		_position = [(_position select 0) + 2 * sin(_direction), (_position select 1) + 2 * cos(_direction), _position select 2];
		_combination = format['%1%2%3%4',floor(random 9)+1,floor(random 9)+1,floor(random 9)+1,floor(random 9)+1];
		
		_log = format['combination: %1', _combination];
		cutText [_log, 'PLAIN DOWN', 5];
		systemChat _log;
		
		PVAH_AdminReq = [9000, player, _this, [_direction, _position], _combination];
		publicVariableServer 'PVAH_AdminReq';
		
		[] spawn {sleep 3;{player reveal _x;} forEach (getpos player nearObjects ['All',50]);};
		
		_log = format['Vault with combination %1 spawned at %2', _combination, mapGridPosition _position];
		PVAH_WriteLogReq = [player,toArray _log];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	adminESPicons =
	{
		if !(('ItemGPS' in items player) || ('ItemMap' in items player))then
		{
			_config = ["ItemGPS"];
			_isOK = [player,_config] call BIS_fnc_invAdd;
		};
		setGroupIconsVisible [true, true];
		_color_list = [0,1,0,1];
		_color_orange = [1,0.35,0.15,1];
		_color_bluefor_plr = [0.047,0.502,1,1];
		_color_opfor_plr = [1,0.17,0.17,1];
		_color_resistance_plr = [0,0.65,0,1];
		_color_civilian_plr = [1,1,1,1];
		_name = "";
		_show = "";
		_clr = _color_bluefor_plr;
		if(isNil "fnc_adminESPicons")then{fnc_adminESPicons = 0;};
		if(fnc_adminESPicons == 0)then 
		{
			fnc_adminESPicons = 1;
			hint "GroupIcons ON";
			cutText ["\nGroupIcons ON", "PLAIN DOWN"];
			
			_nameP = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_nameP = name player;};
			_sl = format["%1 GroupIcons Activated",_nameP];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		} 
		else 
		{
			fnc_adminESPicons = 0;
			hint "GroupIcons OFF";
			cutText ["\nGroupIcons OFF", "PLAIN DOWN"];
			
			_nameP = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_nameP = name player;};
			_sl = format["%1 GroupIcons Disabled",_nameP];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		};
		
		while{fnc_adminESPicons == 1}do
		{
			{
				_pid = getPlayerUID _x;
				if(_pid != "")then
				{
					_namex = 'DEAD';if((alive _x)&&(getPlayerUID _x != ''))then{_namex = name _x;};
					_name = _namex;
					_veh = vehicle _x;
					_type = typeOf _veh;
					
					if(_name == "")then{_name = _type;};
					_pos = (positionCameraToWorld [0,0,0]);
					_posU = getPos _veh;
					_dist = round(_pos distance _posU);
					
					if(_x == _veh)then
					{
						_show = format["%1 (%2m)",_name,_dist];
						_clr = _color_bluefor_plr;
					}
					else
					{
						_crewnames = [];
						{
							_namecx = 'DEAD';if((alive _x)&&(getPlayerUID _x != ''))then{_namecx = name _x;};
							_crewnames = _crewnames + [_namecx];
						} forEach crew _veh;
						
						_show = format["%1 (%2m) - %3",_crewnames,_dist,_type];
						_clr = _color_orange;
					};
					
					_puid = getPlayerUID player;
					if(_pid in (PV_LowLevel_List+PV_NormalLevel_List+PV_SuperLevel_List))then{_clr = _color_list};
					if(!(_pid in PV_SuperLevel_List) || ((_pid in PV_SuperLevel_List) && (_puid in PV_SuperLevel_List)) || (_pid == _puid))then
					{
						if(!(_pid in PV_DevUlDs) || (_puid in PV_DevUlDs))then
						{
							_grp = group _x;
							clearGroupIcons _grp;
							_grp addGroupIcon ["x_art"];
							_grp setGroupIconParams [_clr, _show, 1, true];
						};
					};
				};
			} forEach playableUnits;
			uiSleep 1;
		};
		{clearGroupIcons group _x;} forEach playableUnits;
	};
	admin_fnc_esp = {
		if("  Grim ESP" in admin_toggled)then{ admin_toggled=admin_toggled-["  Grim ESP"];call fnc_bruno_esp; };call admin_init;
		fnc_espSHOW = {
			disableSerialization;
			{_x ctrlShow false;_x ctrlEnable false;} forEach ctrlarray;
			_camPos = positionCameraToWorld [0,0,0];
			{
				if(visibleMap)exitWith{};
				_veh = vehicle _x;
				_pos = ASLtoATL eyepos _x;
				_dist = _camPos distance _pos;
				_pos2D = worldToScreen _pos;
				if(count _pos2D != 0)then
				{
					_dist = round _dist;
					_text = format['<t size=''0.45'' color=''#0B80FF''>%1 (%2m)</t>',name _x,_dist];
					if(_x != _veh)then
					{
						_crewnames = '';
						{
							_namex = name _x;
							if(_crewnames == '')then
							{
								_crewnames = format['%1',_namex];
							}
							else
							{
								_crewnames = format['%1, %2',_crewnames,_namex];
							};
						} forEach (crew _veh);
						_text = format['<t size=''0.45'' color=''#FF5926''>%1 (%2m) %3</t>',_crewnames,_dist,typeOf _veh];
					};
					_ctrl = ctrlarray select _forEachIndex;
					_ctrl ctrlEnable true;_ctrl ctrlShow true;
					_ctrl ctrlSetStructuredText (parseText _text);
					_ctrl ctrlSetPosition [(_pos2D select 0) - (safezoneW / 2), (_pos2D select 1)-0.05, safezoneW, safezoneH];
					_ctrl ctrlSetFade (_dist/fnc_esp_distance)+.2;
					_ctrl ctrlCommit 0;
				};
			} forEach ESP_UNIT_ARR;
		};
		disableSerialization;
		if(isNil'ctrlarray')then
		{
			ctrlarray = [];
			for '_i' from 0 to 100 do
			{
				(random 9999) cutRsc ['rscDynamicText', 'PLAIN'];
				_ctrl = ((uiNameSpace getVariable 'BIS_dynamicText') displayctrl 9999);
				ctrlarray = ctrlarray + [_ctrl];
			};
		};
		if(isNil'fnc_esp_stateT')then
		{
			fnc_esp_stateT = [] spawn {
				_puid = getPlayerUID player;
				while{true}do
				{
					ESP_UNIT_ARR=[];
					_pos = getPos (vehicle player);
					{
						if((getPlayerUID _x != _puid)&&(alive _x))then
						{
							if(_pos distance _x < 1200)then
							{
								ESP_UNIT_ARR=ESP_UNIT_ARR+[_x];
							};
						};
					} forEach playableUnits;
					uiSleep 2;
				};
			};
			fnc_esp_distance = 1200;
			setGroupIconsVisible [true, false];
			onEachFrame {call fnc_espSHOW;};
			cutText ['ESP ON', 'PLAIN DOWN'];
		}
		else
		{
			terminate fnc_esp_stateT;fnc_esp_stateT=nil;
			setGroupIconsVisible [true, true];
			onEachFrame {};
			cutText ['ESP OFF', 'PLAIN DOWN'];
		};
		{_x ctrlShow false;_x ctrlEnable false;} forEach ctrlarray;
	};
	fnc_bruno_esp = {
		if("  ESP for FreeRoam Cam" in admin_toggled)then{ admin_toggled=admin_toggled-["  ESP for FreeRoam Cam"];call admin_fnc_esp; };call admin_init;
		_renderer_init = {
			allAdminSMGT = (PV_LowLevel_List+PV_NormalLevel_List+PV_SuperLevel_List);
			last_render = 2500;
			onEachFrame
			{
				disableSerialization;
				private ["_renderTargets","_ctrl","_pos","_pos2D","_text","_weapon","_renderer_recourse","_unit"];
				_renderTargets = playableUnits - [cameraOn];
				_renderer_recourse = 2500;
				{
					if(visibleMap)exitWith{};
					_unit = _x;
					if((isPlayer _unit) && !(isNull _unit) && ((_unit distance cameraOn) < 1500))then
					{
						_renderer_recourse cutRsc ['rscDynamicText', 'PLAIN'];
						_ctrl = ((uiNamespace getvariable 'BIS_dynamicText') displayctrl 9999);
						_ctrl ctrlShow true; _ctrl ctrlEnable true; _ctrl ctrlSetFade 0;
						_pos = getPosATL _unit;
						_pos = [_pos select 0, _pos select 1, (_pos select 2) + 2];
						_pos2D = worldToScreen _pos;
						_color = 
						if(getPlayerUID _unit in allAdminSMGT)then
						{
							"#0cff00"
						}
						else
						{
							if (vehicle _unit == _unit) then {
								"#ff0000"
							}
							else
							{
								"#2E64FE"
							};
						};
						_name = if(vehicle _unit == _unit)then
						{
							format ["%1 (%2)",name _unit,primaryWeapon _unit]
						}else{
							format ["%1 (%2)",name _unit,typeOf (vehicle _unit)]
						};
						if(count _pos2D > 0)then
						{					
							_ctrl ctrlSetPosition [(_pos2D select 0) - (safezoneW / 2), (_pos2D select 1), safezoneW, safezoneH];
							_text = parseText format ['<t size=''0.3'' color=''%1''> %2 <br/>%3m</t>',_color,_name , round (cameraOn distance _unit)];
							_ctrl ctrlSetStructuredText _text;
							_ctrl ctrlCommit 0;
						};
						_renderer_recourse = _renderer_recourse + 1;
					};
				}
				forEach _renderTargets;
				if(_renderer_recourse < last_render)then
				{
					for "_i" from _renderer_recourse to last_render do {
						_i cutText ["", "PLAIN"];
					};
				};
				last_render = _renderer_recourse;
			};
		};
		if(isNil "RENDER_ESP")then{RENDER_ESP = false;};
		if!(RENDER_ESP)then
		{
			call _renderer_init;
			RENDER_ESP = true;
			systemChat "ESP ON!";
		}
		else
		{
			RENDER_ESP = false;
			systemChat "ESP OFF!";
			disableSerialization;
			_ctrl = ((uiNamespace getvariable 'BIS_dynamicText') displayctrl 9999);
			_ctrl ctrlShow false; _ctrl ctrlEnable false;
			for "_i" from 2500 to 3000 do 
			{
				_i cutText ["", "PLAIN"];
			};
			onEachFrame {};
		};
	};
	fnc_MapIcons_infiSTAR = {
		if(isNil "show_buildables_epoch")then{show_buildables_epoch = false;};
		fnc_epochB = {
			if(isNil "show_buildables_epoch")then{show_buildables_epoch = false;} else {show_buildables_epoch = !show_buildables_epoch;};
		};
		if(isNil "show_loot_infiSTAR")then{show_loot_infiSTAR = false;};
		fnc_LootS = {
			if(isNil "show_loot_infiSTAR")then{show_loot_infiSTAR = false;} else {show_loot_infiSTAR = !show_loot_infiSTAR;};
		};
		if(isNil "show_boxes_infiSTAR")then{show_boxes_infiSTAR = false;};
		fnc_BoxS = {
			if(isNil "show_boxes_infiSTAR")then{show_boxes_infiSTAR = false;} else {show_boxes_infiSTAR = !show_boxes_infiSTAR;};
		};
		if(isNil "show_cWEPm_infiSTAR")then{show_cWEPm_infiSTAR = false;};
		fnc_CWEPS = {
			if(isNil "show_cWEPm_infiSTAR")then{show_cWEPm_infiSTAR = false;} else {show_cWEPm_infiSTAR = !show_cWEPm_infiSTAR;};
		};
		
		fnc_MapIconConfigCM =
		{
			MapIconConfigCM =
			[
				["",true],
				["Icon Options", [-1], "", -5, [["expression", ""]], "1", "0"],
				[(format["Show Epoch Buildables - %1",show_buildables_epoch]), [2], "", -5, [["expression", "call fnc_epochB;"]], "1", "1"],
				[(format["Show Loot - %1",show_loot_infiSTAR]), [3], "", -5, [["expression", "call fnc_LootS;"]], "1", "1"],
				[(format["Show Boxes - %1",show_boxes_infiSTAR]), [4], "", -5, [["expression", "call fnc_BoxS;"]], "1", "1"],
				[(format["Show Weapons - %1",show_cWEPm_infiSTAR]), [5], "", -5, [["expression", "call fnc_CWEPS;"]], "1", "1"]
			];
			showcommandingMenu "#USER:MapIconConfigCM";
		};
		if !(('ItemGPS' in items player) || ('ItemMap' in items player))then
		{
			_config = ["ItemGPS"];
			_isOK = [player,_config] call BIS_fnc_invAdd;
		};
		disableSerialization;
		if(isNil "fnc_MapIcons_run")then
		{
			MapIconConfigCMKey = (findDisplay 46) displayAddEventHandler ["KeyDown","if((_this select 1) == 0x3F)then{call fnc_MapIconConfigCM};false;"];
			if(MOD_EPOCH)then
			{
				cutText ["MapIcons Enabled - Option on F5\nBlue = Unlockable Vehicles\nRed = Lockable Vehicles", "PLAIN"];
			}
			else
			{
				cutText ["MapIcons Enabled - Option on F5", "PLAIN"];
			};
			
			fnc_MapIcons_run = true;
			
			_map = (findDisplay 12) displayCtrl 51;
			_mapdraw = _map ctrlSetEventHandler ["Draw", "_this call fnc_draw_MapIcons;"];
			
			_minimap = (uiNameSpace getVariable "BIS_RscMiniMap") displayCtrl 101;
			if(!isNil "_minimap")then
			{
				_minimapdraw = _minimap ctrlSetEventHandler ["Draw", "_this call fnc_draw_MapIcons;"];
			};
		}
		else
		{
			(findDisplay 46) displayRemoveEventHandler ["KeyDown", MapIconConfigCMKey];
			cutText ["MapIcons Disabled", "PLAIN"];
			
			fnc_MapIcons_run = nil;
		};
		fnc_draw_MapIcons =
		{
			if(!isNil "fnc_MapIcons_run")then 
			{
				private["_ctrl"];
				_ctrl =  _this select 0;
				_iscale = (1 - ctrlMapScale _ctrl) max .2;
				_irad = 27;
				_color = [0, 0, 0, 1];
				_icon = "\ca\ui\data\icon_zora_ca.paa";
				
				if(show_buildables_epoch)then
				{
					if(visibleMap)then
					{
						if(isNil 'All_Map_Objects')then
						{
							if(isNil 'DZE_DoorsLocked')then{DZE_DoorsLocked = [];};
							_DoorsLocked = [];
							{
								_DoorsLocked = _DoorsLocked + (allMissionObjects _x);
							} forEach DZE_DoorsLocked;
							All_Map_Objects = (allMissionObjects 'ModularItems')+_DoorsLocked;
							[] spawn {uiSleep 30;All_Map_Objects = nil;};
						};
						{
							_type = typeOf _x;
							if(_type in ['Plastic_Pole_EP1_DZ'])then
							{
								_icon = "\Ca\buildings\Icons\i_wall_CA.paa";
								_icon = getText (configFile >> 'CfgVehicles' >> _type >> 'picture');
								_ctrl drawIcon [_icon, [0.4,0.25,0,1], getPosASL _x, 10, 10, getDir _x, "", 0];
							}
							else
							{
								_icon = "\Ca\buildings\Icons\i_wall_CA.paa";
								_ctrl drawIcon [_icon, [0.4,0.25,0,1], getPosASL _x, 10, 10, getDir _x, "", 0];
							};
						} forEach All_Map_Objects;
					};
				};
				if((show_loot_infiSTAR) || (show_boxes_infiSTAR))then
				{
					if(isNil 'lootBoxesArray')then
					{
						lootBoxesArray = (allMissionObjects "ReammoBox");
						[] spawn {uiSleep 10;lootBoxesArray = nil;};
					};
					
					{
						if(!isNull _x)then
						{
							_type = typeOf _x;
							if(_type == "WeaponHolder")then
							{
								if(show_loot_infiSTAR)then
								{
									_icon = "\ca\ui\data\icon_zora_ca.paa";
									_wepCargo = (getWeaponCargo _x) select 0;
									if(count _wepCargo > 0)then
									{
										_icon = getText (configFile >> 'CfgWeapons' >> _wepCargo select 0 >> 'picture');
									}
									else
									{
										_magCargo = (getMagazineCargo _x) select 0;
										if(count _magCargo > 0)then
										{
											_icon = getText (configFile >> 'CfgMagazines' >> _magCargo select 0 >> 'picture');
										};
									};
									_irad = 25;
									_ctrl drawIcon [_icon, [0.74,0.97,0.98,1], getPosASL _x, _iscale*_irad, _iscale*_irad, getDir _x, "", 1];
								};
							}
							else
							{
								if(show_boxes_infiSTAR)then
								{
									_icon = getText(configFile >> "CfgVehicles" >> _type >> "icon");
									_irad = 25;
									_ctrl drawIcon [_icon, [1,0,0,1], getPosASL _x, _iscale*_irad, _iscale*_irad, getDir _x, "", 1];
								};
							};
						};
					} forEach lootBoxesArray;
				};
				_AllVehicles = player nearEntities ['AllVehicles',1000000];
				if(!visibleMap)then
				{
					_AllVehicles = player nearEntities ['AllVehicles',150];
				};
				_puid = getPlayerUID player;
				{
					if(!isNull _x)then
					{
						_type = typeOf _x;
						_pid = getPlayerUID _x;
						if((_x isKindOf "LandVehicle") || (_x isKindOf "Air") || (_x isKindOf "Ship"))then
						{
							_icon = getText(configFile >> "CfgVehicles" >> _type >> "icon");
							_irad = 27;
							_vehcolor = [0.05,0.05,0.6,1];
							_characterID = _x getVariable['CharacterID','0'];
							if((MOD_EPOCH) && (_characterID != '0'))then
							{
								_vehcolor = [0.7,0,0,1];
							};
							_ctrl drawIcon [_icon, _vehcolor, getPosASL _x, _iscale*_irad, _iscale*_irad, getDir _x, "", 0.5];
						};
						if((_x isKindOf "Man") || (_pid != ""))then
						{
							if(!(_pid in PV_SuperLevel_List) || ((_pid in PV_SuperLevel_List) && (_puid in PV_SuperLevel_List)) || (_pid == _puid))then
							{
								if(!(_pid in PV_DevUlDs) || (_puid in PV_DevUlDs))then
								{
									if(_x == player)then{_color = [0, 0, 0, 1];} else {_color = [1, 0, 0, 1];};
									if((_x isKindOf "zZombie_Base") || (_x isKindOf "Animal"))then
									{
										if(_pid != "")then
										{
											_ctrl drawIcon ["\ca\ui\data\iconman_ca.paa", _color, getPosASL _x, _iscale*30, _iscale*30, getDir _x, "", 1];
										};
									}
									else
									{
										_ctrl drawIcon ["\ca\ui\data\iconman_ca.paa", _color, getPosASL _x, _iscale*30, _iscale*30, getDir _x, "", 1];
										if(show_cWEPm_infiSTAR)then
										{
											_icon = getText (configFile >> 'CfgWeapons' >> (currentWeapon _x) >> 'picture');
											_irad = 35;
											_pos = getPosASL _x;
											_pos = [_pos select 0,(_pos select 1) + 12,_pos select 2];
											_ctrl drawIcon [_icon, [0.74,0.97,0.98,1], _pos, _iscale*_irad, _iscale*_irad, (getDir _x)+90, "", 1];
										};
									};
								};
							};
						};
					};
				} forEach _AllVehicles;
			};
		};
	};
	adminwreck =
	{
		if !(('ItemGPS' in items player) || ('ItemMap' in items player))then
		{
			_config = ["ItemGPS"];
			_isOK = [player,_config] call BIS_fnc_invAdd;
		};
		
		stopadminwrecks =
		{
			for "_i" from 0 to 8888 do {deleteMarkerLocal ("adminwrecks" + (str _i));};
		};
		adminwrecks =
		{
			while{markadwreck == 1}do
			{
				if(markadwreck == 0)exitWith {[] spawn stopadminwrecks;};
				_objects = allMissionObjects "SpawnableWreck" + allMissionObjects "Supply_Crate_DZE" + allMissionObjects "UH60Wreck_DZ" + allMissionObjects "UH1Wreck_DZ" + allMissionObjects "Mi8Wreck_DZ";
				_objects = _objects + vehicles;
				for "_i" from 0 to (count _objects)-1 do
				{
					deleteMarkerLocal ("adminwrecks" + (str _i));
					
					_selected = _objects select _i;
					_type = typeOf _selected;
					if((getText (configFile >> 'CfgVehicles' >> (typeOf _selected) >> 'displayName') == 'Wreck') || 
					(_type in ["UH60Wreck_DZ","UH1Wreck_DZ","Mi8Wreck_DZ","UH60_NAVY_Wreck_DZ","UH60_ARMY_Wreck_DZ","UH60_NAVY_Wreck_burned_DZ","UH60_ARMY_Wreck_burned_DZ","Mass_grave_DZ"]) || 
					(_selected isKindOf "ReammoBox") || (_selected isKindOf "Supply_Crate_DZE") || (_selected isKindOf "Wreck_Base") || (_selected isKindOf "Wreck"))then 
					{
						deleteMarkerLocal ("adminwrecks" + (str _i));
						_vm = createMarkerLocal [("adminwrecks" + (str _i)), getPos _selected];
						_vm setMarkerTypeLocal "SupplyVehicle";
						_vm setMarkerSizeLocal [0.8, 0.8];
						_vm setMarkerTextLocal format[" %1", getText (configFile >> 'CfgVehicles' >> (typeOf _selected) >> 'displayName')];
						_vm setMarkerColorLocal ("ColorYellow");
					};
				};
				uiSleep 5;
			};
			[] spawn stopadminwrecks;
		};
		if(isNil "markadwreck")then{markadwreck = 0;};
		if(markadwreck == 0)then
		{
			markadwreck = 1;
			hint "2D Map WRECK Markers Activated";
			[] spawn adminwrecks;
			
			_sl = format["%1 WRECK Activated",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		}
		else
		{
			markadwreck = 0;
			hint "2D Map WRECK Markers Disabled";
			
			[] spawn stopadminwrecks;
			
			_sl = format["%1 WRECK Disabled",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		};
	};
	admintent =
	{
		if !(('ItemGPS' in items player) || ('ItemMap' in items player))then
		{
			_config = ["ItemGPS"];
			_isOK = [player,_config] call BIS_fnc_invAdd;
		};
		
		admintents =
		{
			while{markadtent == 1}do
			{
				_objects = [];
				{
					_objects = _objects + (allMissionObjects _x);
					uiSleep 0.5;
				} forEach ["TentStorage","StashSmall","StashSmall1","StashSmall2","StashSmall3","StashSmall4","StashMedium","StashMedium1","StashMedium2","StashMedium3", "StashMedium4"];
				for "_i" from 0 to (count _objects)-1 do
				{
					_selected = _objects select _i;
					deleteMarkerLocal ("admintents" + (str _i));
					_vm = createMarkerLocal [("admintents" + (str _i)), getPos _selected];
					_vm setMarkerTypeLocal "Camp";
					_vm setMarkerSizeLocal [0.8, 0.8];
					_vm setMarkerTextLocal format[" %1", getText (configFile >> 'CfgVehicles' >> (typeOf _selected) >> 'displayName')];
					_vm setMarkerColorLocal ("ColorGreen");
				};
				uiSleep 20;
			};
			for "_i" from 0 to 8888 do {deleteMarkerLocal ("admintents" + (str _i));};
		};
		if(isNil "markadtent")then{markadtent = 0;};
		if(markadtent == 0)then
		{
			markadtent = 1;
			hint "2D Map Tent Markers Activated";
			[] spawn admintents;
			
			_sl = format["%1 TentMarker Activated",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		}
		else
		{
			markadtent = 0;
			hint "2D Map Tent Markers Disabled";
			
			for "_i" from 0 to 8888 do {deleteMarkerLocal ("admintents" + (str _i));};
			
			_sl = format["%1 TentMarker Disabled",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		};
	};
	adminDEAD =
	{
		if !(('ItemGPS' in items player) || ('ItemMap' in items player))then
		{
			_config = ["ItemGPS"];
			_isOK = [player,_config] call BIS_fnc_invAdd;
		};
		adminDEADs =
		{
			while{markadDEAD == 1}do
			{
				if !(markadDEAD == 1)exitWith {
					for "_i" from 0 to 8888 do {deleteMarkerLocal ("adminDEADs" + (str _i));};
				};
				_objects = (allDead+allMissionObjects "GraveDZE");
				for "_i" from 0 to (count _objects)-1 do
				{
					deleteMarkerLocal ("adminDEADs" + (str _i));
					_selected = _objects select _i;
					if(typeOf _selected == 'GraveDZE')then
					{
						_vm = createMarkerLocal [("adminDEADs" + (str _i)), getPos _selected];
						_vm setMarkerTypeLocal "Camp";
						_vm setMarkerSizeLocal [0.4, 0.4];
						_vm setMarkerTextLocal format["%1","GRAVE"];
						_vm setMarkerColorLocal ("ColorRED");
					}
					else
					{
						if((!isNull _selected) && !(_selected isKindOf "zZombie_base") && (_selected isKindOf "CAManBase"))then
						{
							_name = (_selected getVariable["bodyName",""]);
							if(_name != "")then
							{
								_vm = createMarkerLocal [("adminDEADs" + (str _i)), getPos _selected];
								_vm setMarkerTypeLocal "Camp";
								_vm setMarkerSizeLocal [0.4, 0.4];
								_vm setMarkerTextLocal format["%1",_name];
								_vm setMarkerColorLocal ("ColorRED");
							};
						};
					};
				};
				uiSleep 5;
			};
			for "_i" from 0 to 8888 do {deleteMarkerLocal ("adminDEADs" + (str _i));};
		};
		if(isNil "markadDEAD")then{markadDEAD = 0;};
		if(markadDEAD == 0)then
		{
			markadDEAD = 1;
			hint "2D Map DEADMarker Activated";
			[] spawn adminDEADs;
			
			_sl = format["%1 DEADMarker Activated",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		}
		else
		{
			markadDEAD = 0;
			hint "2D Map DEADMarker Disabled";
			
			for "_i" from 0 to 8888 do {deleteMarkerLocal ("adminDEADs" + (str _i));};
			
			_sl = format["%1 DEADMarker Disabled",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		};
	};
	adminPlotPole =
	{
		if !(('ItemGPS' in items player) || ('ItemMap' in items player))then
		{
			_config = ['ItemGPS'];
			_isOK = [player,_config] call BIS_fnc_invAdd;
		};
		adminPlotPoles =
		{
			while{markadPlotPole == 1}do
			{
				ADMIN_PlotPole_LIST = [] + (allMissionObjects 'Plastic_Pole_EP1_DZ');
				if(markadPlotPole == 0)exitWith {};
				for '_i' from 0 to (count ADMIN_PlotPole_LIST)-1 do
				{
					if(markadPlotPole == 0)exitWith {};
					
					deleteMarkerLocal ('adminPlotPoles' + (str _i));
					_selected = ADMIN_PlotPole_LIST select _i;
					_vm = createMarkerLocal [('adminPlotPoles' + (str _i)), getPos _selected];
					_vm setMarkerAlphaLocal 0.8;
					_vm setMarkerBrushLocal 'Grid';
					if(isNil 'DZE_PlotPole')then{DZE_PlotPole = [30,45];};
					_vm setMarkerSizeLocal [DZE_PlotPole select 0,DZE_PlotPole select 0];
					_vm setMarkerShapeLocal 'ELLIPSE';
					_vm setMarkerColorLocal 'ColorGreen';
					
					_k = _i + 4000;
					deleteMarkerLocal ('adminPlotPoles' + (str _k));
					_vm = createMarkerLocal [('adminPlotPoles' + (str _k)), getPos _selected];
					_vm setMarkerTypeLocal 'mil_start';
					_vm setMarkerSizeLocal [0.5, 0.5];
					_vm setMarkerTextLocal 'Plot';
					_vm setMarkerColorLocal 'ColorGreen';
					
					if(markadPlotPole == 0)exitWith {};
				};
				if(markadPlotPole == 0)exitWith {};
				uiSleep 15;
			};
			for '_i' from 0 to 8888 do {deleteMarkerLocal ('adminPlotPoles' + (str _i));deleteMarkerLocal ('adminPlotPoles' + (str (_i+4000)));};
		};
		if(isNil 'markadPlotPole')then{markadPlotPole = 0;};
		if(markadPlotPole == 0)then
		{
			markadPlotPole = 1;
			hint '2D Map PlotPoleMarker Activated';
			[] spawn adminPlotPoles;
			
			_sl = format['%1 PlotPoleMarker Activated',name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		}
		else
		{
			markadPlotPole = 0;
			hint '2D Map PlotPoleMarker Disabled';
			
			for '_i' from 0 to 8888 do {deleteMarkerLocal ('adminPlotPoles' + (str _i));deleteMarkerLocal ('adminPlotPoles' + (str (_i+4000)));};
			
			_sl = format['%1 PlotPoleMarker Disabled',name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		};
	};
	adminVAULT =
	{
		if !(('ItemGPS' in items player) || ('ItemMap' in items player))then
		{
			_config = ["ItemGPS"];
			_isOK = [player,_config] call BIS_fnc_invAdd;
		};
		adminVAULTs =
		{
			while{markadVAULT == 1}do
			{
				ADMIN_VAULT_LIST = [] + (allMissionObjects "VaultStorage"+allMissionObjects "VaultStorageLocked"+allMissionObjects "LockboxStorageLocked"+allMissionObjects "LockboxStorage");
				
				if !(markadVAULT == 1)exitWith {
					for "_i" from 0 to 8888 do {deleteMarkerLocal ("adminVAULTs" + (str _i));};
				};
				for "_i" from 0 to (count ADMIN_VAULT_LIST)-1 do
				{
					deleteMarkerLocal ("adminVAULTs" + (str _i));
					_selected = ADMIN_VAULT_LIST select _i;
					_vm = createMarkerLocal [("adminVAULTs" + (str _i)), getPos _selected];
					_vm setMarkerTypeLocal "Camp";
					_vm setMarkerSizeLocal [0.5, 0.5];
					_vm setMarkerTextLocal "VAULT";
					_vm setMarkerColorLocal ("ColorYellow");
				};
				uiSleep 5;
			};
			for "_i" from 0 to 8888 do {deleteMarkerLocal ("adminVAULTs" + (str _i));};
		};
		if(isNil "markadVAULT")then{markadVAULT = 0;};
		if(markadVAULT == 0)then
		{
			markadVAULT = 1;
			hint "2D Map VAULTMarker Activated";
			[] spawn adminVAULTs;
			
			_sl = format["%1 VAULTMarker Activated",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		}
		else
		{
			markadVAULT = 0;
			hint "2D Map VAULTMarker Disabled";
			
			for "_i" from 0 to 8888 do {deleteMarkerLocal ("adminVAULTs" + (str _i));};
			
			_sl = format["%1 VAULTMarker Disabled",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		};
	};
	adminVEINE =
	{
		if !(('ItemGPS' in items player) || ('ItemMap' in items player))then
		{
			_config = ["ItemGPS"];
			_isOK = [player,_config] call BIS_fnc_invAdd;
		};
		adminVEINEs =
		{
			while{markadVEINE == 1}do
			{
				ADMIN_VEINE_LIST = [] + (allMissionObjects "Iron_Vein_DZE"+allMissionObjects "Silver_Vein_DZE"+allMissionObjects "Gold_Vein_DZE");
				
				if !(markadVEINE == 1)exitWith {
					for "_i" from 0 to 8888 do {deleteMarkerLocal ("adminVEINEs" + (str _i));};
				};
				for "_i" from 0 to (count ADMIN_VEINE_LIST)-1 do
				{
					deleteMarkerLocal ("adminVEINEs" + (str _i));
					_selected = ADMIN_VEINE_LIST select _i;
					_vm = createMarkerLocal [("adminVEINEs" + (str _i)), getPos _selected];
					_vm setMarkerTypeLocal "DestroyedVehicle";
					_vm setMarkerSizeLocal [0.5, 0.5];
					_vm setMarkerTextLocal "VEINE";
					_vm setMarkerColorLocal ("ColorYellow");
				};
				uiSleep 5;
			};
			for "_i" from 0 to 8888 do {deleteMarkerLocal ("adminVEINEs" + (str _i));};
		};
		if(isNil "markadVEINE")then{markadVEINE = 0;};
		if(markadVEINE == 0)then
		{
			markadVEINE = 1;
			hint "2D Map VEINEMarker Activated";
			[] spawn adminVEINEs;
			
			_sl = format["%1 VEINEMarker Activated",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		}
		else
		{
			markadVEINE = 0;
			hint "2D Map VEINEMarker Disabled";
			
			for "_i" from 0 to 8888 do {deleteMarkerLocal ("adminVEINEs" + (str _i));};
			
			_sl = format["%1 VEINEMarker Disabled",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		};
	};
	adminLocateVeh =
	{
		_inv = items player;
		if !(('ItemGPS' in _inv) || ('ItemMap' in _inv))then
		{
			_config = ['ItemGPS'];
			_isOK = [player,_config] call BIS_fnc_invAdd;
		};
		
		adminvehlocmark =
		{
			_markerscreated = 0;
			while{vehlocmark == 1}do
			{
				_items = (items player);
				_temp_keys = [];
				_removeKeys = [];
				_key_colors = ['ItemKeyYellow','ItemKeyBlue','ItemKeyRed','ItemKeyGreen','ItemKeyBlack'];
				{
					if(configName(inheritsFrom(configFile >> 'CfgWeapons' >> _x)) in _key_colors)then
					{
						_ownerKeyId = getNumber(configFile >> 'CfgWeapons' >> _x >> 'keyid');
						_keyName = getText (configFile >> 'CfgWeapons' >> _x >> 'displayName');
						_temp_keys = _temp_keys + [_ownerKeyId,_keyName,_x];
						_removeKeys = _removeKeys + [_x];
					};
				} forEach _items;
				
				for '_i' from 0 to (_markerscreated+1) do {deleteMarkerLocal ('vehicleLocMarker'+ (str _i));};
				_markerscreated = 0;
				
				
				{
					if(!isNil '_x')then
					{
						if(!isNull _x)then
						{
							_charID = _x getVariable ['CharacterID','0'];
							_tID = parseNumber _charID;
							_ftID = _temp_keys find _tID;
							if(_ftID != -1)then
							{
								_targetPosition = getPosATL _x;
								_vehicleName = gettext (configFile >> 'CfgVehicles' >> (typeOf _x) >> 'displayName');
								_Marker = 'vehicleLocMarker' + (str _markerscreated);
								_vehicleLocMarker = createMarkerLocal [_Marker,[(_targetPosition select 0),(_targetPosition select 1)]];
								_vehicleLocMarker setMarkerShapeLocal 'ICON';
								_vehicleLocMarker setMarkerTypeLocal 'DOT';
								_vehicleLocMarker setMarkerColorLocal 'ColorYellow';
								_vehicleLocMarker setMarkerSizeLocal [1.0, 1.0];
								
								_keyName = _temp_keys select (_ftID+1);
								_keyItem = _temp_keys select (_ftID+2);
								_vehicleLocMarker setMarkerTextLocal format['%1 - %2',_vehicleName,_keyName];
								_markerscreated = _markerscreated + 1;
								
								_removeKeys = _removeKeys - [_keyItem];
							};
						};
					};
				} forEach ([0,0,0] nearEntities [['LandVehicle','Air','Ship'],35000]);
				{
					player removeWeapon _x;
				} forEach _removeKeys;
				uiSleep 1;
			};
			for '_i' from 0 to 9999 do {deleteMarkerLocal ('vehicleLocMarker'+ (str _i));};
		};
		if(isNil 'vehlocmark')then{vehlocmark = 0;};
		if(vehlocmark == 0)then
		{
			vehlocmark = 1;
			hint 'Check the map to locate your vehicle(s)!';
			[] spawn adminvehlocmark;
			
			_sl = format['%1 Vehicle Location Markers Activated',name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		}
		else
		{
			vehlocmark = 0;
			hint 'Your Vehicle Locations are removed..';
			
			_sl = format['%1 Vehicle Location Markers Disabled',name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		};
	};
	adminmark =
	{
		if !(('ItemGPS' in items player) || ('ItemMap' in items player))then
		{
			_config = ["ItemGPS"];
			_isOK = [player,_config] call BIS_fnc_invAdd;
		};
		
		adminpmark =
		{
			while{mark == 1}do
			{
				_puid = getPlayerUID player;
				_playableUnits = playableUnits;
				for "_i" from 0 to (count _playableUnits)-1 do
				{
					deleteMarkerLocal ("adminpmark" + (str _i));
					if((_playableUnits select _i) == vehicle (_playableUnits select _i))then 
					{
						deleteMarkerLocal ("adminpmark" + (str _i));
						_pid = getPlayerUID (_playableUnits select _i);
						if(!(_pid in PV_SuperLevel_List) || ((_pid in PV_SuperLevel_List) && (_puid in PV_SuperLevel_List)) || (_pid == _puid))then
						{
							if(!(_pid in PV_DevUlDs) || (_puid in PV_DevUlDs))then
							{
								_pm = createMarkerLocal [("adminpmark" + (str _i)), getPos (_playableUnits select _i)];
								_pm setMarkerTypeLocal "DestroyedVehicle";
								_pm setMarkerSizeLocal [0.8, 0.8];
								_pm setMarkerTextLocal format["%1", name (_playableUnits select _i)];
								_pm setMarkerColorLocal ("ColorBlue");
							};
						};
					};
				};
				uiSleep 2;
			};
			for "_i" from 0 to 8888 do {deleteMarkerLocal ("adminpmark" + (str _i));};
		};
		if(isNil "mark")then{mark = 0;};
		if(mark == 0)then
		{
			mark = 1;
			hint "2D Map Player Markers Activated";
			[] spawn adminpmark;
			
			_sl = format["%1 PlayerMarkers Activated",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		}
		else
		{
			mark = 0;
			hint "2D Map Player Markers Disabled";
			
			for "_i" from 0 to 8888 do {deleteMarkerLocal ("adminpmark" + (str _i));};
			
			_sl = format["%1 PlayerMarkers Disabled",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		};
	};
	adminmarkveh_U =
	{
		if !(('ItemGPS' in items player) || ('ItemMap' in items player))then
		{
			_config = ["ItemGPS"];
			_isOK = [player,_config] call BIS_fnc_invAdd;
		};
		
		adminvmark_U =
		{
			while{markveh_U == 1}do
			{
				_vehicles = [0,0,0] nearEntities [['LandVehicle','Air','Ship'],50000];
				for "_i" from 0 to (count _vehicles)-1 do
				{
					deleteMarkerLocal ("adminvmark_U" + (str _i));
					_cveh = _vehicles select _i;
					if !(locked _cveh)then
					{
						if(count crew _cveh != 0)then 
						{
							_crewnames = [];
							{
								_crewnames = _crewnames + [name _x];
							} forEach crew _cveh;
							
							deleteMarkerLocal ("adminvmark_U" + (str _i));
							_vm = createMarkerLocal [("adminvmark_U" + (str _i)), getPos _cveh];
							_vm setMarkerTypeLocal "DestroyedVehicle";
							_vm setMarkerSizeLocal [0.8, 0.8];
							_vm setMarkerTextLocal format["%1 in %2", _crewnames,getText (configFile >> 'CfgVehicles' >> (typeOf _cveh) >> 'displayName')];
							_vm setMarkerColorLocal ("ColorRed");
						}
						else
						{
							deleteMarkerLocal ("adminvmark_U" + (str _i));
							_vm = createMarkerLocal [("adminvmark_U" + (str _i)), getPos _cveh];
							_vm setMarkerTypeLocal "DestroyedVehicle";
							_vm setMarkerSizeLocal [0.8, 0.8];
							_vm setMarkerTextLocal format["%1", getText (configFile >> 'CfgVehicles' >> (typeOf _cveh) >> 'displayName')];
							_vm setMarkerColorLocal ("ColorBlack");
						};
					};
				};
				uiSleep 3;
			};
			for "_i" from 0 to 8888 do {deleteMarkerLocal ("adminvmark_U" + (str _i));};
		};
		if(isNil "markveh_U")then{markveh_U = 0;};
		if(markveh_U == 0)then
		{
			markveh_U = 1;
			hint "2D Map (unlocked) VEHICLE Markers Activated";
			[] spawn adminvmark_U;
			
			_sl = format["%1 (unlocked) VEHICLEMarkers Activated",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		}
		else
		{
			markveh_U = 0;
			hint "2D Map (unlocked) VEHICLE Markers Disabled";
			
			for "_i" from 0 to 8888 do {deleteMarkerLocal ("adminvmark_U" + (str _i));};
			
			_sl = format["%1 (unlocked) VEHICLEMarkers Disabled",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		};
	};
	adminmarkveh_L =
	{
		if !(('ItemGPS' in items player) || ('ItemMap' in items player))then
		{
			_config = ["ItemGPS"];
			_isOK = [player,_config] call BIS_fnc_invAdd;
		};
		
		adminvmark_L =
		{
			while{markveh_L == 1}do
			{
				_vehicles = ([0,0,0] nearEntities [['LandVehicle','Air','Ship'], 35000]);
				for "_i" from 0 to (count _vehicles)-1 do
				{
					deleteMarkerLocal ("adminvmark_L" + (str _i));
					_cveh = _vehicles select _i;
					if(locked _cveh)then
					{
						if(count crew _cveh != 0)then 
						{
							_crewnames = [];
							{
								_crewnames = _crewnames + [name _x];
							} forEach crew _cveh;
							
							deleteMarkerLocal ("adminvmark_L" + (str _i));
							_vm = createMarkerLocal [("adminvmark_L" + (str _i)), getPos _cveh];
							_vm setMarkerTypeLocal "DestroyedVehicle";
							_vm setMarkerSizeLocal [0.8, 0.8];
							_vm setMarkerTextLocal format["%1 in %2", _crewnames,getText (configFile >> 'CfgVehicles' >> (typeOf _cveh) >> 'displayName')];
							_vm setMarkerColorLocal ("ColorRed");
						}
						else
						{
							deleteMarkerLocal ("adminvmark_L" + (str _i));
							_vm = createMarkerLocal [("adminvmark_L" + (str _i)), getPos _cveh];
							_vm setMarkerTypeLocal "DestroyedVehicle";
							_vm setMarkerSizeLocal [0.8, 0.8];
							_vm setMarkerTextLocal format["%1", getText (configFile >> 'CfgVehicles' >> (typeOf _cveh) >> 'displayName')];
							_vm setMarkerColorLocal ("ColorBrown");
						};
					};
				};
				uiSleep 3;
			};
			for "_i" from 0 to 8888 do {deleteMarkerLocal ("adminvmark_L" + (str _i));};
		};
		if(isNil "markveh_L")then{markveh_L = 0;};
		if(markveh_L == 0)then
		{
			markveh_L = 1;
			hint "2D Map (locked) VEHICLE Markers Activated";
			[] spawn adminvmark_L;
			
			_sl = format["%1 (locked) VEHICLEMarkers Activated",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		}
		else
		{
			markveh_L = 0;
			hint "2D Map (locked) VEHICLE Markers Disabled";
			
			for "_i" from 0 to 8888 do {deleteMarkerLocal ("adminvmark_L" + (str _i));};
			
			_sl = format["%1 (locked) VEHICLEMarkers Disabled",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		};
	};
	adminAntiAggro = {
		if(isNil "adminAntiAggro_zxeds")then{adminAntiAggro_zxeds = false;};
		if(!adminAntiAggro_zxeds)then
		{
			adminAntiAggro_zxeds = true;
			
			hint "No Zed Aggro - On";
			cutText [format["No Zed Aggro - On"], "PLAIN DOWN"];
			_sl = format["%1 No Zed Aggro - On",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
			
			player_zombieCheck = {};
			player_zombieAttack = {};
		}
		else
		{
			adminAntiAggro_zxeds = false;
			
			hint "No Zed Aggro - Disabled";
			cutText [format["No Zed Aggro - Disabled"], "PLAIN DOWN"];
			_sl = format["%1 No Zed Aggro - Disabled",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
			
			player_zombieCheck = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\player_zombieCheck.sqf';
			player_zombieAttack = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\player_zombieAttack.sqf';
		};
	};
	admin_vehicleboost = {
		if(isNil("vehboost_infiSTAR"))then{vehboost_infiSTAR = 0;};
		if(vehboost_infiSTAR == 0)then 
		{
			vehboost_infiSTAR = 1;
			hint "Vehboost 1 - left shift or E to go fast and space for brakes!";
			cutText [format["Vehboost 1 - left shift or E to go fast and space for brakes!"], "PLAIN DOWN"];
			_sl = format["%1 Vehboost On",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
			
			waitUntil {!isNull (finddisplay 46)};
			booostkey_FNC_spd_0 = 
			{
				_vehicle_player = vehicle player;
				if(_vehicle_player == player)exitwith{};
				
				if(isEngineOn _vehicle_player)then 
				{
					switch (_this) do 
					{
						case 18:
						{
							_vehicle_player SetVelocity [(velocity _vehicle_player select 0) * 1.05, (velocity _vehicle_player select 1) *1.05, (velocity _vehicle_player select 2) * 0.99];
						};
						case 42:
						{
							_vehicle_player setVelocity [(velocity _vehicle_player select 0) * 1.025, (velocity _vehicle_player select 1) * 1.025, (velocity _vehicle_player select 2) * 0.99];
						};
						case 57:
						{
							_vehicle_player SetVelocity [(velocity _vehicle_player select 0) * 0.95, (velocity _vehicle_player select 1) *0.95, (velocity _vehicle_player select 2) * 0.99];
						};
					};
				};
			};
			booostkey_KI_0 = (findDisplay 46) displayAddEventHandler ["KeyDown","_this select 1 call booostkey_FNC_spd_0;false;"];
		}
		else
		{
			vehboost_infiSTAR = 0;
			hint "Vehboost 0";
			cutText [format["Vehboost 0"], "PLAIN DOWN"];
			_sl = format["%1 Vehboost Disabled",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
			
			(findDisplay 46) displayRemoveEventHandler ["KeyDown", booostkey_KI_0];
			_vehicle_player = nil;
		};
	};
	adminZedshld = 
	{
		if(isNil "zoombiieshieldd")then{zoombiieshieldd = true;} else {zoombiieshieldd = !zoombiieshieldd;};
		if(zoombiieshieldd)then 
		{	
			cutText [format["ZedShield ON for 50m"],"PLAIN DOWN"];
			
			_sl = format["%1 ZedShield Activated",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		} 
		else 
		{
			cutText ["ZedShield OFF","PLAIN DOWN"];
			
			_sl = format["%1 ZedShield Disabled",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		};
		while{zoombiieshieldd}do 
		{
			{
				if(!isNull _x)then{
					if !(isPlayer _x)then{
						_x setdamage 1;
						deleteVehicle _x;
					};
				};
			} forEach (vehicle player nearEntities [["Zed_Base","Swarm_Base"],50]);
			uiSleep 1;
		};
	};
	adminCallZeds =
	{
		NumOfZed = _this select 0;
		fnc_addZeds =
		{
			_position = _this;
			_amount = NumOfZed;
			_counter = 0;
			_agent = objNull;
			while {_counter < _amount} do {
				_type = "swarm_newBase";
				_agent = createAgent [_type, _position, [], 0, "NONE"];
				_agent setVariable["agentObjectSwarm",_agent,true];
				_agent setUnitPos "Middle";
				dayz_swarmSpawnZombies = dayz_swarmSpawnZombies + 1;
				dayz_spawnZombies = dayz_spawnZombies + 1;
				if (isNull _agent) exitWith {
					dayz_spawnZombies = dayz_spawnZombies - 1;
					dayz_swarmSpawnZombies = dayz_swarmSpawnZombies - 1;
				};
				_isAlive = alive _agent;
				_counter = _counter + 1;
				_id = [_position,_agent,player] execFSM "\z\AddOns\dayz_code\system\fn_swarmagent.fsm";
			};
		};
		openMap [true, false];
		onMapSingleClick '
			[_pos select 0,_pos select 1,_pos select 2] spawn fnc_addZeds;
			openMap [false, false];
			onMapSingleClick "";
		';
	};
	adminammo_recoil = {
		if(isNil ('admin_loop1'))then{admin_loop1 = 0;};
		if(admin_loop1==0)then 
		{
			admin_loop1=1;
			cutText [format['Infinite AMMO and No Recoil ON'], 'PLAIN DOWN'];
			hint 'Infinite AMMO and No Recoil ON';
			
			_sl = format['%1 adminammo_recoil ON',name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		}
		else
		{
			admin_loop1=0;
			cutText [format['Infinite AMMO and No Recoil OFF'], 'PLAIN DOWN'];
			hint 'Infinite AMMO and No Recoil OFF';
			
			_sl = format['%1 adminammo_recoil OFF',name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
			player setUnitRecoilCoefficient 1;
		};
		while{admin_loop1==1}do 
		{
			(vehicle player) setVehicleAmmo 1;
			player setUnitRecoilCoefficient 0;
			(vehicle player) setUnitRecoilCoefficient 0;
			uiSleep 0.01;
		};
	};
	admin_FastFire = {
		if(isNil ('admin_loop2'))then{admin_loop2 = 0;};
		if(admin_loop2==0)then 
		{
			admin_loop2=1;
			cutText [format['FastFire ON'], 'PLAIN DOWN'];
			hint 'FastFire ON';
			
			_sl = format['%1 FastFire ON',name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		}
		else
		{
			admin_loop2=0;
			cutText [format['FastFire OFF'], 'PLAIN DOWN'];
			hint 'FastFire OFF';
			
			_sl = format['%1 FastFire OFF',name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		};
		while{admin_loop2==1}do 
		{
			(vehicle player) setWeaponReloadingTime [(vehicle player),currentWeapon (vehicle player),0];
			player setWeaponReloadingTime [player,currentWeapon player,0];
			uiSleep 0.01;
		};
	};
	admin_low_terrain = {
		if(isNil 'admin_terrain')then{admin_terrain = true;} else {admin_terrain = !admin_terrain};
		if(admin_terrain)then{
			setTerrainGrid 50;
			hint 'Terrain Low';
			cutText [format['Terrain Low'], 'PLAIN DOWN'];
			_sl = format['%1 Terrain Low',name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		}
		else
		{
			setTerrainGrid 25;
			hint 'Terrain Normal';
			cutText [format['Terrain Normal'], 'PLAIN DOWN'];
			_sl = format['%1 Terrain Normal',name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		};
	};
	admingod =
	{
		if(isNil 'gmadmin')then{gmadmin = 0;};
		if(gmadmin == 0)then
		{
			gmadmin = 1;
			gmdadmin = 1;
			hint 'God ON';
			cutText ['God ON', 'PLAIN'];
			
			[] spawn {
				while{gmadmin == 1}do
				{
					r_player_inpain = false;
					r_player_infected = false;
					r_player_injured = false;
					dayz_hunger = 0;
					dayz_thirst = 0;
					dayz_temperatur = 37;
					fnc_usec_damageHandler = {};
					player_death = {};
					player allowDamage false;
					player removeAllEventhandlers 'HandleDamage';
					player addEventhandler ['HandleDamage', {false}];
					uiSleep 0.5;
				};
				uiSleep 1;
				fnc_usec_damageHandler = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\fn_damageHandler.sqf';
				player_death = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_death.sqf";
				player allowDamage true;
				player removeAllEventHandlers 'HandleDamage';
				player addeventhandler ['HandleDamage',{_this call fnc_usec_damageHandler;} ];
			};
			
			_sl = format['%1 G_o_d ON',name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		}
		else
		{
			gmadmin = 0;
			gmdadmin = 0;
			hint 'God OFF';
			cutText ['God OFF', 'PLAIN'];
			
			fnc_usec_damageHandler = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\fn_damageHandler.sqf';
			player_death = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_death.sqf";
			player allowDamage true;
			player removeAllEventHandlers 'HandleDamage';
			player addeventhandler ['HandleDamage',{_this call fnc_usec_damageHandler;} ];
			
			_sl = format['%1 G_o_d OFF',name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		};
	};
	adminNoBuildLimit =
	{
		_log = '';
		if(isNil 'anbl')then{anbl = true;} else {anbl = !anbl};
		if(anbl)then
		{
			if(isNil 'oDZE_BuildingLimit')then{oDZE_BuildingLimit = DZE_BuildingLimit;};
			DZE_BuildingLimit = 9999999;
			
			_log = 'No Build Limit - ON';
		}
		else
		{
			DZE_BuildingLimit = oDZE_BuildingLimit;
			
			_log = 'No Build Limit - OFF';
		};
		hint _log;
		cutText [_log, 'PLAIN'];
		_sl = format['%1 - %2',name player,_log];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	adminob =
	{
		_log = '';
		_fnc_NOB =
		{
			R3F_TIRED_FNCT_Voile_Noir = {};
			R3F_TIRED_FNCT_DoBlackVanish = {};
		};
		_fnc_OB =
		{
			R3F_TIRED_FNCT_Voile_Noir =
			{
				_level = _this select 0;
				if(_level < R3F_TIRED_SHORTNESS_THRESHOLD )then
				{
					playSound 'heartbeat_1';
					addCamShake [2, 1, 25];
				};
			};
			R3F_TIRED_FNCT_DoBlackVanish =
			{
				[player,0.1] call fnc_usec_damageUnconscious;
				[player,'scream',3,false] call dayz_zombieSpeak;
				cutText ['You are overburdened.', 'PLAIN DOWN'];
			};
		};
		if(isNil 'anob')then{anob = true;} else {anob = !anob};
		if(anob)then
		{
			_log = 'No OverBurdened - ON';
			call _fnc_NOB;
		}
		else
		{
			_log = 'No OverBurdened - OFF';
			call _fnc_OB;
		};
		hint _log;
		cutText [_log, 'PLAIN'];
		_sl = format['%1 - %2',name player,_log];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
		while{anob}do
		{
			if(str R3F_TIRED_FNCT_Voile_Noir != '{}')then
			{
				call _fnc_NOB;
			}
			else
			{
				if(anob)then{uiSleep 3;} else {call _fnc_OB;};
			};
		};
		call _fnc_OB;
	};
	admin1build =
	{
		_log = '';
		if(isNil 'a1sb')then{a1sb = true;} else {a1sb = !a1sb};
		if(a1sb)then
		{
			DZE_StaticConstructionCount = 1;
			systemChat format['DZE_StaticConstructionCount changed to: %1',DZE_StaticConstructionCount];
			
			_log = '1 Step Building - ON';
		}
		else
		{
			DZE_StaticConstructionCount = 0;
			systemChat 'DZE_StaticConstructionCount changed to default';
			
			_log = '1 Step Building - OFF';
		};
		hint _log;
		cutText [_log, 'PLAIN'];
		_sl = format['%1 - %2',name player,_log];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	admin_noplot =
	{
		_log = '';
		if(isNil 'anppn')then{anppn = true;} else {anppn = !anppn};
		if(anppn)then
		{
			DZ_ANPP = DZE_PlotPole;
			DZE_PlotPole = [1,1];
			DZE_requireplot = 0;
			_log = 'No PlotPole - ON';
		}
		else
		{
			DZE_PlotPole = DZ_ANPP;
			DZE_requireplot = 1;
			
			_log = 'No PlotPole - OFF';
		};
		hint _log;
		cutText [_log, 'PLAIN'];
		_sl = format['%1 - %2',name player,_log];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	changeHumanity =
	{
		disableSerialization;
		_plr = objNull;	
		{if(name _x == _this select 0)exitWith {_plr = _x;};} forEach playableUnits;
		if(isNull _plr)exitWith {
			systemchat 'Select a Player!';
		};
		if(isNull findDisplay 24)exitWith {
			systemchat 'open the chat, type the Amount of Humanity you want to add (can be negative) and doubleClick again!';
		};
		_chat = (findDisplay 24) displayCtrl 101;
		_txt = ctrlText _chat;
		_num = 0;
		if(_txt != '')then{
			_num = parseNumber _txt;
			if(typeName _num != 'SCALAR')then{systemchat 'INSERT A NUMBER!';};
			(findDisplay 24) closeDisplay 0;
		};
		
		_humanity = _plr getVariable['humanity',0];
		_plr setVariable['humanity',_humanity+_num,true];
		hint format['Gave %1 %2 Humanity!',_this select 0,_num];
		
		_sl = format['%1 %2 Humanity to %3',name player,_num,_this select 0];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	adminHumanityPlus =
	{
		{
			if(name _x == _this select 0)then
			{
				_humanity = _x getVariable['humanity',0];
				_x setVariable['humanity',_humanity+2500,true];
				hint format['Gave %1 +2500 Humanity!',_this select 0];
				
				_sl = format['%1 plus 2500 Humanity to %2',name player,_this select 0];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	adminHumanityMinus =
	{
		{
			if(name _x == _this select 0)then
			{
				_humanity = _x getVariable['humanity',0];
				_x setVariable['humanity',_humanity-2500,true];
				hint format['Gave %1 -2500 Humanity!',_this select 0];
				
				_sl = format['%1 minus 2500 Humanity to %2',name player,_this select 0];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	adminCloneTarget =
	{
		_name = _this select 0;
		
		if (_name == (name player)) exitWith
		{
			hint 'You cannot clone yourself!';
			cutText ['You cannot clone yourself!', 'PLAIN'];
		};

		{
			if((!isNull _x) && {getPlayerUID _x != ''} && {name _x == _name})then
			{
				_weapons = weapons _x;
				_magazines = magazines _x;
				removeAllWeapons player;
				removeAllItems player;
				{player addWeapon _x;} forEach _weapons;
				{player addMagazine _x;} forEach _magazines;
				
				_xbag = unitBackpack _x;
				removebackpack player;
				if(!isNull _xbag)then
				{
					player addBackPack (typeOf _xbag);
					_BW = getWeaponCargo _xbag;
					_BM = getMagazineCargo _xbag;
					pbag = unitBackpack player;
					{pbag addWeaponCargoGlobal [_x,(_BW select 1)select _forEachIndex];} forEach (_BW select 0);
					{pbag addMagazineCargoGlobal [_x,(_BM select 1)select _forEachIndex];} forEach (_BM select 0);
				};
				
				[dayz_playerUID,dayz_characterID,typeOf _x] spawn player_humanityMorph;
				
				hint format['Cloned %1',_name];
				_sl = format['%1 Cloned %2',name player,_name];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	adminfixfps =
	{
		fnc_fix_now =
		{
			systemChat format['infiSTAR.de CLEANUP: cleaning ReammoBoxes - start time: %1 - fps: %2',time,diag_fps];
			_ammobox = ['USLaunchersBox','RULaunchersBox','USSpecialWeapons_EP1','USVehicleBox'];
			_lootpiles =  allMissionObjects 'ReammoBox';
			_deleted = 0;
			{
				if(!isNull _x)then
				{
					_obj = _x;
					_keep = (_obj getvariable['permaLoot',false]) || (typeOf _obj in _ammobox);
					if(!_keep)then
					{
						_nearby = {isPlayer _x} count (_obj nearEntities 100);
						if(_nearby==0)then
						{
							_deleted = _deleted + 1;deleteVehicle _obj;
						};
					};
				};
			} forEach _lootpiles;
			systemChat format['infiSTAR.de CLEANUP: cleaning ReammoBoxes - end time: %1 - fps: %2 - deleted: %3',time,diag_fps,_deleted];
			
			systemChat format['infiSTAR.de CLEANUP: cleaning Weaponholder - start time: %1 - fps: %2',time,diag_fps];
			_allstartlk = ((allMissionObjects 'WeaponHolder')+(allMissionObjects 'Sound_Flies')+(allDead)+([0,0,0] nearEntities ['CAAnimalBase', 10000000]));
			_deleted = 0;
			{
				if(!isNull _x)then
				{
					_obj = _x;
					if(_obj in vehicles)then{_deleted = _deleted + 1;deletevehicle _obj;};
					if(!isNull _obj)then
					{
						_nearbylk1 = {isPlayer _x} count (_obj nearEntities 250);
						_keeplk = _obj getvariable['permaLoot',false];
						if((_nearbylk1 == 0) && (!_keeplk) && !(_obj in alldead))then
						{
							_deleted = _deleted + 1;deleteVehicle _obj;
						};
						if(!isNull _obj)then
						{
							_nearbylk2 = {isPlayer _x} count (_obj nearEntities 25);
							if((_nearbylk2 == 0) && (_obj in alldead) && (_obj isKindOf 'zZombie_Base'))then
							{
								_deleted = _deleted + 1;deleteVehicle _obj;
							};
							if(!isNull _obj)then
							{
								if((_nearbylk2 == 0) && (_obj isKindOf 'CAAnimalBase'))then{_deleted = _deleted + 1;deleteVehicle _obj;};
							};
						};
					};
				};
			} foreach _allstartlk;
			systemChat format['infiSTAR.de CLEANUP: cleaning Weaponholder - end time: %1 - fps: %2 - deleted: %3',time,diag_fps,_deleted];
			
			systemChat format['infiSTAR.de CLEANUP: cleaning Bikes - start time: %1 - fps: %2',time,diag_fps];
			_bikes = entities 'MMT_Civ';
			_deleted = 0;
			{
				_obj = _x;
				if(!isNull _obj)then
				{
					_count = {isPlayer _x} count (_obj nearEntities 100);
					if(_count == 0)then
					{
						_deleted = _deleted + 1;deleteVehicle _obj;
					};
				};
			} forEach _bikes;
			systemChat format['infiSTAR.de CLEANUP: cleaning Bikes - end time: %1 - fps: %2 - deleted: %3',time,diag_fps,_deleted];
			
			systemChat format['infiSTAR.de CLEANUP: cleaning Graves - start time: %1 - fps: %2',time,diag_fps];
			_graves = allMissionObjects 'GraveDZE';
			_deleted = 0;
			{
				_obj = _x;
				if(!isNull _obj)then
				{
					_count = {isPlayer _x} count (_obj nearEntities 100);
					if(_count == 0)then
					{
						_deleted = _deleted + 1;deleteVehicle _obj;
					};
				};
			} forEach _graves;
			systemChat format['infiSTAR.de CLEANUP: cleaning Graves - end time: %1 - fps: %2 - deleted: %3',time,diag_fps,_deleted];
			
			systemChat format['infiSTAR.de CLEANUP: cleaning Zombies - start time: %1 - fps: %2',time,diag_fps];
			_zeds = entities 'zZombie_Base';
			_deleted = 0;
			{
				_obj = _x;
				if(!isNull _obj)then
				{
					_count = {isPlayer _x} count (_obj nearEntities 250);
					if(_count == 0)then
					{
						_deleted = _deleted + 1;deleteVehicle _obj;
					};
				};
			} forEach _zeds;
			systemChat format['infiSTAR.de CLEANUP: cleaning Zombies - end time: %1 - fps: %2 - deleted: %3',time,diag_fps,_deleted];
			
			systemChat format['infiSTAR.de CLEANUP: cleaning Seagulls - start time: %1 - fps: %2',time,diag_fps];
			_deleted = 0;
			{
				if(!isNull _x)then
				{
					_x enableSimulation false;
					deleteGroup (group _x);
					_deleted = _deleted + 1;deleteVehicle _x;
				};
			} forEach entities 'Seagull';
			systemChat format['infiSTAR.de CLEANUP: cleaning Seagulls - end time: %1 - fps: %2 - deleted: %3',time,diag_fps,_deleted];
		};
		[] spawn fnc_fix_now;
		
		_log = 'Fixing FPS';
		hint _log;
		cutText [_log,'PLAIN'];
		_sl = format['%1 - %2',name player,_log];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	adminCarGod =
	{
		if(isNil "adminCarGodToggle")then{adminCarGodToggle = 0;};
		if(adminCarGodToggle == 0)then
		{
			adminCarGodToggle = 1;
			hint "CarGod - ON (fast loop that sets damage to 0)";
			while{adminCarGodToggle==1}do
			{
				_veh = vehicle player;
				if(_veh != player)then
				{
					_veh setDamage 0;
					_veh setFuel 1;
				};
				uiSleep 0.1;
			};
		}
		else
		{
			adminCarGodToggle = 0;
			hint "CarGod - OFF";
		};
		
		_sl = format["%1 adminCarGod %2",name player,adminCarGodToggle];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	admininvis =
	{
		if(isNil 'inv1')then{inv1 = 0;};
		if(inv1 == 0)then
		{
			PVAH_AdminReq = [3,player,true];
			publicVariableServer "PVAH_AdminReq";
			
			inv1 = 1;
			hint "Invisibility Activated";
			
			_sl = format["%1 Invisibility Activated",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		}
		else
		{
			PVAH_AdminReq = [3,player,false];
			publicVariableServer "PVAH_AdminReq";
			
			inv1 = 0;
			hint "Invisibility Disabled";
			
			_sl = format["%1 Invisibility Disabled",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		};
	};
	admin_debug =
	{
		debugMonitorX = false;
		if(isNil "admin_debug_run")then{admin_debug_run = true;} else {admin_debug_run = !admin_debug_run;};
		while{admin_debug_run}do 
		{
			_pic = (getText (configFile >> 'CfgVehicles' >> (typeOf vehicle player) >> 'picture'));
			if(player == vehicle player)then{_pic = (getText (configFile >> 'CfgWeapons' >> (currentWeapon player) >> 'picture'));
			}else{_pic = (getText (configFile >> 'CfgVehicles' >> (typeOf vehicle player) >> 'picture'));};
			
			_txt = '';
			_txt = (getText (configFile >> 'CfgVehicles' >> (typeOf vehicle player) >> 'displayName'));
			private['_stime','_hours','_minutes','_minutes2'];
			_stime = 0;
			if(serverTime > 36000)then{_stime = time;}else{_stime = serverTime;};
			_hours = (_stime/60/60);
			_hours = toArray (str _hours);
			_hours resize 1;
			_hours = toString _hours;
			_hours = compile _hours;
			_hours = call  _hours;
			_minutes = floor(_stime/60);
			_minutes2 = ((_minutes - (_hours*60)) min 60) max 0;if(_minutes2 < 10)then{_minutes2 = format['0%1',_minutes2];};
			_pos = getPosATL player;
			
			_humanity = player getVariable['humanity',0];
			if(_humanity > 999999)then
			{
				_humanity = [_humanity] call fnc_format_humanity;
				_humanity = toArray _humanity;
				_humanity = _humanity - [44];
				_humanity = toString _humanity;
			};
			
			hintSilent parseText format["
			<t size='1' font='Bitstream' align='Center' >[%1]</t><br/>
			<img size='4.75' image='%4'/><br/>
			<t size='1' font='Bitstream' align='left' color='#CC0000'>Blood: </t><t size='1' font='Bitstream' align='right'>%2</t><br/>
			<t size='1' font='Bitstream' align='left' color='#0066CC'>Humanity: </t><t size='1' font='Bitstream' align='right'>%3</t><br/>
			<br/>
			<t size='1' font='Bitstream' align='left' color='#FFBF00'>Zombie Kills: </t><t size='1' font='Bitstream' align='right'>%9</t><br/>
			<t size='1' font='Bitstream' align='left' color='#FFBF00'>Murders: </t><t size='1' font='Bitstream' align='right'>%10</t><br/>
			<t size='1' font='Bitstream' align='left' color='#FFBF00'>Bandits Killed: </t><t size='1' font='Bitstream' align='right'>%11</t><br/>
			<br/>
			<t size='1' font='Bitstream' align='left' color='#FFBF00'>UPTIME: </t><t size='1' font='Bitstream' align='right'>%5h %6min</t><br/>
			<t size='1' font='Bitstream' align='left' color='#FFBF00'>FPS: </t><t size='1' font='Bitstream' align='right'>%8</t><br/>
			<t size='1' font='Bitstream' align='Center' color='#CC0000'>infiSTAR.de AdminDebug</t><br/>
			<t size='1'font='Bitstream'align='left' color='#0066CC'>Vehicles:</t><t size='1'font='Bitstream'align='right'>%15(%16)</t><br/>
			<t size='1'font='Bitstream'align='left' color='#0066CC'>Player in 500m:</t><t size='1'font='Bitstream'align='right'>%13</t><br/>
			<t size='1'font='Bitstream'align='left' color='#0066CC'>Viewdistance:</t><t size='1'font='Bitstream'align='right'>%14</t>
			<br/>
			<t size='1'font='Bitstream'align='left' color='#0066CC'>Direction:</t><t size='1'font='Bitstream'align='right'>%19</t><br/>
			<t size='1'font='Bitstream'align='left' color='#0066CC'>@</t><t size='1'font='Bitstream'align='right'>%17</t><br/>
			<t size='1'font='Bitstream'align='left' color='#0066CC'>Position:</t>
			<t size='1'font='Bitstream'>%18</t>
			",
			_txt,
			(r_player_blood),
			_humanity,
			_pic,
			_hours,
			_minutes2,
			'',
			(round diag_fps),
			(player getVariable['zombieKills', 0]),
			(player getVariable['humanKills', 0]),
			(player getVariable['banditKills', 0]),
			(count playableUnits),
			({isPlayer _x} count ((vehicle player) nearEntities ['AllVehicles', 500]))-1,
			viewdistance,
			{alive _x} count ([0,0,0] nearEntities [['LandVehicle','Air','Ship'], 10000000]),
			count vehicles,
			mapGridPosition _pos,
			_pos,
			getDir (vehicle player)
			];
			uiSleep 1;
		};
		if(!admin_debug_run)then{hintSilent parseText format["<t size='1'font='TahomaB'align='center'>DEBUG OFF</t>"];};
	};
	admin_animate1 =
	{
		{player reveal _x;} forEach (player nearObjects ['All',25]);
		_ct = cursorTarget;
		if((!isNull _ct) && (_ct distance player < 15))then
		{
			if((_ct isKindOf "AllVehicles") && !(_ct isKindOf "Man"))then
			{
				if(locked _ct)then
				{
					[nil,nil,nil,[_ct,"[infiSTAR.de ADMIN-TOOL]"]] execVM "\z\addons\dayz_code\actions\unlock_veh.sqf";
				}
				else
				{
					cutText ["Vehicle is already open.", "PLAIN"];
				};
			};
			{_ct animate [_x,1];} forEach ["Open_hinge","Open_latch","Lights_1","Lights_2","Open_door","DoorR","LeftShutter","RightShutter"];
			_type = typeOf _ct;
			_alreadyPacking = _ct getVariable["packing",0];
			if((_type in DZE_LockedStorage) && (_alreadyPacking == 0))then
			{
				dayz_combination = _ct getVariable["CharacterID","0"];
				_ct spawn player_unlockVault;
			};
		};
	};
	admin_animate2 =
	{
		{player reveal _x;} forEach (player nearObjects ['All',25]);
		_ct = cursorTarget;
		if((!isNull _ct) && (_ct distance player < 15))then
		{
			if((_ct isKindOf "AllVehicles") && !(_ct isKindOf "Man"))then
			{
				if(locked _ct)then
				{
					cutText ["Vehicle is already locked.", "PLAIN"];
				}
				else
				{
					[nil,nil,nil,_ct] execVM "\z\addons\dayz_code\actions\lock_veh.sqf";
					cutText ["[infiSTAR.de ADMIN-TOOL] used to lock vehicle.", "PLAIN"];
				};
			};
			{_ct animate [_x,0];} forEach ["Open_hinge","Open_latch","Lights_1","Lights_2","Open_door","DoorR","LeftShutter","RightShutter"];
			_type = typeOf _ct;
			_alreadyPacking = _ct getVariable["packing",0];
			if((_type in DZE_UnLockedStorage) && (_alreadyPacking == 0))then
			{
				dayz_combination = _ct getVariable["CharacterID","0"];
				_ct spawn player_lockVault;
			};
		};
	};
	admin_generatekey =
	{
		private ["_ct","_id","_result","_inventory","_backpack"];
		_ct = cursorTarget;
		if(!isNull _ct)then{
			if(_ct distance player > 12)exitWith {cutText [format["%1 is to far away.",typeOf _ct], "PLAIN"];};
			if !((_ct isKindOf "LandVehicle") || (_ct isKindOf "Air") || (_ct isKindOf "Ship"))exitWith {cutText [format["%1 is not a vehicle..",typeOf _ct], "PLAIN"];};
			
			_id = _ct getVariable["CharacterID","0"];
			_id = parsenumber _id;
			if(_id == 0)exitWith {cutText [format["%1 has ID 0 - No Key possible.",typeOf _ct], "PLAIN"];};
			if((_id > 0) && (_id <= 2500))then{_result = format["ItemKeyGreen%1",_id];};
			if((_id > 2500) && (_id <= 5000))then{_result = format["ItemKeyRed%1",_id-2500];};
			if((_id > 5000) && (_id <= 7500))then{_result = format["ItemKeyBlue%1",_id-5000];};
			if((_id > 7500) && (_id <= 10000))then{_result = format["ItemKeyYellow%1",_id-7500];};
			if((_id > 10000) && (_id <= 12500))then{_result = format["ItemKeyBlack%1",_id-10000];};
			
			_inventory = (weapons player);
			_backpack = ((getWeaponCargo unitBackpack player) select 0);
			if(_result in (_inventory+_backpack))then
			{
				if(_result in _inventory)then{cutText [format["Key [%1] already in your inventory!",_result], "PLAIN"];};
				if(_result in _backpack)then{cutText [format["Key [%1] already in your backpack!",_result], "PLAIN"];};
			}
			else
			{
				player addweapon _result;
				cutText [format["Key [%1] added to your inventory!",_result], "PLAIN"];
				
				_pos = getPos _ct;
				_sl = format["%1 generated Key %2 for %3 (CharID %4) @%5",name player,_result,typeOf _ct,_id,mapGridPosition _pos];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		};
	};
	admin_showid =
	{
		_obj = cursortarget;
		if(!isNull _obj)then
		{
			_charID = _obj getVariable['CharacterID','0'];
			_objID = _obj getVariable['ObjectID','0'];
			_objUID = _obj getVariable['ObjectUID','0'];
			_lastUpdate = _obj getVariable['lastUpdate',time];
			_pos = getPosATL _obj;
			_log1 = format['%1, WorldSpace: [%2,%3], @%4',typeOf _obj,getDir _obj,_pos,mapGridPosition _pos];
			_log2 = format['charID: %1, objID: %2, objUID: %3, lastUpdate: %4s ago',_charID,_objID,_objUID,time - _lastUpdate];
			if(isPlayer _obj)then
			{
				_log2 = format['Name: %1  PlayerUID: %2  charID: %3',_obj getVariable['bodyName',name _obj],getPlayerUID _obj,_charID];
			};
			if(!isNil 'DZE_DoorsLocked' && !isNil 'DZE_LockedStorage')then
			{
				_objType = typeOf _obj;
				if(_objType in DZE_DoorsLocked || _objType in DZE_LockedStorage)then
				{
					_log2 = format['LockCode: %1, objID: %2, objUID: %3, lastUpdate: %4s ago',_charID,_objID,_objUID,time - _lastUpdate];
				}
				else
				{
					_vID = parseNumber _charID;
					if(((_obj isKindOf 'LandVehicle') || (_obj isKindOf 'Air') || (_obj isKindOf 'Ship')) && (_vID > 0))then
					{
						_colors = ['Green', 'Red', 'Blue', 'Yellow', 'Black'];
						_key = format['ItemKey%1%2', _colors select floor(_vID / 2500), (_vID - (floor(_vID / 2500) * 2500))];
						_displayName = (getText (configFile >> 'CfgWeapons' >> _key >> 'displayName'));
						
						_log2 = format['Key: %1 (%2) - CharID: %3, objID: %4, objUID: %5',_key,_displayName,_charID,_objID,_objUID];
					};
				};
			};
			{systemChat _x;diag_log _x;} forEach [_log1,_log2];
		};
	};
	fnc_admin_fly =
	{
		forwardAndBackward_d = 4;
		leftAndRight_d = 4;
		upAndDown_d = 3;
		d_FromGround = 1;
		HoverState = nil;
		fnc_move_forward =
		{
			if((getPosATL (vehicle player) select 2) > d_FromGround)then
			{
				_forwardCurrentDirection = getdir (vehicle player);
				_forwardCurrentPosition = getPosATL (vehicle player);
				(vehicle player) setdir _forwardCurrentDirection;
				(vehicle player) setPosATL [(_forwardCurrentPosition select 0) + forwardAndBackward_d * sin(_forwardCurrentDirection),(_forwardCurrentPosition select 1) + forwardAndBackward_d * cos(_forwardCurrentDirection),(_forwardCurrentPosition select 2)];
			};
		};
		fnc_move_left =
		{
			if((getPosATL (vehicle player) select 2) > d_FromGround)then
			{
				_leftDirection = getdir (vehicle player);
				(vehicle player) setdir (_leftDirection) - leftAndRight_d;
			};
		};
		fnc_move_backward =
		{
			if((getPosATL (vehicle player) select 2) > d_FromGround)then
			{
				_backwardCurrentDirection = getdir (vehicle player);
				_backwardCurrentPosition = getPosATL (vehicle player);
				(vehicle player) setdir _backwardCurrentDirection;
				(vehicle player) setPosATL [(_backwardCurrentPosition select 0) - forwardAndBackward_d * sin(_backwardCurrentDirection),(_backwardCurrentPosition select 1) - forwardAndBackward_d * cos(_backwardCurrentDirection),(_backwardCurrentPosition select 2)];
			};
		};
		fnc_move_right =
		{
			if((getPosATL (vehicle player) select 2) > d_FromGround)then
			{
				_rightDirection = getdir (vehicle player);
				(vehicle player) setdir (_rightDirection) + leftAndRight_d;
			};
		};
		fnc_move_up =
		{
			_upCurrentDirection = getdir (vehicle player);
			_upCurrentPosition = getPosATL (vehicle player);
			(vehicle player) setdir _upCurrentDirection;
			(vehicle player) setPosATL [(_upCurrentPosition select 0), (_upCurrentPosition select 1), (_upCurrentPosition select 2) + upAndDown_d];
		};
		fnc_move_down =
		{
			if((getPosATL (vehicle player) select 2) > d_FromGround)then
			{
				_downCurrentDirection = getdir (vehicle player);
				_downCurrentPosition = getPosATL (vehicle player);
				(vehicle player) setdir _downCurrentDirection;
				(vehicle player) setPosATL [(_downCurrentPosition select 0), (_downCurrentPosition select 1), (_downCurrentPosition select 2) - upAndDown_d];
			};
		};
		fnc_Hover =
		{
			if(isnil 'HoverState')then
			{
				HoverState = true;
				cutText ['Now Hovering','PLAIN DOWN'];
				[] spawn {
					_pos = getPosATL (vehicle player);
					while{!isNil 'HoverState'}do
					{
						(vehicle player) SetVelocity [0,0,1];
						(vehicle player) setPosATL _pos;
					};
				};
			}
			else
			{
				HoverState = nil;
				cutText ['No longer Hovering','PLAIN DOWN'];
			};
		};
		if(isnil 'FlyOnTheWingsOfLove')then 
		{
			cutText ['Fly On','PLAIN DOWN'];
			
			systemchat 'Admin Fly Keybinds:';
			systemchat '   Q up Z/Y down | WASD to Move around | H to Hover';
			
			FlyOnTheWingsOfLove = true;
			fly_keyForward = (findDisplay 46) displayAddEventHandler ['KeyDown','if((_this select 1) == 17)then{call fnc_move_forward;};false'];
			fly_keyLeft = (findDisplay 46) displayAddEventHandler ['KeyDown','if((_this select 1) == 30)then{call fnc_move_left;};false'];
			fly_keyBackward = (findDisplay 46) displayAddEventHandler ['KeyDown','if((_this select 1) == 31)then{call fnc_move_backward;};false'];
			fly_keyRight = (findDisplay 46) displayAddEventHandler ['KeyDown','if((_this select 1) == 32)then{call fnc_move_right;};false'];
			fly_keyUp = (findDisplay 46) displayAddEventHandler ['KeyDown','if((_this select 1) == 16)then{call fnc_move_up;};false'];
			fly_keyDown = (findDisplay 46) displayAddEventHandler ['KeyDown','if((_this select 1) in [44,21])then{call fnc_move_down;};false'];
			fly_keyHover = (findDisplay 46) displayAddEventHandler ['KeyDown','if((_this select 1) == 35)then{call fnc_Hover;};false'];
		}
		else
		{
			cutText ['Fly OFF','PLAIN DOWN'];
			FlyOnTheWingsOfLove = nil;
			(findDisplay 46) displayRemoveEventHandler ['KeyDown', fly_keyForward];
			(findDisplay 46) displayRemoveEventHandler ['KeyDown', fly_keyLeft];
			(findDisplay 46) displayRemoveEventHandler ['KeyDown', fly_keyBackward];
			(findDisplay 46) displayRemoveEventHandler ['KeyDown', fly_keyRight];
			(findDisplay 46) displayRemoveEventHandler ['KeyDown', fly_keyUp];
			(findDisplay 46) displayRemoveEventHandler ['KeyDown', fly_keyDown];
			(findDisplay 46) displayRemoveEventHandler ['KeyDown', fly_keyHover];
		};
	};
	admin_fly_up =
	{
		if(isNil "admin_tpdirection_0n")exitWith {};
		if(!admin_tpdirection_0n)exitWith {};
		_vehicle = (vehicle player);
		_vel = velocity _vehicle;
		if((vehicle player)==player)then
		{
			_vehicle setVelocity [(_vel select 0),(_vel select 1),8];
		}
		else
		{
			_vehicle setVelocity [(_vel select 0),(_vel select 1),20];
		};
	};
	admin_tpdirection_on =
	{
		if(isNil "admin_tpdirection_0n")then{admin_tpdirection_0n = true;} else {admin_tpdirection_0n = !admin_tpdirection_0n;};
		uiSleep 0.1;
		if(admin_tpdirection_0n)then 
		{
			hint "TP infront of you ON";
			cutText ["TP infront of you ON", "PLAIN DOWN"];
			
			_sl = format["%1 TP infront of you ON",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		}
		else
		{
			hint "TP infront of you OFF";
			cutText ["TP infront of you OFF", "PLAIN DOWN"];
			
			_sl = format["%1 TP infront of you OFF",name player];
			PVAH_WriteLogReq = [player,toArray _sl];
			publicVariableServer 'PVAH_WriteLogReq';
		};
	};
	admin_tpdirection = 
	{
		if(isNil "admin_tpdirection_0n")exitWith {};
		if(!admin_tpdirection_0n)exitWith {};
		
		_distance = 10;
		_object = (vehicle player);
		_dir = getdir _object;
		_pos = getPosATL _object;
		if(_object isKindOf "Air")then
		{
			if(count(crew _object)>1)then 
			{ 
				_distance = 10;
				_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),((getpos _object) select 2)+100];
				if(surfaceIsWater _pos)then{_object setPosASL _pos;} else {_object setPosATL _pos;};
			} 
			else
			{
				_distance = 50;
				_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),0];
				if(surfaceIsWater _pos)then{_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),2];};
				if((getpos _object) select 2 > 6)then{_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),((getpos _object) select 2)+0.1]};
				if(surfaceIsWater _pos)then{_object setPosASL _pos;} else {_object setPosATL _pos;};
			};
		}
		else
		{
			_distance = 10;
			_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),0];
			if(surfaceIsWater _pos)then{_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),2];};
			if((getpos _object) select 2 > 3)then{_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),((getpos _object) select 2)];};
			if(surfaceIsWater _pos)then{_object setPosASL _pos;} else {_object setPosATL _pos;};
		};
		{player reveal _x;} forEach (player nearObjects ['All',25]);
	};
	adminaltteleport =
	{
		if(isNil "adminaltteleport_toggle")then{adminaltteleport_toggle = true;} else {adminaltteleport_toggle = !adminaltteleport_toggle;};
		if(adminaltteleport_toggle)then 
		{
			if !(('ItemGPS' in items player) || ('ItemMap' in items player))then
			{
				_config = ["ItemGPS"];
				_isOK = [player,_config] call BIS_fnc_invAdd;
			};
			((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["MouseButtonDown", "if(((_this select 1) == 0) && altstate_Admin)then
			{
				_pos = ((_this select 0) posScreenToWorld [_this select 2, _this select 3]);
				PVAH_AdminReq = [1,player,player,_pos];publicVariableServer 'PVAH_AdminReq';
				openMap [false, false];
				{player reveal _x;} forEach (player nearObjects ['All',25]);
				_sl = format['Admin %1(%2) teleported to   GPS: %3   WorldSpace: %4',name player,getPlayerUID player,mapGridPosition _pos,_pos];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};"];
			hint "ALT TELEPORT ACTIVATED";
			cutText ["ALT TELEPORT ACTIVATED", "PLAIN"];
		}
		else
		{
			((findDisplay 12) displayCtrl 51) ctrlRemoveAllEventHandlers "MouseButtonDown";
			hint "ALT TELEPORT DISABLED";
			cutText ["ALT TELEPORT DISABLED", "PLAIN"];
		};
	};
	adminbreakleg =
	{
		{
			if(name _x == _this select 0)then
			{
				PVAH_AdminReq = [2,player,_x];
				publicVariableServer "PVAH_AdminReq";
				hint format["Breaking %1's legs", _this select 0];
				
				_sl = format["%1 Break Legs %2",name player,_this select 0];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	admin_show = {
		closeDialog 0;
		if(!isNil 'VARIABLE_ADMIN_TARGET_OBJ')then
		{
			if(!isNull VARIABLE_ADMIN_TARGET_OBJ)then
			{
				createGearDialog [VARIABLE_ADMIN_TARGET_OBJ,'RscDisplayGear'];
				cutText [format['Showing Gear of %1',VARIABLE_ADMIN_TARGET_NAME], 'PLAIN DOWN'];
			};
		};
	};
	fnc_getConfig = {
		_cfg = '';
		if(isClass (configFile >> 'CfgWeapons' >> _this))then
		{
			_cfg = 'CfgWeapons';
		}
		else
		{
			if(isClass (configFile >> 'CfgMagazines' >> _this))then
			{
				_cfg = 'CfgMagazines';
			}
			else
			{
				if(isClass (configFile >> 'CfgVehicles' >> _this))then
				{
					_cfg = 'CfgVehicles';
				};
			};
		};
		_cfg
	};
	remove_spec_000 = {
		(vehicle player) switchCamera cameraView;
		for '_i' from 3025 to 3045 do {['',0,0,1,0,0,_i] spawn bis_fnc_dynamicText;};
		if(!isNil 'SpecateLoopActive')then
		{
			[] spawn remove_spec_000;
			SpecateLoopActive = nil;
			cutText ['Finished spectating.', 'PLAIN DOWN'];
		};
	};
	adminspec = {
		cutText ['Spectating - Press F10 to exit. F9 to show Gear!', 'PLAIN DOWN'];
		if(isNil 'SpecateLoopActive')then
		{
			SpecateLoopActive = true;
			while{!isNil 'SpecateLoopActive'}do
			{
				uiSleep 0.2;
				
				if(isNil 'VARIABLE_ADMIN_TARGET_UID')exitWith {};
				_unit = objNull;
				{
					if(getPlayerUID _x == VARIABLE_ADMIN_TARGET_UID)exitWith
					{
						_unit = _x;
					};
				} forEach playableUnits;
				if(isNull _unit)then{_unit = player;};
				if(str(_unit) == '<NULL-object>')then{_unit = player;};
				if(getPlayerUID _unit == '')then{_unit = player;};
				
				
				_veh = vehicle _unit;
				if(str _veh != str cameraOn)then{_veh switchCamera cameraView;for '_i' from 3025 to 3045 do {['',0,0,1,0,0,_i] spawn bis_fnc_dynamicText;};};
				
				
				_log = format['%1 (%2) @%3 SPD %4',name _unit,getPlayerUID _unit,mapGridPosition _veh,abs(speed _veh)];
				['<t align=''left'' size=''0.5'' color=''#238701''>'+_log+'</t>',safezoneX+0.2,safezoneY+0.405,0.3,0,0,3033] spawn bis_fnc_dynamicText;
				
				_log2 = format['Blood: %1  Humanity: %2',(_unit getVariable['USEC_BloodQty',12000]),(_unit getVariable['humanity',0])];
				['<t align=''left'' size=''0.5'' color=''#238701''>'+_log2+'</t>',safezoneX+0.2,safezoneY+0.435,0.3,0,0,3034] spawn bis_fnc_dynamicText;
				
				_cwep = '';
				_cammo = '';
				_cmags = '';
				_wpnstate = weaponState _unit;
				if(!isNil '_wpnstate')then
				{
					if(str _wpnstate != '[]')then
					{
						_cwep = _wpnstate select 0;
						_cmags = {_wpnstate select 3 == _x} count magazines _unit;
						_cammo = _wpnstate select 4;
					};
				};
				if(_cwep == '')then
				{
					_log3 = 'Bare Fists';
					['<t align=''left'' size=''0.5'' color=''#238701''>'+_log3+'</t>',safezoneX+0.2,safezoneY+0.465,0.3,0,0,3035] spawn bis_fnc_dynamicText;
				}
				else
				{
					_type = _cwep;
					_cfg = _type call fnc_getConfig;
					_displayName = getText (configFile >> _cfg >> _type >> 'displayName');
					_pic = getText (configFile >> _cfg >> _type >> 'picture');
					
					_log3 = format[' %1 [%2] (%3/%4)',_displayName,_cwep,_cammo,_cmags];
					['
					<img size=''0.75'' image='''+_pic+''' align=''left''/>
					<t align=''left'' size=''0.5'' color=''#238701''>'+_log3+'</t>
					',
					safezoneX+0.2,safezoneY+0.465,0.3,0,0,3035] spawn bis_fnc_dynamicText;
					
					if(_veh != _unit)then
					{
						_cwepsV = weapons _veh;
						_cwepsV = _cwepsV - ['CarHorn'];
						_cwepsV = _cwepsV - ['MiniCarHorn'];
						_cwepsV = _cwepsV - ['SportCarHorn'];
						_cwepsV = _cwepsV - ['TruckHorn'];
						if(count _cwepsV > 0)then
						{
							_id = 3032;
							_YPOS = safezoneY+0.355;
							
							{
								_cwep = _x;
								_cammo = _veh ammo _cwep;
								_cmags = {currentMagazine _veh == _x} count magazines _veh;
								
								_type = _cwep;
								_cfg = _type call fnc_getConfig;
								_displayName = getText (configFile >> _cfg >> _type >> 'displayName');
								
								_log3a = format[' %1 [%2] (%3/%4)',_displayName,_cwep,_cammo,_cmags];
								['<t align=''left'' size=''0.5'' color=''#A90F68''>'+_log3a+'</t>',safezoneX+0.2,_YPOS,0.3,0,0,_id] spawn bis_fnc_dynamicText;
								
								_id = _id - 1;
								_YPOS = _YPOS - 0.03;
							} forEach _cwepsV;
						};
					};
				};
				
				
				_ct = cursorTarget;
				if(!isNull _ct)then
				{
					if(getPlayerUID _ct != '')then
					{
						_cwep_ct = currentWeapon _ct;
						_cammo_ct = _ct ammo _cwep_ct;
						_cmags_ct = {currentMagazine _ct == _x} count magazines _ct;
						
						_log4 = format['%1 (%2) @%3 SPD %4',name _ct,getPlayerUID _ct,mapGridPosition _ct,abs(speed _ct)];
						['<t align=''left'' size=''0.5'' color=''#B80B36''>'+_log4+'</t>',safezoneX+0.2,safezoneY+0.545,0.3,0,0,3036] spawn bis_fnc_dynamicText;
						
						_log5 = format['Blood: %1  Humanity: %2  Distance: %3m',(_ct getVariable['USEC_BloodQty',12000]),(_ct getVariable['humanity',0]),round(cameraOn distance _ct)];
						['<t align=''left'' size=''0.5'' color=''#B80B36''>'+_log5+'</t>',safezoneX+0.2,safezoneY+0.575,0.3,0,0,3037] spawn bis_fnc_dynamicText;
						
						_type = _cwep_ct;
						_cfg = _type call fnc_getConfig;
						_displayName = getText (configFile >> _cfg >> _type >> 'displayName');
						_pic = getText (configFile >> _cfg >> _type >> 'picture');
						_log6 = format[' %1 [%2] (%3/%4)',_displayName,_cwep_ct,_cammo_ct,_cmags_ct];
						['
						<img size=''0.75'' image='''+_pic+''' align=''left''/>
						<t align=''left'' size=''0.5'' color=''#B80B36''>'+_log6+'</t>
						',
						safezoneX+0.2,safezoneY+0.605,0.3,0,0,3038] spawn bis_fnc_dynamicText;
					}
					else
					{
						_type = typeOf _ct;
						_cfg = _type call fnc_getConfig;
						_displayName = getText (configFile >> _cfg >> _type >> 'displayName');
						_log4 = format['%1 [%2] @%3',_displayName,_type,mapGridPosition _ct];
						['<t align=''left'' size=''0.5'' color=''#B80B36''>'+_log4+'</t>',safezoneX+0.2,safezoneY+0.545,0.3,0,0,3036] spawn bis_fnc_dynamicText;
						
						_log5 = format['Health: %1 - Distance: %2m',(1-(damage _ct))*100,round(cameraOn distance _ct)];
						['<t align=''left'' size=''0.5'' color=''#B80B36''>'+_log5+'</t>',safezoneX+0.2,safezoneY+0.575,0.3,0,0,3037] spawn bis_fnc_dynamicText;
						
						['',0,0,1,0,0,3038] spawn bis_fnc_dynamicText;
					};
					
					_vehCT = vehicle _ct;
					if((_vehCT isKindOf 'LandVehicle') || (_vehCT isKindOf 'Air') || (_vehCT isKindOf 'Ship') || (_vehCT isKindOf 'Static'))then
					{
						_cwepsV = weapons _vehCT;
						_cwepsV = _cwepsV - ['CarHorn'];
						_cwepsV = _cwepsV - ['MiniCarHorn'];
						_cwepsV = _cwepsV - ['SportCarHorn'];
						_cwepsV = _cwepsV - ['TruckHorn'];
						if(count _cwepsV > 0)then
						{
							_id = 3039;
							_YPOS = safezoneY+0.655;
							
							{
								_cwep = _x;
								_cammo = _vehCT ammo _cwep;
								_cmags = {currentMagazine _vehCT == _x} count magazines _vehCT;
								
								_type = _cwep;
								_cfg = _type call fnc_getConfig;
								_displayName = getText (configFile >> _cfg >> _type >> 'displayName');
								
								_log6a = format[' %1 [%2] (%3/%4)',_displayName,_cwep,_cammo,_cmags];
								['<t align=''left'' size=''0.5'' color=''#A90F68''>'+_log6a+'</t>',safezoneX+0.2,_YPOS,0.3,0,0,_id] spawn bis_fnc_dynamicText;
								
								_id = _id + 1;
								_YPOS = _YPOS + 0.03;
							} forEach _cwepsV;
						};
					};
				};
			};
			[] spawn remove_spec_000;
		};
	};
	adminkill =
	{
		{
			if(name _x == _this select 0)then
			{
				PVAH_AdminReq = [4,player,_x];
				publicVariableServer "PVAH_AdminReq";
				hint format["Killing %1", _this select 0];
				
				_sl = format["%1 Adminkilled %2",name player, _this select 0];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	adminSlap = 
	{
		{
			if(name _x == _this select 0)then
			{
				PVAH_AdminReq = [21,player,_x];
				publicVariableServer "PVAH_AdminReq";
				hint format["Slap %1", _this select 0];
				
				_sl = format["%1 Slaps %2",name player, _this select 0];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	adminBurn =
	{
		{
			if(name _x == _this select 0)then
			{
				PVAH_AdminReq = [111,player,_x];
				publicVariableServer "PVAH_AdminReq";
				hint format["Burning %1 ...", _this select 0];
				
				_sl = format["%1 burning %2 ...",name player,_this select 0];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	adminFDisconnect =
	{
		{
			if(name _x == _this select 0)then
			{
				PVAH_AdminReq = [10,player,_x];
				publicVariableServer "PVAH_AdminReq";
				hint format["Disconnect %1", _this select 0];
				
				_sl = format["%1 Disconnected %2",name player, _this select 0];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	adminremovegear = 
	{
		{
			if(name _x == _this select 0)then
			{
				PVAH_AdminReq = [8,player,_x];
				publicVariableServer "PVAH_AdminReq";
				hint format["%1 Gear Removed", _this select 0];
				
				_sl = format["%1 Removes %2 Gear",name player, _this select 0];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	adminmsg =
	{
		createDialog 'RscDisplayPassword';
		ctrlSetText [1001,'BroadCast Message Plugin'];
		ctrlSetText [101,''];
		ctrlshow [1002,false];
		buttonSetAction [1,'PVAH_AdminReq = [91, player, toArray(ctrlText 101), ''#FFFFFF'']; publicVariableServer ''PVAH_AdminReq'';'];
	};
	adminmsg2 =
	{
		createDialog 'RscDisplayPassword';
		ctrlSetText [1001,'BroadCast Message Plugin'];
		ctrlSetText [101,''];
		ctrlshow [1002,false];
		buttonSetAction [1,'PVAH_AdminReq = [91, player, toArray(ctrlText 101), ''#FFCC00'']; publicVariableServer ''PVAH_AdminReq'';'];
	};
	admint2me =
	{
		{
			if(name _x == _this select 0)then
			{
				_pos = getPosATL player;
				_dir = getDir player;
				_distance = 5;
				_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),(_pos select 2)];
				(vehicle _x) setDir _dir;
				PVAH_AdminReq = [1,player,_x,_pos];publicVariableServer 'PVAH_AdminReq';
				hint format["%1 Moved to %2",name _x, name player];
				cutText [format["%1 Moved to %2",name _x, name player], "PLAIN"];
				
				_sl = format["%1 Moved to %2",name _x, name player];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	admintele =
	{
		adminport_prevLoc =
		{
			(vehicle player) setPosATL prevLoc;
			{player reveal _x;} forEach (player nearObjects ['All',25]);
			prevLoc = nil;
		};
		fnc_adminKeybinds2 =
		{
			_keyDown = _this select 1;
			if(_keyDown == 14)then
			{
				call adminport_prevLoc;
			};
		};
		if(!isNil 'adminKeybinds2')then{(findDisplay 46) displayRemoveEventHandler ['KeyDown', adminKeybinds2];};
		adminKeybinds2 = (findDisplay 46) displayAddEventHandler ['KeyDown','_this call fnc_adminKeybinds2;false'];
		if(isNil 'prevLoc')then
		{
			prevLoc = getPosATL player;
		};
		{
			if(name _x == _this select 0)then
			{
				_pos = getPosATL (vehicle _x);
				_dir = direction (vehicle _x);
				_distance = -1;
				if(player != vehicle player)then{_distance = -8;};
				_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),(_pos select 2)];
				(vehicle player) setPosATL _pos;
				(vehicle player) setDir _dir;
				{player reveal _x;} forEach (player nearObjects ['All',25]);
				
				hint format['Moving to %1 - press BACKSPACE to revert teleport',name _x];
				cutText [format['Moving to %1\npress BACKSPACE to revert teleport',name _x], 'PLAIN'];
				_sl = format['%1 Moving to %2',name player,_this select 0];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	adminsveh =
	{
		_dir = getdir vehicle player;
		_pos = getPos vehicle player;
		_pos = [(_pos select 0)+8*sin(_dir),(_pos select 1)+8*cos(_dir),0];
		PVAH_AdminReq = [0, player, _this select 0, _pos];
		publicVariableServer "PVAH_AdminReq";
		
		cutText [format["SPAWNED: %1 @%2",_this select 0,_pos], "PLAIN DOWN"];
	};
	adminsvehhive =
	{
		_class = _this select 0;
		_dir = getdir vehicle player;
		_pos = getPos vehicle player;
		_pos = [(_pos select 0)+8*sin(_dir),(_pos select 1)+8*cos(_dir),0];
		_worldspace = [_dir,_pos];
		
		if(MOD_EPOCH)then
		{
			_keyColor = ["Green","Red","Blue","Yellow","Black"] call BIS_fnc_selectRandom;
			_keyNumber = (floor(random 2500)) + 1;
			_keySelected = format[("ItemKey%1%2"),_keyColor,_keyNumber];
			_isKeyOK = 	isClass(configFile >> "CfgWeapons" >> _keySelected);
			_config = _keySelected;
			_isOk = [player,_config] call BIS_fnc_invAdd;
			
			PVAH_AdminReq = [-3, player, _class, _worldspace,_keySelected];
			publicVariableServer "PVAH_AdminReq";
			cutText [format["HIVESPAWNED: %1 @%2\n%3 added to toolbelt.",_class,_worldspace,_keySelected], "PLAIN DOWN"];
		}
		else
		{
			PVAH_AdminReq = [-1, player, _class, _pos];
			publicVariableServer "PVAH_AdminReq";
			cutText [format["HIVESPAWNED: %1 @%2",_class,_worldspace], "PLAIN DOWN"];
		};
	};
	admin_fillobj =
	{
		inSub = true;
		_ctrl = -1 call getControl;
		_ctrl ctrlSetPosition [safezoneXAbs + 0.01, safezoneY + 0.07, ((0.485)*0.65) *2, (safeZoneH - 0.07 - 0.03)*0.65];
		_ctrl ctrlSetScale 1.55;
		_ctrl ctrlCommit 0;
		
		_ctrl = 1 call getControl;
		_ctrl ctrlSetFont "TahomaB";
		_ctrl ctrlSetPosition [safezoneXAbs + 0.01, (safezoneY + 0.07), (0.485)*0.65, ((safeZoneH - 0.07 - 0.03)*0.65)];
		_ctrl ctrlSetScale 1.55;
		_ctrl ctrlCommit 0;
		
		_ctrl = 2 call getControl;
		lbclear _ctrl;
		_ctrl ctrlSetFont "TahomaB";
		_ctrl ctrlSetPosition [safezoneXAbs + 0.5, (safezoneY + 0.07), (0.485)*0.65, ((safeZoneH - 0.07 - 0.03)*0.65)];
		_ctrl ctrlSetScale 1.55;
		_ctrl ctrlCommit 0;
		
		if(isNil 'GLOBAL_OBJECTTYPE')then{GLOBAL_OBJECTTYPE = '';};
		if(isNil 'infiSTAR_showOBJ')then
		{
			infiSTAR_showOBJ =
			{
				_type = lbtext [2, (lbCurSel 2)];
				if((_type isKindOf 'Building') && (str _type != str GLOBAL_OBJECTTYPE))then
				{
					_distance = 18;
					_dir = getdir player;
					_pos = getPos player;
					_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),0];
					
					_obj = _type createVehicleLocal _pos;
					[_obj] spawn {
						_obj = _this select 0;
						waitUntil {isNull finddisplay 3030};
						deleteVehicle _obj;
					};
					
					_obj setPosATL _pos;
					_obj setDir (_dir + 180);
					
					if(!isNil 'GLOBAL_OBJECT')then{deleteVehicle GLOBAL_OBJECT;};
					GLOBAL_OBJECT = _obj;
				};
				GLOBAL_OBJECTTYPE = _type;
			};
			_ctrl ctrlSetEventHandler ["LBSelChanged", "call infiSTAR_showOBJ;"];
		};
		_spwx = "['%1'] call adminsobj;";
		adminadd = [];
		call admin_fillsubsss;
		call admin_fillSpawnMenuFILL;
		adminadd = adminadd + ["--- Buildings","","0","0","0","0",[0,0.8,1,1]];
		adminadd = adminadd + ["  START SEARCH  (type in chat - searching stops when chat is closed)","['adminBuildings'] spawn fnc_infiSTAR_search","0","0","0","0",[0,0.8,1,1]];
		{
			adminadd = adminadd + [_x,format[_spwx,_x],"0","0","0","0",[]];
		} forEach ALL_OBJ_TO_SEARCH;
		call admin__FILL_MENUS;
	};
	adminsobj =
	{
		_classname = _this select 0;
		if(!isNil 'GLOBAL_OBJECT')then{
			if(!isNull GLOBAL_OBJECT)then{
				detach GLOBAL_OBJECT;
				GLOBAL_OBJECT = nil;
			};
		};
		closeDialog 1;
		GLOBAL_OFFSET = getArray (configFile >> 'CfgVehicles' >> _classname >> 'offset');
		if((count GLOBAL_OFFSET) <= 0)then{GLOBAL_OFFSET = [0,15,0];};
		_dir = getDir player;
		_pos = getPosATL player;
		_pos = [(_pos select 0) + 15 *sin(_dir),(_pos select 1) + 15 *cos(_dir),0];
		GLOBAL_OBJECT = createVehicle [_classname, _pos, [], 0, 'CAN_COLLIDE'];
		GLOBAL_OBJECT attachTo [player,GLOBAL_OFFSET];
		_key = '';
		{
			_x = _x * 10;
			if( _x < 0 )then{ _x = _x * -10 };
			_key = _key + str(round(_x));
		} count _pos;
		_key = _key + str(round(_dir));
		GLOBAL_OBJECT setVariable['ObjectID', '0', true];
		GLOBAL_OBJECT setVariable['ObjectUID', _key, true];
		GLOBAL_POS = _pos;
		systemChat format['%1: constructing %2 @%3',round time,_classname,_pos];
		[] spawn fnc_HelpConstruct;
	};
	fnc_ConstructKeyBinds =
	{
		if(isNil 'GLOBAL_OBJECT')exitWith {};
		if(isNull GLOBAL_OBJECT)exitWith {};
		detach GLOBAL_OBJECT;
		private ['_key','_shift','_ctrl','_alt'];
		_key = _this select 1;
		_shift = _this select 2;
		_ctrl = _this select 3;
		_alt = _this select 4;
		if(_key == 16)then
		{
			['Left'] spawn fnc_LeftRight;
		};
		if(_key == 18)then
		{
			['Right'] spawn fnc_LeftRight;
		};
		if(_key == 200)then
		{
			['UP'] spawn fnc_UpDown;
		};
		if(_key == 201)then
		{
			['UP'] spawn fnc_UpDown;
		};
		if(_key == 208)then
		{
			['DOWN'] spawn fnc_UpDown;
		};
		if(_key == 209)then
		{
			['DOWN'] spawn fnc_UpDown;
		};
		if(_key == 209)then
		{
			['DOWN'] spawn fnc_UpDown;
		};
		if(_key == 15)then
		{
			_pos = getPosATL GLOBAL_OBJECT;
			_pos = [_pos select 0,_pos select 1,0];
			GLOBAL_OBJECT setPosATL _pos;
		};
		if(_key == 54)then
		{
			[GLOBAL_LAST_OBJECT] call adminsobj;
		};
		if(_key == 57)then
		{
			systemChat format['%1: %2 constructed @%3!',round time,typeOf GLOBAL_OBJECT,GLOBAL_POS];
			GLOBAL_LAST_OBJECT = typeOf GLOBAL_OBJECT;
			GLOBAL_OBJECT = nil;
		};
		{player reveal _x;} forEach (player nearObjects ['All',75]);
	};
	if(!isNil 'ConstructKeyBinds')then{(findDisplay 46) displayRemoveEventHandler ['KeyDown', ConstructKeyBinds];ConstructKeyBinds = nil;};
	ConstructKeyBinds = (findDisplay 46) displayAddEventHandler ['KeyDown','_this call fnc_ConstructKeyBinds;false;'];
	(findDisplay 46) displayRemoveAllEventHandlers 'MouseZChanged';
	(findDisplay 46) displayAddEventHandler ['MouseZChanged','_this call fnc_ForwardBack;false;'];
	fnc_ForwardBack =
	{
		if(isNil 'GLOBAL_OBJECT')exitWith {};
		if(isNull GLOBAL_OBJECT)exitWith {};
		_num = _this select 1;
		_num = (_num/-8);
		_dir = getDir GLOBAL_OBJECT;
		_pos = getPosATL GLOBAL_OBJECT;
		_pos = [(_pos select 0) - _num *sin(_dir),(_pos select 1) - _num *cos(_dir),(_pos select 2)];
		GLOBAL_OBJECT setPosATL _pos;
		GLOBAL_POS = getPosATL GLOBAL_OBJECT;
	};
	fnc_UpDown =
	{
		if(isNil 'GLOBAL_OBJECT')exitWith {hint 'GLOBAL_OBJECT not defined';};
		if(isNull GLOBAL_OBJECT)exitWith {hint 'GLOBAL_OBJECT is Null';};
		GLOBAL_POS = getPosATL GLOBAL_OBJECT;
		if(_this select 0 == 'UP')then
		{
			GLOBAL_POS = [GLOBAL_POS select 0,GLOBAL_POS select 1,(GLOBAL_POS select 2) + 0.05];
		};
		if(_this select 0 == 'DOWN')then
		{
			GLOBAL_POS = [GLOBAL_POS select 0,GLOBAL_POS select 1,(GLOBAL_POS select 2) - 0.05];
		};
		GLOBAL_OBJECT setPosATL GLOBAL_POS;
	};
	fnc_LeftRight =
	{
		if(isNil 'GLOBAL_OBJECT')exitWith {hint 'GLOBAL_OBJECT not defined';};
		if(isNull GLOBAL_OBJECT)exitWith {hint 'GLOBAL_OBJECT is Null';};
		GLOBAL_POS = getPosATL GLOBAL_OBJECT;
		GLOBAL_DIR = getDir GLOBAL_OBJECT;
		if(_this select 0 == 'Right')then
		{
			GLOBAL_DIR = GLOBAL_DIR + 2;
		};
		if(_this select 0 == 'Left')then
		{
			GLOBAL_DIR = GLOBAL_DIR - 2;
		};
		GLOBAL_OBJECT SETDIR GLOBAL_DIR;
		GLOBAL_OBJECT setPosATL GLOBAL_POS;
	};
	fnc_HelpConstruct = {
		["
		<t align='left' size='0.5' color='#008fff'>Mouse Wheel - Move foward/back</t><br/>
		<t align='left' size='0.5' color='#008fff'>Tab to set Object on the Ground</t><br/>
		<t align='left' size='0.5' color='#008fff'>Page Up - Move object up</t><br/>
		<t align='left' size='0.5' color='#008fff'>Page Down - Move object down</t><br/>
		<t align='left' size='0.5' color='#008fff'>Q - Rotate object left</t><br/>
		<t align='left' size='0.5' color='#008fff'>E - Rotate object right</t><br/>
		<t align='left' size='0.5' color='#008fff'>Spacebar - Place Object</t><br/>
		<t align='left' size='0.5' color='#008fff'>Insert - Save Object</t>
		",0,safezoneY,60,0,0,3016] spawn bis_fnc_dynamicText;
	};
	adminUncon =
	{
		{
			if(name _x == _this select 0)then
			{
				PVAH_AdminReq = [11,player,_x];
				publicVariableServer "PVAH_AdminReq";
				hint format["Knocked %1 out...", _this select 0];
				
				_sl = format["%1 Knocks %2 out...",name player,_this select 0];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	adminFreeze =
	{
		{
			if(name _x == _this select 0)then
			{
				PVAH_AdminReq = [112,player,_x];
				publicVariableServer "PVAH_AdminReq";
				hint format["Freezing %1", _this select 0];
				
				_sl = format["%1 Froze %2",name player,_this select 0];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	adminUnFreeze =
	{
		{
			if(name _x == _this select 0)then
			{
				PVAH_AdminReq = [113,player,_x];
				publicVariableServer "PVAH_AdminReq";
				hint format["Un-Freezing %1", _this select 0];
				
				_sl = format["%1 Un-Froze %2",name player,_this select 0];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	adminHitVeh =
	{
		disableSerialization;
		_name = _this select 0;
		_hitpoint = _this select 1;
		_damage = _this select 2;
		if(_name == '')then{_name = name player;};
		if(_hitpoint in ['FIND'])then
		{
			inSub = true;
			_ctrl = 2 call getControl;
			lbclear _ctrl;
			_ctrl ctrlSetFont "TahomaB";
			adminadd = [];
			call admin_fillsubsss;
			
			_veh = objNull;
			_nametarget = call fnc_admin_call_for_name;
			{
				if(!isNull _x)then
				{
					if(getPlayerUID _x != "")then
					{
						if(name _x == _nametarget)then
						{
							_veh = vehicle _x;
						};
					};
				};
			} forEach playableUnits;
			if(isNull _veh)then
			{
				_veh = vehicle player;
			};
			_getHitpoints = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\vehicle_getHitpoints.sqf";
			_hitPoints = _veh call _getHitpoints;
			
			_spwx = "[call fnc_admin_call_for_name,'%1',1] spawn adminHitVeh;";
			{
				adminadd = adminadd + ["  "+_x,format[_spwx,_x],"0","0","0","0",[0.99,0.8,0.8,1]];
			} forEach _hitpoints;
			call admin__FILL_MENUS;
		}
		else
		{
			if(_hitpoint == 'HitFuel')then
			{
				_damage = 0.7;
			};
			{
				if(name _x == _name)then
				{
					_vehicle = vehicle _x;
					
					PVAH_AdminReq = [110,player,_x,_hitpoint,_damage];
					publicVariableServer 'PVAH_AdminReq';
					hint format['%3 of %1(%2) with %4 damage',_name,typeOf _vehicle,_hitpoint,_damage];
					
					_sl = format['%1 %4 %2(%3) with %5 damage',name player,_name,typeOf _vehicle,_hitpoint,_damage];
					PVAH_WriteLogReq = [player,toArray _sl];
					publicVariableServer 'PVAH_WriteLogReq';
				};
			} forEach playableUnits;
		};
	};
	admin_del_bxs =
	{
		PVAH_AdminReq = [14,player];
		publicVariableServer "PVAH_AdminReq";
		
		hint "deleting boxes..";
		
		_sl = format["%1 deleted boxes",name player];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	adminDrug = 
	{
		{
			if(name _x == _this select 0)then
			{
				PVAH_AdminReq = [15,player,_x];
				publicVariableServer "PVAH_AdminReq";
				hint format["Drugging %1...", _this select 0];
				
				_sl = format["%1 drugged %2",name player,_this select 0];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	adminSuicide =
	{
		{
			if(name _x == _this select 0)then
			{
				PVAH_AdminReq = [22,player,_x];
				publicVariableServer "PVAH_AdminReq";
				hint format["Suiciding %1", _this select 0];
				
				_sl = format["%1 Suiciding %2",name player,_this select 0];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	adminClearBan =
	{
		PVAH_AdminReq = [16,player];
		publicVariableServer "PVAH_AdminReq";
		hint "Bans cleared!";
		
		_sl = format["%1 cleared Bans",name player];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	adminKick =
	{
		{
			if(name _x == _this select 0)then
			{
				PVAH_AdminReq = [17,player,_x];
				publicVariableServer "PVAH_AdminReq";
				hint format["Kicked %1...", _this select 0];
				
				_sl = format["%1 Kicked %2",name player,_this select 0];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};	
	adminbanTemp =
	{
		{
			if(name _x == _this select 0)then
			{
				PVAH_AdminReq = [18,player,_x,1];
				publicVariableServer "PVAH_AdminReq";
				hint format["TempBanned %1...", _this select 0];
				
				_sl = format["%1 TempBanned %2",name player,_this select 0];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	adminBanPerm =
	{
		{
			if(name _x == _this select 0)then
			{
				PVAH_AdminReq = [18,player,_x,2];
				publicVariableServer "PVAH_AdminReq";
				hint format["Banned %1...", _this select 0];
				
				_sl = format["%1 Banned %2",name player,_this select 0];
				PVAH_WriteLogReq = [player,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		} forEach playableUnits;
	};
	adminUnBan =
	{
		_uid = _this select 0;
		
		PVAH_AdminReq = [182,player,_uid];
		publicVariableServer "PVAH_AdminReq";
		hint format["UnBanned %1",_uid];
		
		_sl = format["%1 UnBanned %2",name player,_uid];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	adminPlayerDeaths =
	{
		if(isNil "dayzPlayerDeathsResult")then{dayzPlayerDeathsResult = [];};
		"dayzPlayerDeathsResult" addPublicVariableEventHandler
		{
			if((count dayzPlayerDeathsResult) > 0)then
			{
				call EpochDeathBoardLoad;
			}
			else
			{
				cutText ["No recent Deaths.", "PLAIN DOWN"];
			};
		};
		if(isNil "PVDZE_plr_DeathBResult")then{PVDZE_plr_DeathBResult = [];};
		"PVDZE_plr_DeathBResult" addPublicVariableEventHandler
		{
			if((count PVDZE_plr_DeathBResult) > 0)then
			{
				call EpochDeathBoardLoad;
			}
			else
			{
				cutText ["No recent Deaths.", "PLAIN DOWN"];
			};
		};
		PVAH_AdminReq = [23,player];
		publicVariableServer "PVAH_AdminReq";
		hint "Loading EPOCH-DEATHBOARD..";
	};
	admin_removePlotPoles =
	{
		private ['_objs'];
		_objs = (nearestObjects [player, ['Plastic_Pole_EP1_DZ'], 30]);
		if(count _objs > 0)then
		{
			{
				PVAH_AdminReq = [-2,player,_x];
				publicVariableServer 'PVAH_AdminReq';
			} forEach _objs;
			_log = format['<infiSTAR.de>   %1 - PlotPoles within 30m deleted',count _objs];
			systemChat _log;
			hint _log;
		}
		else
		{
			_log = '<infiSTAR.de>   No Plotpoles within 30m found';
			systemChat _log;
			hint _log;
		};
		
		_sl = format['%1 used Remove Plot Poles @%2',name player,mapGridPosition player];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	admin_removeNets =
	{
		private ['_objs'];
		_objs = (nearestObjects [player, ['DesertLargeCamoNet_DZ','ForestLargeCamoNet_DZ','DesertCamoNet_DZ','ForestCamoNet_DZ','MAP_Camo_Box','MAP_CamoNet_EAST','MAP_CamoNet_EAST_var1','MAP_CamoNetB_EAST','MAP_CamoNet_NATO','MAP_CamoNet_NATO_var1','MAP_CamoNetB_NATO','MAP_Pristresek'], 30]);
		if(count _objs > 0)then
		{
			{
				PVAH_AdminReq = [-2,player,_x];
				publicVariableServer 'PVAH_AdminReq';
			} forEach _objs;
			_log = format['<infiSTAR.de>   %1 - Nets within 30m deleted',count _objs];
			systemChat _log;
			hint _log;
		}
		else
		{
			_log = '<infiSTAR.de>   No Nets within 30m found';
			systemChat _log;
			hint _log;
		};
		
		_sl = format['%1 used Remove Nets',name player];
		PVAH_WriteLogReq = [player,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	admin_save_target =
	{
		if(!MOD_EPOCH)exitWith {hint 'fnc EPOCH only';};
		
		SAVE_THIS = nil;
		_obj = cursorTarget;
		if(isNull _obj)exitWith {hint "target doesn't exist";cutText ["target doesn't exist", "PLAIN"];};
		adminSaveNOW = {
			if(!isNull SAVE_THIS)then
			{
				systemChat format["<infiSTAR.de>:  %1  saved at [%2,%3]",typeOf SAVE_THIS,getDir SAVE_THIS,getPosATL SAVE_THIS];
				PVAH_AdminReq = [26,player,SAVE_THIS];
				publicVariableServer "PVAH_AdminReq";
			};
		};
		if(!isNull _obj)then
		{
			SAVE_THIS = nil;
			SAVE_THIS = _obj;
			systemChat format["<infiSTAR.de>: save  %1  at [%2,%3]?",typeOf SAVE_THIS,getDir SAVE_THIS,getPosATL SAVE_THIS];
			adminSaveX = 
			[
				["",true],
				[(format["%1-[%2,%3]",typeOf SAVE_THIS,getDir SAVE_THIS,getPosATL SAVE_THIS]), [-1], "", -5, [["expression", ""]], "1", "0"],
				["Save", [2], "", -5, [["expression", "[] spawn adminSaveNOW"]], "1", "1"],
				["Exit", [3], "", -5, [["expression", ""]], "1", "1"]
			];
			showcommandingMenu "#USER:adminSaveX";
		};
	};
	adminDelete =
	{
		DELETE_THIS = objNull;
		_delete = cursorTarget;
		if(isNull _delete)exitWith {hint "target doesn't exist";cutText ["target doesn't exist", "PLAIN"];};
		adminDeleteX = 
		[
			["",true],
			[(format["%1",typeOf DELETE_THIS]), [-1], "", -5, [["expression", ""]], "1", "0"],
			["Delete", [2], "", -5, [["expression", "[] spawn adminDeleteNOW"]], "1", "1"],
			["Exit", [3], "", -5, [["expression", ""]], "1", "1"]
		];
		adminDeleteNOW = {
			if(!isNull DELETE_THIS)then
			{
				systemChat format["<infiSTAR.de>:  %1  DELETED",typeOf DELETE_THIS];
				PVAH_AdminReq = [-2,player,DELETE_THIS];
				publicVariableServer "PVAH_AdminReq";
			};
		};
		if(!isNull _delete)then
		{
			DELETE_THIS = _delete;
			systemChat format["<infiSTAR.de>: DELETE  %1  ?",typeOf DELETE_THIS];
			showcommandingMenu "#USER:adminDeleteX";
		};
	};
	BCBaseListOld =
	[
		[
			"base1",
			"Test Base",
			[0,23,0],
			[
				["CinderWallDoor_DZ",[0.0551758,-0.736328,3.37357],239.861],
				["MetalFloor_DZ",[2.53516,0.763672,6.58356],59.9374],
				["MetalFloor_DZ",[2.54492,0.763672,3.19955],59.8886],
				["MetalFloor_DZ",[-2.00488,-1.83691,6.58356],239.937],
				["MetalFloor_DZ",[-2.00488,-1.83691,3.19955],239.889],
				["CinderWall_DZ",[-4.20508,1.36328,3.38358],150.186],
				["CinderWallDoorSmall_DZ",[-2.5249,3.76367,3.38358],239.993],
				["FireBarrel_DZ",[4.40527,1.86328,3.43457],59.2191],
				["CinderWallDoor_DZ",[4.78516,2.06348,-0.000427246],59.9374],
				["MetalFloor_DZ",[-0.0947266,5.26367,6.58356],239.937],
				["MetalFloor_DZ",[-0.0947266,5.26367,3.19955],59.8886],
				["WoodSmallWallThird_DZ",[4.84521,2.06348,3.38358],239.847],
				["WoodSmallWallThird_DZ",[4.89502,1.96289,3.38358],59.8468],
				["MetalFloor_DZ",[-4.63477,2.66309,3.19955],239.889],
				["MetalFloor_DZ",[-4.63477,2.66309,6.58356],59.9374],
				["CinderWall_DZ",[-0.214844,-5.63672,3.38358],329.709],
				["CinderWallDoorSmall_DZ",[2.71484,-5.23633,3.39355],59.7286],
				["MetalFloor_DZ",[5.16504,-3.83691,6.58356],239.937],
				["MetalFloor_DZ",[5.1748,-3.83691,3.19955],59.8886],
				["MetalFloor_DZ",[0.625,-6.43652,6.58356],59.9374],
				["MetalFloor_DZ",[0.635254,-6.43652,3.19955],239.889],
				["CinderWall_DZ",[6.18506,2.76367,3.38358],60.0843],
				["CinderWallDoorSmall_DZ",[2.33496,6.36328,-0.000427246],59.7633],
				["CinderWall_DZ",[-1.50488,7.46289,3.38956],329.972],
				["CinderWall_DZ",[-1.54492,7.46289,-0.000427246],150.363],
				["CinderWall_DZ",[-6.04492,4.76367,-0.000427246],148.928],
				["CinderWallDoorSmall_DZ",[7.34521,-2.33691,0.009552],59.8816],
				["CinderWallHalf_DZ",[-6.23486,4.66309,3.38956],149.364],
				["MetalFloor_DZ",[7.08496,3.36328,6.58356],59.9374],
				["MetalFloor_DZ",[-6.54492,-4.53711,3.19955],239.889],
				["MetalFloor_DZ",[-6.54492,-4.53711,6.58356],239.937],
				["MetalFloor_DZ",[5.36523,6.36328,3.18356],59.7772],
				["CinderWall_DZ",[8.55518,1.06348,-0.000427246],149.939],
				["CinderWall_DZ",[-8.59473,-1.13672,3.38358],150.109],
				["MetalFloor_DZ",[8.90527,0.263672,3.19357],59.8189],
				["CinderWall_DZ",[6.375,-6.23633,3.37958],149.81],
				["CinderWall_DZ",[6.375,-6.23633,-0.000427246],329.81],
				["Sandbag1_DZ",[6.68506,6.16309,-0.00143433],329.956],
				["MetalFloor_DZ",[4.44482,7.96289,3.19955],59.8886],
				["MetalFloor_DZ",[4.45508,7.96289,6.58356],59.9374],
				["MetalFloor_DZ",[-9.1748,0.0634766,6.58356],239.937],
				["MetalFloor_DZ",[-9.1748,0.0634766,3.19955],239.889],
				["CinderWallHalf_DZ",[1.60498,-9.03711,3.37958],149.81],
				["CinderWall_DZ",[1.60498,-9.03711,-0.000427246],329.81],
				["CinderWall_DZ",[-4.58496,-8.13672,3.38358],329.818],
				["CinderWallDoorSmall_DZ",[7.10498,6.36328,3.39755],330.226],
				["MetalFloor_DZ",[8.5752,4.26367,3.19357],59.7494],
				["MetalFloor_DZ",[8.70508,4.26367,6.58755],59.9444],
				["MetalFloor_DZ",[9.71484,-1.13672,6.58356],59.9374],
				["MetalFloor_DZ",[-3.90479,-9.03711,3.19955],239.889],
				["MetalFloor_DZ",[-3.91504,-9.03711,6.58356],239.937],
				["CinderWallDoorSmall_DZ",[9.78516,1.76367,3.39755],149.591],
				["WoodStairsSans_DZ",[9.64502,-3.23633,0.299561],149.952],
				["WoodSmallWallThird_DZ",[10.1748,-1.83691,3.37756],149.842],
				["WoodSmallWallThird_DZ",[10.2148,-1.73633,3.37756],329.842],
				["CinderWall_DZ",[3.24512,10.1631,-0.000427246],150.363],
				["CinderWall_DZ",[3.24512,10.1631,3.37958],330.363],
				["CinderWall_DZ",[-9.03516,-5.73633,-0.000427246],60.2108],
				["CinderWall_DZ",[-9.60498,-4.73633,3.38956],60.2249],
				["CinderWall_DZ",[-10.5649,2.16309,-0.000427246],150.057],
				["CinderWallHalf_DZ",[-10.5649,2.16309,3.37958],330.057],
				["CinderWall_DZ",[-8.23486,-7.13672,3.38956],60.0563],
				["CinderWall_DZ",[6.85498,9.16309,3.37958],60.0283],
				["CinderWall_DZ",[6.85498,9.16309,-0.000427246],240.028],
				["CinderWall_DZ",[-11.5552,-1.33691,-0.000427246],60.3165],
				["CinderWallHalf_DZ",[-11.5552,-1.33691,3.37958],240.317],
				["CinderWall_DZ",[11.1353,-3.43652,-0.000427246],329.81],
				["CinderWall_DZ",[11.1353,-3.43652,3.37958],149.81],
				["CinderWallHalf_DZ",[-2.60498,-11.4365,3.37958],150.089],
				["CinderWall_DZ",[-2.60498,-11.4365,-0.000427246],330.089],
				["CinderWallHalf_DZ",[10.7451,5.46289,3.37357],59.9723],
				["CinderWall_DZ",[12.0649,0.163086,3.37958],60.1405],
				["CinderWall_DZ",[12.0649,0.163086,-0.000427246],240.14],
				["CinderWall_DZ",[-6.29492,-10.5371,-0.000427246],60.2108],
				["CinderWallHalf_DZ",[-6.29492,-10.5371,3.37958],240.211],
				["WoodStairsSans_DZ",[12.2749,-1.63672,-2.20044],149.947]
			]
		],
		[
			"base2",
			"Another Base",
			[0,23,0],
			[
				["CinderWallDoor_DZ",[0.0551758,-0.736328,3.37357],239.861],
				["MetalFloor_DZ",[2.53516,0.763672,6.58356],59.9374]
			]
		]
	];
	if(isNil 'BCBaseList')then{BCBaseList = BCBaseListOld;};
	admin_BaseMenu =
	{
		if(isNil "BCCurrentBase")then{BCCurrentBase = [];};
		if((!isNil "TraderDialogLoadItemList") && (isNil "oTraderDialogLoadItemList"))then{oTraderDialogLoadItemList = TraderDialogLoadItemList;};
		if((!isNil "TraderDialogShowPrices") && (isNil "oTraderDialogShowPrices"))then{oTraderDialogShowPrices = TraderDialogShowPrices;};
		if((!isNil "TraderDialogSell") && (isNil "oTraderDialogSell"))then{oTraderDialogSell = TraderDialogSell;};
		if((!isNil "TraderDialogBuy") && (isNil "oTraderDialogBuy"))then{oTraderDialogBuy = TraderDialogBuy;};
		fn_BCInsert = {
			TraderDialogLoadItemList = {};
			TraderDialogShowPrices = {};
			TraderDialogSell = {};
			TraderDialogBuy = {
				systemChat str [lbCurSel 12000, lbCurSel 12001];
				[lbCurSel 12000, lbCurSel 12001] spawn {
					private ["_pindex", "_bindex", "_base", "_player", "_base_objects"];
					systemChat str _this;
					_pindex = _this select 0;
					_bindex = _this select 1;
					if(_pindex < 0 or _bindex < 0)exitWith {};
					_base = BCBaseList select _bindex;
					_player = BCNearbyList select _pindex;
					_attach_position = player modelToWorld (_base select 2);
					_attach_position set [2, getPosASL player select 2];
					_base_objects = [_base select 3, _attach_position, _player] call fn_BCCreateBase;
					[_base_objects] call fn_BCBuildbase;
				};
			};
			createdialog "TraderDialog";
			[] spawn {
				uiSleep 0.1;
				waitUntil {!dialog};
				uiSleep 0.1;
				if(!isNil "oTraderDialogLoadItemList")then{TraderDialogLoadItemList = oTraderDialogLoadItemList;};
				if(!isNil "oTraderDialogShowPrices")then{TraderDialogShowPrices = oTraderDialogShowPrices;};
				if(!isNil "oTraderDialogSell")then{TraderDialogSell = oTraderDialogSell;};
				if(!isNil "oTraderDialogBuy")then{TraderDialogBuy = oTraderDialogBuy;};
			};
			lbClear 12000;
			lbClear 12001;
			ctrlShow [12005, false];
			{
				lbAdd [12001, format["%1 (%2)", _x select 1, _x select 0]];
				true
			} count BCBaseList;
		 
			BCNearbyList = [];
			{
				if(!isNull _x)then
				{
					if(_x distance player < 50)then
					{
						BCNearbyList set [count BCNearbyList, _x];
						lbAdd [12000, format["%1", name _x]];
					};
				};
				true
			} count playableUnits;
		};
		fn_BCExport = {
			private ['_objects', '_position', '_distance', '_nearest_objects'];
			if(isNil 'BC_Center' or isNil 'BC_radius')exitWith
			{
				systemChat 'Center not set';
			};
			_objects = [];
			_position = BC_center;
			_distance = BC_radius;
			_nearest_objects = nearestObjects [[_position select 0, _position select 1], DayZ_SafeObjects, _distance];
			diag_log text ('/' + '/ --------- Start Base Export --------- /' + '/');
			diag_log text 'if(isServer)then{';
			{
				private ['_obj_type', '_direction', '_obj_position', '_row','_vector'];
				_obj_type = typeOf _x;
				_direction = getDir _x;
				_obj_position = getPosASL _x;
				_objVector = [(vectorDir _x),(vectorUp _x)];
				_row = [_obj_type, _obj_position, [], 0, 'CAN_COLLIDE'];
				if((_obj_type != 'VaultStorageLocked') && (_obj_type != 'CinderWallDoorSmallLocked_DZ') && (_obj_type != '') && (_obj_type != 'LockboxStorageLocked') && (_obj_type != 'StorageShed_DZ') && (_obj_type != 'CinderWallDoorLocked_DZ') && (_obj_type != 'Land_DZE_GarageWoodDoorLocked') && (_obj_type != 'Land_DZE_LargeWoodDoorLocked') && (_obj_type != 'GunRack_DZ') && (_obj_type != 'Wooden_shed_DZ') && (_obj_type != 'WoodCrate_DZ') && (_obj_type != 'Sign_sphere100cm_EP1') && (_obj_type != 'Sign_arrow_down_large_EP1'))then{
					diag_log text '_bldObj = objNull;';
					diag_log text 'if(true)then{';
					diag_log text format['_bldObj = createVehicle %1;', _row];
					diag_log text format['_bldObj setDir %1;',_direction];
					diag_log text format['_bldObj setPosASL %1;',_obj_position];
					diag_log text format['_bldObj setVectorDirAndUp %1;',_objVector];
					diag_log text '};';
					diag_log text '';
				};
				_row set [count _row, _x];
				_objects set [count _objects, _row];
				true
			} count _nearest_objects;
			systemChat format['Exported %1 items', count _nearest_objects];
			diag_log text '};';
			diag_log text ('/' + '/ --------- End Base Export --------- /' + '/');
			BCCopiedBase = _objects;
			['<t size=''0.6''>Base exported to logs in SQF Format</t>',0,0.8,0.5,0,0,8] spawn BIS_fnc_dynamicText;
			showCommandingMenu '#USER:BCMainMenu';
			_objects
		};
		fn_BCSetCenter = {
			private ["_centerSign"];
			BC_radius = nil;
			BC_Center = getPosASL player;
			_centerSign = createVehicle ["Sign_arrow_down_large_EP1", [0,0,0], [], 0, "CAN_COLLIDE"];
			_centerSign setPosASL BC_Center;
			_centerSign spawn {uiSleep 30; deleteVehicle _this;};
			showcommandingMenu "#USER:BCMainMenu";
		};
		fn_BCSetRadius = {
			if(isNil "BC_Center")exitWith
			{
				systemChat "Center not set";
			};
			BC_radius = [player, BC_center] call BIS_fnc_distance2D;
			if(BC_radius == 0)exitWith
			{
				systemChat "Radius is 0";
			};
			showcommandingMenu "#USER:BCMainMenu";
			[] spawn {
				private ["_pos", "_radius", "_angle", "_distance", "_count", "_step", "_count", "_step", "_objects"];
				_angle = 0;
				_count = round((2 * pi * BC_radius) / 2);
				_objects = [];
				for "_x" from 0 to _count do
				{
					private["_a", "_b", "_obj"];
					_a = (BC_Center select 0) + (sin(_angle)*BC_radius);
					_b = (BC_Center select 1) + (cos(_angle)*BC_radius);
					_obj = createVehicle ["Sign_sphere100cm_EP1", [0,0,0], [], 0, "CAN_COLLIDE"];
					_obj setPosASL [_a, _b, BC_center select 2];
					_objects set [count _objects, _obj];
					_angle = _angle + (360/_count);
				};
				
				for "_x" from 0 to _count do
				{
					private["_a", "_b", "_obj"];
					_a = (BC_Center select 0) + (sin(_angle)*BC_radius);
					_b = (BC_Center select 2) + (cos(_angle)*BC_radius);
					_obj = createVehicle ["Sign_sphere100cm_EP1", [0,0,0], [], 0, "CAN_COLLIDE"];
					_obj setPosASL [_a, BC_center select 1, _b];
					_objects set [count _objects, _obj];
					_angle = _angle + (360/_count);
				};
				
				for "_x" from 0 to _count do
				{
					private["_a", "_b", "_obj"];
					_a = (BC_Center select 1) + (sin(_angle)*BC_radius);
					_b = (BC_Center select 2) + (cos(_angle)*BC_radius);
					_obj = createVehicle ["Sign_sphere100cm_EP1", [0,0,0], [], 0, "CAN_COLLIDE"];
					_obj setPosASL [BC_center select 0, _a, _b];
					_objects set [count _objects, _obj];
					_angle = _angle + (360/_count);
				};
				uiSleep 30;
				{ deleteVehicle _x; true } count _objects;
			};
		};
		fn_BCCopy = {
			private ["_objects", "_position", "_distance", "_nearest_objects"];
			if(isNil "BC_Center" or isNil "BC_radius")exitWith
			{
				systemChat "Center not set";
			};
			if(BC_radius == 0)exitWith
			{
				systemChat "Radius is 0";
			};
			_objects = [];
			_position = BC_center;
			_distance = BC_radius;
			_nearest_objects = nearestObjects [[_position select 0, _position select 1], DayZ_SafeObjects, _distance];
			diag_log "========= Copying Objects [start] =========";
			{
				private ["_obj_type", "_direction", "_obj_position", "_relative_position", "_row"];
				_obj_type = typeOf _x;
				_direction = getDir _x;
				_obj_position = getPosASL _x;
				_relative_position = [
					(_obj_position select 0) - (_position select 0),
					(_obj_position select 1) - (_position select 1),
					(_obj_position select 2) - (_position select 2)
				];
				_row = [_obj_type, _relative_position, _direction];
				diag_log str(_row);
				_row set [count _row, _x];
				_objects set [count _objects, _row];
				true
			} count _nearest_objects;
			systemChat format["Copied %1 items", count _nearest_objects];
			diag_log "========= Copying Objects [end] =========";
			BCCopiedBase = _objects;
			["<t size='0.6'>Base copied to logs</t>",0,0.8,0.5,0,0,8] spawn BIS_fnc_dynamicText;
			showcommandingMenu "#USER:BCMainMenu";
			_objects
		};
		fn_BCPaste = {
			private ["_dimensions", "_attach_position", "_base_objects"];
			if(isNil "BCCopiedBase")exitWith
			{
				systemChat "Base not copied not set";
			};
			_dimensions = BCCopiedBase call fn_BCGetDimensions;
			_attach_position = player modelToWorld [0, ((_dimensions select 0) max (_dimensions select 1)), 0];
			diag_log str [0, ((_dimensions select 0) max (_dimensions select 1)), 0];
			_attach_position set [2, getPosASL player select 2];
			_base_objects = [BCCopiedBase, _attach_position] call fn_BCCreateBase;
			[_base_objects] call fn_BCBuildbase;
		};
		fn_BCDelete = {
			BCConfirmBaseDelete = [
				["",true],
				["Base Manager", [-1], "", -5, [], "1", "0"],
				["   by Maca134", [-1], "", -5, [], "1", "0"],
				["      infiSTAR.de edit", [-1], "", -5, [], "1", "0"],
				["Delete Objects in Radius?", [-1], "", -5, [], "1", "0"],
					["No", 	[2], "", -5, [["expression", ""]], "1", "1"],
					["Yes", 	[3], "", -5, [["expression", "[] spawn fn_BCConfirmDelete"]], "1", "1"]
			];
			showcommandingMenu "#USER:BCConfirmBaseDelete";
		};
		fn_BCConfirmDelete = {
			private ["_position", "_distance", "_nearest_objects","_tmp","_tmpobj","_objid"];
			if(isNil "BC_Center" or isNil "BC_radius")exitWith
			{
				systemChat "Center not set";
			};
			if(BC_radius == 0)exitWith
			{
				systemChat "Radius is 0";
			};
			_position = BC_center;
			_distance = BC_radius;
			
			
			_objs_to_delete = DayZ_SafeObjects;
			_objs_to_delete = _objs_to_delete - ["VaultStorageLocked"];
			_objs_to_delete = _objs_to_delete - ["LockboxStorageLocked"];
			_nearest_objects = nearestObjects [[_position select 0, _position select 1], _objs_to_delete, _distance];
			
			uiSleep 1;
			PVAH_AdminReq = [-2,player,_nearest_objects];
			publicVariableServer "PVAH_AdminReq";
			
			[format["<t size='0.6'>Deleted %1 objects</t>", count _nearest_objects],0,0.8,0.5,0,0,8] spawn BIS_fnc_dynamicText;
		};
		fn_BCSaveToDb = {
			{
				PVAH_AdminReq = [26,player,_x];
				publicVariableServer "PVAH_AdminReq";
				true
			} count BCCurrentBase;
			[format["<t size='0.6'>Added %1 objects to database</t>", count BCCurrentBase],0,0.8,0.5,0,0,8] spawn BIS_fnc_dynamicText;
			BCCurrentBase = [];
		};
		fn_BCCancelBase = {
			{
				detach _x; deleteVehicle _x;
			} count BCCurrentBase;
			BCCurrentBase = [];
			["<t size='0.6'>Cancelled</t>",0,0.8,0.5,0,0,8] spawn BIS_fnc_dynamicText;
		};
		fn_BCCenter = {
			private ["_objects", "_ax", "_ay", "_az", "_total", "_thanks"];
			_thanks = _this;
			if(isNil '_thanks')exitWith {};
			_objects = [];
			_ax = 0;
			_ay = 0;
			_az = 0;
			{
				private ["_pos"];
				_pos = getPosASL _x;
				_ax = _ax + (_pos select 0);
				_ay = _ay + (_pos select 1);
				_az = _az + (_pos select 2);
			} count _thanks;
			_total = count _thanks;
			_center = [_ax / _total, _ay / _total, _az / _total];
			_center
		};
		fn_BCCreateBase = {
			private ["_objects", "_items", "_position", "_player"];
			_objects = [];
			_items = _this select 0;
			_position = _this select 1;
			if(count _this == 3)then{
				_player = _this select 2;
			};
			{
				private ["_object", "_orig_obj"];
				_object = createVehicle [_x select 0, [0,0,0], [], 0, "CAN_COLLIDE"];
				_object setPosASL [
					((_x select 1) select 0) + (_position select 0),
					((_x select 1) select 1) + (_position select 1),
					((_x select 1) select 2) + (_position select 2) 
				];
				_object attachTo [player];
				_object setDir ((_x select 2) - getDir player);
				if(count _x == 4)then{
					_orig_obj = _x select 3;
					_object setVariable["CharacterID", _orig_obj getVariable["CharacterID", ""], true];
				};
				if(!isNil "_player")then{
					_object setVariable["CharacterID", (_player getVariable["CharacterID","0"]), true];
				};
				_objects set [count _objects, _object];
				true
			} count _items;
			_objects
		};
		fn_BCBuildbase = {
			private ["_base_objects", "_finished", "_place"];
			_base_objects = _this select 0;
			{
				_x attachTo [player];
				true
			} count _base_objects;
			_finished = false;
			DZE_Q = false;
			DZE_Z = false;
			DZE_4 = false;
			DZE_6 = false;
			DZE_5 = false;
			DZE_cancelBuilding = false;
			_place = false;
			while{!_finished}do {
				private ["_player_direction"];
				["<t size='0.6'>SPACE: Place | Q/R: Rotate | PgUp/PgDn: Height</t>",0,0.8,0.5,0,0,8] spawn BIS_fnc_dynamicText;
				_player_direction = getDir player;
				if(DZE_Q or DZE_Z)then{
					{
						private ["_obj_direction", "_position"];
						detach _x;
						_obj_direction = getDir _x;
						_position = getPosASL _x;
						_position set [2, (_position select 2) + (if(DZE_Q)then{0.5} else {-0.5})];
						_x setPosASL _position;
						_x attachTo [player];
						_x setDir (_obj_direction - _player_direction);
						true
					} count _base_objects;
					DZE_Q = false;
					DZE_Z = false;
				};
				if(DZE_4 or DZE_6)then{
					private ["_center_position"];
					_center_position = _base_objects call fn_BCCenter;
					{
						private ["_position", "_obj_direction", "_dif_direction", "_new_direction", "_distance", "_rotated_position"];
						detach _x;
						_position = getPosASL _x;
						_obj_direction = ([_center_position, _position] call BIS_fnc_dirTo);
						_dif_direction = if(DZE_4)then{10} else {-10};
						_new_direction = _obj_direction + _dif_direction;
						_distance = [_center_position, _position] call BIS_fnc_distance2D;
						_obj_direction = getDir _x;
						_rotated_position = [_center_position, _distance, _new_direction] call BIS_fnc_relPos;
						_rotated_position set [2, _position select 2];
						_x setPosASL _rotated_position;
						_x attachTo [player];
						_x setDir (((_obj_direction - _player_direction) + _dif_direction) % 360);
						true
					} count _base_objects;
					DZE_4 = false;
					DZE_6 = false;
				};
				if(DZE_5)exitWith {
					_finished = true;
					_place = true;
				};
				if(DZE_cancelBuilding)exitWith {
					_finished = true;
					_place = false;
				};
			};
			{detach _x; true} count _base_objects;
			BCCurrentBase = _base_objects;
			if(!_place)then
			{
				call fn_BCCancelBase;
			};
		};
		fn_BCGetDimensions = {
			private ["_xmin", "_xmax", "_ymin", "_ymax"];
			_xmin = 0;
			_xmax = 0;
			_ymin = 0;
			_ymax = 0;
			{
				private ["_position"];
				_position = _x select 1;
				if((_position select 0) < _xmin)then{
					_xmin = _position select 0;
				};
				if((_position select 0) > _xmax)then{
					_xmax = _position select 0;
				};
				
				if((_position select 1) < _ymin)then{
					_ymin = _position select 1;
				};
				if((_position select 1) > _ymax)then{
					_ymax = _position select 1;
				};
				true
			} count _this;
			[abs _xmin + abs _xmax, abs _ymin + abs _ymax]
		};
		BCBaseSaveMenu = [
			["",true],
			["Base Manager", [-1], "", -5, [], "1", "0"],
			["   by Maca134", [-1], "", -5, [], "1", "0"],
			["      infiSTAR.de edit", [-1], "", -5, [], "1", "0"],
			["Save in DB?", 	[2], "", -5, [["expression", "[] spawn fn_BCSaveToDb"]], "1", "1"],
			["Exit", 	[3], "", -5, [["expression", "[] spawn fn_BCCancelBase"]], "1", "1"]
		];
		BCMainMenu =
		[
			["",true],
			["Base Manager", [-1], "", -5, [], "1", "0"],
			["   by Maca134", [-1], "", -5, [], "1", "0"],
			["      infiSTAR.de edit", [-1], "", -5, [], "1", "0"],
			["Insert", 		[2], "", -5, [["expression", "[] spawn fn_BCInsert"]], "1", "1"],
			["Export", 		[3], "", -5, [["expression", "[] spawn fn_BCExport"]], "1", "1"],
			["========", 	[-1], "", -5, [["expression", ""]], "1", "0"],
			["Set Center", 	[4], "", -5, [["expression", "[] spawn fn_BCSetCenter"]], "1", "1"],
			["Set Radius", 	[5], "", -5, [["expression", "[] spawn fn_BCSetRadius"]], "1", "1"],
			["========", 	[-1], "", -5, [["expression", ""]], "1", "0"],
			["Copy",		[6], "", -5, [["expression", "[] spawn fn_BCCopy"]], "1", "1"],
			["Paste", 		[7], "", -5, [["expression", "[] spawn fn_BCPaste"]], "1", "1"],
			["Save", [7], "#USER:BCBaseSaveMenu", -5, [["expression", ""]], "1", "1"],
			["Delete", 		[8], "", -5, [["expression", "[] spawn fn_BCDelete"]], "1", "1"]
		];
		showcommandingMenu "#USER:BCMainMenu";
	};
	if(isNil 'admin_announce')then{admin_announce = true;};
	fnc_showFoundSearch =
	{
		_foundarray = _this select 0;
		_what = _this select 1;
		inSub = true;
		_ctrl = 2 call getControl;
		_ctrl ctrlSetFont "TahomaB";
		lbclear _ctrl;
		if(_what == "weaponmags")then
		{
			isWep__i_n_f_i_S_T_A_R = true;
			isMag__i_n_f_i_S_T_A_R = true;
			_spwx = "['%1'] spawn adminweapon;";
			_ammo = "[] spawn ammo_current_wpn_admin;";
			_spAx = "['%1'] spawn adminmagazino;";
			adminadd = [];
			call admin_fillsubsss;
			call admin_fillSpawnMenuFILL;
			adminadd = adminadd + ["--- Ammo Current Wep",format[_ammo],"0","0","0","0",[0,0.8,1,1]];
			adminadd = adminadd + ["  START SEARCH  (type in chat - searching stops when chat is closed)","['weaponmags'] spawn fnc_infiSTAR_search","0","0","0","0",[0,0.8,1,1]];
			{
				adminadd = adminadd + [_x,format[_spwx,_x],"0","0","0","0",[]];
				_mags = getArray (configFile >> 'CfgWeapons' >> _x >> 'magazines');
				{
					adminadd = adminadd + [_x,format[_spAx,_x],"0","0","0","0",[0.8,0.8,0,1]];
				} forEach _mags;
			} forEach _foundarray;
		};
		if(_what == "weapon")then
		{
			isWep__i_n_f_i_S_T_A_R = true;
			_spwx = "['%1'] spawn adminweapon;";
			_ammo = "[] spawn ammo_current_wpn_admin;";
			adminadd = [];
			call admin_fillsubsss;
			call admin_fillSpawnMenuFILL;
			adminadd = adminadd + ["--- Ammo Current Wep",format[_ammo],"0","0","0","0",[0,0.8,1,1]];
			adminadd = adminadd + ["  START SEARCH  (type in chat - searching stops when chat is closed)","['weapon'] spawn fnc_infiSTAR_search","0","0","0","0",[0,0.8,1,1]];
			{
				adminadd = adminadd + [_x,format[_spwx,_x],"0","0","0","0",[]];
			} forEach _foundarray;
		};
		if(_what == "magazine")then
		{
			isMag__i_n_f_i_S_T_A_R = true;
			_spwx = "['%1'] spawn adminmagazino;";
			_ammo = "[] spawn ammo_current_wpn_admin;";
			adminadd = [];
			call admin_fillsubsss;
			call admin_fillSpawnMenuFILL;
			adminadd = adminadd + ["--- Ammo Current Wep",format[_ammo],"0","0","0","0",[0,0.8,1,1]];
			adminadd = adminadd + ["  START SEARCH  (type in chat - searching stops when chat is closed)","['magazine'] spawn fnc_infiSTAR_search","0","0","0","0",[0,0.8,1,1]];
			{
				adminadd = adminadd + [_x,format[_spwx,_x],"0","0","0","0",[]];
			} forEach _foundarray;
		};
		if(_what == "adminSNV")then
		{
			isVehicle__i_n_f_i_S_T_A_R = true;
			_spwx = "['%1'] call adminsveh;";
			adminadd = [];
			call admin_fillsubsss;
			call admin_fillSpawnMenuFILL;
			adminadd = adminadd + ["--- NORMAL SPAWN","","0","0","0","0",[0,0.8,1,1]];
			adminadd = adminadd + ["  START SEARCH  (type in chat - searching stops when chat is closed)","['adminSNV'] spawn fnc_infiSTAR_search","0","0","0","0",[0,0.8,1,1]];
			{
				adminadd = adminadd + [_x,format[_spwx,_x],"0","0","0","0",[]];
			} forEach _foundarray;
		};
		if(_what == "adminSHV")then
		{
			isVehicle__i_n_f_i_S_T_A_R = true;
			_spwx = "['%1'] call adminsvehhive;";
			adminadd = [];
			call admin_fillsubsss;
			call admin_fillSpawnMenuFILL;
			adminadd = adminadd + ["--- HIVE SPAWN","","0","0","0","0",[0,0.8,1,1]];
			adminadd = adminadd + ["  START SEARCH  (type in chat - searching stops when chat is closed)","['adminSHV'] spawn fnc_infiSTAR_search","0","0","0","0",[0,0.8,1,1]];
			{
				adminadd = adminadd + [_x,format[_spwx,_x],"0","0","0","0",[]];
			} forEach _foundarray;
		};
		if(_what == "adminBuildings")then
		{
			_spwx = "['%1'] call adminsobj;";
			adminadd = [];
			call admin_fillsubsss;
			call admin_fillSpawnMenuFILL;
			adminadd = adminadd + ["--- Buildings","","0","0","0","0",[0,0.8,1,1]];
			adminadd = adminadd + ["  START SEARCH  (type in chat - searching stops when chat is closed)","['adminBuildings'] spawn fnc_infiSTAR_search","0","0","0","0",[0,0.8,1,1]];
			{
				adminadd = adminadd + [_x,format[_spwx,_x],"0","0","0","0",[]];
			} forEach _foundarray;
		};
		call admin__FILL_MENUS;
	};
	if(isNil 'fnc_inString')then
	{
		fnc_inString = {
			private ['_needle','_haystack','_needleLen','_hay','_found'];
			_needle = _this select 0;
			if(isNil'_needle')exitWith{};
			if(typeName _needle != 'STRING')then{_needle = str _needle;};
			if(_needle == '')exitWith{};
			
			_haystack = _this select 1;
			if(isNil'_haystack')exitWith{};
			if(typeName _haystack != 'STRING')then{_haystack = str _haystack;};
			if(_haystack == '')exitWith{};
			_haystack = toArray _haystack;
			
			
			_needleLen = count toArray _needle;
			_hay = +_haystack;
			_hay resize _needleLen;
			_found = false;
			for '_i' from _needleLen to count _haystack do {
				if(toString _hay == _needle)exitWith {_found = true};
				_hay set [_needleLen, _haystack select _i];
				_hay set [0, 'x'];
				_hay = _hay - ['x']
			};
			_found
		};
	};
	fnc_infiSTAR_search =
	{
      disableSerialization;
      _what = _this select 0;
      _category = '[UNDEFINED VARIABLE]';
      if(_what == 'weapon')then{ALL_TO_SEARCH = ALL_WEPS_TO_SEARCH;_category = 'weapons';};
      if(_what == 'magazine')then{ALL_TO_SEARCH = ALL_MAGS_TO_SEARCH;_category = 'magazines';};
      if(_what == 'adminSNV')then{ALL_TO_SEARCH = ALL_VEHS_TO_SEARCH;_category = 'vehicles';};
      if(_what == 'adminSHV')then{ALL_TO_SEARCH = ALL_VEHS_TO_SEARCH;_category = 'vehicles';};
      if(_what == 'adminBuildings')then{ALL_TO_SEARCH = ALL_OBJ_TO_SEARCH;_category = 'Buildings';};
      if(_what == 'weaponmags')then{ALL_TO_SEARCH = ALL_WEPS_TO_SEARCH+ALL_MAGS_TO_SEARCH;_category = 'weapons & mags';};
      if(!isNil 'fnc_searching_running')exitWith {systemChat format['still searching [%1] - open/close the chat to stop.',_category];};
      fnc_searching_running = true;

      if(!isNull (findDisplay 24))then{
         _text = ctrlText ((findDisplay 24) displayCtrl 101);
         (findDisplay 24) closeDisplay 1;
         if(_text != '')then{
            systemChat format['Searching for [%1] in [%2] started..',_text,_category];
            _foundarray = [];
            _countAll = (count ALL_TO_SEARCH) - 1;
            {
               hintSilent str (_countALL - _forEachIndex);
               if([_text, toLower _x] call fnc_inString)then{
                  _foundarray set [count _foundarray, _x];
               };
            } forEach ALL_TO_SEARCH;
            if(count _foundarray >= 1)then{
               systemChat format['searching for [%1] - STOPPED',_category];
               [_foundarray,_what] call fnc_showFoundSearch;
            } else {
               systemChat format['[%1] not found in [%2]..',_text,_category];
            };
         };
      } else {
         systemChat format['[%1] You must type something into the chat to start the search..',_category];
      };
      fnc_searching_running = nil;
   };
	admin_do_this_first =
	{
		infiSTAR_A2_debug = {
			if(isNil 'firstRun_infiSTAR_A2_debug')then
			{
				firstRun_infiSTAR_A2_debug = true;
				systemChat 'infiSTAR.de: Debug best fits with interface size small!';
			};
			private['_this','_igotthis'];
			_settext = '';
			if(!isNil '_this')then
			{
				_igotthis = _this select 0;
				if(typename _igotthis != 'STRING')then{_igotthis = str _igotthis;};
				_settext = _igotthis;
			};
			disableSerialization;
			closeDialog 0;
			if(!dialog)then{createDialog 'RscFunctionsViewer';};
			_ctrl = (findDisplay 2929) displayctrl 292901;
			_ctrl ctrlCommit 0;
			_display = findDisplay 2929;
			_textTitle = _display displayctrl 292905;
			_textPath = _display displayctrl 292906;
			_textDesc = _display displayctrl 292907;
			_textCode = _display displayctrl 292908;
			_btnCopy = _display displayctrl 292909;
			_btnCopy2 = _display displayctrl 292910;
			_btnCopy3 = _display displayctrl 292911;
			_listFunctions = _display displayCtrl 292901;
			_listSources = _display displayCtrl 292902;
			_listTags = _display displayCtrl 292903;
			_listCats = _display displayCtrl 292904;
			_textTitle ctrlShow false;
			_textPath ctrlShow false;
			_textDesc ctrlShow false;
			_btnCopy ctrlShow true;
			_btnCopy2 ctrlShow true;
			_btnCopy3 ctrlShow true;
			_listFunctions ctrlShow false;
			_listSources ctrlShow false;
			_listTags ctrlShow false;
			_listCats ctrlShow false;
			_textCode ctrlSetText _settext;
			_textCode ctrlSetPosition [0, safezoneY + 0.45, 0.75, safezoneH - 1.1];
			_textCode ctrlSetFont 'TahomaB';
			_textCode ctrlSetScale (safezoneH - safezoneW / 2) * 2.2;
			_textCode ctrlCommit 0;
			
			_btnCopy2 ctrlSetText 'Global';
			_btnCopy2 ctrlSetTextColor [0.1, 0.6, 1, 1];
			_btnCopy2 ctrlSetFont 'Zeppelin33';
			fnc_get_stringGLOBAL =
			{
				_text = ctrlText 292908;
				_text
			};
			_btnCopy2 buttonSetAction '[call fnc_get_stringGLOBAL] spawn admin_d0';
			_btnCopy2 ctrlSetPosition [((ctrlPosition _btnCopy2) select 0), ((ctrlPosition _btnCopy2) select 1)+0.04, (ctrlPosition _btnCopy2) select 2, (ctrlPosition _btnCopy2) select 3];
			_btnCopy2 ctrlCommit 0;
			
			_btnCopy ctrlSetText 'Server';
			_btnCopy ctrlSetTextColor [0.1, 0.6, 1, 1];
			_btnCopy ctrlSetFont 'Zeppelin33';
			fnc_get_stringSERVER =
			{
				_text = ctrlText 292908;
				_string = format['if(isServer)then{%1};',_text];
				_string
			};
			_btnCopy buttonSetAction '[call fnc_get_stringSERVER] spawn admin_d0';
			_btnCopy ctrlSetPosition [((ctrlPosition _btnCopy) select 0), ((ctrlPosition _btnCopy) select 1)+0.04, (ctrlPosition _btnCopy) select 2, (ctrlPosition _btnCopy) select 3];
			_btnCopy ctrlCommit 0;
			
			_btnCopy3 ctrlSetText 'Local';
			_btnCopy3 ctrlSetTextColor [0.1, 0.6, 1, 1];
			_btnCopy3 ctrlSetFont 'Zeppelin33';
			_btnCopy3 buttonSetAction '_text = ctrlText 292908;call compile _text;';
			_btnCopy3 ctrlSetPosition [((ctrlPosition _btnCopy3) select 0), ((ctrlPosition _btnCopy3) select 1)+0.04, (ctrlPosition _btnCopy3) select 2, (ctrlPosition _btnCopy3) select 3];
			_btnCopy3 ctrlCommit 0;
		};
		uiSleep 15;
		if(isNil "ALL_WEPS_TO_SEARCH")then
		{
			ALL_WEPS_TO_SEARCH = [];
			_CfgWeapons = configFile >> "CfgWeapons";
			for "_i" from 0 to (count _CfgWeapons)-1 do
			{
				_weapon = _CfgWeapons select _i;
				if(isClass _weapon)then
				{
					_wpn_type = configName _weapon;
					_plx = toArray _wpn_type;
					_plx resize 7;
					_plx;
					_plx = toString _plx;
					if(((_plx != "ItemKey") || (_wpn_type == "ItemKeyKit")) && (_wpn_type != "MineE") && (_wpn_type != "ItemCore"))then
					{
						if((getText(_weapon >> 'displayName') != '') && {getText(_weapon >> 'picture') != ''} && {getNumber(_weapon >> 'scope') in [0,2]})then
						{
							if !(_wpn_type in ALL_WEPS_TO_SEARCH)then
							{
								ALL_WEPS_TO_SEARCH = ALL_WEPS_TO_SEARCH + [_wpn_type];
							};
						};
					};
				};
			};
		};
		if(isNil "ALL_MAGS_TO_SEARCH")then
		{
			ALL_MAGS_TO_SEARCH = [];
			_Cfgmagazines = configFile >> "CfgMagazines";
			for "_i" from 0 to (count _Cfgmagazines)-1 do
			{
				_magazine = _Cfgmagazines select _i;
				if(isClass _magazine)then
				{
					_mag_type = configName(_magazine);
					if((getText(_magazine >> 'displayName') != '') && {getText(_magazine >> 'picture') != ''} && {getNumber(_magazine >> 'scope') in [0,2]} && {!(_mag_type in ['AngelCookies','Skinbase','ItemCore'])})then
					{
						if !(_mag_type in ALL_MAGS_TO_SEARCH)then
						{
							ALL_MAGS_TO_SEARCH = ALL_MAGS_TO_SEARCH + [_mag_type];
						};
					};
				};
			};
		};
		if(isNil "ALL_VEHS_TO_SEARCH")then
		{
			ALL_VEHS_TO_SEARCH = [];
			_cfgvehicles = configFile >> "cfgVehicles";
			for "_j" from 0 to (count _cfgvehicles)-1 do
			{
				_vehicle = _cfgvehicles select _j;
				if(isClass _vehicle)then
				{
					_veh_type = configName _vehicle;
					if((getText(_vehicle >> 'displayName') != '') && {getText(_vehicle >> 'picture') != ''} && {getNumber(_vehicle >> 'scope') in [0,2]} && {((_veh_type isKindOf "Air") || (_veh_type isKindOf "LandVehicle") || (_veh_type isKindOf "Ship"))})then
					{
						ALL_VEHS_TO_SEARCH = ALL_VEHS_TO_SEARCH + [_veh_type];
					};
				};
			};
		};
		if(isNil "ALL_OBJ_TO_SEARCH")then
		{
			ALL_OBJ_TO_SEARCH = [];
			_cfgvehicles = configFile >> "cfgVehicles";
			for "_j" from 0 to (count _cfgvehicles)-1 do
			{
				_vehicle = _cfgvehicles select _j;
				if(isClass _vehicle)then
				{
					_veh_type = configName _vehicle;
					if((getText(_vehicle >> 'displayName') != '') && {getText(_vehicle >> 'picture') != ''} && {getNumber(_vehicle >> 'scope') in [0,2]} && {((_veh_type isKindOf "Building") || (_veh_type isKindOf "House"))})then
					{
						ALL_OBJ_TO_SEARCH = ALL_OBJ_TO_SEARCH + [_veh_type];
					};
				};
			};
			ALL_OBJ_TO_SEARCH = ALL_OBJ_TO_SEARCH + ["MAP_LHD_house_1"];
			ALL_OBJ_TO_SEARCH = ALL_OBJ_TO_SEARCH + ["Land_A_Villa_EP1"];
		};
	};
	if(isNil 'admin_dofirst_state')then
	{
		admin_dofirst_state = true;
		[] spawn admin_do_this_first;
	};
};