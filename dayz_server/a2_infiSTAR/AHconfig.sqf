/*
	Author: Chris(tian) "infiSTAR" Lorenzen
	Contact: infiSTAR23@gmail.com // www.infiSTAR.de
	
	Description:
	Arma AntiHack & AdminTools - infiSTAR.de
	
	ON LINUX YOU NEED THIS PARAMETER: -profiles
	
	
	______ _____  ___ ______  ______ _____ _     _____  _    _ 
	| ___ \  ___|/ _ \|  _  \ | ___ \  ___| |   |  _  || |  | |
	| |_/ / |__ / /_\ \ | | | | |_/ / |__ | |   | | | || |  | |
	|    /|  __||  _  | | | | | ___ \  __|| |   | | | || |/\| |
	| |\ \| |___| | | | |/ /  | |_/ / |___| |___\ \_/ /\  /\  /
	\_| \_\____/\_| |_/___/   \____/\____/\_____/\___/  \/  \/ 
	
	Don't forget to read the readme.txt
	-
	Make sure to have proper settings!
*/
/* ********************************************************************************* */
/* *******************Developer : infiSTAR (infiSTAR23@gmail.com)******************* */
/* **************infiSTAR Copyright®© 2011 - 2024 All rights reserved.************** */
/* *********************************www.infiSTAR.de********************************* */
/* ********************************************************************************* */
/*  infiSTAR.de .dll path */  /* REMOVED */
/*  Key to open the menu  */ _OpenMenuKey = 0x3C;    /* google DIK_KeyCodes (0x3C is F2) */
/*  LOW ADMIN HERE        */ _LAdmins = ["0","0","0"]; //do not have a , at the end.
/*  NORMAL ADMIN HERE     */ _NAdmins = ["0","0","0"]; //do not have a , at the end.
/*  SUPER ADMIN HERE      */ _SAdmins = ["76561198067477778","76561198066910299","76561197992049260","76561198843874020"]; //do not have a , at the end.
/*  BANNED UIDs HERE      */ _BLOCKED = ["0","0","0"]; //do not have a , at the end.

/*  HEADLESS ClIENT UIDs  */ _HEADLESS_CLIENT_UIDs = ["0","0","0"]; //do not have a , at the end.

/*  Use Player White-list */ _UPW = true;	/* true or false */
/*  WHITELIST UIDs HERE   */ _WHITELIST = ["76561198067477778","76561198066910299","76561197992049260","76561198843874020"]; //do not have a , at the end.
/* ********************************************************************************* */
serverName = "Lenny`s Oripoch (PVE)"; // Name of this Server (same as in config file would make sense.)
/*  Top esc menu TXT      */ _TopOfESC = "Lenny`s Oripoch"; //do not use " in this text.
/*  Bottom esc menu TXT   */ _LowerTop = "Have fun!"; //do not use " in this text.
/*  Bottom esc menu TXT2  */ _LowerBottom = "Play fair! PVE!"; //do not use " in this text.
/*  Color esc menu TXT    */ _EscColor = [0.6,0,0,1];
/*  DebugMonitor TXT      */ _BottomDebug = "Lenny`s Oripoch (PVE)"; //do not use " in this text.
/*  DebugMonitor Key      */ _ODK =  0xCF;	/* google DIK_KeyCodes (0xCF is END) */
/*  Use DebugMonitor      */ _DMS =  true;	/* true or false */	/* starts up with debugmonitor ON if true */
/*  DebugMonitor Action   */ _DMW = false;	/* true or false */	/* "Debug" option on mousewheel */
/* ********************************************************************************* */
/*
	Your server is getting attacked by local explosions? well on scriptbase we can not do much against that besides blocking the damage from it.
	below you will find an array of damage sources from what the damage will be blocked
*/
_blockDamageFrom = [
	'',	// This might also block fall damage, however since hackers create Bombs using "createVehicleLocal" it sometimes results in us seeing it on our client as '' nothing.
	'SmallSecondary',	// also happens when a vehicle explodes
	'HelicopterExploSmall','HelicopterExploBig',
	'PipeBomb','TimeBomb',
	'Mine','MineE',
	'GrenadeHand','GrenadeHand_stone','grenadecore',
	'R_57mm_HE','M_9M311_AA',
	'M_AT2_AT','M_AT5_AT','M_AT6_AT','M_AT9_AT','M_AT13_AT','Bo_GBU12_LGB','Bo_FAB_250','G_Camel_HE','M_Ch29_AT','Sh_122_HE','Sh_125_SABOT','Sh_125_HE','R_Hydra_HE',
	'R_GRAD','M_Hellfire_AT','M_Igla_AA','Sh_105_HE','B_20mm_AA','B_30x113mm_M789_HEDP','Sh_120_SABOT','Sh_120_HE',
	'M_Maverick_AT','G_40mm_HE','Bo_Mk82','R_MLRS','M_R73_AA','R_80mm_HE','R_S8T_AT','M_Sidewinder_AA','M_Sidewinder_AA_F35','R_PG9_AT','R_OG9_HE','M_Stinger_AA','M_TOW_AT','M_TOW2_AT',
	'M_Vikhr_AT','Sh_85_AP','Sh_85_HE','ARTY_Sh_122_HE','ARTY_Sh_122_WP','ARTY_Sh_105_HE','ARTY_Sh_105_WP','ARTY_Sh_81_HE','ARTY_Sh_81_WP','ARTY_Sh_82_HE','ARTY_Sh_82_WP',
	'ARTY_R_227mm_HE_Rocket','ARTY_R_120mm_HE_Rocket','ARTY_Sh_82_ILLUM','ARTY_Sh_105_SADARM','ARTY_Sh_105_LASER','ARTY_Sh_105_SMOKE','ARTY_Sh_105_ILLUM','ARTY_Sh_122_SADARM',
	'ARTY_Sh_122_LASER','ARTY_Sh_122_SMOKE','ARTY_Sh_122_ILLUM','ARTY_Sh_81_ILLUM'	
];



/*  Use Loaded Check(s)   */ _AHL = false;	/* true or false */	/* "AH NOT LOADED ON PLAYER" */
/*  _timedif for _AHL     */ _TDI =    130;	/*   45 - 300   */	/* only used if "_AHL = true;" -> takes longer to detect if the AH is loaded on a player or not. */

/*  unitRecoil checks     */ _URC = false;	/* true or false */	/* checks unitRecoilCoefficient and resets default unitRecoilCoefficient */
/*  Log Bad Keys pressed  */ _LBK = false;	/* true or false */	/* will be logged to surveillancelog.. can become huge spam I would have it disabled */
/*  Punish Forbidden Keys */ _PBK =  true;	/* true or false */	/* will freeze the user on BadKey click for ~3 seconds! */
/*  Forbid VON Sidechat   */ _VON =  true;	/* true or false */	/* talking on sidechat will put out a warning and kick if continue */
/*  Use Chat Functions    */ _UCF =  true;	/* true or false */	/* Enables Chatfunctions like /dance */

/*  Use vehicle check?    */ _UVC = false;	/* true or false */	/* using _ALLOWED_Vehicles and _FORBIDDEN_Vehicles lists */
/*  Use zombie check?     */ _UZC = false;	/* true or false */	/* "Walk Amongst The Dead" or "ESS" needs this set to false */
/*  Vehicle WHITELIST     */ _UVW = false;	/* true or false */	/* if false - _ALLOWED_Vehicles won't not be used */

/*  Cheatengine Checks ?  */ _UCC =  true;	/* true or false */	/* certain strings have been changed */
/*  Use Anti Teleport?    */ _UAT =  true;	/* true or false */
/*  DynamicText Checks ?  */ _UCS = false;	/* true or false */	/* dynamicText ~ often colored, animated or used in credits */
/*  Use Damage Check ?    */ _UDC =  true;	/* true or false */	/* try to catch Hacks that change the damage value of weapons (DayZ mods only (DayZ, Epoch, Overwatch and others)) */

/*  Remove "itemsAdded"   */ _RAI =  false;	/* true or false */	/* might remove items from a custom crafting system.. */
/*  HACKED BOX Check ?    */ _CHB =  false;	/* true or false */	/* custom crates might be deleted if "Max Cargo Count" is to low */
/*  Max Cargo Count ?     */ _MCC =  3000;

/*  MouseMoving EH check  */ _MOH = false;	/* true or false */	/* will say: "MouseMoving EventHandler added" - needs to be disabled for UAV scripts and such.. */
/*  Close Dialogs ?       */ _CUD = false;	/* true or false */	/* Closes custom Dialogs (Menus) that are not in _ALLOWED_Dialogs */
/*  check MapSingleClick  */ _OMC = false;	/* true or false */	/* announces: "MapSingleClick modified", if modification is found - NEEDS _MBC to be true! */
/*  Remove Keybinds ?     */ _RCK = false;	/* true or false */	/* Removes custom Keybinds and sets back the default ones */
/*  Check CMDMenus ?      */ _CCM = false;	/* true or false */	/* only disable this if you know what you are doing. I strongly recommend to use this! */
/*  BLOCK ALL CMDMenus    */ _BCM =  true;	/* true or false */	/* we don't need commandingMenus. so have this true as well. */
/*  Check Actions ?       */ _CSA = false;	/* true or false */	/* this checks mousewheel actions */
/*  Force Terrain Grid ?  */ _FTG =    25;	/* 50, 25, 12.5  */	/* if set to 50 grass will be very low for better client FPS.. default is 25 */
/* ********************************************************************************* */
/*  ALLOWED Custom Dialogs "_ALLOWED_Dialogs" are only used if you have "_CUD =  true;"  */
/*  If you want install custom scripts using dialog windows, you can add IDD numbers  */
/*  from the custom script's desc.h file included through MPMIssions/description.ext  */
_ALLOWED_Dialogs = [
	-1,4,63,129,106,666,667,2200,6900,6901,6902,6903,6999,
	41144,61144,76761,80000,420420,
	711194,711195,711197,690000,4099999
];
//	-1			Epoch Safe/Lockbox Keycode UI
//	106		Inventory (Gear)
//	2200		Blood Test
//	6900,6901,6902,6903	New Player (select Gender and such things)
//	420420	Epoch Trader
//	41144		Epoch Door Keycode UI
//	129		Diary
//	666,667	Clay Car Radio
//	4444		Radio Communication
//	65431,65432,65433,65434,65440,65441,65442		R3F ARTY Lift/Tow/Transport.
//	711194	Plot Management	(http://epochmod.com/forum/index.php?/topic/16166-release-plot-management/)
_ALLOWED_Dialogs = _ALLOWED_Dialogs + [81000,88890,20001,20002,20003,20004,20005,20006,55510,55511,55514,55515,55516,55517,55518,55519,555120,118338,118339,571113]; // adding some others from community addons


/*  Player that have one of these items in their inventory will get punished!  */
_ForbiddenItems =
[
	"ItemMap_Debug","ItemCore","Laserdesignator"
];

/*  If "_UVC =  true;" and "_UVW =  true;" this will delete all vehicles that are not in "_ALLOWED_Vehicles"  */
_ALLOWED_Vehicles = ["ALL IF _UVW = false","Tractor","Policecar"];

/*  If "_UVC =  true;" this will delete all vehicles that are in "_FORBIDDEN_Vehicles"  */
_FORBIDDEN_Vehicles =
[
	"A10","AH1Z","AH64D","T90","F35B","AV8B2","UH1Y","Mi24_V",
	"Mi24_P","Mi24_D","KA52","KA52Black","SU39","Su25_CDF","SU25_Ins",
	"A10_US_EP1","AH64D_EP1","M1A1","M1A1_TUSK_MG","T72","T72_INS","T72_RU",
	"T72_CDF","T72_Gue","BMP3","MLRS","T34","2S6M_Tunguska", "Su25_TK_EP1",
	"BAF_Apache_AH1_D","UH60M_EP1","UH60M_MEV_EP1","Mi171Sh_rockets_CZ_EP1",
	"Mi24_D_TK_EP1","L39_TK_EP1","M1A1_US_DES_EP1","M1A2_US_TUSK_MG_EP1",
	"T72_TK_EP1","BMP2_TK_EP1","BMP2_UN_EP1","BMP2_HQ_TK_EP1","ZSU_TK_EP1",
	"MLRS_DES_EP1","T34_TK_EP1","T34_TK_GUE_EP1","T55_TK_EP1","T55_TK_GUE_EP1","M2A2_EP1",
	"M2A3_EP1","M6_EP1","BAF_FV510_D","BAF_FV510_W"
];

/*  ALLOWED CMDMenus "_cMenu" are only used if you have "_BCM = false;" which I would not recommend.  */
_cMenu =
[
	"","RscMainMenu","RscMoveHigh","#WATCH","#WATCH0",
	"RscWatchDir","RscDisplayClassSelecter","RscDisplayGenderSelect",
	"RscDisplaySpawnSelecter","RscWatchMoreDir","#GETIN","RscStatus",
	"RscCombatMode","RscFormations","RscTeam","RscSelectTeam","RscReply",
	"RscCallSupport","#ACTION","#CUSTOM_RADIO","RscRadio","RscGroupRootMenu",
	"BTC_Hud","PlotManagement","DoorManagement","Entercode","#USER:_keyMenu"
];

/*  ALLOWED Actions "_dayzActions" are only used if you have "_CSA =  true;"  */
_dayzActions =
[
	"ActionMenu","batteryLevelCheckRavenAct","batteryRechargeRavenAct","bis_fnc_halo_action","BTC_liftActionId","BTC_liftHudId","BTC_SganciaActionId",
	"churchie_check","churchie_defuse","churchie_rig_veh","dayz_myCursorTarget","dayz_myLiftVehicle","degreeActions","disassembleRavenAct","DonorSkins",
	"DoorManagement","Entercode","horror_traders","launchRavenAct","manatee_craft_menu","manatee_craft_menu_ind","manatee_craft_menu_sur",
	"manatee_craft_menu_wea","mavBaseStationActionName_00","mavBaseStationActionName_001","mavBaseStationActionName_01","mavBaseStationActionName_02",
	"mavBaseStationActionName_03","mavBaseStationActionName_04","menu_CIV_EuroMan01_EP1","menu_CIV_EuroMan02_EP1","menu_Doctor","menu_Dr_Hladik_EP1",
	"menu_Pilot_EP1","menu_Profiteer4","menu_Rita_Ensler_EP1","menu_Rocker4","menu_RU_Citizen1","menu_RU_Citizen3","menu_RU_Citizen4",
	"menu_RU_Functionary1","menu_RU_Villager3","menu_RU_WorkWoman1","menu_RU_WorkWoman5","menu_TK_CIV_Takistani04_EP1","menu_Woodlander1",
	"menu_Woodlander3","menu_Worker2","menu_Worker3","neutral","NORRN_dropAction","nul","null","player_Cannibalism","r_player_actions",
	"r_player_actions2","s_bank_dialog","s_bank_dialog2","s_build_Hedgehog_DZ","s_build_Sandbag1_DZ","s_build_Wire_cat1","s_building_snapping",
	"s_clothes","s_givemoney_dialog","s_halo_action","s_player_1bupd","s_player_attach_bomb","s_player_attack","s_player_barkdog","s_player_boil",
	"s_player_breakinhouse","s_player_BuildLock","s_player_BuildUnLock","s_player_butcher","s_player_butcher_human","s_player_calldog",
	"s_player_callzombies","s_player_checkGear","s_player_clearEvacChopper","s_player_CloseGate","s_player_clothes","s_player_cnbb",
	"s_player_codeObject","s_player_codeRemove","s_player_codeRemoveNet","s_player_combi","s_player_cook","s_player_craftZombieBait",
	"s_player_craftZombieBaitBomb","s_player_dance","s_player_debug","s_player_debugCheck","s_player_deleteBuild","s_player_deleteCamoNet",
	"s_player_deploybike","s_player_deploybike2","s_player_deploygyro","s_player_deployjetski","s_player_deploymoped","s_player_deploymoped2",
	"s_player_deploymozzie","s_player_deploymozzie2","s_player_destorytent","s_player_disarmBomb","s_player_downgrade_build","s_player_dragbody",
	"s_player_Drinkfromhands","s_player_dropflare","s_player_enterCode","s_player_equip_carry","s_player_evacCall","s_player_feeddog",
	"s_player_fillfuel","s_player_fillfuel20","s_player_fillfuel210","s_player_fillfuel5","s_player_fillgen","s_player_fillwater",
	"s_player_fillwater2","s_player_fire","s_player_fireout","s_player_fishing","s_player_fishing_veh","s_player_flipveh","s_player_flipvehicleheavy",
	"s_player_flipvehiclelight","s_player_followdog","s_player_forceSave","s_player_fuelauto","s_player_fuelauto2","s_player_gather",
	"s_player_grabflare","s_player_heli_detach","s_player_heli_lift","s_player_holderPickup","s_player_igniteTent","s_player_information",
	"s_player_isCruse","s_player_knockout","s_player_lastTarget","s_player_load_help","s_player_lockhouse","s_player_lockunlock",
	"s_player_lockUnlock_crtl","s_player_lockUnlockInside_ctrl","s_player_lockvault","s_player_maint_build","s_player_maintain_area",
	"s_player_maintain_area_preview","s_player_maintain_area_previewd","s_player_maintain_aread","s_player_makeBomb","s_player_makeEvacChopper",
	"s_player_makePLBomb","s_player_manageDoor","s_player_menu","s_player_movedog","s_player_netCodeObject","s_player_newbie_kit",
	"s_player_openGate","s_player_otkdv","s_player_packbike","s_player_packFdp","s_player_packjetski","s_player_packMozzie","s_player_packtent",
	"s_player_packtentinfected","s_player_packvault","s_player_painkiller","s_player_paint","s_player_parts","s_player_parts_crtl",
	"s_player_plot_boundary_off","s_player_plot_boundary_on","s_player_plot_take_ownership","s_player_plotManagement","s_player_pzombiesattack",
	"s_player_pzombiesfeed","s_player_pzombiesvision","s_player_rearm_action","s_player_recipeMenu","s_player_refuel_action","s_player_removeActions",
	"s_player_removeflare","s_player_repair_action","s_player_repair_crtl","s_player_repairActions","s_player_rest","s_player_scrollBandage",
	"s_player_selfBloodbag","s_player_setCode","s_player_setVectors1","s_player_setVectors45","s_player_setVectors5","s_player_setVectors90",
	"s_player_setVectorsBack","s_player_setVectorsForward","s_player_setVectorsLeft","s_player_setVectorsReset","s_player_setVectorsRight",
	"s_player_showname","s_player_showname1","s_player_siphonfuel","s_player_sleep","s_player_smelt_engineparts","s_player_smelt_fueltank",
	"s_player_smelt_jerrycan","s_player_smelt_mainrotoraryparts","s_player_smelt_scrapmetal","s_player_smelt_wheel","s_player_smelt_windscreenglass",
	"s_player_smeltItems","s_player_smeltRecipes","s_player_speeddog","s_player_stats","s_player_staydog","s_player_studybody","s_player_suicide",
	"s_player_SurrenderedGear","s_player_takeOwnership","s_player_tamedog","s_player_toggleDegree","s_player_toggleDegrees","s_player_toggleSnap",
	"s_player_toggleSnapSelect","s_player_toggleSnapSelectPoint","s_player_toggleVector","s_player_toggleVectors","s_player_towing","s_player_trackdog",
	"s_player_unlockhouse","s_player_unlockvault","s_player_upgrade_build","s_player_upgradebike","s_player_upgradegyro","s_player_upgrademoto",
	"s_player_upgradestorage","s_player_upgradestroage","s_player_warndog","s_player_waterdog","s_player_zombieShield","s_player_vi1387345919_copyToKey",
	"s_siphon","s_vehicle_lockunlock","s_vehicle_lockUnlock_crtl","silver_myCursorTarget","snapActions","SP_rearm_actions","SP_refuel_action",
	"SP_repair_action","stow_vehicle","STR_R3F_ARTY_action_ouvrir_dlg_SM","STR_R3F_LOG_action_charger_deplace","STR_R3F_LOG_action_charger_selection",
	"STR_R3F_LOG_action_contenu_vehicule","STR_R3F_LOG_action_deplacer_objet","STR_R3F_LOG_action_detacher","STR_R3F_LOG_action_heliport_larguer",
	"STR_R3F_LOG_action_heliporter","STR_R3F_LOG_action_relacher_objet","STR_R3F_LOG_action_remorquer_deplace","STR_R3F_LOG_action_remorquer_selection",
	"STR_R3F_LOG_action_selectionner_objet_charge","STR_R3F_LOG_action_selectionner_objet_remorque","strobeRavenResetAct","strobeRavenTestAct",
	"Tow_settings_action_charger_deplace","Tow_settings_action_charger_selection","Tow_settings_action_contenu_vehicule",
	"Tow_settings_action_deplacer_objet","Tow_settings_action_detacher","Tow_settings_action_heliport_larguer","Tow_settings_action_heliporter",
	"Tow_settings_action_relacher_objet","Tow_settings_action_remorquer_deplace","Tow_settings_action_remorquer_selection",
	"Tow_settings_action_selectionner_objet_charge","Tow_settings_action_selectionner_objet_remorque","Tow_settings_dlg_CV_btn_decharger",
	"Tow_settings_dlg_CV_btn_fermer","Tow_settings_dlg_CV_titre","unpackRavenAct","vectorActions","wardrobe"
];
/* ********************************************************************************* */
//	NEW (EXPERIMENTAL):
_UDP = false;	// Use Dupe Protection			/* true or false */
_URG = false;	// Antirefuel & AntiCargod		/* true or false */
_UIC = false;	//	Vehicle ID Check	/* true or false */
_UCL =  true;	// Use Anti Combat Log	/* true or false */


/*
	"_UIM": Use Incognito Mode, makes it for the most part look like you don't run infiSTAR to the normal player.
	But for that it disables for example:
	Script Scan, reworked unconscious, Bad Keybinds, The debugmonitor,
	Escape Menu will be default again, Chatfunctions and more
	So it will make the server more unsecure! but look like it's a default one.
*/
_UIM = false;	/* true or false */


/*
	"_sUptime": Server Uptime in seconds!
	Using this will show "Restart in: xh xxmin"
	If you don't want to use it - just do:
	_sUptime = 0;
*/
_sUptime = 0;


/*
	"_UDN": Players can Vote if they want Day- or NighTime
	!vote day,/vote day, vote day,
	!vote night,/vote night, vote night
*/
_UDN =  false;	/* true or false */



/*
	custom Box content:
	just an item like it is in the example with   'ItemMap'   will put the item once in the box.
	if an array is used like the   ['ItemGPS',5]   example, well I assume you could guess what it will do.
*/
_SupportBox1Content =
[
	'ItemMap',['ItemGPS',3],'ItemWatch'
];

_SupportBox2Content =
[
	'ItemMap',['ItemGPS',2],'ItemWatch'
];

_SupportBox3Content =
[
	'ItemMap',['ItemGPS',7],'ItemWatch'
];



/*
	custom Vault content (EPOCH ONLY), make sure to insert the Items in the right places :)
*/
//	Support-Vault1
_weapons1 = [
	[],
	[]
];
_magazines1 = [
	['plot_pole_kit', 'ItemComboLock'],
	[2,5]
];
_backpack1 = [
	[],
	[]
];


//	Support-Vault2
_weapons2 = [
	[],
	[]
];
_magazines2 = [
	['plot_pole_kit', 'ItemComboLock'],
	[1,3]
];
_backpack2 = [
	[],
	[]
];


//	Support-Vault3
_weapons3 = [
	[],
	[]
];
_magazines3 = [
	['plot_pole_kit', 'ItemComboLock'],
	[5,6]
];
_backpack3 = [
	[],
	[]
];
/* ********************************************************************************* */
/* *******************Developer : infiSTAR (infiSTAR23@gmail.com)******************* */
/* **************infiSTAR Copyright®© 2011 - 2024 All rights reserved.************** */
/* *********************************www.infiSTAR.de********************************* */
/* ****DayZAntiHack.com***DayZAntiHack.de***ArmaAntiHack.com***Arma3AntiHack.com**** */
diag_log ("<infiSTAR.de> infiSTAR AHconfig.sqf loaded");