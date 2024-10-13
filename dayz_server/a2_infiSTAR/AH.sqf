/*
	Author: Chris(tian) "infiSTAR" Lorenzen
	Contact: infiSTAR23@gmail.com // www.infiSTAR.de
	
	Description:
	Arma AntiHack & AdminTools - infiSTAR.de
*/
/* *******************Developer : infiSTAR (infiSTAR23@gmail.com)******************* */
/* **************infiSTAR Copyright®© 2011 - 2024 All rights reserved.************** */
/* ********************************07-10-2024 18-14-07-v1452********************************* */
/* *********************************www.infiSTAR.de********************************* */
if(!isNil "infiSTAR_LoadStatus")exitWith {diag_log "<infiSTAR.de> infiSTAR_LoadStatus: infiSTAR is already loaded!";};
infiSTAR_LoadStatus = true;
infiSTAR_serverInit = false;publicVariable 'infiSTAR_serverInit';






fn_clean_bad = {
	private '_clean';
	_clean = _this;
	_clean = toArray _clean;
	_clean = _clean - [35];
	_clean = toString _clean;
	_clean
};
fn_select_string_rest = {
	private ['_input','_from','_newArray','_inputArray','_i'];
	_input = _this select 0;
	_from = _this select 1;
	
	_newArray = [];
	_inputArray = toArray _input;
	for '_i' from _from to (count _inputArray)-1 do
	{
		_newArray = _newArray + [_inputArray select _i];
	};
	toString _newArray
};
fn_select_string_range = {
	private ['_input','_from','_to','_newArray','_inputArray','_max','_i'];
	_input = _this select 0;
	_from = _this select 1;
	_to = _this select 2;
	
	_newArray = [];
	_inputArray = toArray _input;
	_max = (count _inputArray)-1;
	if(_to > _max)then{_to = _max;};
	for '_i' from _from to _to do
	{
		_newArray = _newArray + [_inputArray select _i];
	};
	toString _newArray
};
IAH_fnc_getIntFromString = {
	private["_input","_inputArray","_newArray"];
	_input = _this select 0;
	if (_input == "") exitWith {-1};
	_inputArray = toArray _input;
	_newArray = _inputArray select 0;
	diag_log format["IAH_fnc_getIntFromString: %1",_newArray];
	if(typeName _newArray == "ARRAY")then{ diag_log format["IAH_fnc_getIntFromString: %1",toString _newArray]; };
	_newArray
};
if(isNil"serverName")then{serverName="EMPTY";};
if(typeName serverName != "STRING")then{serverName="ERROR";};
//diag_log format["<infiSTAR.de> updatearmalog callExtension: %1","updatearmalog" callExtension "update"];
_response = "armalog" callExtension ("1sn="+str(toArray ("ARMA2_"+serverName)));
_armalog = ([_response] call IAH_fnc_getIntFromString == 0x01);
if(!_armalog)then{
	diag_log "<infiSTAR.de> Error loading infiSTAR DLL";
	diag_log "<infiSTAR.de> vi1387345919";
	diag_log "<infiSTAR.de> d0cbb9e68e247e37857c3fe2415eba";
	diag_log format["<infiSTAR.de> %1",[_response, 1] call fn_select_string_rest];
};
if(_armalog)then{
	diag_log "<infiSTAR.de> infiSTAR dll loaded successfully";
	diag_log format["<infiSTAR.de> %1",[_response, 1] call fn_select_string_rest];
	diag_log "<infiSTAR.de> Loading infiSTAR code..";

	infiSTAR_LogFolderName = "My_infiSTAR_Logs\";
	FN_CALL_LOG_DLL = {
		private ["_filename","_logentry"];
		_filename = _this select 0;
		_logentry = _this select 1;
		"armalog" callExtension format["2%1%2|%3", infiSTAR_LogFolderName, _filename, _logentry];
	};

	FN_ARMA_FETCHDATA = {
		private["_url","_response","_id","_timeOut","_parts","_output"];
		_url = _this select 0;
		_url = _url call fn_clean_bad;
		if (_url == "") exitWith {""};

		"armalog" callExtension ("7" + _url)
	};

	FN_ARMA_FIREANDFORGET = {
		private ["_url"];
		_url = _this select 0;
		_url = _url call fn_clean_bad;
		if (_url == "") exitWith {""};
		"armalog" callExtension format["3%1", _url]
	};

	FN_ARMA_REMOTELOG = {
		_logname = _this select 0;
		_logentry = _this select 1;
		"armalog" callExtension ("8"+"a2"+";;"+_logname+";;"+_logentry+";;"+"07-10-2024 18-14-07 - v1452");
	};
}
else
{
	FN_CALL_LOG_DLL = {diag_log ('<infiSTAR.de> ' + (str _this));};
	FN_ARMA_FETCHDATA = {};
	FN_ARMA_FIREANDFORGET = {};
	FN_ARMA_REMOTELOG = {};
};
fn_custom_log = FN_CALL_LOG_DLL;
fn_remote_log = {
	_this call fn_custom_log;
	_this call FN_ARMA_REMOTELOG;
};








['START','waiting..'] call fn_custom_log;
waitUntil {!isNil 'sm_done'};
diag_log ("<infiSTAR.de> infiSTAR loading config..");
#include "AHconfig.sqf"
diag_log ("<infiSTAR.de> infiSTAR LOADING..");
['START','infiSTAR LOADING..'] call fn_custom_log;
_MEH = if(isNil'EpochEvents')then{false}else{diag_log 'Epoch detected';true};
if(isNil'dayZ_instance')then{dayZ_instance = '1';publicVariable 'dayZ_instance';};


if(isNil"BIS_fnc_distance2D")then{BIS_fnc_distance2D = {(_this select 0) distance (_this select 1)};};publicVariable "BIS_fnc_distance2D";
if(isNil"BIS_fnc_dirTo")then{BIS_fnc_dirTo = {systemChat "Function missing: BIS_fnc_dirTo";};};publicVariable "BIS_fnc_dirTo";
if(isNil"BIS_fnc_relPos")then{BIS_fnc_relPos = {systemChat "Function missing: BIS_fnc_relPos";};};publicVariable "BIS_fnc_relPos";
if(isNil"BIS_fnc_invAdd")then{BIS_fnc_invAdd = {systemChat "Function missing: BIS_fnc_invAdd";};};publicVariable "BIS_fnc_invAdd";
if(isNil"bis_fnc_dynamicText")then{bis_fnc_dynamicText = {hintSilent parseText (_this select 0);};};publicVariable "bis_fnc_dynamicText";
if(isNil"BIS_fnc_selectRandom")then{BIS_fnc_selectRandom = {_this select (floor(random ((count _this) - 1)))};};publicVariable "BIS_fnc_selectRandom";
if(isNil"BIS_fnc_infoText")then{BIS_fnc_infoText = {};};publicVariable "BIS_fnc_infoText";


fn_executeGlobal = {
	private "_reobj";
	_reobj = createVehicle ['WeaponHolder', [0,0,0], [], 0, 'CAN_COLLIDE'];
	_reobj addMPEventHandler ['MPKilled',_this];
	_reobj setDamage 1;
	deleteVehicle _reobj;
};
_PV_DevUlDs = ['0'];comment 'These IDs (player) are hidden in the Admin-Log and Playerlist of the AdminMenu but have SuperAdmin access';
_DONT_LOG = ['0'];comment 'These IDs (player) are hidden in the Admin-Log';

_BadSkins =
[
	'GoInvisible','InvisibleManW_EP1'
];
_watched =
[
	'PipeBomb','NVGoggles','Binocular_Vector','Binocular','Skin_Camo1_DZ','Skin_Sniper1_DZ',
	'ItemMap','ItemGPS','PartWoodPile','G17_FL_DZ','Revolver_DZ','revolver_gold_EP1',
	'30Rnd_556x45_G36','30Rnd_556x45_Stanag','Sa61_EP1','PDW_DZ','UZI_SD_EP1','M1911_DZ','M9_DZ','M9_SD_DZ',
	'Makarov_DZ','Makarov_SD_DZ','ItemMatchbox','ItemEtool','ItemAntibiotic','ItemBandage','ItemBloodbag',
	'ItemEpinephrine','ItemHeatPack','ItemMorphine','ItemPainkiller','ItemWire',
	'ItemKeyKit','Sa58V_RCO_EP1','AK_107_pso','AK_107_GL_pso','SVD_PSO1_Gh_DZ','SVD_PSO1_DZ','30Rnd_762x39_AK47',
	'30Rnd_545x39_AKSD','DMR_DZ','DMR_DZ','30Rnd_556x45_StanagSD','20Rnd_556x45_Stanag','30Rnd_556x45_G36SD',
	'10Rnd_762x54_SVD','ChainSaw','ChainSawB','ChainSawG','ChainSawP','ChainSawR','AKS_GOLD','Pecheneg_DZ',
	'AK74_DZ','AK74_Kobra_DZ','AKS_74_pso','Bizon_SD_DZ','G36_C_SD_eotech','G36a','M4A1_Aim_camo','M4A1_HWS_GL',
	'M4A1_RCO_GL','M4A1_DZ','Mk48_CCO_DZ','M8_carbineGL','M8_compact','M16A2_GL_DZ','M16A4','M16A4_ACOG_DZ','M8_sharpshooter',
	'M24_DZ','ItemSodaCoke','17Rnd_9x19_glock17','ItemCompass','30Rnd_9x19_UZI_SD','M8_carbine',
	'FoodCanBakedBeans','FoodCanFrankBeans','ItemSodaPepsi','ItemSodaMdew',
	'BAF_AS50_scoped','BAF_AS50_TWS','PMC_AS50_scoped','PMC_AS50_TWS',
	'BAF_AS50_scoped_Large','BAF_AS50_TWS_Large','PMC_AS50_scoped_Large','PMC_AS50_TWS_Large',
	'SCAR_L_STD_EGLM_TWS','M110_TWS_EP1','ItemCore','M136','Javelin','Stinger',
	'RPG7V','Strela','Igla','RPG18','MetisLauncher','SMAW','BAF_NLAW_Launcher'
];


fnc_infiSTAR_ServerkickNew = {
	private['_clientName','_clientUID','_playerObj','_reason','_do','_log'];
	_clientName = _this select 0;
	_clientUID = _this select 1;
	_playerObj = _this select 2;
	_reason = _this select 3;

	if(isNull _playerObj)then
	{
		{
			_xuid = getPlayerUID _x;
			if(_xuid != '' && _xuid == _clientUID)exitWith
			{
				_playerObj = _x;
			};
		} forEach playableUnits;
	};
	if(!isNull _playerObj)then
	{
		_playerObj setVariable ['KICKME',true,true];
		_do = 'if(player getVariable [''KICKME'',false])then{KickOFF = true;KICKED = true;publicVariableServer ''KICKED'';_d = (findDisplay 0) createDisplay ''RscDisplayMission'';(findDisplay 0) closeDisplay 0;};';
		_do call fn_executeGlobal;
		_playerObj setDamage 1;
	};

	if(_clientUID != '')then{
		_do = 'if(getPlayerUID player == '''+_clientUID+''')then{KickOFF = true;KICKED = true;publicVariableServer ''KICKED'';_d = (findDisplay 0) createDisplay ''RscDisplayMission'';(findDisplay 0) closeDisplay 0;};';
		_do call fn_executeGlobal;
	};

	_log = format['SERVER kicked %1(%2) - %3',_clientName,_clientUID,_reason];
	['KickLog',_log] call fn_remote_log;
};
if(!isNil '_sUptime')then
{
	if(typeName _sUptime != 'SCALAR')then
	{
		_sUptime = parseNumber _sUptime;
	};
	if(typeName _sUptime == 'SCALAR')then
	{
		if(_sUptime > 0)then
		{
			infiSTAR_UPTIMER = _sUptime;
			publicVariable 'infiSTAR_UPTIMER';
		};
	};
};
if((preProcessFileLineNumbers ("low_admins.sqf")) != "")then{
	_tmpLA = call compile preProcessFileLineNumbers "low_admins.sqf";
	if(!isNil '_tmpLA')then
	{
		if(typeName _tmpLA == 'ARRAY')then
		{
			if(str _tmpLA != '[]')then
			{
				_LAdmins = _LAdmins + _tmpLA;
			};
		};
	};
};
if((preProcessFileLineNumbers ("normal_admins.sqf")) != "")then{
	_tmpNA = call compile preProcessFileLineNumbers "normal_admins.sqf";
	if(!isNil '_tmpNA')then
	{
		if(typeName _tmpNA == 'ARRAY')then
		{
			if(str _tmpNA != '[]')then
			{
				_NAdmins = _NAdmins + _tmpNA;
			};
		};
	};
};
if((preProcessFileLineNumbers ("super_admins.sqf")) != "")then{
	_tmpSA = call compile preProcessFileLineNumbers "super_admins.sqf";
	if(!isNil '_tmpSA')then
	{
		if(typeName _tmpSA == 'ARRAY')then
		{
			if(str _tmpSA != '[]')then
			{
				_SAdmins = _SAdmins + _tmpSA;
			};
		};
	};
};
if((preProcessFileLineNumbers ("blacklist.sqf")) != "")then{
	_tmpBL = call compile preProcessFileLineNumbers "blacklist.sqf";
	if(!isNil '_tmpBL')then
	{
		if(typeName _tmpBL == 'ARRAY')then
		{
			if(str _tmpBL != '[]')then
			{
				_BLOCKED = _BLOCKED + _tmpBL;
			};
		};
	};
};
iproductVersion = '07-10-2024 18-14-07-v1452';
_log = format['<infiSTAR.de> iproductVersion: %1 | Server productVersion: %2 | worldName: %3 | dayz_instance: %4 | missionName: %5',iproductVersion,productVersion,worldName,dayz_instance,missionName];
diag_log _log;
['START',_log] call fn_remote_log;
_version = productVersion select 3;
if(_version < 103718)exitWith{ diag_log format['<infiSTAR.de> Server Arma2OA beta is outdated! (%1)',_version]; };
_fnc_RandomGen =
{
	_abc = ['z','y','x','w','v','u','t','s','r','q','p','o','n','m','l','k','j','i','h','g','f','e','d','c','b','a'];
	_gen = _abc select (random ((count _abc)-1));
	_arr = ['a','d','0','c','b','b','9','e','6','8','e','2','4','7','e','3','7','8','5','7','c','3','f','e','2','4','1','5','e','b','a'];
	for '_i' from 0 to (8+(round(random 3))) do {_gen = _gen + str(round(random 9)) + (_arr select (random ((count _arr)-1)));};
	_gen
};diag_log format['<infiSTAR.de> _fnc_RandomGen: %1',_fnc_RandomGen];
_simple = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _simple: %1',_simple];
_dialogIds = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _dialogIds: %1',_dialogIds];
_badtxts = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _badtxts: %1',_badtxts];
_randvar1 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _randvar1: %1',_randvar1];
_randvar2 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _randvar2: %1',_randvar2];
_randvar3 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _randvar3: %1',_randvar3];
_randvar4 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _randvar4: %1',_randvar4];
_randvar5 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _randvar5: %1',_randvar5];
_randvar6 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _randvar6: %1',_randvar6];
_randvar11 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _randvar11: %1',_randvar11];
_randvar12 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _randvar12: %1',_randvar12];
_randvar13 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _randvar13: %1',_randvar13];
_randvar14 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _randvar14: %1',_randvar14];
_randvar19 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _randvar19: %1',_randvar19];
_randvar27 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _randvar27: %1',_randvar27];
_randvar25 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _randvar25: %1',_randvar25];
_randvar31 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _randvar31: %1',_randvar31];
_randvar33 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _randvar33: %1',_randvar33];
_randvar34 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _randvar34: %1',_randvar34];
_randvar35 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _randvar35: %1',_randvar35];
_randvar36 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _randvar36: %1',_randvar36];
_randvar37 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _randvar37: %1',_randvar37];
_fnc_handlerandvar10 = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _fnc_handlerandvar10: %1',_fnc_handlerandvar10];
_remark = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _remark: %1',_remark];
_AHpos = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _AHpos: %1',_AHpos];
_loadedcheckpos = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _loadedcheckpos: %1',_loadedcheckpos];
_loadedchecktime = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _loadedchecktime: %1',_loadedchecktime];
_MenuChecksRunningx = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _MenuChecksRunningx: %1',_MenuChecksRunningx];
_anotherloop = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _anotherloop: %1',_anotherloop];
_lastUnlock = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _lastUnlock: %1',_lastUnlock];
_AdminReqCheck = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _AdminReqCheck: %1',_AdminReqCheck];
_antidupeCheckVar = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _antidupeCheckVar: %1',_antidupeCheckVar];
_antidupePVResVar = call _fnc_RandomGen;diag_log format['<infiSTAR.de> _antidupePVResVar: %1',_antidupePVResVar];
_antidupePVCheckVar = 'PVAHR_0_' + (call _fnc_RandomGen);diag_log format['<infiSTAR.de> _antidupePVCheckVar: %1',_antidupePVCheckVar];
_antidupePVEH = format['_a=0;''%1'' addPublicVariableEventHandler { %2 = true; (owner (_this select 1)) publicVariableClient ''%2''; };', _antidupePVCheckVar, _antidupePVResVar];
call compile _antidupePVEH;
_randvar10 = 'PVAHR_0_' + (call _fnc_RandomGen);diag_log format['<infiSTAR.de> _randvar10: %1',_randvar10];


_SupportVault1Content = [_weapons1,_magazines1,_backpack1];
_SupportVault2Content = [_weapons2,_magazines2,_backpack2];
_SupportVault3Content = [_weapons3,_magazines3,_backpack3];
call compile ("
	_kickfnc = {
		diag_log '<infiSTAR.de> calling kick fnc..';
		[] spawn {call compile ('endMission ''LOSER'';');call compile ('forceEnd;');};
		KICKED = 'k';publicVariableServer 'KICKED';
		for '_i' from 0 to 99 do {(findDisplay _i) closeDisplay 0;};
		_d = (findDisplay 0) createDisplay 'RscDisplayMission';(findDisplay 0) closeDisplay 0;
	};
	"+_randvar2+" = _kickfnc;
	publicVariable '"+_randvar2+"';
	"+_randvar37+" = {"+_randvar10+" = _this;publicVariableServer'"+_randvar10+"';};publicVariable '"+_randvar37+"';

	fnc_getSupportVaultContent = {
		if(_this==1)exitWith{"+str _SupportVault1Content+"};
		if(_this==2)exitWith{"+str _SupportVault2Content+"};
		if(_this==3)exitWith{"+str _SupportVault3Content+"};
		nil
	};
	fnc_getSupportBoxContent = {
		if(_this==1)exitWith{"+str _SupportBox1Content+"};
		if(_this==2)exitWith{"+str _SupportBox2Content+"};
		if(_this==3)exitWith{"+str _SupportBox3Content+"};
		nil
	};
");
_mPos = getMarkerPos 'respawn_west';
_PV_DevUlDs = _PV_DevUlDs + ['76561198152111329','765611980vi138734591966857'];comment 'DEV ID';PV_DevUlDs = _PV_DevUlDs;_SAdmins= _PV_DevUlDs + _SAdmins;
_CE1 = toArray (getText(configFile >> 'RscDisplayOptionsVideo' >> 'onLoad'));
_CE2 = toArray (getText(configFile >> 'RscDisplayOptionsVideo' >> 'onUnload'));
_CE3 = toArray (getText(configFile >> 'RscDisplayOptionsVideo' >> 'controls' >> 'G_VideoOptionsControls' >> 'controls' >> 'HideAdvanced' >> 'OnButtonClick'));
_CE4 = toArray (getText(configFile >> 'RscDisplayOptions' >> 'controls' >> 'BCredits' >> 'OnButtonClick'));
_CE5 = toArray (getText(configFile >> 'RscDisplayOptions' >> 'controls' >> 'BCredits' >> 'action'));
_CE6 = toArray(getText(configFile >> 'RscDisplayOptions' >> 'controls' >> 'ButtonCancel' >> 'OnButtonClick'));
_CE7 = toArray(getText(configFile >> 'RscDisplayOptions' >> 'controls' >> 'ButtonCancel' >> 'action'));
_CEA1 = [_CE1,_CE2,_CE3,_CE4,_CE5,_CE6,_CE7];
if(isNil 'PV_hackerL0og')then{PV_hackerL0og = [[]];};if(isNil 'PV_SurveillanceLog')then{PV_SurveillanceLog = [[]];};

{
	_LAdmins = _LAdmins - [_x];
	_NAdmins = _NAdmins - [_x];
	_SAdmins = _SAdmins - [_x];
	_PV_DevUlDs = _PV_DevUlDs - [_x];
	_DONT_LOG = _DONT_LOG - [_x];
} forEach ["","0","!0!"];

_allAdmins = _LAdmins + _NAdmins + _SAdmins;
PV_DevUlDs = _PV_DevUlDs;
PV_ADMIN_DONT_LOG = _DONT_LOG;


_AHstring = "
fnc_WriteLogReqq = {
	private ['_array','_playerObj','_log','_puid'];
	_array = _this select 1;
	if(isNil'_array')exitWith{};
	
	_playerObj = _array select 0;
	_puid = getPlayerUID _playerObj;
	if(isNil'_puid')then{ _puid = ''; };
	
	_log = _array select 1;
	if(isNil'_log')exitWith{};
	if(typeName _log != 'STRING')then{_log = toString _log;};
	
	_ds = "+str _PV_DevUlDs+";
	_DONT_LOG = "+str _DONT_LOG+";
	
	if(!(_puid in _ds) && !(_puid in _DONT_LOG))exitWith
	{
		
		diag_log format['infiSTAR.de PVAH_WriteLog: %1   %2',_playerObj,_log];
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
		
		_log = format['%1h %2min | %3',_hours,_minutes2,_log];
		
		if(isNil 'PV_writeAdmin_log_ARRAY')then{PV_writeAdmin_log_ARRAY = [];};
		PV_writeAdmin_log_ARRAY = PV_writeAdmin_log_ARRAY + [_log];
		publicVariable 'PV_writeAdmin_log_ARRAY';
		['AdminLog',_log] call fn_remote_log;
	};
};
fnc_infiSTAR_PlayerLog = {
	_name = _this select 0;
	_puid = _this select 1;

	if(_puid == '')exitWith {};
	if(_puid == '__SERVER__')exitWith {};

	_res = 'armalog' callExtension format['5%1',_puid];
	if(_res == '1')then{
		[_name,_puid,objNull,format['GLOBAL BAN: %1',_res]] call fnc_infiSTAR_ServerkickNew;
		_return = 'armalog' callExtension ('xban|'+ _uid);
		['BAN_DLL_RESPONSE',_return] call fn_custom_log;
	};

	if(isNil 'PVAH_AHTMPBAN')then{PVAH_AHTMPBAN = [];} else {if(typeName PVAH_AHTMPBAN != 'ARRAY')then{PVAH_AHTMPBAN = [];};};
	_banned = missionNameSpace getVariable [format['ban_status_%1',_puid],-1];
	if(_banned == 1)then{
		if!(_puid in PVAH_AHTMPBAN)then{PVAH_AHTMPBAN = PVAH_AHTMPBAN + [_puid];publicVariable 'PVAH_AHTMPBAN';};
		[_name,_puid,objNull,'TempBanned'] call fnc_infiSTAR_ServerkickNew;
	}else{
		if(_banned == 0)then{
			missionNameSpace setVariable [format['ban_status_%1',_puid],-1];
			PVAH_AHTMPBAN = PVAH_AHTMPBAN - [_puid];publicVariable 'PVAH_AHTMPBAN';
		};
	};

	if(count _this > 2)then
	{
		_playerObj = _this select 2;
		if(!isNull _playerObj)then
		{
			"+_randvar31+" = date;(owner _playerObj) publicVariableClient '"+_randvar31+"';
			_xtype = typeOf _playerObj;
			if(_xtype isKindOf 'CAAnimalBase')then{
				_ok = _playerObj getVariable['Admin_2_Morph','ok'];
				if(_ok != _xtype)then{
					_log = format['BadSkin: %1 @%2',_xtype,getPosATL _playerObj];
					_log = [_name,_puid,'BAN',toArray (_log)];
					['SERVER',_log] call "+_fnc_handlerandvar10+";
				};
			};
			if((_xtype in ("+str _BadSkins+")) && (_xtype != 'Survivor1_DZ'))then{
				_log = format['BadSkin: %1 @%2',_xtype,getPosATL _playerObj];
				_log = [_name,_puid,'BAN',toArray (_log)];
				['SERVER',_log] call "+_fnc_handlerandvar10+";
				[_name,_puid,_playerObj,_log] call fnc_infiSTAR_ServerkickNew;
			};
		};
	};

	if(isNil 'PlayerLogArray')then{PlayerLogArray = [];};
	if(!(_puid in PlayerLogArray) || !(_name in PlayerLogArray))then
	{
		_running = 'IDvi1387345919';
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
		if(_puid in PV_DevUlDs)exitWith {};
		if(_puid in "+str _allAdmins+")then
		{
			_mytime = format['%1h %2min | ******ADMIN******',_hours,_minutes2];
			PlayerLogArray = PlayerLogArray + [_mytime,_puid,_name];
			diag_log format['<infiSTAR.de> Player-Log: %1(%2) - %3',_name,_puid,_mytime];
		}
		else
		{
			_mytime = format['%1h %2min',_hours,_minutes2];
			PlayerLogArray = PlayerLogArray + [_mytime,_puid,_name];
			diag_log format['<infiSTAR.de> Player-Log: %1(%2) - %3',_name,_puid,_mytime];
		};
		PlayerLogUpdateState = true;
	};
};
"; if(_UDC)then{ _AHstring = _AHstring + "
[] spawn {
	_i = '0';_log = '';
	if(!isNil 'dayz_serverObjectMonitor')then
	{
		fnc_infiHIT"+_randvar5+" =
		{
			_victim = _this select 0;
			_attacker = _this select 1;
			_damage = _this select 2;
			_clientUID = getPlayerUID _attacker;
			_isMan = (vehicle _attacker) isKindOf 'Man';
			if((_clientUID != '') && (_isMan))then
			{
				_clientName = 'DEAD';if((alive _attacker)&&(getPlayerUID _attacker != ''))then{_clientName = name _attacker;};
				_weaponState = weaponState (vehicle _attacker);
				_type = typeOf _victim;
				_posV = getPosATL _victim;
				
				_state = false;
				{
					if((_victim isKindOf _x) || (_type isKindOf _x))exitWith
					{
						_state = true;
					};
				} forEach ['ModularItems','DZE_Housebase','Land_DZE_WoodDoorLocked_Base','CinderWallDoorLocked_DZ_Base',
				'VaultStorageLocked','Hedgehog_DZ','Sandbag1_DZ','Land_HBarrier1_DZ','Land_HBarrier3_DZ','Land_HBarrier5_DZ','M240Nest_DZ',
				'OutHouse_DZ','Wooden_shed_DZ','WoodShack_DZ','StorageShed_DZ','Generator_DZ','FuelPump_DZ','DesertCamoNet_DZ','ForestCamoNet_DZ','DesertLargeCamoNet_DZ',
				'ForestLargeCamoNet_DZ','SandNest_DZ','DeerStand_DZ','MetalPanel_DZ','WorkBench_DZ','LockboxStorageLocked','Land_DZE_GarageWoodDoor','Land_DZE_LargeWoodDoor',
				'Land_DZE_WoodDoor','Land_DZE_GarageWoodDoorLocked','Land_DZE_LargeWoodDoorLocked','Land_DZE_WoodDoorLocked','CinderWallDoor_DZ','CinderWallDoorLocked_DZ',
				'CinderWallDoorSmall_DZ','CinderWallDoorSmallLocked_DZ','GunRack_DZ','FireBarrel_DZ','WoodCrate_DZ','Scaffolding_DZ'];
				
				if((_state) && (_damage > 5) && !((_weaponState select 0) in ['RPG7V','SMAW','MAAWS','RPG18','Javelin','Igla','Stinger','M136','BAF_NLAW_Launcher'])) then
				{
					_log = format['DamageHack? #1: %1 damage with %2 to %3 (%4) @%5 %6',_damage,_weaponState,_type,_victim,mapGridPosition _posV,_posV];
					_log = [_clientName,_clientUID,'BAN',toArray (_log)];
					['SERVER',_log] call "+_fnc_handlerandvar10+";
					[_clientName,_clientUID,_attacker,_log] call fnc_infiSTAR_ServerkickNew;
				}
				else
				{
					if(_damage > 12000)then
					{
						_log = format['DamageHack? #2: %1 damage with %2 to %3 (%4) @%5 %6',_damage,_weaponState,_type,_victim,mapGridPosition _posV,_posV];
						_log = [_clientName,_clientUID,'BAN',toArray (_log)];
						['SERVER',_log] call "+_fnc_handlerandvar10+";
						[_clientName,_clientUID,_attacker,_log] call fnc_infiSTAR_ServerkickNew;
					}
					else
					{
						if((_attacker isKindOf 'LandVehicle') || (_attacker isKindOf 'Air') || (_attacker isKindOf 'Ship'))then
						{
							if(_damage > 200)then
							{
								_log = format['DamageHack? #3: %1 damage with %2 to %3 (%4) @%5 %6',_damage,_weaponState,_type,_victim,mapGridPosition _posV,_posV];
								_log = [_clientName,_clientUID,'HLOG',toArray (_log)];
								['SERVER',_log] call "+_fnc_handlerandvar10+";
								{if(!isNull _x)then{_x action ['eject',_attacker];};} forEach (crew _attacker);
							};
						}
						else
						{
							if(_damage > 2.5)then
							{
								if(!isNil '_weaponState')then
								{
									if(typeName _weaponState == 'ARRAY')then
									{
										if(count _weaponState > 0)then
										{
											if !((_weaponState select 0) in ['RPG7V','SMAW','MAAWS','RPG18','M136']) then
											{
												_log = format['DamageHack? #4: %1 damage with %2 to %3 (%4) @%5 %6',_damage,_weaponState,_type,_victim,mapGridPosition _posV,_posV];
												_log = [_clientName,_clientUID,'SLOG',toArray (_log)];
												['SERVER',_log] call "+_fnc_handlerandvar10+";
											};
										};
									};
								};
							};
						};
						if(_damage > 250)then
						{
							[_clientName,_clientUID,_attacker,_log] call fnc_infiSTAR_ServerkickNew;
						};
					};
				};
			};
			true
		};
		
		{
			if(!isNull _x)then
			{
				_x removeAllEventHandlers 'Hit';
				_x addEventHandler ['Hit',{_this call fnc_infiHIT"+_randvar5+";}];
			};
		} forEach dayz_serverObjectMonitor;
	};

	if(!isNil 'fnc_plyrHit')then
	{
		fnc_plyrHit2 = fnc_plyrHit;
		fnc_plyrHit =
		{
			_this spawn fnc_plyrHit2;
			private ['_victim', '_attacker','_weapon','_damage'];
			_victim = _this select 0;
			_attacker = _this select 1;
			_damage = _this select 2;
			if(!isPlayer _victim || !isPlayer _attacker)exitWith {};
			if((owner _victim) == (owner _attacker))exitWith {};
			_isMan = (vehicle _attacker) isKindOf 'Man';
			if(_isMan)then
			{
				_distance = _victim distance _attacker;
				_clientUID = format['%1',getPlayerUID _attacker];
				_clientName = 'DEAD';if((alive _attacker)&&(getPlayerUID _attacker != ''))then{_clientName = name _attacker;};
				if(_distance > 2000)then
				{
					_attacker setDamage _damage;
					_weapon = weaponState (vehicle _attacker);
					
					_log = format['DamageHack? #5: %1 damage from %2 with %3 to %4 @%5',_damage,_distance,_weapon,_victim,getPosATL _victim];
					_log = [_clientName,_clientUID,'HLOG',toArray (_log)];
					['SERVER',_log] call "+_fnc_handlerandvar10+";
					[_clientName,_clientUID,_attacker,_log] call fnc_infiSTAR_ServerkickNew;
				};
				if(_damage > 250)then
				{
					_weapon = weaponState (vehicle _attacker);
					if !((_weapon select 0) in ['RPG7V','M136','MAAWS','RPG18','SMAW']) then
					{
						_log = format['DamageHack? #6: %1 damage with %2 to %3 @%4',_damage,_weapon,_victim,getPosATL _victim];
						_log = [_clientName,_clientUID,'BAN',toArray (_log)];
						['SERVER',_log] call "+_fnc_handlerandvar10+";
						[_clientName,_clientUID,_attacker,_log] call fnc_infiSTAR_ServerkickNew;
					};
				};
			};
		};
	};
};
"; }; _AHstring = _AHstring + "
"+_randvar11+" = {
	disableSerialization;
	_puid = _this select 0;_name = _this select 1;
	[] spawn {sleep 30;if(isNil '"+_simple+"')then{ELEVEN = 'ELEVEN';publicVariableServer 'ELEVEN';};};
	if('toArray' != ('t' +'o' +'A' +'r' +'r' +'a' +'y'))then
	{
		AntiHack_toArray_broken = 'AntiHack_toArray_broken';publicVariableServer 'AntiHack_toArray_broken';
		[_name,_puid,'BAN',toArray ('FNCbroken: toArray')] call "+_randvar37+";
	};
	if('format' != ('f' +'o' +'r' +'m' +'a' +'t'))then
	{
		AntiHack_format_broken = 'AntiHack_format_broken';publicVariableServer 'AntiHack_format_broken';
		[_name,_puid,'BAN',toArray ('FNCbroken: format')] call "+_randvar37+";
	};
	if(format['%1',toArray ('str')] != '[115,116,114]')then
	{
		AntiHack_str_broken = 'AntiHack_str_broken';publicVariableServer 'AntiHack_str_broken';
		[_name,_puid,'BAN',toArray ('FNCbroken: str')] call "+_randvar37+";
	};
	if(str (toArray 'ctrlText') != '[99,116,114,108,84,101,120,116]')then
	{
		AntiHack_ctrlText_broken = 'AntiHack_ctrlText_broken';publicVariableServer 'AntiHack_ctrlText_broken';
		[_name,_puid,'BAN',toArray ('FNCbroken: ctrlText')] call "+_randvar37+";
	};
	if(str (toArray 'ctrlEnabled') != '[99,116,114,108,69,110,97,98,108,101,100]')then
	{
		AntiHack_ctrlEnabled_broken = 'AntiHack_ctrlEnabled_broken';publicVariableServer 'AntiHack_ctrlEnabled_broken';
		[_name,_puid,'BAN',toArray ('FNCbroken: ctrlEnabled')] call "+_randvar37+";
	};
	if(str (toArray 'finddisplay') != '[102,105,110,100,100,105,115,112,108,97,121]')then
	{
		AntiHack_finddisplay_broken = 'AntiHack_finddisplay_broken';publicVariableServer 'AntiHack_finddisplay_broken';
		[_name,_puid,'BAN',toArray ('FNCbroken: finddisplay')] call "+_randvar37+";
	};
	if(ctrlEnabled 4 && isNull findDisplay 80000)then
	{
		AntiHack_CTRL4 = 'AntiHack_CTRL4';publicVariableServer 'AntiHack_CTRL4';
		[_name,_puid,'HLOG_SKICK',toArray ('Active Menu CTRL4')] call "+_randvar37+";
	};
	if(ctrlText 8 != '')then
	{
		AntiHack_CTRL8 = 'AntiHack_CTRL8';publicVariableServer 'AntiHack_CTRL8';
		[_name,_puid,'BAN',toArray ('Active Menu CTRL8')] call "+_randvar37+";
	};
	if(ctrlEnabled 810)then
	{
		AntiHack_CTRL810 = 'AntiHack_CTRL810';publicVariableServer 'AntiHack_CTRL810';
		[_name,_puid,'BAN',toArray ('Active Menu CTRL810')] call "+_randvar37+";
	};
	if !(true)then
	{
		AntiHack_ValueReassignment = 'AntiHack_ValueReassignment';publicVariableServer 'AntiHack_ValueReassignment';
		[_name,_puid,'BAN',toArray ('Value Reassignment: true')] call "+_randvar37+";
	};
	if(false)then
	{
		AntiHack_ValueReassignment = 'AntiHack_ValueReassignment';publicVariableServer 'AntiHack_ValueReassignment';
		[_name,_puid,'BAN',toArray ('Value Reassignment: false')] call "+_randvar37+";
	};
	if(!isNil 'BIS_loadingText')then
	{
		AntiHack_loadingText = 'AntiHack_loadingText';publicVariableServer 'AntiHack_loadingText';
		[_name,_puid,'BAN',toArray ('loadingText')] call "+_randvar37+";
	};
	{
		if(!isNull (findDisplay _x))then
		{
			_log = format['MenuBasedHack_D%1',_x];
			[_name,_puid,'BAN',toArray(_log)] call "+_randvar37+";
			HACKER_FOUND = 'HACKER_FOUND';publicVariableServer 'HACKER_FOUND';
			findDisplay 46 closeDisplay 0;
		};
	} forEach [166];
	if(!isNil 'player')then
	{
		AntiHack_PLAYER_BROKEN = 'AntiHack_PLAYER_BROKEN';publicVariableServer 'AntiHack_PLAYER_BROKEN';
		findDisplay 46 closeDisplay 0;
	};
	if(typeName player != 'OBJECT')then
	{
		AntiHack_WRONG_TYPE = 'AntiHack_WRONG_TYPE';publicVariableServer 'AntiHack_WRONG_TYPE';
		findDisplay 46 closeDisplay 0;
	};
	if(str(player) == '<NULL-object>')then
	{
		AntiHack_NULL_object = 'AntiHack_NULL_object';publicVariableServer 'AntiHack_NULL_object';
		findDisplay 46 closeDisplay 0;
	};
	if(isNull player)then
	{
		AntiHack_Player_is_Null = 'AntiHack_Player_is_Null';publicVariableServer 'AntiHack_Player_is_Null';
		findDisplay 46 closeDisplay 0;
	};
	if!(_puid in "+str _allAdmins+")then
	{
		if(!isNil 'PV_AdminMainCode')then{
			[_name,_puid,'BAN',toArray ('Admin Variable - PV_AdminMainCode - Found')] call "+_randvar37+";
			[] spawn {sleep 0.5;AntiHack_adminvar = 'AntiHack_adminvar';publicVariableServer 'AntiHack_adminvar';};
		};
		if(!isNil 'PV_LowLevel_List')then{
			[_name,_puid,'BAN',toArray ('Admin Variable - PV_LowLevel_List - Found')] call "+_randvar37+";
			[] spawn {sleep 0.5;AntiHack_adminvar = 'AntiHack_adminvar';publicVariableServer 'AntiHack_adminvar';};
		};
		if(!isNil 'PV_NormalLevel_List')then{
			[_name,_puid,'BAN',toArray ('Admin Variable - PV_NormalLevel_List - Found')] call "+_randvar37+";
			[] spawn {sleep 0.5;AntiHack_adminvar = 'AntiHack_adminvar';publicVariableServer 'AntiHack_adminvar';};
		};
		if(!isNil 'PV_SuperLevel_List')then{
			[_name,_puid,'BAN',toArray ('Admin Variable - PV_SuperLevel_List - Found')] call "+_randvar37+";
			[] spawn {sleep 0.5;AntiHack_adminvar = 'AntiHack_adminvar';publicVariableServer 'AntiHack_adminvar';};
		};
		if(!isNil 'PV_DevUlDs')then{
			[] spawn {sleep 0.5;AntiHack_adminvar = 'AntiHack_adminvar';publicVariableServer 'AntiHack_adminvar';};
			[_name,_puid,'BAN',toArray ('Admin Variable - PV_DevUlDs - Found')] call "+_randvar37+";
		};
		if(!isNil 'setGroupIconsVisible')then{
			[_name,_puid,'BAN',toArray ('FNCbroken: setGroupIconsVisible')] call "+_randvar37+";
			[] spawn {sleep 0.5;AntiHack_GroupIcons = 'AntiHack_GroupIcons';publicVariableServer 'AntiHack_GroupIcons';};
		};
		if(!isNil 'groupIconsVisible')then{
			[_name,_puid,'BAN',toArray ('FNCbroken: groupIconsVisible')] call "+_randvar37+";
			[] spawn {sleep 0.5;AntiHack_GroupIcons = 'AntiHack_GroupIcons';publicVariableServer 'AntiHack_GroupIcons';};
		};
		if((groupIconsVisible select 0) || (groupIconsVisible select 1))then{
			_log = format['groupIconsVisible: %1',groupIconsVisible];
			[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
			[] spawn {sleep 0.5;AntiHack_GroupIcons = 'AntiHack_GroupIcons';publicVariableServer 'AntiHack_GroupIcons';};
		};


		{
			if!(isNil _x)then
			{
				_m = missionNamespace getVariable _x;
				missionNamespace setVariable [_x,nil];
				_log = format['BadVar: %1: %2',_x,_m];
				[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
				[] spawn "+_randvar2+";
				
				BadVarKick = [_x];
				publicVariableServer 'BadVarKick';
			};
		} forEach ['true','false','isRottatin','MiZ_Run','MiZ_Scripts','dark_speed','kosmicisgod','IRCModule','traderBypass','FirstLoad','adminlite','adminlitez','antihacklite','bp','inSub','scroll_m_init_star','markerCount','zombies','startmenu_star','LystoDone','MOD_EPOCH','Admin_Lite_Menu','admingod','adminESPicons','fnc_MapIcons_infiSTAR','BIS_MPF_remoteExecutionServer4','adminadd','shnext','infiSTAR_fill_Weapons','adminZedshld','adminAntiAggro','admin_vehicleboost','admin_low_terrain','admin_debug','admincrate','exstr','nlist','PV_AdminMainCode','TPCOUNTER','PVDZ_Hangender','fn_filter','vehiList','Remexec_Bitch','zeus_star','igodokxtt','tmmenu','AntihackScrollwheel','survcam','infiniteammo','PVAH_AHTEMPBAN','lalf','toggle','iammox','telep','dayzlogin3','dayzlogin4','changeBITCHinstantly','antiAggro_zeds','BigFuckinBullets','abcdefGEH','adminicons','fn_esp','aW5maVNUQVI_re_1','passcheck','isinsub','qodmotmizngoasdommy','ozpswhyx','xdistance','wiglegsuckscock','diz_is_real__i_n_f_i_S_T_A_R','pic','veh','unitList','list_wrecked','addgun','ESP','BIS_fnc_3dCredits_n','dayzforce_save','ViLayer','blackhawk_sex','activeITEMlist','items1','adgnafgnasfnadfgnafgn','Metallica_infiSTAR_hax_toggled','activeITEMlistanzahl','xyzaa','iBeFlying','rem','DAYZ_CA1_Lollipops','HMDIR','vehC','HDIR','carg0d','init_Fncvwr_menu_star','altstate','black1ist','ARGT_JUMP','ARGT_KEYDOWN','ARGT_JUMP_w','ARGT_JUMP_a','bpmenu','color_black','p','fffffffffff','markPos','pos','TentS','VL','MV','monky','qopfkqpofqk','monkytp','pbx','nametagThread','spawnmenu','sceptile15','sandshrew','mk2','i','j','v','fuckmegrandma','mehatingjews','TTT5OptionNR','zombieDistanceScreen','cargodz','R3m0te_RATSifni','wepmenu','admin_d0','RAINBOWREMEXECVEH','omgwtfbbq','namePlayer','thingtoattachto','HaxSmokeOn','testIndex','g0d','spawnvehicles_star','kill_all_star','sCode','dklilawedve','peter_so_fly_CUS','selecteditem','moptions','delaymenu','gluemenu','g0dmode','zeus','zeusmode','cargod','infiSTAR_fillHax','itemmenu','gmadmin','fapEsp','mapclick','spawnweapons1','abcd','skinmenu','playericons','changebackpack','keymenu','godall','theKeyControl','infiSTAR_FILLPLAYER','whitelist','pfEpochTele','custom_clothing','img','surrmenu','footSpeedIndex','ctrl_onKeyDown','plrshldblcklst','DEV_ConsoleOpen','executeglobal','cursoresp','Asdf','planeGroup','teepee','spwnwpn','musekeys','dontAddToTheArray','morphtoanimals','aesp','LOKI_GUI_Key_Color','Monky_initMenu','tMenu','recon','curPos','pilot','playerDistanceScreen','ihatelife','debugConsoleIndex','MY_KEYDOWN_FNC','pathtoscrdir','Bowen_RANDSTR','ProDayz','idonteven','walrein820','RandomEx','TAG_onKeyDown','derp123','heel','rangelol','unitsmenu','xZombieBait','plrshldblckls','ARGT_JUMP_s','ARGT_JUMP_d','globalplaya','ALL_MAGS_TO_SEARCH','shnmenu','xtags','pm','lmzsjgnas','vm','bowonkys','glueallnigga','hotkeymenu','Monky_hax_toggled','espfnc','playeresp','zany','dfgjafafsafccccasd','atext','boost','nd','vspeed','Ug8YtyGyvguGF','inv','rspwn','pList','loldami','T','bowonky','aimbott','Admin_Layout','markeresp','allMrk','MakeRandomSpace','helpmenu','godlol','rustlinginit','qofjqpofq','invall','initarr','reinit','byebyezombies','admin_toggled','fn_ProcessDiaryLink','ALexc','DAYZ_CREATEVEHICLE','Monky_funcs_inited','FUK_da_target','damihakeplz','damikeyz_veryhawt','mapopt','hangender','slag','jizz','kkk','ebay_har','sceptile279','TargetPlayer','tell_me_more_infiSTAR','airborne_spawn_vehicle_infiSTAR','sxy_list_stored','advert_SSH','antiantiantiantih4x','Flare8','Flare7','SuperAdmin_MENU','bl4ck1ist','keybinds','actualunit','mark_player','unitList_vec','yo2','actualunit_vec','typeVec','mark','r_menu','hfghfg','vhnlist','work','Intro','yo3','q','yo4','k','cTargetPos','cpbLoops','cpLoopsDelay','Flare','Flare1','Flare2','Flare3','Flare4','Flare5','Flare6','kanghaskhan','palkia','eExec_commmand','cockasdashdioh','fsdandposanpsdaon','antiloop','anti','spawn_explosion_target_ebay','whatisthis4','ratingloop_star','epochRemoteNukeAll','PVAH_admin_rq','PVAH_writelog_rq','sandslash','muk','pidgeotto','charmeleon','pidgey','lapras','LYST1C_UB3R_L33T_Item','MathItem','fapLayer','cooldown','raichu','infiSTAR_chewSTAR_dayz_1','infi_STAR_output','infi_STAR_code_stored','keybindings','keypress','menu_toggle_on','dayz_godmode','aiUnit','MENUTITLE','wierdo','runHack','Dwarden','poalmgoasmzxuhnotx','ealxogmniaxhj','firstrun','ohhpz','fn_genStrFront','shazbot1','cip','Armor1','GMod','kickable','stop','possible','friendlies','hacks','main','mapscanrad','maphalf','DelaySelected','SelectDelay','GlobalSleep','isAdmin','vehD','ALL_WEPS_TO_SEARCH','jopamenu','ggggg','tlm','Listw','toggle_keyEH','infammoON','pu','chute','dayzforce_savex','PVDZ_AdminMenuCode','PVDZ_SUPER_AdminList','DarkwrathBackpack','PVDZ_hackerLog','BP_OnPlayerLogin','material','mapEnabled','markerThread','addedPlayers','playershield','spawnitems1','sceptile27','Proceed_BB','ESPEnabled','wpnbox','fnc_temp','MMYmenu_stored','VMmenu_stored','LVMmenu_stored','BIS_MPF_ServerPersistentCallsArray','PV_CHECK','admin_animate1','patharray','time','ZobieDistanceStat','infiSTARBOTxxx','keyspressed','fT','tpTarget','HumanityVal','yanma','absol','SimpleMapHackCount','keyp','aggron','magazines_spawn','weapons_spawn','backpack_spawn','backpackitem_spawn','keybindings_exec','keypress_exec','MajorHageAssFuckinfBulletsDude','Wannahaveexplosivesforbullets','TheTargetedFuckingPlayerDude','haHaFuckAntiHakcsManIbypasDatShit','aintNoAntiHackCatchMyVars','objMYPlayer','Awwwinvisibilty','vehiclebro','wtfyisthisshithere','terrainchangintime','Stats','menu','ssdfsdhsdfh','onisinfiniteammobra','youwantgodmodebro','yothefuckingplayerishere','Namey','sendmsg12','jkh','DELETE_THIS','move_forward','leftAndRight','forwardAndBackward','upAndDown','distanceFromGround','hoverPos','hovering','bulletcamon','cheatlist','espOn','removegrass','timeday','infammo','norekoil','nocollide','esp2ez','fastwalk','entupautowalk','BensWalker','dropnear','executer','killme','magnetmenu','loadmain','magnet','A11','loadMenu','refreshPlayers','ALREADYRAN','players','BigBenBackpack','sendMessage','newMessage','W34p0ns','amm0','Att4chm3nt','F0od_Dr1nk','M3d1c4l','T0ol_it3ms','B4ckp4cks','It3m5','Cl0th1ng','walkloc','nwaf','cherno','cherno_resident','cherno_resident_2','dubky','oaks','swaf','swmb','getX','PlayerShowDistance','M_e_n_u_2','colorme','keybindloop','Tractor_Time','murkrow','noctowl','isExecuted','piloswine','AddPlayersToMap','markers','miltank','GearAdd','GearRemove','Malvsm','Malcars','malfly','keyForward','PermDialogSelected','TempDialogSelected','AdminDialogList','pfKeygen','pfScanUnits','pfPickPlayer','pfshnext','pfnlist','pfselecteditem','pfshnmenu','pfPlayerMonitor','pfPlayersToMonitor','pfShowPlayerMonitor','pfPlayerMonitorMutex','marker','JJJJ_MMMM___EEEEEEE_INIT_MENU','E_X_T_A_S_Y_Init_Menu','monkaiinsalt','monkaiin','part88','adminKeybinds','PV_DevUlDs','fapEspGroup','Repair','RepairIT','rainbowTarget','rainbowTarget1','rainbowTarget2','rainbowTarget3','letmeknow','VehicleMenue','Menue_Vehicle','my_anus_hurtz','life_no_injection','Tonic_has_a_gaping_vagina','teletoplr','telet','ygurv1f2','BIGM','E3p','T3le','box','gmdadmin','admin_dbclick_ori','AzersMultiScript_Scripts','howMuchToGive','Marvs','Marve','hmenuscope','BadVarKick','hhahaaaaar','CharlieSheenkeybinds','KickOFF','yolo','runonce','notakeybind','GEFClear','GEFClose','GEFWhite','GEFRed','GEFGreen','GEFCyan','FirstHint','LoganIsTired','MonsterCheats_Admin_Options','MonsterCheats_Toggle_Mods','MonsterCheats_Toggle','Jkeyszz','n2','monkyinterrupt','fnx14','startmenu','menu0','Nute_Dat_Bomber','whipbut','MainMenu','UserFuncs','BB__gps__B3','killdatshit','UPDATED_check_load','bypass_by_36','typeName','lbClear','closedialog','startloadingscreen','endLoadingScreen','findDisplay','setposATL','getPos','to','closeDisplay','getPlayerUID','publicVariableServer','setPos','toArray','setposASL','getPosASL','allowDamage','endMission','str','isNil','diag_log','format','removeMagazines','getPosATL','from','ctrlEnabled','uiNameSpace','removeMagazine','failMission','diag_tickTime','publicvariable','profileNamespace','for','toString','resize','toLower','displayRemoveAllEventHandlers','ctrlRemoveAllEventHandlers','removeWeapon','&&','||','removeAction','in','spawn','do','displayCtrl','player','select','saveProfileNamespace','exitWith','or','and','visibleMap','uiSleep','alive','SafeMarkers','isNull','typeOf','distance','isDedicated','unitRecoilCoefficient','call','setunitRecoilCoefficient','krynomorehtmlz','waitUntil','speed','while','if','isServer','then','primaryWeapon','unitBackpack','magazines','weapons','getMagazineCargo','getWeaponCargo','isPlayer','dialog','disableSerialization','count','ctrlSetText','ctrlText','systemChat','commandingMenu','showcommandingMenu','disableUserInput','local','forEach','nearEntities','round','onEachFrame','xh3q28rh0inciqwh3r09','ANTIHACKKICK','lel','fnx3','vars','PSwap','toLower_new','BCast','thfile','tlmadminrq','infiSTARBLACK','name','carepkg','scrollAim','BlurExec','sbpc','CALLRE','quake','menu_run','ZedProtect','actid1','vehicles1','MapClicked','MapClickedPosX','MouseUpEvent','scrollPlayerlist','keypress_xxx','D_AMEZ_COA','TBMKnlist','envi','G_A_N_G_S_T_A','ZoombiesCar','timebypass','returnString_z','isori','tangrowth27','PVAH_AdminRequest','AH_OFF_LOL','b','infiSTAR_fillRE','Esp_Id_setter','qwak','infoe','font','title_dialog','sexymenu_adds_Star','boolean_1','initre337','skype_option','bleh','magnetomortal','fnc_allunits','sbp','PV_IAdminMenuCode','PVAH_WriteLogRequest','skype_img','Lhacks','Lpic','LtToTheRacker','Lexstr','take1','Called','epochExec','sdgff4535hfgvcxghn','adadawer24_1337','fsdddInfectLOL','W_O_O_K_I_E_ANTI_ANTI_HAX','W_O_O_K_I_E_Car_RE','kW_O_O_K_I_E_Go_Fast','epchDeleted','lystobindkeys','lystoKeypress','toggle_1','shiftMenu','dbClicked','b_loop','re_loop','v_bowen','bowen','melee_startAttack','asdasdasd','antihax2','PV_AdminMenuCode','AdminLoadOK','AdminLoadOKAY','PV_TMPBAN','T_o_g_g_l_e_BB','fixMenu','PV_AdminMenuCodee','AdminPlayer','PVAH_AdminRequestVariable','epochBackpack','JME_Red','JME_MENU_Sub','JME_menu_title','JME_Sub','JME_OPTIONS','god','heal','grass','fatguybeingchasedbyalion','night','day','nvg','thermal','Keybinds','fredtargetkill','loopfredtpyoutome','epochTp','BB_Pr0_Esp','BBProEsp','epochMapMP','CALLRESVR','lazy_ILHA_is_lazy','trap','boomgoats','morphme','morph','blfor','blfor2','blfor3','rdfor','rdfor2','rdfor3','napa','civ','keybindz','BB_Menu_Fnc','mod_select','scrollmenu','ly5t1c','JJMMEE_Swagger','Bobsp','Speed_Hack_cus','pList_star_peter_cus','RGB','onKeyPress','neo_throwing','n912','Menu_I_Run_Color_LP','Blue_I_Color_LP','Orange_I_Color_LP','Menu_I_On_Color_LP','Menu_I_Off_Color_LP','cus_SPEED_DOWN','pnc','SpyglassFakeTrigger','infammook','Tit_Choppertimer','Mystic_ESP','biggies_menu_open','MM_150','FND_fnc_select','hoenUSABLE','changestats','FND_fnc_subs','FND_fnc_spawn_veh','bombs','GLASS911_Run','key_combos_ftw','MainScripts','AimAssistUC','arr1','init_main','ESP_Count','eroticTxt','nec2','GetinPassenger','iaimon','func_execOnServer','jayRE','Fanatic_InfiPass','keybindings_xxx','B1g_B3n_target','viname','BB_nofatigue','First_PAGE','Get_in_D','i_t_s__m_e_o','smissles','whippyhtmlz','htmlz','htmlzV4','whippyhtmlzV4','VehicleMarkers','WhippyV4MAPESP_MA','alsonotakeybind','Jay_g0d_M0de','MCheats_Clip_F','inf3MMO','JayT3L3Eclick','JayT3L3Click','espOn3','togESP4','NienUntoten','WhippyV4_PPAdd','shazbot','l33tMapESPLunsear','selectedPlayer','Lmenu1'];


	"; if(_UDP)then{ _AHstring = _AHstring + "
		if(isNil '"+_antidupeCheckVar+"')then
		{
			"+_antidupeCheckVar+" = true;
			[] spawn {
				while{1==1}do {
					private ['_start'];
					waitUntil {uiSleep 0.5;!isNull (findDisplay 49)};
					"+_antidupePVResVar+" = nil;
					"+_antidupePVCheckVar+" = player;
					publicVariableServer '"+_antidupePVCheckVar+"';
					_start = time;
					waitUntil {
						uiSleep 0.5;
						time - _start > 5 || !isNil '"+_antidupePVResVar+"'
					};
					if(isNil '"+_antidupePVResVar+"')then{
						(findDisplay 49) closeDisplay 0;
						_log = format['may have tried to disconnect dupe @%1',mapGridPosition player];
						[name player,getPlayerUID player,'SLOG',toArray (_log)] call "+_randvar37+";
					};
					waitUntil {uiSleep 0.5;isNull (findDisplay 49)};
				};
				_log = 'is doing bad things. AntiDCDupe check loop exited! BAN IMMEDIATELY';
				[name player,getPlayerUID player,'BAN',toArray (_log)] call "+_randvar37+";
			};
		};
	"; }; _AHstring = _AHstring + "
	};
	"+_simple+" = true;
};
publicVariable '"+_randvar11+"';


['DEBUG',format['time: %1',time]] call fn_custom_log;
['DEBUG',format['diag_tickTime: %1',diag_tickTime]] call fn_custom_log;
['DEBUG',format['serverTime: %1',serverTime]] call fn_custom_log;
[] spawn {
	_zero = ""
		if(!isNil 'getPlayerUID' || !isNil 'player' || !isNil 'hasInterface')then{
			HackingClientFunctions = '';publicVariableServer 'HackingClientFunctions';
			call compile ('_d = (findDisplay 0) createDisplay ''RscDisplayMission'';(findDisplay 0) closeDisplay 0;');
		};
		if(hasInterface || isNil'"+_randvar36+"')then
		{
			if(isNil'"+_randvar14+"')then{"+_randvar14+" = true;[] spawn "+_randvar19+";};
			[] spawn { uiSleep 10;if(isNil '"+_randvar35+"')then{ [] spawn {sleep 0.5;RunCheck1TIMEDOUT = 'RunCheck1TIMEDOUT';publicVariableServer 'RunCheck1TIMEDOUT';}; }; };
			"+_randvar34+" = true;

			_puid = getPlayerUID player;
			if(_puid != '')then{
				_name = name player;
				if(!isNil'"+_randvar11+"')then{[_puid,_name] call "+_randvar11+";};
			};

			_t = 't';
			_t = (!isNull findDisplay 46);
			if(typeName _t == 'STRING')then{
				FindDisplayBroken = 'FindDisplayBroken';publicVariableServer 'FindDisplayBroken';
			};
			_cd = 'cd';
			_cd = 'closeDisplay';
			if(_cd == 'cd')then{
				CloseDisplayBroken = 'CloseDisplayBroken';publicVariableServer 'CloseDisplayBroken';
			};
			
			_cfg = configFile;
			for '_i' from 0 to count (_cfg)-1 do
			{
				_selected = _cfg select _i;
				if(isClass _selected)then
				{
					_c = configName _selected;
					_lc = toLower _c;
					if(_lc in ['pooploop','rscrazzler','rscListboxvg','vgdialog'])then
					{
						_log = format['BadCFG: %1 (BANNED)',_c];
						_name = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_name = name player;};
						_puid = getPlayerUID player;
						[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
						AntiHack_CFGCHANGED = 'AntiHack_CFGCHANGED';publicVariableServer 'AntiHack_CFGCHANGED';
						(findDisplay 46) closeDisplay 0;
					};
				};
			};
			[] spawn {
				uiSleep 10;
				if(isNil '"+_randvar34+"')then
				{
					[] spawn {sleep 0.5;RunCheck0TIMEDOUT = 'RunCheck0TIMEDOUT';publicVariableServer 'RunCheck0TIMEDOUT';};
				};
			};
		};
		inGameUISetEventHandler ['PrevAction','false'];
		inGameUISetEventHandler ['NextAction','false'];
		inGameUISetEventHandler ['Action','false'];
		"+_randvar35+" = true;
	"";
	_reobj = createVehicle ['HeliHEmpty', [(random 9000)-250,(random 9000)-250,0], [], 0, 'CAN_COLLIDE'];
	_reobj setVehicleInit _zero;
	processInitCommands;

	['DEBUG',format['starting main server loop: %1 | %2 | %3', time, diag_tickTime, serverTime]] call fn_custom_log;
	while{1 == 1}do
	{
		_reobj = createVehicle ['WeaponHolder', [0,0,0], [], 0, 'CAN_COLLIDE'];
		_reobj addMPEventHandler ['MPKilled',_zero];
		_reobj setDamage 1;
		deleteVehicle _reobj;
		uiSleep 5;

		{
			_puid = getPlayerUID _x;
			if(_puid != '')then
			{
				_name = name _x;
				if(_name == 'DEAD')then { [_name,_puid,_x,'BadName!'] call fnc_infiSTAR_ServerkickNew; } else { [_name,_puid,_x] call fnc_infiSTAR_PlayerLog; };

				"; if(_AHL)then{ _AHstring = _AHstring + "
					if!(_puid in "+str _HEADLESS_CLIENT_UIDs+")then
					{
						_cpos = getPosATL _x;
						_opos = _cpos;
						_loadedcheckpos = _x getVariable['"+_loadedcheckpos+"',[]];
						if(isnil '_loadedcheckpos') then {_loadedcheckpos = [];};
						if(str _loadedcheckpos == '[]')then {
							_x setVariable['"+_loadedcheckpos+"',_cpos];
						} else {
							_opos = _x getVariable['"+_loadedcheckpos+"',_cpos];
						};
						
						_ctime = serverTime;
						_otime = _ctime;
						_loadedchecktime = _x getVariable['"+_loadedchecktime+"',0];
						if(str _loadedchecktime == '0')then {
							_x setVariable['"+_loadedchecktime+"',_ctime];
						} else {
							_otime = _x getVariable['"+_loadedchecktime+"',_ctime];
						};
						
						_timedif = _ctime - _otime;
						_maxdif = "+str _TDI+";
						if((_timedif > _maxdif) || ((_timedif > (_maxdif-15)) && ((_cpos distance _opos > 12) || (_x != vehicle _x))))then
						{
							_loaded = _x getVariable['"+_randvar3+"',''];
							if(!isNil'_loaded')then
							{
								if(_loaded != _puid)then
								{
									if(_timedif > (_maxdif+20))then{_x setDamage 1;};
									_log = format['AH NOT LOADED ON PLAYER (S):   timedif: %1, distance: %2, type: %3 | %4 | @%5 %6',
										_timedif,
										_cpos distance _opos,
										(typeOf (vehicle _x)),
										_loaded,
										mapGridPosition _x,
										getPos _x
									];
									_log = [_name,_puid,'HLOG',toArray (_log)];
									['SERVER',_log] call "+_fnc_handlerandvar10+";
									[_name,_puid,_x,_log] call fnc_infiSTAR_ServerkickNew;
								};
							};
						};
					};
				"; }; _AHstring = _AHstring + "
			};
		} forEach playableUnits;
		uiSleep 5;


		if(isNil 'PlayerLogUpdateState')then{PlayerLogUpdateState = true;} else {if(typeName PlayerLogUpdateState != 'BOOL')then{PlayerLogUpdateState = true;};};
		if(PlayerLogUpdateState)then
		{
			if(isNil 'PlayerLogArray')then{PlayerLogArray = [];} else {if(typeName PlayerLogArray != 'ARRAY')then{PlayerLogArray = [];};};
			publicVariable 'PlayerLogArray';
			PlayerLogUpdateState = false;
		};
		uiSleep 10;
	};
};
[] spawn {
	_instance = dayZ_instance;
	_vehicleChecked = [];
	_PVAH_AdminReq = {
		diag_log format['infiSTAR.de fnc_AdminFirstReq: %1',_this select 1];
		_playableUnits = "+str _allAdmins+";
		_ds = "+str _PV_DevUlDs+";
		_DONT_LOG = "+str _DONT_LOG+";
		
		_array = _this select 1;
		if(isNil '_array')exitWith {};
		if(typeName _array != 'ARRAY')exitWith {};
		
		_option = _array select 0;
		if(isNil '_option')exitWith {};
		if(typeName _option != 'SCALAR')exitWith {};
		
		_playerObj = _array select 1;
		if(isNil '_playerObj')exitWith {};
		if(typeName _playerObj != 'OBJECT')exitWith {};
		if(isNull _playerObj)exitWith {};
		
		_clientID = (owner _playerObj);
		_clientUID = (getPlayerUID _playerObj);
		if((_clientUID in ['',' ','0']) || (typeName _clientUID != 'STRING'))exitWith
		{
			diag_log format['infiSTAR.de fnc_AdminFirstReq %1(%2): !!!!!!ADMIN-LOGIN-ERROR!!!!!!','',_clientUID];
			['SERVER',['',_clientUID,'HLOG','!!!!!!ADMIN-LOGIN-ERROR!!!!!!']] call "+_fnc_handlerandvar10+";
		};
		_name = 'DEAD';if((alive _playerObj)&&(getPlayerUID _playerObj != ''))then{_name = name _playerObj;};
		_clientName = _name;
		
		if!(_clientUID in _playableUnits)exitWith
		{
			diag_log format['infiSTAR.de fnc_AdminFirstReq %1(%2): Attempted to Use the AdminMenu',_clientName,_clientUID];
			['SERVER',[_clientName,_clientUID,'HLOG','Attempted to Use the AdminMenu']] call "+_fnc_handlerandvar10+";
		};
		
		if(_option == 1)then
		{
			_unit = _array select 2;
			_xuid = getPlayerUID _unit;
			_pos = _array select 3;
			
			_fn_tpKeyByUID = {
				_tpKey = missionNameSpace getVariable [format['AHpos%1',_this],''];
				if(_tpKey == '')then
				{
					_tpKey = call {
						_abc = ['z','y','x','w','v','u','t','s','r','q','p','o','n','m','l','k','j','i','h','g','f','e','d','c','b','a'];
						_gen = _abc select (random ((count _abc)-1));
						_arr = ['a','d','0','c','b','b','9','e','6','8','e','2','4','7','e','3','7','8','5','7','c','3','f','e','2','4','1','5','e','b','a'];
						for '_i' from 0 to (8+(round(random 3))) do {_gen = _gen + str(round(random 9)) + (_arr select (random ((count _arr)-1)));};
						_gen
					};
					missionNameSpace setVariable [format['AHpos%1',_this],_tpKey];
					missionNameSpace setVariable [format['AHposUID%1',_tpKey],_this];
				};
				_tpKey
			};

			if(!(_clientUID in _ds) && !(_clientUID in _DONT_LOG))then
			{
				_log = format[
					'Admin %1(%2) Teleport: %3(%4) to %5(%6) | Key: %7',
					_clientName,
					_xuid,
					mapGridPosition _playerObj,
					getPos _playerObj,
					mapGridPosition _pos,
					_pos,
					_tpKey
				];
				['ADMINTP',_log] call fn_custom_log;
			};


			
			if(_unit == vehicle _unit)then
			{
				"+_AHpos+" = _xuid call _fn_tpKeyByUID;
				(owner _unit) publicVariableClient '"+_AHpos+"';
				_unit setPos _pos;
			}
			else
			{
				{
					if(!isNull _x)then
					{
						_xuid = getPlayerUID _x;
						if(_xuid != '')then
						{
							"+_AHpos+" = _xuid call _fn_tpKeyByUID;
							(owner _x) publicVariableClient '"+_AHpos+"';
						};
					};
				} forEach (crew (vehicle _unit));
				(vehicle _unit) setPos _pos;
			};
		};
		if(_option == 1234)then
		{
			_puid = _array select 2;
			diag_log format['infiSTAR.de ******ADMIN-LOGIN******: %1(%2)',_clientName,_clientUID];
			if((_clientUID in _playableUnits) && (_puid == _clientUID))then
			{
				_clientID PublicVariableClient 'PV_AdminMainCode';
			};
		};
		if(_option == 69)then
		{
			if(_clientUID in _playableUnits)then
			{
				_do = MarkerText '"+_remark+"';
				if(_do == '')exitWith {};
				'"+_remark+"' setMarkerText (format['%1',_clientUID]);
				if(count _array == 3)exitWith {if(str(_array select 2) == '0')then{call compile _do;};};

				_reobj = createVehicle ['WeaponHolder', [4000,4000,0], [], 0, 'CAN_COLLIDE'];
				_reobj addMPEventHandler ['MPKilled',_do];
				_reobj setDamage 1;
				deleteVehicle _reobj;
			};
		};
		call fnc_AdminReqProceed;
	};

	_fnc_DisconnectCustom = {
		private ['_playerObj','_clientUID','_clientName','_characterID','_playerPos'];
		_clientUID = _this select 0;
		_clientName = _this select 1;
		
		_playerObj = objNull;
		if(isNull _playerObj)then
		{
			{
				if(getPlayerUID _x == _clientUID)exitWith
				{
					_playerObj = _x;
				};
			} forEach playableUnits;
		};
		if(!isNull _playerObj)then
		{
			_playerPos = getPosATL _playerObj;
			_characterID = _playerObj getvariable['CharacterID','0'];
			if(_UDP)then{
				_exit = false;
				{
					_obj = _x;
					if(!isNull _obj)then
					{
						if((_obj isKindOf 'Man') && !(alive _obj))then
						{
							if((_x getvariable['CharacterID','0']) == '0')then{deleteVehicle _x;};
						}
						else
						{
							_wpn = getWeaponCargo _obj;
							_mag = getMagazineCargo _obj;
							_bpc = getBackpackCargo _obj;
							if((str _wpn != '[[],[]]') || (str _mag != '[[],[]]') || (str _bpc != '[[],[]]'))then
							{
								_exit = true;
							};
						};
					};
				} forEach (nearestObjects [_playerPos, ['All'],12]);
				if(_exit)then
				{
					_log = format['%1 | PlayerUID: %2 CharacterID: %3 | Disconnected near Storage Unit @%4 | Resync Gear to prevent duping!',_clientName,_clientUID,_characterID,mapGridPosition _playerPos];
					diag_log _log;
					
					[_playerObj,magazines _playerObj,true,true,false] call server_playerSync;
				};
			};
			if(_UCL)then{
				_isInCombat = 0;_isInCombat = _playerObj getVariable['startcombattimer',0];
				_timeout = 0;_timeout = _playerObj getVariable['combattimeout',0];
				if((_isInCombat == 1) || ((_timeout - time) > 0))then
				{
					_log = format['CombatLog! Attacked @%1',mapGridPosition _playerPos];
					_log = [_clientName,_clientUID,'SLOG',toArray (_log)];
					['SERVER',_log] call "+_fnc_handlerandvar10+";
				};
			};
		};
	};
	_opd = compile ('
		_log = format[''DISCONNECT - %1(%2)'', _name, _uid];
		[''CONNECTLOG'',_log] call fn_custom_log;
		
		"; if(_UDP || _UCL)then{ _AHstring = _AHstring + "
		if(!isNil ''DZE_CleanNull'')then{ [_uid,_name] call '+str _fnc_DisconnectCustom+'; };
		"; }; _AHstring = _AHstring + "
		
		[_uid,_name] call server_onPlayerDisconnect;
	');
	onPlayerConnected {
		_reported = missionNameSpace getVariable [format['reported_%1',_uid],0];
		if(_reported == 0)then
		{
			missionNameSpace setVariable [format['reported_%1',_uid],1];
			'armalog' callExtension ('0'+_uid);
		};
		
		_log = format['CONNECT - %1(%2)', _name, _uid];
		['CONNECTLOG',_log] call fn_custom_log;
	};
	while{1 == 1}do
	{
		onPlayerDisconnected _opd;
		'PVAH_AdminReq' addPublicVariableEventHandler _PVAH_AdminReq;
		
		dze_diag_fps = {};
		_mPos = "+str _mPos+";
		_debug = createMarker ['respawn_west',_mPos];
		_cmPos = (getMarkerPos 'respawn_west');
		if(_cmPos distance _mPos > 100)then
		{
			'respawn_west' setMarkerPos _mPos;
			
			_nearGuys = [];
			{
				_puid = getPlayerUID _x;
				if(_puid != '')then
				{
					_name = 'DEAD';if((alive _x)&&(getPlayerUID _x != ''))then{_name = name _x;};
					_log = format['%1 (%2)',_name,_puid];
					_nearGuys = _nearGuys + [_log];
				};
			} forEach (_cmPos nearEntities ['AllVehicles',150]);
			_log = format['Somebody is trying to change the respawn marker position! %1',_nearGuys];
			_log = ['SERVER','-','HLOG',toArray (_log)];
			['SERVER',_log] call "+_fnc_handlerandvar10+";
		};

		{
			if !(isNil _x)then
			{
				_log = format['Function   %1   broken - Ending Mission! #0',_x];
				diag_log ('<infiSTAR.de> ' + _log);
				_log = ['SERVER','-','HLOG',toArray (_log)];
				['SERVER',_log] call "+_fnc_handlerandvar10+";
				[] spawn {call compile ('endMission ''END1'';');call compile ('forceEnd;');};
			};
		} forEach ['closeDisplay','processInitCommands','setVehicleInit','removeAllEventHandlers','addEventHandler','allowDamage','entities','typeName',
		'forceEnd','allMissionObjects','playableUnits','vehicles','PVAH_AdminRequest','PVAH_WriteLogRequest','endMission','failMission','agents','isDedicated','isServer'];
		if(str _instance != str dayZ_instance)then
		{
			_log = format['dayZ_instance changed from %1 to %2',_instance,dayZ_instance];
			_log = ['SERVER','-','HLOG',toArray (_log)];
			['SERVER',_log] call "+_fnc_handlerandvar10+";
			dayZ_instance = _instance;
		};
		if('infiSTAR' != ('i' +'n' +'f' +'i' +'S' +'T' +'A' +'R'))then{diag_log '<infiSTAR.de> changed source code..';[] spawn {call compile ('endMission ''END1'';');call compile ('forceEnd;');};};
		"; if(_UVC)then{ _AHstring = _AHstring + "
			{
				if(!isNull _x)then
				{
					if !(_x in _vehicleChecked)then
					{
						_vehicleChecked = _vehicleChecked + [_x];
						_type = typeOf _x;
						if((!(_type in ("+str _ALLOWED_Vehicles+")) && ("+str _UVW+")) || (_type in ("+str _FORBIDDEN_Vehicles+")))then
						{
							_posV = getPosATL _x;
							_crew = crew _x;
							
							_crewguys = [];
							if(count _crew > 0)then
							{
								{
									_puid = getPlayerUID _x;
									if(_puid != '')then
									{
										_name = 'DEAD';if((alive _x)&&(getPlayerUID _x != ''))then{_name = name _x;};
										_crewguys = _crewguys + [format['%1 (%2)',_name,_puid]];
									};
								} forEach _crew;
							};
							
							_nearGuys = [];
							{
								_puid = getPlayerUID _x;
								if(_puid != '')then
								{
									_name = 'DEAD';if((alive _x)&&(getPlayerUID _x != ''))then{_name = name _x;};
									_log = format['%1 (%2)',_name,_puid];
									if !(_log in _crewguys)then
									{
										_nearGuys = _nearGuys + [_log];
									};
								};
							} forEach (_posV nearEntities ['AllVehicles',150]);
							
							
							if(count _crew == 0)then
							{
								_log = format['Forbidden Vehicle: %1 (deleted) Near: %2 @%3',_type,_nearGuys,mapGridPosition _posV];
								_log = ['SERVER','-','HLOG',toArray (_log)];
								['SERVER',_log] call "+_fnc_handlerandvar10+";
							}
							else
							{
								{
									_puid = getPlayerUID _x;
									if((_puid != '') && !(_puid in "+str _allAdmins+"))then
									{
										_log = format['Forbidden Vehicle: %1 @%2',_type,_posV];
										_name = 'DEAD';if((alive _x)&&(getPlayerUID _x != ''))then{_name = name _x;};
										_log = [_name,_puid,'BAN',toArray (_log)];
										['SERVER',_log] call "+_fnc_handlerandvar10+";
										[_name,_puid,_x,_log] call fnc_infiSTAR_ServerkickNew;
									};
								} forEach _crew;
							};
							_obj = _x;
							_obj setDamage 1;
							if(!isNull _obj)then
							{
								_objectID 	= _obj getVariable['ObjectID','0'];
								_objectUID	= _obj getVariable['ObjectUID','0'];
								deleteVehicle _obj;
								[_objectID,_objectUID,'<infiSTAR.de> Vehicle Check'] call server_deleteObjDirect;
							};
						};
					};
				};
			} forEach ([0,0,0] nearEntities [['LandVehicle','Air','Ship'], 35000]);
			uiSleep 2;
		"; }; _AHstring = _AHstring + "
		uiSleep 3;
	};
};
"+_randvar1+" = {
	_puid = _this select 0;_name = _this select 1;
	"+_randvar25+" = true;
	diag_log (format['<infiSTAR.de> randvar1 created randvar27a (%1)',time]);
	if !(_puid in "+str _allAdmins+")then
	{
		[_name,_puid] spawn {
			_name = _this select 0;_puid = _this select 1;
			disableSerialization;
			[_name,_puid] spawn {
				_name = _this select 0;_puid = _this select 1;
				sleep 45;
				if(isNil '"+_MenuChecksRunningx+"')then{
					(findDisplay 46) closeDisplay 0;
					_log = 'Menu Checks are broken!';
					[_name,_puid,'SLOG',toArray (_log)] call "+_randvar37+";
				};
			};
			uiNamespace setVariable ['RscDisplayRemoteMissions',nil];
			
			_dayz_spaceInterrupt = {};
			if(isNil'dayz_spaceInterrupt')then
			{
				if(!isNil'DZ_KeyDown_EH')then{_dayz_spaceInterrupt = DZ_KeyDown_EH;};
			}
			else
			{
				_dayz_spaceInterrupt = '_this call dayz_spaceInterrupt';
			};
			_keyDownfncid = -1;
			_ALLOWED_Dialogs = "+str _ALLOWED_Dialogs+";
			while{1 == 1}do
			{
				{
					if !(isNull (findDisplay _x))then
					{
						(findDisplay _x) displayRemoveAllEventHandlers 'MouseZChanged';
						if !(_x in [-1,106,12])then
						{
							(findDisplay _x) displayRemoveAllEventHandlers 'MouseMoving';
							(findDisplay _x) displayRemoveAllEventHandlers 'MouseHolding';
							(findDisplay _x) displayRemoveAllEventHandlers 'MouseButtonDown';
							(findDisplay _x) displayRemoveAllEventHandlers 'MouseButtonUp';
						};
						(findDisplay _x) displayRemoveAllEventHandlers 'KeyDown';
						(findDisplay _x) displayRemoveAllEventHandlers 'KeyUp';
						(findDisplay _x) displayAddEventHandler ['KeyUp',"+_randvar6+"];
					};
				} forEach [-1,12,18,49,106,129];
				
				
				(findDisplay 46) displayRemoveAllEventHandlers 'MouseButtonDown';
				(findDisplay 46) displayRemoveAllEventHandlers 'MouseButtonUp';
				(findDisplay 46) displayRemoveAllEventHandlers 'MouseZChanged';
				(findDisplay 46) displayRemoveAllEventHandlers 'KeyUp';
				(findDisplay 46) displayAddEventHandler ['KeyUp',"+_randvar6+"];
				
				_kdID = 0;
				_shouldbe = 0;
				_checknow = false;
				
				_veh = vehicle player;
				if((_veh != player)&&{(!(_veh isKindOf 'ParachuteBase')&&!(_veh isKindOf 'BIS_Steerable_Parachute'))})then
				{
					(findDisplay 46) displayRemoveAllEventHandlers 'MouseMoving';
					(findDisplay 46) displayRemoveAllEventHandlers 'MouseHolding';
					"; if(_RCK)then{ _AHstring = _AHstring + "
						if(str _dayz_spaceInterrupt == '{}')then
						{
							(findDisplay 46) displayRemoveEventHandler ['KeyDown',_keyDownfncid];
							_keyDownfncid = (finddisplay 46) displayAddEventHandler ['KeyDown',"+_randvar6+"];
						}
						else
						{
							(findDisplay 46) displayRemoveAllEventHandlers 'KeyDown';
							(findDisplay 46) displayAddEventHandler ['KeyDown',"+_randvar6+"];
							(findDisplay 46) displayAddEventHandler ['KeyDown',_dayz_spaceInterrupt];
						};
					"; }; _AHstring = _AHstring + "
				};
				
				uiSleep 0.3;
				
				
				_cc1 = uiNamespace getVariable 'RscDisplayRemoteMissions';
				if(!isNil '_cc1')then
				{
					if(_cc1 != '<null>')then
					{
						_log = format['MenuBasedHack_RscDisplayRemoteMissions: %1',_cc1];
						[] spawn "+_randvar2+";
						[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
					};
				};
				if(!isNull ((findDisplay 64) displayCtrl 101))then
				{
					[] spawn "+_randvar2+";
					[_name,_puid,'BAN',toArray ('Active Menu: 64 ctrl 101')] call "+_randvar37+";
				};
				if(!isNull ((findDisplay 49) displayCtrl 0))then
				{
					[] spawn "+_randvar2+";
					[_name,_puid,'BAN',toArray ('Active Menu: 49 ctrl 0')] call "+_randvar37+";
				};
				if( (lbSelection  ((findDisplay 12) displayCtrl 1001)) select 0 == 1 && ((lbSize ((findDisplay 12) displayCtrl 1002)) > 2 ))then
				{
					[] spawn "+_randvar2+";
					[_name,_puid,'BAN',toArray ('YOLO Menu')] call "+_randvar37+";
				};
				if(!isNull (findDisplay 420420))then
				{
					_state = true;
					{
						if((!isNull _x) && (alive _x) && (getPlayerUID _x == '') && !(_x isKindOf 'zZombie_Base') && !(_x isKindOf 'CAAnimalBase'))exitWith
						{
							_state = false;
						};
					} forEach (player nearEntities ['Man',5]);
					if(_state)then
					{
						(findDisplay 420420) closeDisplay 0;
						closeDialog 0;closeDialog 0;closeDialog 0;
					};
				};
				if(!isNull (findDisplay 41144))then
				{
					_stateD = false;
					_stateV = false;
					if(isNil 'dayz_selectedDoor')then{_stateD = true;} else {if(isNull dayz_selectedDoor)then{_stateD = true;};};
					if(isNil 'dayz_selectedVault')then{_stateV = true;} else {if(isNull dayz_selectedVault)then{_stateV = true;};};
					if((_stateD) && (_stateV))then
					{
						(findDisplay 41144) closeDisplay 0;
						closeDialog 0;closeDialog 0;closeDialog 0;
					};
				};
				if(!isNull (findDisplay 148))then
				{
					if((lbSize 104)-1 > 3)then
					{
						[] spawn "+_randvar2+";
						_log = 'MenuBasedHack_MenuBasedHack_RscDisplayConfigureControllers';
						[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
					};
				};
				if(lbSize 109 > 2)then
				{
					[] spawn "+_randvar2+";
					_log = format['bad lbSize 109 - %1',lbSize 109];
					[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
				};
				{
					if(!isNull (findDisplay _x))exitWith {
						[] spawn "+_randvar2+";
						_log = format['Active Menu: %1',_x];
						[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
					};
				} forEach [17,64,155,156,162,1001,2929,3030,125,69,19,71,45,132,32,165,157,2727,30,9899,0110,110];
				{if(!isNull (findDisplay _x))then{(findDisplay _x) closeDisplay 0;closeDialog 0;};} forEach [148];
				
				
				
				"; if(_CUD)then{ _AHstring = _AHstring + "
					_break = true;
					for '_d' from 0 to (count _ALLOWED_Dialogs) - 1 do
					{
						_id = _ALLOWED_Dialogs select _d;
						if(!isNull (findDisplay _id))exitWith{_break = false;};
					};
					if((_break) && !(ctrlEnabled 1900))then
					{
						closeDialog 0;closeDialog 0;closeDialog 0;
					}
					else
					{
						if(!isNull (findDisplay 106))then
						{
							if(!(ctrlEnabled 6902) && (lbSize ((findDisplay 106) displayCtrl 105) < 1))then
							{
								closeDialog 0;closeDialog 0;closeDialog 0;
							};
						};
					};
					
					_display = findDisplay 106;
					if(!isNull _display)then
					{
						_chck = _display displayCtrl 101;
						_txt = ctrlText _chck;
						_txtA = toArray _txt;
						_cntA = count _txtA;
						if(_cntA < 3)then
						{
							closeDialog 0;
							for '_close' from 0 to 25 do {uiSleep 0.1;closeDialog 0;};
						};
						for '_y' from -10 to 8888 do
						{
							if !(_y in [0,8,12,18,46,70,106,2200])then
							{
								if(!isNull (findDisplay _y))then
								{
									closeDialog 0;
									for '_close' from 0 to 25 do {uiSleep 0.1;closeDialog 0;};
									if(_y in [843])then
									{
										[] spawn "+_randvar2+";
									};
								};
							};
						};
					};
				"; }; _AHstring = _AHstring + "
				"; if(_MEH)then{ _AHstring = _AHstring + "
					buttonSetAction [12004,'[(lbCurSel 12001)] call TraderDialogBuy;((ctrlParent (_this select 0)) closeDisplay 9000);'];
					buttonSetAction [12005,'[(lbCurSel 12001)] call TraderDialogSell;((ctrlParent (_this select 0)) closeDisplay 9000);'];
				"; }; _AHstring = _AHstring + "
				buttonSetAction [104,''];
				"+_MenuChecksRunningx+" = true;
			};
		};
		[_name,_puid] spawn {
			_name = _this select 0;_puid = _this select 1;
			infi_fired"+_randvar5+" =
			{
				private['_cwep','_muzzle','_projectile'];
				_cwep = _this select 1;
				_muzzle = _this select 4;
				_projectile = _this select 6;
				if((_muzzle isKindOf 'Melee') || (_muzzle isKindOf ('Bol' +'tSteel')) || (_muzzle isKindOf 'WoodenArrow') || (_muzzle isKindOf 'GrenadeHand') || (_muzzle isKindOf 'ThrownObjects') || (_muzzle isKindOf 'RoadFlare') || (_muzzle isKindOf 'ChemLight'))exitWith {};
				_cmag = currentMagazine player;
				if(!(_cwep in ['','Throw','Flare','Put']) && !(_projectile in ['','PipeBomb']) && (player == vehicle player))then
				{
					_cfgmuzzle = getText(configFile >> 'CfgMagazines' >> _cmag >> 'ammo');
					if(_muzzle != _cfgmuzzle)then
					{
						player removeMagazines _cmag;
						_log = format['Bad Muzzle - Removed Magazines: %1 %2 %3',_cwep,_cmag,_muzzle];
						_name = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_name = name player;};
						[_name,getPlayerUID player,'HLOG',toArray (_log)] call "+_randvar37+";
					};
					
					_maxAmmo = getNumber (configFile >> 'CfgMagazines' >> _cmag >> 'count');
					if(_maxAmmo > 1)then
					{
						[_maxAmmo,_cwep,_cmag] spawn {
							uiSleep 0.2;
							_maxAmmo = _this select 0;
							_cwep = _this select 1;
							_cmag = _this select 2;
							_camm = player ammo _cwep;
							if(_camm == _maxAmmo)then
							{
								player removeMagazine _cmag;
								[] spawn "+_randvar2+";
								_log = format['No Ammo Loss - Removed Current Magazine: %1 %2 %3 %4',_cwep,_cmag,_camm,_maxAmmo];
								_name = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_name = name player;};
								[_name,getPlayerUID player,'HLOG',toArray (_log)] call "+_randvar37+";
							};
						};
					};
					
					_swep = '';
					{
						if((getNumber (configFile >> 'CfgWeapons' >> _x >> 'Type')) == 2)exitWith
						{
							_swep = _x;
						};
					} forEach (weapons player);
					if(_cwep == _swep)then
					{
						_spd = speed _projectile;
						if(_spd > 3800)then
						{
							player removeMagazines _cmag;
							player removeWeapon _cwep;
							_log = format['Bullet too fast! %1 %2 %3 %4',_cwep,_cmag,_muzzle,_spd];
							_name = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_name = name player;};
							[_name,getPlayerUID player,'HLOG',toArray (_log)] call "+_randvar37+";
						};
					};
				};
			};
			fnc_animchanged"+_randvar5+" =
			{
				if((_this select 1) in ['smk_urbanproneright','smk_prone_to_urbanprone_right','smk_urbanproneleft','smk_prone_to_urbanprone_left'])then
				{
					if((nearestObject [player,'Plastic_Pole_EP1_DZ']) distance player < 75)then
					{
						[objNull, player, rswitchMove,''] call RE;
						player playActionNow 'stop';
						_log = 'Can not use urbanprone near Plot Poles!';
						hint _log;
						systemChat _log;
					};
				};
			};
			while{1 == 1}do
			{
				player removeAllEventHandlers 'AnimChanged';
				player addEventHandler ['AnimChanged', { _this call fnc_animchanged"+_randvar5+" }];
				player removeAllEventHandlers 'Fired';
				player addEventHandler ['Fired', {
					_this call player_fired;
					_this call infi_fired"+_randvar5+";
					if(isNil 'inSafeZone')then{ inSafeZone = false; } else { if(typeName inSafeZone != 'BOOL')then{ inSafeZone = false;YOLO = true; }; };
					if(inSafeZone)then{
						titleText ['You cannot fire your weapon in a SafeZone!','WHITE IN'];
						titleFadeOut 4;
						deleteVehicle (nearestObject [_this select 0,_this select 4]);
					};
				}];
				uiSleep 2;
			};
		};
		[_puid,_name] spawn {
			_puid = _this select 0;
			_name = _this select 1;
			_mPos = "+str _mPos+";
			_spawnPos = _mPos;
			dayz_spawnPos = getPosATL player;
			_spawnPos = getPosATL player;
			_zombieCheck = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\player_zombieCheck.sqf';
			_zombieAttack = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\player_zombieAttack.sqf';
			disableSerialization;
			_idMouseMoving1251 = 0;
			_idMouseMoving1251loops = 0;
			while{1 == 1}do
			{
				"; if(_MOH)then{ _AHstring = _AHstring + "
					_lastidMouseMoving1251 = _idMouseMoving1251;
					_idMouseMoving1251 = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ['MouseMoving',''];
					_idMouseMoving1251loops = _idMouseMoving1251loops + 1;
					if(_idMouseMoving1251loops > 2)then
					{
						if(_lastidMouseMoving1251+1 != _idMouseMoving1251)then
						{
							_log = format['MouseMoving added EventHandler to Map!:   %1 should be %2',_lastidMouseMoving1251+1,_idMouseMoving1251];
							[] spawn "+_randvar2+";
							[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
						};
					};
				"; }; _AHstring = _AHstring + "
				"; if(_UCS)then{ _AHstring = _AHstring + "
					if((ctrlEnabled ((uiNameSpace getVariable 'BIS_dynamicText') displayctrl 9999)) || (ctrlShown ((uiNameSpace getVariable 'BIS_dynamicText') displayctrl 9999)))then
					{
						[] spawn "+_randvar2+";
						[_name,_puid,'BAN',toArray ('dynamicText CHECK 1')] call "+_randvar37+";
					};
					if(str(uiNameSpace getVariable 'BIS_dynamicText') != 'No Display')then
					{
						[] spawn "+_randvar2+";
						[_name,_puid,'BAN',toArray ('dynamicText CHECK 2')] call "+_randvar37+";
					};
				"; }; _AHstring = _AHstring + "
				if(!isNil 'dayz_temperatur')then
				{
					if(dayz_temperatur > dayz_temperaturmax)then
					{
						dayz_temperatur = 37;
						uiSleep 2;
						if(dayz_temperatur > dayz_temperaturmax)then
						{
							[] spawn "+_randvar2+";
							_log = format['dayz_temperatur: %1',dayz_temperatur];
							[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
						};
					};
				};
				
				{
					private ['_ctrlID','_control','_txt','_txtArr'];
					_display = uiNameSpace getVariable ['DAYZ_GUI_display',displayNull];
					if(!isNull _display)then
					{
						_ctrlID = _x;
						_control = _display displayctrl _ctrlID;
						if(!isNull _control)then
						{
							if(str(_control) != 'No Control')then
							{
								_txt = ctrlText _control;
								if((_txt != '') && (ctrlShown _control))then
								{
									_txtArr = toArray _txt;
									if !(46 in _txtArr)then
									{
										_control ctrlShow false;
										[] spawn "+_randvar2+";
										_log = format['BadContent:   id %1   txt %2',_ctrlID,_txt];
										[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
									};
								};
							};
						};
					};
				} forEach [1203,1204,1205,1206,1300,1301,1302,1303,1305,1306,1307];
				
				uiSleep 2;
				_pPos = getPosATL player;
				_noSafeZone = true;
				{
					if(!isNull _x)then
					{
						if(!alive _x)then
						{
							_cip = _x getVariable['"+_randvar3+"',''];
							if(_cip == '')then
							{
								deleteVehicle _x;
							};
						};
					};
					if((!isNull _x) && (alive _x) && (getPlayerUID _x == '') && !(_x isKindOf 'zZombie_Base') && !(_x isKindOf 'CAAnimalBase'))exitWith
					{
						_noSafeZone = false;
					};
				} forEach (_pPos nearEntities ['Man',400]);
				
				"; if(_UZC)then{ _AHstring = _AHstring + "
					if(_noSafeZone)then
					{
						if(isNil 'player_zombieCheck')then
						{
							[] spawn "+_randvar2+";
							[_name,_puid,'BAN',toArray ('zombieCheck broken')] call "+_randvar37+";
						}
						else
						{
							if(str player_zombieCheck != str _zombieCheck)then
							{
								uiSleep 2;
								if(str player_zombieCheck != str _zombieCheck)then
								{
									[] spawn "+_randvar2+";
									[_name,_puid,'HLOG_SKICK',toArray ('zombieCheck changed')] call "+_randvar37+";
								};
							};
						};
						if(isNil 'player_zombieAttack')then
						{
							[] spawn "+_randvar2+";
							[_name,_puid,'BAN',toArray ('zombieAttack broken')] call "+_randvar37+";
						}
						else
						{
							if(str player_zombieAttack != str _zombieAttack)then
							{
								uiSleep 2;
								if(str player_zombieAttack != str _zombieAttack)then
								{
									[] spawn "+_randvar2+";
									[_name,_puid,'HLOG_SKICK',toArray ('zombieAttack changed')] call "+_randvar37+";
								};
							};
						};
					};
				"; }; _AHstring = _AHstring + "
			};
		};
		[_name,_puid] spawn {
			_name = _this select 0;_puid = _this select 1;
			diag_log format['LOCALPLAYERINFO: %1(%2) | %3(%4) | %5',_name,_puid,str _name,str _puid,str (getPlayerUID player)];
			while{1 == 1}do
			{
				"; if(_CSA)then{ _AHstring = _AHstring + "
					"; if(_MEH)then{ _AHstring = _AHstring + "
						if(isNil 's_player_removeActions')then{s_player_removeActions = [];};
						if(isNil 's_player_repairActions')then{s_player_repairActions = [];};
						if(isNil 'r_player_actions')then{r_player_actions = [];};
						if(isNil 'r_player_actions2')then{r_player_actions2 = [];};
						if(isNil 's_player_parts')then{s_player_parts = [];};
						if(isNil 's_player_combi')then{s_player_combi = [];};
						if(isNil 's_player_lockunlock')then{s_player_lockunlock = [];};
						if(isNil 's_vehicle_lockunlock')then{s_vehicle_lockunlock = [];};
						_tempRemoveAction = vehicle player addAction ['', '', [], 1, false, true, '', 'false'];
						_startRemove = _tempRemoveAction - 10;
						_endRemove = _tempRemoveAction + 99;
						
						_dayzActions = [];
						{
							if(!isNil _x)then
							{
								_var = missionNamespace getVariable _x;
								if(typeName _var == 'SCALAR')then
								{
									if!(_var in _dayzActions)then
									{
										_dayzActions set [count _dayzActions,_var];
									};
								}
								else
								{
									if(typeName _var == 'ARRAY')then
									{
										{
											if !(_x in _dayzActions)then
											{
												_dayzActions set [count _dayzActions,_x];
											};
										} forEach _var;
									};
								};
							};
						} forEach "+str _dayzActions+";
						
						for '_i' from _startRemove to _endRemove do
						{
							if !(_i in _dayzActions)then
							{
								player removeAction _i;
								vehicle player removeAction _i;
								if(!isNull cursorTarget)then{cursorTarget removeAction _i;};
							};
						};
					"; }; _AHstring = _AHstring + "
					"; if(!_MEH)then{ _AHstring = _AHstring + "
						_tmpV = vehicle player;
						_tmpRAV =  _tmpV addAction ['', '', [], 1, false, true, '', 'false'];
					"; }; _AHstring = _AHstring + "
					uiSleep 0.2;
					"; if(!_MEH)then{ _AHstring = _AHstring + "
						_tmpV1 = vehicle player;
						_tmpRAV1 =  _tmpV1 addAction ['', '', [], 1, false, true, '', 'false'];
						_dif = _tmpRAV1 - _tmpRAV;
						_cnt = 11;
						if(isNull cursorTarget)then{_cnt = 9;};
						if((_dif > _cnt) && (_tmpV == _tmpV1))then
						{
							if(isNil 'ACTION"+_randvar5+"')then
							{
								[_dif] spawn {
									ACTION"+_randvar5+" = true;
									for '_i' from -10 to 199 do
									{
										player removeAction _i;
										vehicle player removeAction _i;
										if(!isNull cursorTarget)then{cursorTarget removeAction _i;};
									};
									_log = format['To many actions: %1 - (turn off action check if false positive)',_this select 0];
									_name = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_name = name player;};
									[_name,getPlayerUID player,'SLOG',toArray (_log)] call "+_randvar37+";
									uiSleep 1.5;
									ACTION"+_randvar5+" = nil;
								};
							};
						}
						else
						{
							_tmpV removeAction _tmpRAV; _tmpV removeAction _tmpRAV1;
							_tmpV1 removeAction _tmpRAV; _tmpV1 removeAction _tmpRAV1;
						};
					"; }; _AHstring = _AHstring + "
				"; }; _AHstring = _AHstring + "
				if((!isNil 'BIS_MENU_GroupCommunication') && (commandingMenu in ['#User:BIS_MENU_GroupCommunication']))then
				{
					_tmp = BIS_MENU_GroupCommunication;
					showcommandingMenu '';
					for '_i' from 0 to (count _tmp)-1 do
					{
						_selected = _tmp select _i;
						if(count _selected > 4)then
						{
							_log = format['BIS_MENU_GroupCommunication: %1',_selected select 4 select 0 select 1];
							[_name,_puid,'SLOG',toArray (_log)] call "+_randvar37+";
						};
					};
					player removeWeapon 'ItemRadio';
					BIS_MENU_GroupCommunication = nil;
				};
				"; if(_CCM)then{ _AHstring = _AHstring + "
					_commandingMenu = nil;
					_commandingMenu = format['%1',commandingMenu];
					if(!isNil'_commandingMenu')then
					{
						if(_commandingMenu != '')then
						{
							_A = toArray _commandingMenu;
							_A resize 6;
							_A;
							_short = toString _A;
							if!(_commandingMenu in "+str _cMenu+")then
							{
								showcommandingMenu '';
								if(_short in ['#USER:'])then
								{
									[] spawn "+_randvar2+";
									_log = format['BadcommandingMenu: %1',_commandingMenu];
									[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
								};
							};
						};
					};
				"; }; _AHstring = _AHstring + "
				"; if(_BCM)then{ _AHstring = _AHstring + "
					showcommandingMenu '';
				"; }; _AHstring = _AHstring + "
				PV_hackerL0og = nil;PV_SurveillanceLog = nil;PV_writeAdmin_log_ARRAY = nil;
				uiSleep 0.2;
				player hideObject false;
				(vehicle player) hideObject false;
			};
		};
		[] spawn {
			{_x hideObject true;} forEach (allMissionObjects 'USOrdnanceBox');
			{_x hideObject true;} forEach (allMissionObjects 'Foodbox0');
			_mPos = "+str _mPos+";
			_maxx = "+str _MCC+";
			_RAI = "+str _RAI+";
			_watched = "+str _watched+";
			uiSleep 5;
			while{1 == 1}do
			{
				_posP = getPosATL (vehicle player);
				_posPG = [_posP select 0,_posP select 1,0];
				_state = true;
				{
					if((!isNull _x) && (alive _x) && (getPlayerUID _x == '') && !(_x isKindOf 'zZombie_Base') && !(_x isKindOf 'CAAnimalBase'))exitWith
					{
						_state = false;
					};
				} forEach (_posPG nearEntities ['CAManBase',25]);
				if(_state)then
				{
					_nearestObjects = (nearestObjects [player, ['All'], 15]);
					_crew = [];
					if(vehicle player != player)then
					{
						{_crew = _crew + [_x];} forEach (crew vehicle player);
						_nearestObjects = _nearestObjects + [vehicle player];
						_nearestObjects = _nearestObjects + _crew;
					};
					_itemsNear = [];
					{
						if(!isNull _x)then
						{
							_object = _x;
							_pos = getPosATL _object;
							_cntfnd = 0;
							_curInventory = [];
							_curCargo = [];
							_type = typeOf _object;
							
							_LD = ['Land_DZE_GarageWoodDoorLocked','Land_DZE_LargeWoodDoorLocked','Land_DZE_WoodDoorLocked','CinderWallDoorLocked_DZ','CinderWallDoorSmallLocked_DZ'];
							if(isNil 'DZE_DoorsLocked')then{DZE_DoorsLocked = [];};
							if(typeName DZE_DoorsLocked != 'ARRAY')then{DZE_DoorsLocked = [];YOLO = true;};
							if(_type in (DZE_DoorsLocked+_LD))then
							{
								_do =
								{
									_latch = 0;
									_door = 0;
									_hinge = 0;
									{
										if(_x == 'Open_latch')then
										{
											_latch = _object animationPhase _x;
										};
										if(_x == 'Open_hinge')then
										{
											_hinge = _object animationPhase _x;
										};
										if(_x == 'Open_door')then
										{
											_door = _object animationPhase _x;
										};
									} forEach ['Open_latch','Open_hinge','Open_door'];
									if(((_latch == 0) && (_hinge == 0)) && (_door == 1))then
									{
										[_object] spawn {
											_object = _this select 0;
											for '_closedoor' from 0 to 15 do
											{
												{_object animate [_x,0];} forEach ['Open_hinge','Open_latch','Lights_1','Lights_2','Open_door','DoorR','LeftShutter','RightShutter'];
												uiSleep 0.1;
											};
										};
									};
								};
								call _do;
								if(!isNil 'dayz_selectedDoor')then
								{
									if(!isNull dayz_selectedDoor)then
									{
										_object = dayz_selectedDoor;
										call _do;
									};
								};
							};
							
							if(_object isKindOf 'Man')then
							{
								if((getPlayerUID _object == '') && (player distance _mPos > 500) && (_object distance _mPos > 500))then
								{
									_cip = _object getVariable['"+_randvar3+"',''];
									if(_cip == '')then
									{
										_wepsBOT = weapons _object;
										_cwepsBOT = count _wepsBOT;
										_magsBOT = magazines _object;
										_cmagsBOT = count _magsBOT;
										_cntBOT = _cwepsBOT+_cmagsBOT;
										if(_cntBOT > 50)then
										{
											deleteVehicle _object;
											[] spawn "+_randvar2+";
											_log = format['Gear-Bot?: %1 - (%2 @%3) - %4-%5',_cntBOT,_type,_pos,_wepsBOT,_magsBOT];
											_name = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_name = name player;};
											[_name,getPlayerUID player,'HLOG_SKICK',toArray (_log)] call "+_randvar37+";
										};
									};
									if(!isNull _object)then
									{
										if(isNil 'dayz_firstGroup')then
										{
											[] spawn "+_randvar2+";
											_log = format['dayz_firstGroup: %1',dayz_firstGroup];
											_name = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_name = name player;};
											[_name,getPlayerUID player,'HLOG_SKICK',toArray (_log)] call "+_randvar37+";
										};
										_units = units dayz_firstGroup;
										if(_object in _units)then
										{
											deleteVehicle _object;
										};
									};
								};
							};
							
							if(!isNull _object)then
							{
								_curInventory = ((weapons _object)+(magazines _object));
								if((_object isKindOf 'CAManBase') && (!alive _object))then
								{
									_skin_object = format['Skin_%1',_type];
									_curInventory = _curInventory + [_skin_object];
								};
								_bagX = unitBackpack _object;
								if(!isNull _bagX)then
								{
									_pUBM = (getMagazineCargo _bagX) select 0;
									_curInventory = _curInventory + _pUBM;
									_pUBW = (getWeaponCargo _bagX) select 0;
									_curInventory = _curInventory + _pUBW;
									_curInventory;
								};
								{_itemsNear = _itemsNear + [_x];} forEach _curInventory;
								
								_infiSTAR = ((getWeaponCargo _object)+(getMagazineCargo _object));
								if(str(_infiSTAR) != '[[],[],[],[]]')then
								{
									{_cntfnd = _cntfnd + _x;} forEach ((_infiSTAR select 1)+(_infiSTAR select 3));
									{_curCargo = _curCargo + [_x];} forEach (_infiSTAR select 0);
									{_curCargo = _curCargo + [_x];} forEach (_infiSTAR select 2);
									{_itemsNear = _itemsNear + [_x];} forEach _curCargo;
								};
								if(_type in ['WeaponHolder'])then
								{
									_wpnsInObjT = _infiSTAR select 0;
									_wpnsInObjC = _infiSTAR select 1;
									{
										if(_x > 30)then
										{
											_wpnT = _wpnsInObjT select _forEachIndex;
											_log = format['WeaponHolder with %1 %2s looks suspicious',_x,_wpnT];
											_name = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_name = name player;};
											[_name,getPlayerUID player,'HLOG',toArray (_log)] call "+_randvar37+";
										};
									} forEach _wpnsInObjC;
								};
								
								"; if(_CHB)then{ _AHstring = _AHstring + "
									if(_type == 'USOrdnanceBox')then
									{
										_object hideObject true;
										(findDisplay 106) closeDisplay 0;
									}
									else
									{
										_ctypes = ['MedBox0','AmmoBoxSmall_556','AmmoBoxSmall_762','FoodBox2','FoodBox3'];
										if(_type in _ctypes)then
										{
											_BRLCD = 'xoxo';_BRLCD = _object getVariable['BRLCD','xoxo'];
											if(_BRLCD in ['xoxo'])then
											{
												_dirBox = getDir _object;
												_posBox = getPosATL _object;
												deleteVehicle _object;
												
												_object = createVehicle [_type,_posBox,[],0,'CAN_COLLIDE'];
												_object setPosATL _posBox;
												_object setDir _dirBox;
												_object setVariable['BRLCD','kk',true];
												player reveal _object;
											};
										};
										_cntfndW = 0;
										{_cntfndW = _cntfndW + _x;} forEach (_infiSTAR select 1);
										_characterID = '0';_characterID = _object getVariable['CharacterID','0'];
										if((_cntfnd > 10) || ((_type in _ctypes) && (_cntfndW > 1)))then
										{
											if((_type in _ctypes) || (_characterID == '0'))then
											{
												_fine = ['WeaponHolder','WeaponHolder_ItemVault','GraveDZE','CAManBase','TentStorageDomed2','GunRack_DZ','WoodCrate_DZ'];
												if !((_type in _fine) || (_type isKindOf 'Bag_Base_EP1') || (_object isKindOf 'WeaponHolder') || (_object isKindOf 'LandVehicle') || (_object isKindOf 'Air') || (_object isKindOf 'Ship'))then
												{
													_afid = _infiSTAR select 2;
													if(count _afid > 0)then
													{
														_fid = _afid find 'ItemBriefcase100oz';
														if(_fid > -1)then
														{
															_acfid = _infiSTAR select 3;
															_cfid = _acfid select _fid;
															if(_cfid >= 3)then
															{
																_object setPosATL [_pos select 0,_pos select 1,(_pos select 2)+45];
															};
														};
													};
												};
											};
										};
										if((_cntfnd > _maxx) && !(_type in ['WeaponHolder','Wooden_shed_DZ','VaultStorage','StorageShed_DZ','ArmoredSUV_PMC','ArmoredSUV_PMC_DZE','SeaFox']))then
										{
											if(_object isKindOf 'static')then
											{
												_object hideObject true;
												_object setPosATL [_pos select 0,_pos select 1,(_pos select 2)+45];
												
												_log = format['MaxCargo exceeded: %1 | %2 | @%3 %4 | %5 | %6',_type,_cntfnd,mapGridPosition _pos,_pos,_characterID,_infiSTAR];
												_name = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_name = name player;};
												[_name,getPlayerUID player,'HLOG',toArray (_log)] call "+_randvar37+";
											}
											else
											{
												if(_cntfnd > _maxx + 100)then
												{
													{if(!isNull _x)then{_x action ['eject',_object];};} forEach (crew _object);
													_object hideObject true;
													_object setPosATL [_pos select 0,_pos select 1,(_pos select 2)+45];
													
													_log = format['MaxCargo exceeded: %1 | %2 | @%3 %4 | %5 | %6',_type,_cntfnd,mapGridPosition _pos,_pos,_characterID,_infiSTAR];
													_name = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_name = name player;};
													[_name,getPlayerUID player,'HLOG',toArray (_log)] call "+_randvar37+";
												};
											};
										};
									};
								"; }; _AHstring = _AHstring + "
							};
						};
					} forEach _nearestObjects;
					
					_typePlr = typeOf player;
					_invPLR = ((weapons player)+(magazines player));
					_invPLR = _invPLR + [primaryWeapon player];
					_invPLR = _invPLR + [currentWeapon player];
					_invPLR = _invPLR + [(format['Skin_%1',_typePlr])];
					_bagPlr = unitBackpack player;
					if(!isNull _bagPlr)then
					{
						_pUBMPLR = (getMagazineCargo _bagPlr) select 0;
						_invPLR = _invPLR + _pUBMPLR;
						_pUBWPLR = (getWeaponCargo _bagPlr) select 0;
						_invPLR = _invPLR + _pUBWPLR;
						_invPLR;
					};
					if(isNil 'DayZ_onBack')then{DayZ_onBack = '';};
					_TMP_onBack = DayZ_onBack;
					
					uiSleep 0.5;
					
					_inv_plrNEW = ((weapons player)+(magazines player));
					_inv_plrNEW = _inv_plrNEW + [primaryWeapon player];
					_inv_plrNEW = _inv_plrNEW + [currentWeapon player];
					_newbag = unitBackpack player;
					if(!isNull _newbag)then
					{
						if(str _bagPlr == str _newbag)then
						{
							_pUBM__pIrN = (getMagazineCargo _newbag) select 0;
							_inv_plrNEW = _inv_plrNEW + _pUBM__pIrN;
							_pUBW_plrN = (getWeaponCargo _newbag) select 0;
							_inv_plrNEW = _inv_plrNEW + _pUBW_plrN;
							_inv_plrNEW;
						};
					};
					if(isNil 'DayZ_onBack')then{DayZ_onBack = '';};
					_allowed = [DayZ_onBack,_TMP_onBack,'Throw','Flare','Put'];
					
					_allIHave = [];
					{
						if !(_x in _allIHave)then
						{
							_allIHave = _allIHave + [_x];
						};
					} forEach (_invPLR+_allowed+_itemsNear);
					_foundbad = [];
					if !((currentWeapon player) in _allIHave)then
					{
						if !((currentWeapon player) in _foundbad)then
						{
							_foundbad = _foundbad + [(currentWeapon player)];
						};
					};
					if !((primaryWeapon player) in _allIHave)then
					{
						if !((primaryWeapon player) in _foundbad)then
						{
							_foundbad = _foundbad + [(primaryWeapon player)];
						};
					};
					_swep = '';
					{
						if((getNumber (configFile >> 'CfgWeapons' >> _x >> 'Type')) == 2)exitWith
						{
							_swep = _x;
						};
					} forEach (weapons player);
					{
						if(((_x in _watched) || (_x == currentWeapon player) || (_x == primaryWeapon player) || (_x == _swep)) && !(_x in _allIHave))then
						{
							if !(_x in _foundbad)then
							{
								_foundbad = _foundbad + [_x];
							};
						};
					} forEach _inv_plrNEW;
					if(count _foundbad > 0)then
					{
						{
							_Iarray = toArray _x;
							_Iarray resize 5;
							_Iarray;
							_short = toString _Iarray;
							if(_short in ['Melee'])then
							{
								_foundbad = _foundbad - [_x];
							};
						} forEach _foundbad;
					};
					
					_ItemsAdded = [];
					{
						if !(_x in _ItemsAdded)then
						{
							_ItemsAdded = _ItemsAdded + [_x];
						};
					} forEach _foundbad;
					_ItemsAdded = _ItemsAdded - ['Put'];
					_ItemsAdded = _ItemsAdded - [''];
					if(count _ItemsAdded > 0)then
					{
						if(_RAI)then
						{
							{
								[_x] spawn {
									_y = _this select 0;
									for '_i' from 0 to ({_x == _y} count (weapons player)) do {player removeWeapon _y;};
									player removeMagazines _y;
									for '_w' from 0 to 10 do {uiSleep 0.1;player removeWeapon _y;player removeMagazines _y;};
								};
							} forEach _ItemsAdded;
						};
					};
				}
				else
				{
					uiSleep 0.25;
				};
			};
		};
		[] spawn {
			while{1 == 1}do
			{
				_inv = [];
				_inv = _inv + (magazines player);
				_inv = _inv + (weapons player);
				if(!isNull (unitBackpack player))then
				{
					_BW = (getWeaponCargo unitBackpack player) select 0;
					_BM = (getMagazineCargo unitBackpack player) select 0;
					_inv = _inv + _BW + _BM;
				};
				if(isNil 'DayZ_onBack')then{DayZ_onBack = '';};
				_inv = _inv + [DayZ_onBack];
				
				{
					if((_x in _inv) && (_x != ''))then
					{
						[_x] spawn {
							_y = _this select 0;
							for '_i' from 0 to ({_x == _y} count (weapons player)) do {player removeWeapon _y;};
							player removeMagazines _y;
							for '_w' from 0 to 10 do {uiSleep 0.1;player removeWeapon _y;player removeMagazines _y;};
						};
						if(player distance "+str _mPos+" > 500)then
						{
							[] spawn {
								player setDamage 1;
								deleteVehicle player;
							};
							
							[] spawn "+_randvar2+";
							_log = format['BadItem: %1',_x];
							_name = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_name = name player;};
							[_name,getPlayerUID player,'BAN',toArray (_log)] call "+_randvar37+";
						};
					};
				} forEach ("+str _ForbiddenItems+" + ['FakeWeapon','RocketPods','GyroGrenadeLauncher','FFARLauncher','FFARLauncher_12','Rifle','M16_base',
				'HandGunBase','Put','M240_veh','M240_veh_2','M240_veh_MG_Nest','PKT','PKT_MG_Nest','PKT_veh','DT_veh','M2',
				'M3P','DSHKM','KORD','KPVT','M168','M197','AZP85','2A14','GAU12','2A42','M242','GAU8','2A38M','AGS30','AGS17',
				'MK19','M119','M256','D30','D81','ZiS_S_53','2A46M','FFARLauncher_14','CamelGrenades','57mmLauncher',
				'57mmLauncher_64','57mmLauncher_128','80mmLauncher','S8Launcher','MissileLauncher','SidewinderLaucher',
				'SidewinderLaucher_F35','SidewinderLaucher_AH1Z','AT5Launcher','AT5LauncherSingle','2A46MRocket','AT10LauncherSingle',
				'AT11LauncherSingle','AT13LauncherSingle','TOWLauncher','TOWLauncherSingle','HellfireLauncher','VikhrLauncher',
				'BombLauncher','BombLauncherF35','BombLauncherA10','SEARCHLIGHT','CarHorn','BikeHorn','TruckHorn','TruckHorn2',
				'SportCarHorn','MiniCarHorn','R73Launcher','R73Launcher_2','Ch29Launcher','Ch29Launcher_Su34','2A70Rocket','2A70',
				'AT6Launcher','AT9Launcher','AT2Launcher','HeliBombLauncher','AirBombLauncher','Mk82BombLauncher','Mk82BombLauncher_6',
				'StingerLaucher','StingerLauncher_twice','AALauncher_twice','Igla_twice','MaverickLauncher','9M311Laucher',
				'WeaponExplosive','M252','2B14','MeleeWeapon','m8_base','PKT_2','PKT_3','SidewinderLaucher_AH64','M230','BAF_L2A1',
				'BAF_M240_veh','BAF_L7A2','BAF_L94A1','BAF_static_GMG','BAF_GMG','CTWS','CRV7_PG','CRV7_HEPD','CRV7_FAT','M621','M68',
				'D10','PKTBC','PKTBC_veh','SGMT','HellfireLauncher_AH6','StingerLaucher_4x','M242BC','M240BC_veh','M2BC','MK19BC',
				'M120','GrenadeLauncher_EP1','SCAR_Base','SCAR_L_Base','SCAR_H_Base','PKT_high_AI_dispersion','PKT_high_AI_dispersion_tank',
				'AGS30_heli','M32_heli','CZ805_A1_ACR','CZ805_A1_GL_ACR','CZ805_B_GL_ACR','2A42_AI','ATKMK44_ACR_AI','M242_AI','M242BC_AI',
				'CTWS_AI','M256_AI','M68_AI','D81_AI','2A46M_AI','D81CZ_AI','D10_AI','ZiS_S_53_AI','ATKMK44_ACR','D81CZ','2A72','ItemMap_Debug',
				'CMFlareLauncher','FlareLauncher','GRAD','GSh23L','GSh23L_L39','GSh301','GSh302','M134','M134_2','MLRS',
				'SmokeLauncher','SPG9','TwinM134','TwinVickers','YakB']);
				uiSleep 15;
			};
		};
		[] spawn {
			private ['_maxdist','_lastVeh','_curVeh','_lastPos','_curPos','_worldspace','_spawnPos'];
			_mPos = "+str _mPos+";
			_spawnPos = _mPos;
			dayz_spawnPos = getPosATL player;
			_spawnPos = getPosATL player;
			_TPC = 0;

			_name = name player;
			_uid = getPlayerUID player;
			_fn_sendToServer = compile('"+_randvar10+" = _this;publicVariableServer''"+_randvar10+"'';');

{
	_plant = _x createVehicleLocal (getMarkerPos 'center');
	uiSleep 0.1;
	if (sizeOf _x == 0) exitWith { 
		_log = 'Plants texture hack for type ' + _x;
		[_name,_uid,'HLOG_SKICK',toArray (_log)] call _fn_sendToServer;
		diag_log ('<infiSTAR.de> ' + _log);
		[] spawn {call compile ('endMission ''LOSER'';');call compile ('forceEnd;');};
	};
	deleteVehicle _plant;
} count ['grass','prunus','picea','fallentree','phragmites','acer','amygdalusn','Brush','fiberplant','amygdalusc','boulder'];
			while{1 == 1}do
			{
				inGameUISetEventHandler ['PrevAction','false'];
				inGameUISetEventHandler ['NextAction','false'];
				inGameUISetEventHandler ['Action','false'];
				{
					(findDisplay 12) displayCtrl 51 ctrlRemoveAllEventHandlers _x;
					(findDisplay 12) displayRemoveAllEventHandlers _x;
				} count [
					'Load','Unload','ChildDestroyed','MouseEnter','MouseExit','SetFocus',
					'KillFocus','Timer','KeyDown','KeyUp','Char','IMEChar','IMEComposition','JoystickButton','MouseButtonDown',
					'MouseButtonUp','MouseButtonClick','MouseButtonDblClick','MouseMoving','MouseHolding','MouseZChanged',
					'CanDestroy','Destroy','ButtonClick','ButtonDblClick','ButtonDown','ButtonUp','LBSelChanged',
					'LBListSelChanged','LBDblClick','LBDrag','LBDragging','LBDrop','TreeSelChanged','TreeLButtonDown',
					'TreeDblClick','TreeExpanded','TreeCollapsed','TreeMouseMove','TreeMouseHold','TreeMouseExit',
					'ToolBoxSelChanged','Checked','CheckedChanged','CheckBoxesSelChanged','HTMLLink','SliderPosChanged',
					'ObjectMoved','MenuSelected','Draw','VideoStopped'
				];
				"; if(_OMC)then{ _AHstring = _AHstring + "
					((findDisplay 12) displayCtrl 51) ctrlSetEventHandler ['MouseButtonClick',_MBC];
					((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ['MouseButtonClick',_MBC];
				"; }; _AHstring = _AHstring + "
				"; if(!_OMC)then{ _AHstring = _AHstring + "
					onMapSingleClick '';
				"; }; _AHstring = _AHstring + "

				"; if(_UAT)then{ _AHstring = _AHstring + "
					_lastVeh = vehicle player;
					_lastPos = getPosATL player;
					_lastPosZ = [_lastPos select 0,_lastPos select 1,0];
					if !(_lastVeh isKindOf 'Air')then
					{
						_vel = velocity _lastVeh;
						if(_vel select 2 > 10)then
						{
							_velNew = [_vel select 0,_vel select 1,0];
							_lastVeh SetVelocity _velNew;
							_lastVeh setPosATL _lastPosZ;
						};
					};
			uiSleep 0.35;
					_curVeh = vehicle player;
					_curPos = getPosATL player;
					_distance1 = floor(_lastPosZ distance [_curPos select 0,_curPos select 1,0]);
					_maxdist = 120;
					if(_curVeh isKindOf 'Man')then
					{
						_maxdist = 100;
						if(_curVeh == player)then
						{
							_speed = abs (speed player);
							if(_speed <= 0.1)then{_maxdist = 3;};
						};
					};
					if(_curVeh isKindOf 'Air')then{_maxdist = 750;};
					if(_curVeh isKindOf 'LandVehicle')then{_maxdist = 400;};
					if(_curVeh isKindOf 'Ship')then{_maxdist = 400;};
					if(_distance1 > _maxdist)then
					{						
						if((str _lastVeh == str _curVeh) && (_mPos distance _curPos < 350))then
						{
							player setPosATL _lastPos;
						};
						if((str _lastVeh == str _curVeh) && {(player == _driver) || (isNull _driver)})then
						{
							if(_mPos distance _lastPos < 500)exitWith{};
							if(_mPos distance _curPos < 500)exitWith{};
							if(_spawnPos distance _lastPos < 25)exitWith{};
							
							player setVectorUp [0,0,1];
							player setVelocity [0,0,0];
							if(isNil '"+_AHpos+"')then
							{
								if(_distance1 < 15)then
								{
									player setPosATL _lastPos;
								}
								else
								{
									if(_TPC > 1)then
									{
										player setPosATL _lastPos;
										if(_TPC > 3)then
										{
											_log = format['Player Teleport: %1 to %2 (%3m) | %4 | %5 to %6',mapGridPosition _lastPos,mapGridPosition _curPos,_distance1,typeOf _curVeh,_lastPos,_curPos];
											[_name,_uid,'HLOG_SKICK',toArray (_log)] call _fn_sendToServer;
										};
									};
									if(((_curVeh isKindOf 'ParachuteBase') || (_curVeh isKindOf 'BIS_Steerable_Parachute')) && ((floor (_curPos select 2)) > 35))then
									{
										_curVeh setPosATL _lastPosZ;
										if(!isNull _curVeh)then{deleteVehicle _curVeh;};
										_log = 'Player to fast with Parachute (Teleport?) put to Ground.';
										[_name,_uid,'SLOG',toArray (_log)] call _fn_sendToServer;
									}
									else
									{
										_TPC = _TPC + 1;
									};
								};
							}
							else
							{
								[_name,_uid,'TPCHECK',"+_AHpos+"] call _fn_sendToServer;
								"+_AHpos+" = nil;
							};
						};
					};
				"; }else{ _AHstring = _AHstring + "
		uiSleep 0.35;
				"; }; _AHstring = _AHstring + "
			};
		};
		"+_randvar4+" = {
			_bkey = _this select 0;
			_log = format['<infiSTAR.de>: You have pressed a forbidden Key! (%1)',_bkey];
			cutText [_log,'WHITE IN'];
			hint _log;
			systemchat _log;
			"; if(_PBK)then{ _AHstring = _AHstring + "
			for '_start' from 0 to 5 do {disableUserInput true;};
			"; }; _AHstring = _AHstring + "
			
			"; if(_LBK)then{ _AHstring = _AHstring + "
			_log = format['BadKey: %1',_bkey];
			_name = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_name = name player;};
			[_name,getPlayerUID player,'SLOG_BK',toArray (_log)] call "+_randvar37+";
			"; }; _AHstring = _AHstring + "
			
			"; if(_PBK)then{ _AHstring = _AHstring + "
			uiSleep 3;for '_stop' from 0 to 5 do {disableUserInput false;};
			"; }; _AHstring = _AHstring + "
		};
		"; if(_UIM)then{ _AHstring = _AHstring + "
			"+_randvar6+" = ""
				_key = _this select 1;
				_shift = _this select 2;
				_ctrl = _this select 3;
				_alt = _this select 4;
				_handled = false;
				if(_key == "+str _ODK+")then
				{
					[] spawn fnc_debugX0;
					_handled = true;
				};
				_handled
			"";
		"; }else{ _AHstring = _AHstring + "
			"+_randvar6+" = ""
				_key = _this select 1;
				_shift = _this select 2;
				_ctrl = _this select 3;
				_alt = _this select 4;
				_handled = false;
				
				_fnc_punish_combatlog = {
					_isInCombat = player getVariable['startcombattimer',0];
					if(str _isInCombat != '0')then{ player setDamage 1; };
				};
				
				if(_key == "+str _ODK+")then{[] spawn fnc_debugX0;_handled=true};
				"; if(_RCK)then{ _AHstring = _AHstring + "
					if(_key == "+str _OpenMenuKey+")then{['AdminMenu Key'] spawn "+_randvar4+";_handled=true};
					if(_key == 0xC7)then{['Home - Known to start HackMenus'] spawn "+_randvar4+";_handled=true};
					if(_key == 0x3C)then{['F2 - Known to start HackMenus'] spawn "+_randvar4+";_handled=true};
					if(_key == 0x3D)then{['F3 - Known to start HackMenus'] spawn "+_randvar4+";_handled=true};
					if(_shift)then
					{
						if(_key == 0x19)then{['Shift + P to CombatLog'] spawn "+_randvar4+";call _fnc_punish_combatlog;_handled=true};
					};
					if(_alt)then
					{
						if(_key == 0x57)then{['ALT-F11'] spawn "+_randvar4+";};
						if(_key == 0x3E)then{['ALT-F4 to CombatLog'] spawn "+_randvar4+";call _fnc_punish_combatlog;_handled=true};
					};
				"; }; _AHstring = _AHstring + "
				_handled
			"";
			"; if(_VON)then{ _AHstring = _AHstring + "
			[] spawn {
				_voicecount = 0;
				while{1 == 1}do
				{
					if(!isNull findDisplay 63)then
					{
						_ctrlText = ctrlText (findDisplay 63 displayCtrl 101);
						_chID = switch _ctrlText do {
							case localize 'STR_GLOBAL_CHANNEL' : {0};
							case localize 'STR_SIDE_CHANNEL' : {1};
							default {['',-1]};
						};
						if((!isNull findDisplay 55) && (_chID in [0,1]))then
						{
							_msg = '<infiSTAR.de>: NO VOICE ON SIDE/GLOBAL!';
							hint _msg;
							1 cutText [format ['%1',_msg],'PLAIN DOWN'];
							systemchat _msg;
							
							_voicecount = _voicecount + 1;
							if(_voicecount > 3)then
							{
								_log = format['Voice over Side Chat (KILLED) @%1',mapGridPosition player];
								[name player,getPlayerUID player,'SLOG',toArray (_log)] call "+_randvar37+";
								uiSleep 3;
								findDisplay 46 closeDisplay 0;
							};
						};
					};
					uiSleep 0.5;
				};
			};
			"; }; _AHstring = _AHstring + "
		"; }; _AHstring = _AHstring + "
		[_name,_puid] spawn {
			_name = _this select 0;_puid = _this select 1;
			_FTG = "+str _FTG+";
			while{1 == 1}do
			{
				_ltxt = lbtext [12001,0];
				if(!isNil 'TraderItemList')then
				{
					if(typeName TraderItemList == 'CODE')then
					{
						[] spawn "+_randvar2+";
						_log = format['Active Menu:   Trader Menu - not near a Trader! #1 - %1 @%2',_ltxt,getPosATL player];
						[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
					};
				};
				
				_cwep = currentWeapon player;
				if(_cwep != '')then
				{
					_cammo = player ammo _cwep;
					if(abs _cammo > 100000)then
					{
						[] spawn "+_randvar2+";
						_log = format['AmmoCheck: %1',_cammo];
						[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
					};
				};
				"; if(_URC)then{ _AHstring = _AHstring + "
				if(str(unitRecoilCoefficient player) != str(1))then
				{
					[] spawn "+_randvar2+";
					[_name,_puid,'BAN',toArray ('NoRecoil')] call "+_randvar37+";
				};
				vehicle player setUnitRecoilCoefficient 1;
				player setUnitRecoilCoefficient 1;
				"; }; _AHstring = _AHstring + "
				setTerrainGrid _FTG;
				BIS_fnc_spawnCrew = {};
				BIS_fnc_spawnGroup = {};
				BIS_fnc_help = {};
				bis_fnc_3Dcredits = {};
				BIS_fnc_crows = {};
				bis_fnc_customGPS = {};
				bis_fnc_destroyCity = {};
				BIS_fnc_dirIndicator = {};
				bis_fnc_spawnvehicle = {};
				BIS_fnc_spawnEnemy = {};
				BIS_fnc_AAN = {};
				bis_fnc_taskPatrol = {};
				bis_fnc_taskDefend = {};
				BIS_fnc_taskAttack = {};
				BIS_fnc_supplydrop = {};
				BIS_fnc_spotter = {};
				BIS_fnc_listPlayers = {};
				bis_fnc_customGPSvideo = {};
				uiSleep 0.5;
				_con = vehicle cameraOn;
				_veh = vehicle player;
				if(str _con != str _veh)then
				{
					if(typeName _con == 'OBJECT')then
					{
						if(str(_con) != '<NULL-object>')then
						{
							if(!isNull _con)then
							{
								if((_veh distance "+str _mPos+" > 250) && (_con distance "+str _mPos+" > 250) && (_con distance _veh > 150))then
								{
									if(str(vehicle cameraOn) != str(vehicle player))then
									{
										[] spawn "+_randvar2+";
										_log = format['BadCamera: (%1) should be (%2), distance: %3m',_con,_veh,_con distance _veh];
										[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
									};
								};
							};
						};
					};
				};
			};
		};
		"; if(_UIC)then{ _AHstring = _AHstring + "
		[_puid,_name] spawn {
			_puid = _this select 0;_name = _this select 1;
			while{1 == 1}do
			{
				uiSleep 3;
				_posP = getPos player;
				{
					if((!isNull _x)&&{alive _x})then
					{
						if(str _x != str player)then
						{
							_type = typeOf _x;
							_parachuteWest = ((_type == 'ParachuteWest') || (_type == 'ParachuteC'));
							if(!_parachuteWest)then
							{
								_xID = _x getVariable['ObjectID','-3'];
								_xUID = _x getVariable['ObjectUID','-3'];
								if(_xID == '-3' && _xUID == '-3')then
								{
									_checkedTime = _x getVariable['ObjectIDCT',-1];
									if(_checkedTime == -1)then
									{
										_x setVariable['ObjectIDCT',diag_tickTime];
									}
									else
									{
										if(diag_tickTime - _checkedTime > 30)then
										{
											_pos = getPos _x;
											_mgp = mapGridPosition _pos;
											_x setDamage 1;
											
											_log = format['Vehicle with Invalid ID: %1 @%2 (waited 30 seconds..)',_type,_mgp];
											[_name,_puid,'HLOG',toArray (_log)] call "+_randvar37+";
										};
									};
								};
							};
						};
					};
				} forEach ([vehicle player]+(_posP nearEntities [['LandVehicle','Air','Ship'],25]));
			};
		};
		"; }; _AHstring = _AHstring + "
		"; if(_URG)then{ _AHstring = _AHstring + "
		[_name,_puid] spawn {
			_name = _this select 0;_puid = _this select 1;
			private ['_fuelpumparray','_fueltruckarray','_fuelsources'];
			_antirefuel = true;
			_anticargod = true;
			_cheatref = 0;
			_cheatrep = 0;
			_impparts = ['HitLFWheel','HitLBWheel','HitRFWheel','HitRBWheel','HitEngine'];
			_fuelpumparray =
			[
				'FuelPump_DZ','Land_A_FuelStation_Feed','Land_Ind_FuelStation_Feed_EP1','Land_FuelStation_Feed_PMC','FuelStation',
				'Land_ibr_FuelStation_Feed','Land_fuelstation_army','Land_fuelstation','land_fuelstation_w','Land_benzina_schnell'
			];
			if(!isNil 'dayz_fuelpumparray')then
			{
				if(typeName dayz_fuelpumparray == 'ARRAY')then
				{
					_fuelpumparray = _fuelpumparray + dayz_fuelpumparray;
				};
			};
			_fueltruckarray =
			[
				'KamazRefuel_DZ','UralRefuel_TK_EP1_DZ','MtvrRefuel_DES_EP1_DZ','V3S_Refuel_TK_GUE_EP1_DZ','MtvrRefuel_DZ',
				'KamazRefuel_DZE','UralRefuel_TK_EP1_DZE','MtvrRefuel_DES_EP1_DZE','V3S_Refuel_TK_GUE_EP1_DZE','MtvrRefuel_DZE'
			];
			if(!isNil 'DZE_fueltruckarray')then
			{
				if(typeName DZE_fueltruckarray == 'ARRAY')then
				{
					_fueltruckarray = _fueltruckarray + DZE_fueltruckarray;
				};
			};
			_fuelsources =
			[
				'Land_Ind_TankSmall','Land_fuel_tank_big','Land_fuel_tank_stairs','Land_fuel_tank_stairs_ep1',
				'Land_wagon_tanker','Land_fuelstation','Land_fuelstation_army','land_fuelstation_w','Land_benzina_schnell'
			];
			if(!isNil 'dayz_fuelsources')then
			{
				if(typeName dayz_fuelsources == 'ARRAY')then
				{
					_fuelsources = _fuelsources + dayz_fuelsources;
				};
			};
			vehicle_getHitpoints = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\vehicle_getHitpoints.sqf';
			_getHitpoints = vehicle_getHitpoints;
			object_getHit = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\object_getHit.sqf';
			_getHit = object_getHit;
			while{1 == 1}do
			{
				_vehold = vehicle player;
				if((_vehold != player) && (player == driver _vehold) && ((typeOf _vehold) != 'Tractor'))then
				{
					_oldpos = getPosATL _vehold;
					_oldfuel = fuel _vehold;
					_oldtime = time;
					_damold = false;
					_hitp = _vehold call _getHitpoints;
					{
						_damage = [_vehold,_x] call _getHit;
						if((_x in _impparts) && (_damage == 1))exitWith 
						{
							_damold = true;
						};
					} forEach _hitp;
					uiSleep 3;
					_vehnew = vehicle player;
					if((_vehnew == _vehold) && (player == driver _vehnew))then
					{
						_newpos = getPosATL _vehnew;
						_newfuel = fuel _vehnew;
						_newtime = time;
						if((_newfuel > _oldfuel) || (_damold))then
						{
							_distance = [_oldpos select 0,_oldpos select 1,0] distance [_newpos select 0,_newpos select 1,0];
							_difftime = _newtime - _oldtime;
							_speed = (_distance / _difftime)*3.6;
							_typeveh = typeOf _vehnew;
							_topSpeed = getNumber (configFile >> 'CfgVehicles' >> _typeveh >> 'maxSpeed');
							_nearSpeed = 30*(_topSpeed/100);
							if(_speed > _nearSpeed)then
							{
								_adm = false;
								_ppls = crew _vehnew;
								_nameppls = [];
								{
									_uid = getPlayerUID _x;
									if(_uid != '')then
									{
										if(_x != player)then{
											_namexx = 'DEAD';if((alive _x)&&(getPlayerUID _x != ''))then{_namexx = name _x;};
											_nameppls = _nameppls + [[_namexx,_uid]];
										};
									};
								} forEach _ppls;
								if(!_adm)then
								{
									if((_damold) && (_anticargod))then
									{
										_dampart = [];
										_damnew = false;
										{
											_damage = [_vehnew,_x] call _getHit;
											if((_x in _impparts) && (_damage == 1))then 
											{
												_dampart = _dampart + [[_x,_damage]];
												_damnew = true;
											};
										} forEach _hitp;
										if(_damnew)then{_cheatrep = _cheatrep + 1;};
										if(_cheatrep > 2)then
										{
											_cheatrep = 0;
											[_vehnew] spawn {
												_vehnew = _this select 0;
												
												vehicle_getHitpoints = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\vehicle_getHitpoints.sqf';
												_getHitpoints = vehicle_getHitpoints;
												_hitp = _vehnew call _getHitpoints;
												_selections = [];
												{
													_selections = _selections + [getText (configFile >> 'CfgVehicles' >> (typeOf _vehnew) >> 'HitPoints' >> _x >> 'name')];
												} forEach _hitp;
												while{1 == 1}do
												{
													{
														_strH = 'hit_' + (_x);
														_dam = _vehnew getvariable[_strH,0];
														if(_dam != 0)then{_vehnew setHit [_x,_dam];};
													} forEach _selections;
													if((_vehnew == player) || (player != driver _vehnew))exitWith {};
													uiSleep 0.005;
												};
											};
											_log = format['%1 DRIVING %2 WITH CHEAT REPAIRING | speed: %4km/h | damage: %3 | position: %5 (%6) | players in vehicle: %7',_name,_typeveh,_dampart,round _speed,_newpos,mapGridPosition _newpos,_nameppls];
											[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
											[] spawn "+_randvar2+";
										};
									};
									if((_newfuel > _oldfuel) && (_antirefuel))then
									{
										_fsources = _fuelpumparray + _fuelsources;
										_listfuel = (nearestObjects [_posnew, _fsources, 100]) + (nearestObjects [_posold, _fsources, 100]);
										_listveh = ((_posnew nearEntities [['Landvehicle'], 100]) + (_posold nearEntities [['Landvehicle'], 100]));
										_fveh = false;
										{
											if((typeOf _x) in _fueltruckarray)exitWith {_fveh = true;};
										} forEach _listveh;
										
										if(!_fveh && ((count _listfuel) == 0))then{_cheatref = _cheatref + 1;};
										if(_cheatref > 2)then 
										{
											_cheatref = 0;
											_vehnew setVelocity [0,0,0];
											{_x action ['eject',_vehnew];} forEach (crew _vehnew);
											deleteVehicle _vehnew;
											_log = format['AUTO REFUEL %10 IN MOVEMENT (x3) | speed: %2km/h | old position: %3 (%4) - new position: %5 (%6) | old fuel: %7 - new fuel: %8 | players in vehicle: %9',_name,round _speed,_oldpos,mapGridPosition _oldpos,_newpos,mapGridPosition _newpos,_oldfuel,_newfuel,_nameppls,_typeveh];
											[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
											[] spawn "+_randvar2+";
										};
									};
								};
							};
						};
					};
				}
				else
				{
					uiSleep 3;
				};
			};
		};
		"; }else{ _AHstring = _AHstring + "
		[] spawn {
			vehicle_getHitpoints = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\vehicle_getHitpoints.sqf';
			_getHitpoints = vehicle_getHitpoints;
			while{1 == 1}do
			{
				_veh = vehicle player;
				if((_veh != player) && (player == driver _veh))then
				{
					_hitp = _veh call _getHitpoints;
					_selections = [];
					{
						_selections = _selections + [getText (configFile >> 'CfgVehicles' >> (typeOf _veh) >> 'HitPoints' >> _x >> 'name')];
					} forEach _hitp;
					while{1 == 1}do
					{
						{
							_strH = 'hit_' + (_x);
							_dam = _veh getvariable[_strH,0];
							if(_dam != 0)then{_veh setHit [_x,_dam];};
						} forEach _selections;
						if((_veh == player) || (player != driver _veh))exitWith {};
						uiSleep 0.005;
					};
				};
				uiSleep 2;
			};
		};
		"; }; _AHstring = _AHstring + "
		_version = productVersion select 3;
		if(_version < 125548)then
		{
			_log1 = format['BadVersion: %1 - install newer arma2oa beta!',_version];
			hint _log1;
			cutText [_log1,'PLAIN DOWN'];
			
			_log2 = format['BadVersion: %1 (has to be a newer arma2oa beta - disconnected)',_version];
			[name player,getPlayerUID player,'SLOG',toArray (_log2)] call "+_randvar37+";
			
			(findDisplay 46) closeDisplay 0;
		};
	};
	[_name,_puid] spawn {
		disableSerialization;
		_name = _this select 0;_puid = _this select 1;
		_idcount = 0;
		_startTime = time;
		_fnc_inString = {
			private ['_needle','_haystack','_needleLen','_hay','_found'];
			_needle = _this select 0;
			if(isNil'_needle')exitWith{};
			if(typeName _needle != 'STRING')exitWith{};
			if(_needle == '')exitWith{};
			_needle = toLower _needle;
			
			_haystack = _this select 1;
			if(isNil'_haystack')exitWith{};
			if(typeName _haystack != 'STRING')exitWith{};
			if(_haystack == '')exitWith{};
			_haystack = toLower _haystack;
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
		_veryBadTexts =
		[
			'/item','/gunbox','/run','/backpack','/morph','/start','/exec','/menu','/skin','/ban','adminstart','admin_start','.ban','.sqf','bbhelp','bbammo','bbbox','bbdel','bbesp','bbgod','bbtp','bbunlock',
			'/pesp','/pmarkers','/ptp','/pdel','/pammo','/pnuke','/pgunbox','/pepochbox','/pteleportall','/pgod','t3l3all','n00k3','t3p3','4mm0','3sp','j3sus','v3hj3sus','m4rk3rs','z3dz','inf4mm0','b0mb4ll','bombtrgt',
			'/troll','/troll funces','/trollf','/trollfu','/trollfun','/trollfunk','/trollfunks','/troll funks','/trollf','/trollfuc','/trollfuck','/trollfucku','/trollfuckup','/spawn100','irap3','irap3bt','irap3ex','irap3mrk',
			'irap35p','irap37a','irap3d3l','/bot','/tp','/2ndtp','/playermarker','/safemarkers','/fini','/finikillall','/banall','/givecoins','/itemspawn','/itemmassspawn','/vehspawn','/finitpall','/finiinfistar',
			'/finiactivatere','/kickall','/finialldance','/god','/fixvehicle','/time','/keybind','/esp'
		];
		while{1 == 1}do
		{
			if(animationState player == 'awoppercmstpsoptwbindnon_awoppknlmstpsoptwbindnon_lnr')then
			{
				player setDamage 1;
				uiSleep 1;
				_log = format['Launcher glitch trying to crash server @%1',mapGridPosition player];
				[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
			};
			if(!isNil 'PVCDZ_plr_Login')then
			{
				if(typeName PVCDZ_plr_Login != 'ARRAY')then
				{
					[] spawn "+_randvar2+";
					_log = format['PlayerLogin: %1 != ARRAY      %2',typeName PVCDZ_plr_Login,time];
					[_name,_puid,'HLOG_SKICK',toArray (_log)] call "+_randvar37+";
				};
			};
			uiSleep 0.2;
		"; if(!_UIM)then{ _AHstring = _AHstring + "
			_display = findDisplay 24;
			if(isNull _display)then
			{
				uiSleep 0.3;
			}
			else
			{
				_chat = _display displayCtrl 101;
				_txt = ctrlText _chat;
				if(_txt != '')then
				{
					_txtArray = toArray _txt;
					if((_txtArray select 0) in [44,36,37,38,92,124,194,176,45,95,60,62])then{_chat ctrlSetText '';};
					_txt = toLower _txt;
					"; if(_UCF)then{ _AHstring = _AHstring + "
						if(_txt in ['/scream','scream'])then
						{
							(_display) closeDisplay 0;
							_sound = ['z_scream_3','z_scream_4'] call BIS_fnc_selectRandom;
							[nil,player,rSAY,[_sound,250]] call RE;
							[player,500,true,(getPosATL player)] spawn player_alertZombies;
						};
						if(isNil 'canbuild')then{ canbuild = true; } else { if(typeName canbuild != 'BOOL')then{ canbuild = true;YOLO = true; }; };
						if(vehicle player == player)then
						{
							if((count (nearestObjects [player, ['Plastic_Pole_EP1_DZ'],65]) == 0) && (canbuild))then
							{
								if(_txt in ['stop','/stop'])then
								{
									(_display) closeDisplay 0;
									[objNull, player, rswitchMove,''] call RE;
									player playActionNow 'stop';
								};
								if(_txt in ['pushup','/pushup'])then
								{
									(_display) closeDisplay 0;
									[objNull, player, rplayMove,'AmovPercMstpSnonWnonDnon_exercisePushup'] call RE;
								};
								if(_txt in ['handstand','/handstand'])then
								{
									(_display) closeDisplay 0;
									[objNull, player, rplayMove,'AmovPercMstpSnonWnonDnon_idle70chozeniPoRukou'] call RE;
								};
								if(_txt in ['boxing','/boxing'])then
								{
									(_display) closeDisplay 0;
									[objNull, player, rplayMove,'AmovPercMstpSnonWnonDnon_idle68boxing'] call RE;
								};
								if(_txt in ['karate','/karate','fighter','/fighter'])then
								{
									(_display) closeDisplay 0;
									[objNull, player, rplayMove,'AmovPercMstpSnonWnonDnon_exerciseKata'] call RE;
								};
								if(_txt in ['boogie','/boogie'])then
								{
									(_display) closeDisplay 0;
									[objNull, player, rplayMove,'ActsPercMstpSnonWnonDnon_DancingDuoIvan'] call RE;
								};                             
								if(_txt in ['dance','/dance'])then
								{
									(_display) closeDisplay 0;
									[objNull, player, rplayMove,'ActsPercMstpSnonWnonDnon_DancingStefan'] call RE;
								};
								if(_txt in ['clubbing','/clubbing'])then
								{
									(_display) closeDisplay 0;
									[objNull, player, rplayMove,'ActsPercMstpSnonWnonDnon_DancingDuoStefan'] call RE;
								};
								if(_txt in ['excercise','/excercise'])then
								{
									(_display) closeDisplay 0;
									[objNull, player, rplayMove,'AmovPercMstpSnonWnonDnon_idle69drepy'] call RE;
								};
							};
						};
						if(_txt in ['/killme','!killme','/suicide','!suicide'])then
						{
							_waitTime = 180;
							if(time > _startTime + _waitTime)then
							{
								_chat ctrlSetText 'GOOD BYE CRUEL WORLD';
								player setDamage 1;
								_startTime = time;
							}
							else
							{
								_chat ctrlSetText format['You have to wait %1s',ceil((_startTime + _waitTime) - time)];
							};
						};
						if(_txt in ['/cry','cry','!cry'])then
						{
							(_display) closeDisplay 0;
							[nil,player,rSAY,['babycry_1', 100]] call RE;
						};
					"; }; _AHstring = _AHstring + "
					"; if(_UDN)then{ _AHstring = _AHstring + "
						if(_txt in ['!vote day','/vote day','vote day','!day','/day'])then
						{
							(_display) closeDisplay 0;
							[player,'DAY'] call "+_randvar37+";
						};
						if(_txt in ['!vote night','/vote night','vote night','!night','/night'])then
						{
							(_display) closeDisplay 0;
							[player,'NIGHT'] call "+_randvar37+";
						};
					"; }; _AHstring = _AHstring + "
					if(_txt in ['!help','/help','help'])then
					{
						(_display) closeDisplay 0;
						systemChat 'infiSTAR.de ChatCommands:';
						systemChat '/stop, stop, /pushup, pushup, /handstand, handstand, /boxing, boxing,';
						systemChat '/karate, karate, /fighter, fighter, /boogie, boogie,';
						systemChat '/dance, dance, /clubbing, clubbing, /excercise, excercise,';
						"; if(_UDN)then{ _AHstring = _AHstring + "
						systemChat '!vote day,/vote day, vote day,!vote night,/vote night, vote night';
						"; }; _AHstring = _AHstring + "
						systemChat '/killme, killme, /suicide, suicide';
						systemChat '/cry, cry, !cry';
					};
					if(_txt in _veryBadTexts)then
					{
						(_display) closeDisplay 0;
						_log = format['BadText: %1',_txt];
						[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
						(findDisplay 46)closeDisplay 0;
					}
					else
					{
						{
							_found = [_x,_txt] call _fnc_inString;
							if(_found)exitWith
							{
								(_display) closeDisplay 0;
								_log = format['BadText: %1',_txt];
								[_name,_puid,'HLOG_SKICK',toArray (_log)] call "+_randvar37+";
								(findDisplay 46)closeDisplay 0;
							};
						} forEach _veryBadTexts;
					};
					if(_txt in ['/m'])then
					{
						[] spawn {
							for '_i' from 0 to 10 do
							{
								closeDialog 0;closeDialog 0;closeDialog 0;
								uiSleep 0.2;
							};
						};
						(_display) closeDisplay 0;
						_log = format['BadText: %1',_txt];
						[_name,_puid,'HLOG',toArray (_log)] call "+_randvar37+";
					};
					if!(_puid in "+str _allAdmins+")then
					{
						if(_txt in [format['.ban %1',toLower _name],format['.ban %1 true',toLower _name],format['.ban %1 true;',toLower _name]])then
						{
							_log = format['BadText: %1',_txt];
							[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
						};
						if(_txt in ['adminstart','admin_start'])then
						{
							_log = format['BadText: %1',_txt];
							[_name,_puid,'BAN',toArray (_log)] call "+_randvar37+";
						};
					};
				};
			};
			if(!isNil 'r_player_unconscious')then
			{
				if(typeName r_player_unconscious != 'BOOL')then{r_player_unconscious = false;};
				if(isNil 'deathHandled')then{ deathHandled = true; } else { if(typeName deathHandled != 'BOOL')then{ deathHandled = true;YOLO = true; }; };
				
				_obj = player;
				if(isNil 'inSafeZone')then{ inSafeZone = false; } else { if(typeName inSafeZone != 'BOOL')then{ inSafeZone = false;YOLO = true; }; };
				if(inSafeZone)then
				{
					if(r_player_unconscious)then
					{
						player setVariable ['NORRN_unconscious',false,true];
						player setVariable ['unconsciousTime',0,true];
						player setVariable ['USEC_isCardiac',false,true];
						r_player_unconscious = false;
						r_player_cardiac = false;
						r_player_handler1 = false;
						disableUserInput false;
						if(vehicle player == player)then{
							[nil, player, rSWITCHMOVE, 'AinjPpneMstpSnonWnonDnon'] call RE;
							player SWITCHMOVE 'AinjPpneMstpSnonWnonDnon';
							PVDZ_plr_SwitchMove = [player,'AinjPpneMstpSnonWnonDnon'];
							publicVariableServer 'PVDZ_plr_SwitchMove';
							
							player playMoveNow 'AmovPpneMstpSnonWnonDnon_healed';
						};
					};
				};
				if((r_player_unconscious) && (!deathHandled))then
				{
					if(_obj getVariable['infiUnconDone','0'] == '0')then
					{
						_obj setVariable['infiUnconDone','1'];
						[] spawn {
							endLoadingScreen;
							_mytime = 0;
							if(!isNull player)then{_mytime = player getVariable['unconsciousTime',0];};
							if(_mytime == 0)then{_mytime = 30;};
							_steps = 1 / _mytime;	
							for '_i' from 0 to _mytime do
							{
								_txt = format['infiSTAR.de unconscious: %1s',_mytime - _i];
								startLoadingScreen [_txt,'DayZ_loadingScreen'];
								progressLoadingScreen (_steps*_i);
								uiSleep 1;
								if(isNil 'r_player_unconscious')then{ r_player_unconscious = true; } else { if(typeName r_player_unconscious != 'BOOL')then{ r_player_unconscious = true;YOLO = true; }; };
								if(!r_player_unconscious)exitWith {endLoadingScreen;};
								if(isNil 'deathHandled')then{ deathHandled = true; } else { if(typeName deathHandled != 'BOOL')then{ deathHandled = true;YOLO = true; }; };
								if(deathHandled)exitWith {endLoadingScreen;};
							};
							endLoadingScreen;
						};
					};
					(findDisplay 24) closeDisplay 0;
				}
				else
				{
					if(_obj getVariable['infiUnconDone','-1'] == '1')then
					{
						_obj setVariable['infiUnconDone','0'];comment '#vi1387345919';
					};
				};
			};
		"; }; _AHstring = _AHstring + "
		};
	};
	"; if(!_UIM)then{ _AHstring = _AHstring + "
	[_name,_puid] spawn {
		_name = _this select 0;_puid = _this select 1;
		_colorTXT = "+str _EscColor+";
		_btnTitle0TXT = "+str _TopOfESC+";
		_btnTitle1TXT = "+str _LowerTop+";
		_btnTitle2TXT = "+str _LowerBottom+";
		disableSerialization;
		_startTime = time;
		while{1 == 1}do
		{
			waitUntil {uiSleep 0.1;!isNull findDisplay 49};
			_display = findDisplay 49;
			if(!isNull _display)then
			{
				_btnSave = _display displayCtrl 103;
				_btnSave ctrlShow true;
				_btnSave ctrlEnable false;
				_btnSave ctrlSetScale 0.8;
				_btnSave ctrlSetText 'PlayerUID (SteamID):';
				_btnSave ctrlCommit 0;
				
				_btnRestart = _display displayCtrl 119;
				_btnRestart ctrlShow true;
				_btnRestart ctrlEnable false;
				_btnRestart ctrlSetScale 0.9;
				_btnRestart ctrlSetText (format['%1',getPlayerUID player]);
				_btnRestart ctrlCommit 0;
				
				_btnRespawn = _display displayCtrl 1010;
				_btnRespawn ctrlShow true;
				_btnRespawn ctrlSetScale 0.9;
				if((canStand player) || (deathHandled))then
				{
					_btnRespawn ctrlEnable false;
					_btnRespawn ctrlSetText 'by infiSTAR.de';
				}
				else
				{
					_waitTime = 180;
					_btnRespawn ctrlEnable false;
					_btnRespawn ctrlSetText format['wait %1s',round((_startTime + _waitTime) - time)];
					if(time > _startTime + _waitTime)then
					{
						_btnRespawn ctrlEnable true;
						_btnRespawn ctrlSetText 'Respawn';
						_startTime = time;
					};
				};
				_btnRespawn buttonSetAction '
					[player,''btnRespawn''] call player_death;
				';
				_btnRespawn ctrlCommit 0;
				
				_btnTitle0 = _display displayCtrl 523;
				_btnTitle0 ctrlSetText _btnTitle0TXT;
				_btnTitle0 ctrlSetTextColor _colorTXT;
				_btnTitle0 ctrlSetScale 0.9;
				_btnTitle0 ctrlCommit 0;
				
				_btnTitle1 = _display displayCtrl 121;
				_btnTitle1 ctrlSetText _btnTitle1TXT;
				_btnTitle1 ctrlSetTextColor _colorTXT;
				_btnTitle1 ctrlSetScale 0.9;
				_btnTitle1 ctrlCommit 0;
				
				_btnTitle2 = _display displayCtrl 120;
				_btnTitle2 ctrlSetText _btnTitle2TXT;
				_btnTitle2 ctrlSetTextColor _colorTXT;
				_btnTitle2 ctrlSetScale 0.9;
				_btnTitle2 ctrlCommit 0;
			};
		};
	};
	"; }; _AHstring = _AHstring + "
	[_name,_puid] spawn {
		_name = _this select 0;
		_puid = _this select 1;

		_timeOut = diag_tickTime + 60;
		waitUntil {!isNil 'local_lockUnlock' || diag_tickTime > _timeOut};
		if(isNil 's_player_deleteBuild')then{s_player_deleteBuild = -1;};

		if(isNil 'local_lockUnlock')then{local_lockUnlock = {};};
		orig_local_lockUnlock = local_lockUnlock;
		_infiSTAR_local_lockUnlock = {
			private ['_vehicle','_status','_lock','_log'];
			_vehicle = _this select 0;
			if(local _vehicle)then {
				_status = _this select 1;
				_lock = if(_status)then{'LOCKED'}else{'UNLOCKED'};
				PVAHR_0_INFI_LOCAL_LOCKUNLOCK = [_vehicle,_lock,player];
				publicVariableServer 'PVAHR_0_INFI_LOCAL_LOCKUNLOCK';
			};
			call orig_local_lockUnlock;
		};
		while{1 == 1}do
		{
			local_lockUnlock = _infiSTAR_local_lockUnlock;
			
			if(s_player_deleteBuild == 1)then
			{
				_obj = cursorTarget;
				if(!isNull _obj)then
				{
					if(typeOf _obj == 'Plastic_Pole_EP1_DZ')then
					{
						if(isNil 'deleteBuildAnnounced')then{deleteBuildAnnounced = [];};
						if !(_obj in deleteBuildAnnounced)then
						{
							deleteBuildAnnounced = deleteBuildAnnounced + [_obj];
							_pos = getPosATL _obj;
							_log = format['Plot Pole removed @%1',mapGridPosition _pos];
							[_name,_puid,'SLOG_PP',toArray (_log)] call "+_randvar37+";
						};
					};
				};
			};
			uiSleep 2;
			if(!isNil 'infiSTAR_UPTIMER')then
			{
				private['_stime','_hours','_minutes','_minutes2','_upTimeLeft'];
				_stime = 0;
				if(serverTime > 36000)then{_stime = time;}else{_stime = serverTime;};
				_upTimeLeft = infiSTAR_UPTIMER - _stime;
				_hours = (_upTimeLeft/60/60);
				_hours = toArray (str _hours);
				_hours resize 1;
				_hours = toString _hours;
				_hours = compile _hours;
				_hours = call  _hours;
				_minutes = floor(_upTimeLeft/60);
				_minutes2 = ((_minutes - (_hours*60)) min 60) max 0;if(_minutes2 < 10)then{_minutes2 = format['0%1',_minutes2];};
				_mytime = format['Restart in: %1h %2min',_hours,_minutes2];
				['<t size=''0.35'' align=''right'' font=''TahomaB''>'+_mytime+'</t>',safezoneX*-1,0.98 * safezoneH + safezoneY,15,0,0,1338] spawn bis_fnc_dynamicText;
			};
			if(!isNil 'infiSTAR_Advert')then
			{
				['<t size=''0.35'' align=''left'' font=''TahomaB''>'+infiSTAR_Advert+'</t>',safezoneX,0.98 * safezoneH + safezoneY,15,0,0,1339] spawn bis_fnc_dynamicText;
			};
		};
		YOLO = true;
	};
	[_puid,_name] spawn {
		_puid = _this select 0;_name = _this select 1;
		_CEA1 = "+str _CEA1+";
		while{1 == 1}do
		{
			_CE1 = (getText(configFile >> 'RscDisplayOptionsVideo' >> 'onLoad'));
			_CE2 = (getText(configFile >> 'RscDisplayOptionsVideo' >> 'onUnload'));
			_CE3 = (getText(configFile >> 'RscDisplayOptionsVideo' >> 'controls' >> 'G_VideoOptionsControls' >> 'controls' >> 'HideAdvanced' >> 'OnButtonClick'));
			_CE4 = (getText(configFile >> 'RscDisplayOptions' >> 'controls' >> 'BCredits' >> 'OnButtonClick'));
			_CE5 = (getText(configFile >> 'RscDisplayOptions' >> 'controls' >> 'BCredits' >> 'action'));
			_CE6 = (getText(configFile >> 'RscDisplayOptions' >> 'controls' >> 'ButtonCancel' >> 'OnButtonClick'));
			_CE7 = (getText(configFile >> 'RscDisplayOptions' >> 'controls' >> 'ButtonCancel' >> 'action'));
			_CEA2 = [_CE1,_CE2,_CE3,_CE4,_CE5,_CE6,_CE7];
			for '_i' from 0 to (count _CEA1)-1 do
			{
				_a = _CEA1 select _i;
				_a = _a - [32];
				_a = _a - [9];
				if(count _a > 120)then{_a resize 120;};
				_b = toArray (_CEA2 select _i);
				_b = _b - [32];
				_b = _b - [9];
				if(count _b > 120)then{_b resize 120;};
				if(str _a != str _b)then
				{
					_log = format['CheatEngine %1: %2 != %3',_i,toString _a,toString _b];
					"; if(_UCC)then{ _AHstring = _AHstring + "
					[] spawn "+_randvar2+";
					[_name,_puid,'HLOG_SKICK',toArray (_log)] call "+_randvar37+";
					"; }; _AHstring = _AHstring + "
				};
			};
			uiSleep 60;
		};
	};
	"; if(_DMS)then{ _AHstring = _AHstring + "
		[] spawn {
			hint 'Loading..';
			uiSleep 4;
			"; if(_DMW)then{ _AHstring = _AHstring + "
				[] spawn {
					while{1 == 1}do
					{
						if(isNil 's_player_debug')then{s_player_debug = -1;};
						if(isNil 'unit_veh')then{unit_veh = vehicle player;};
						if(s_player_debug == -1)then
						{
							s_player_debug = unit_veh addAction [('<t color=''#0066CC''>' + ('Debug') +'</t>'),'ca\modules\MP\data\scriptCommands\moveIn.sqf','Driver ObjNull;([] spawn fnc_debugX0);',5,false,false,'',''];
						};
						if(unit_veh != vehicle player)then
						{
							unit_veh removeAction s_player_debug;
							unit_veh = nil;
							s_player_debug = -1;
						};
						uiSleep 1.5;
					};
				};
			"; }; _AHstring = _AHstring + "
			fnc_debugX0 = {
				"; if(_DMS)then{ _AHstring = _AHstring + "
				if(isNil 'debugMonitorX')then{
					debugMonitorX = true;
					[] spawn fnc_debugX;
				} else {
					debugMonitorX = !debugMonitorX;
					hintSilent '';
					[] spawn fnc_debugX;
				};
				"; }; _AHstring = _AHstring + "
			};	
			fnc_debugX = {
				"; if(!_UIM)then{ _AHstring = _AHstring + "
				admin_debug_run = false;
				_BottomDebug = "+str _BottomDebug+";
				while{debugMonitorX}do
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
					
					_pOn = [];
					{
						if(!isNull _x)then
						{
							if(getPlayerUID _x != '')then
							{
								_y = _x;
								if(isPlayer _y)then
								{
									{
										if(!((getPlayerUID _x) in _pOn) && (isPlayer _x))then
										{
											_pOn = _pOn + [getPlayerUID _x];
										};
									} forEach (crew _y);
								};
							};
						};
					} forEach ([0,0,0] nearEntities ['AllVehicles', 35000]);
					_pOn = count _pOn;
					
					_humanity = player getVariable['humanity',0];
					if(_humanity > 999999)then{_humanity = '> 999999';} else {if(_humanity < -999999)then{_humanity = '< -999999';};};
					
					private['_stime','_hours','_minutes','_minutes2','_upTimeLeft'];
					_timertext = 'UPTIME: ';
					if(!isNil 'infiSTAR_UPTIMER')then
					{
						_timertext = 'Restart in: ';
						_stime = 0;
						if(serverTime > 36000)then{_stime = time;}else{_stime = serverTime;};
						_upTimeLeft = infiSTAR_UPTIMER - _stime;
						if(_upTimeLeft > 0)then
						{
							_hours = (_upTimeLeft/60/60);
							_hours = toArray (str _hours);
							_hours resize 1;
							_hours = toString _hours;
							_hours = compile _hours;
							_hours = call  _hours;
							_minutes = floor(_upTimeLeft/60);
							_minutes2 = ((_minutes - (_hours*60)) min 60) max 0;if(_minutes2 < 10)then{_minutes2 = format['0%1',_minutes2];};
						}
						else
						{
							_hours = '0';
							_minutes2 = '00';
						};
					};
					
					
					hintSilent parseText format[""
					<t size='1' font='Bitstream' align='Center' >[%1]</t><br/>
					<t size='0.8' font='Bitstream' align='Center' >Players Online: %12</t><br/>
					<img size='4.75' image='%4'/><br/>
					<t size='1' font='Bitstream' align='left' color='#CC0000'>Blood: </t><t size='1' font='Bitstream' align='right'>%2</t><br/>
					<t size='1' font='Bitstream' align='left' color='#0066CC'>Humanity: </t><t size='1' font='Bitstream' align='right'>%3</t><br/>
					<br/>
					<t size='1' font='Bitstream' align='left' color='#FFBF00'>Zombie Kills: </t><t size='1' font='Bitstream' align='right'>%9</t><br/>
					<t size='1' font='Bitstream' align='left' color='#FFBF00'>Murders: </t><t size='1' font='Bitstream' align='right'>%10</t><br/>
					<t size='1' font='Bitstream' align='left' color='#FFBF00'>Bandits Killed: </t><t size='1' font='Bitstream' align='right'>%11</t><br/>
					<br/>
					<t size='1' font='Bitstream' align='left' color='#FFBF00'>%13</t><t size='1' font='Bitstream' align='right'>%5h %6min</t><br/>
					<t size='1' font='Bitstream' align='left' color='#FFBF00'>FPS: </t><t size='1' font='Bitstream' align='right'>%8</t><br/>
					<t size='1' font='Bitstream' align='Center' color='#CC0000'>%7</t>
					"",
					_txt,
					(r_player_blood),
					_humanity,
					_pic,
					_hours,
					_minutes2,
					_BottomDebug,
					(round diag_fps),
					(player getVariable['zombieKills', 0]),
					(player getVariable['humanKills', 0]),
					(player getVariable['banditKills', 0]),
					_pOn,
					_timertext
					];
					uiSleep 1;
				};
				"; }; _AHstring = _AHstring + "
			};
			[] spawn fnc_debugX0;
		};
	"; }; _AHstring = _AHstring + "
	[] spawn {
		uiSleep 5;
		["+str _TopOfESC+","+str _LowerTop+","+str _LowerBottom+"] spawn BIS_fnc_infoText;
		"; if(!_UIM)then{ _AHstring = _AHstring + "
		uiSleep 5;
		['AntiHack &','AdminTools by','infiSTAR.de'] spawn BIS_fnc_infoText;
		"; }; _AHstring = _AHstring + "
	};
	"; if(_UIM)then{ _AHstring = _AHstring + "
	diag_log format['Successfully Loaded on Client IDvi1387345919 (%1)',time];
	"; }else{ _AHstring = _AHstring + "
	systemChat '<infiSTAR.de>: Successfully Loaded In.';
	if("+str _DMS+")then{systemChat '<infiSTAR.de>: -END- key toggles the debugmonitor';};
	diag_log format['<infiSTAR.de> 07-10-2024 18-14-07-v1452 - Successfully Loaded on Client IDvi1387345919 (%1)',time];
	"; }; _AHstring = _AHstring + "
	"+_randvar27+" = true;
	diag_log (format['<infiSTAR.de> randvar1 created randvar27 (%1)',time]);
};
publicVariable """+_randvar1+""";


_randvar19Local = {
	diag_log '<infiSTAR.de> waiting for player and functions..';
	waitUntil { getPlayerUID player != '' && !isNil '"+_randvar1+"' && !isNil '"+_randvar2+"' && !isNil '"+_randvar37+"' };
	_randvar1 = "+_randvar1+";
	_randvar2 = "+_randvar2+";
	_randvar37 = "+_randvar37+";
	_name = name player;
	_puid = getPlayerUID player;

	if(38 in (toArray _name))then
	{
		[] spawn _randvar2;
		[_name,_puid,'HLOG_SKICK',toArray ('& in name breaks BattleEye..')] call _randvar37;
	};

	"; if(_UPW)then{ _AHstring = _AHstring + "
	if !(_puid in "+str _WHITELIST+")then
	{
		if(_puid in "+str _allAdmins+")exitWith{};
		if(isNil'NOTWHITELISTED')then{NOTWHITELISTED = 'NOTWHITELISTED';};publicVariableServer'NOTWHITELISTED';
		(findDisplay 46) closeDisplay 0;
	};
	"; }; _AHstring = _AHstring + "

	if(isNil 'PVAH_AHTMPBAN')then{PVAH_AHTMPBAN = [];} else {if(typeName PVAH_AHTMPBAN != 'ARRAY')then{PVAH_AHTMPBAN = [];};};
	_AHBANNED = (("+str _BLOCKED+") + PVAH_AHTMPBAN);
	if(_puid in _AHBANNED)then{[] spawn _randvar2;};


	if((isNil '"+_randvar27+"') || (isNil '"+_randvar25+"'))then{
		[_puid,_name,_randvar37] spawn {
			_puid = _this select 0;_name = _this select 1;
			uiSleep 35;
			if((isNil '"+_randvar27+"') || (isNil '"+_randvar25+"'))then
			{
				[] spawn {sleep 0.5;AntiHack_NotRunningTHREE = 'AntiHack_NotRunningTHREE';publicVariableServer 'AntiHack_NotRunningTHREE';};
				_log = format['RunCheck: _randvar27: %1, _randvar25: %2',(isNil '"+_randvar27+"'),(isNil '"+_randvar25+"')];
				[_name,_puid,'SLOG',toArray (_log)] call (_this select 2);
				(findDisplay 46) closeDisplay 0;
			};
		};
	};

	if(!isNil 'PVCDZ_plr_Login')then
	{
		if(count PVCDZ_plr_Login >= 9)then
		{
			if(PVCDZ_plr_Login select 8)then
			{
				_log = format['New Player: %1',PVCDZ_plr_Login];
				_name = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_name = name player;};
				[_name,getPlayerUID player,'SLOG_NP',toArray (_log)] call _randvar37;
			};
		};
	};
	if(!isNil 'dayzSetOvercast')then{drn_fnc_DynamicWeather_SetWeatherLocal = {};0 setOvercast dayzSetOvercast;0 setfog 0;};
	if(!isNil 'dayzSetViewDistance')then{setViewDistance dayzSetViewDistance;};

	[_puid,_name] spawn _randvar1;

	if(_puid in "+str _allAdmins+")then
	{
		if(isNil 'PV_LowLevel_List')then
		{
			PV_LowLevel_List = "+str _LAdmins+";
			PV_NormalLevel_List = "+str _NAdmins+";
			PV_SuperLevel_List = "+str _SAdmins+";
			PV_DevUlDs = "+str _PV_DevUlDs+";
			admin_d0 = {
				deleteMarker '"+_remark+"';
				(createMarker ['"+_remark+"', [0,0,0]]) setMarkerText (_this select 0);
				PVAH_AdminReq = [69,player];publicVariableServer 'PVAH_AdminReq';
			};
			admin_d0_server = {
				deleteMarker '"+_remark+"';
				(createMarker ['"+_remark+"', [0,0,0]]) setMarkerText (_this select 0);
				PVAH_AdminReq = [69,player,0];publicVariableServer 'PVAH_AdminReq';
			};
		};
		if(isNil 'PV_hackerL0og')then{PV_hackerL0og = [[]];};
		if(isNil 'PV_SurveillanceLog')then{PV_SurveillanceLog = [[]];};
		[_puid] spawn {
			_puid = _this select 0;
			'PV_AdminMainCode' addPublicVariableEventHandler {
				MOD_EPOCH = "+str _MEH+";
				adminKeybinds = {false;};
				[] spawn PV_AdminMainCode;
				'"+_randvar13+"' addPublicVariableEventHandler
				{
					if(admin_announce)then{
						_show = format['%1',(_this select 1)];
						taskHint [_show, [1,0,0.1,1], 'taskNew'];
						hint _show;
						hint _show;
						hint _show;
						_show2 = format['<infiSTAR.de>: %1',(_this select 1)];
						systemChat _show2;
					};
				};
				'"+_randvar13+"NEWPLAYER' addPublicVariableEventHandler
				{
					if(admin_announce)then{systemChat format['<<infiSTAR.de> New Player>: %1',(_this select 1)];};
				};
				[] spawn {
					r_player_timeout = 0;
					player setVariable['medForceUpdate',true,true];
					player setVariable['unconsciousTime', r_player_timeout, true];
					r_player_unconscious = false;
					player setVariable['NORRN_unconscious',false,true];
				};
				admindefaultKeybinds =
				{
					private ['_key','_shift','_ctrl','_alt'];
					_key = _this select 1;
					_shift = _this select 2;
					_ctrl = _this select 3;
					_alt = _this select 4;
					altstate_Admin = false;
					altstate_Admin = _alt;
					if(_key == "+str _ODK+")then{[] spawn fnc_debugX0;};
					if(_key == "+str _OpenMenuKey+")then{call admin_init;};
					if((_key == 0x29) && {_shift})then{if(!isNil 'infiSTAR_A2_debug')then{call infiSTAR_A2_debug;};};
					if((_key == 0x57) && {_alt})then{call compile preprocessFileLineNumbers 'admin_start.sqf';};
				};
				if(isNil 'start_admin_Keybind_loop')then
				{
					start_admin_Keybind_loop = true;
					[] spawn {
						while{1 == 1}do
						{
							if(!isNil 'admindefaultKeybindsVAR')then{(findDisplay 46) displayRemoveEventHandler ['KeyDown',admindefaultKeybindsVAR];admindefaultKeybindsVAR = nil;};
							admindefaultKeybindsVAR = (findDisplay 46) displayAddEventHandler ['KeyDown', '_this call admindefaultKeybinds;false;'];
							if(!isNil 'adminKeybindsVAR')then{(findDisplay 46) displayRemoveEventHandler ['KeyDown',adminKeybindsVAR];adminKeybindsVAR = nil;};
							adminKeybindsVAR = (findDisplay 46) displayAddEventHandler ['KeyDown', '_this call adminKeybinds;false'];
							uiSleep 0.05;
						};
					};
				};
			};
			PVAH_AdminReq = [1234,player,_puid];
			publicVariableServer 'PVAH_AdminReq';
		};
	}
	else
	{
		_randvar2 spawn {uiSleep 15;if(isNil '"+_randvar4+"')then{[] spawn _this;};};
	};
	if(isNil 'ADMINCHECK')then{ADMINCHECK = toString [32,32,32,65,110,116,105,72,97,99,107,32,98,121,32,105,110,102,105,83,84,65,82,46,100,101];};
	player createDiarySubject [ADMINCHECK,ADMINCHECK];
	'dayzSetViewDistance' addPublicVariableEventHandler {setViewDistance dayzSetViewDistance;};
	'dayzSetOvercast' addPublicVariableEventHandler {drn_fnc_DynamicWeather_SetWeatherLocal = {};3 setOvercast dayzSetOvercast;0 setfog 0;};
	if(!isNil 'fnc_infiSTAR_DeathMSG')then{[] spawn fnc_infiSTAR_DeathMSG;};
	if(!isNil 'fnc_infiSTAR_Publish')then{[] spawn fnc_infiSTAR_Publish;};
	if(!isNil 'fnc_infiSTAR_custom')then{[] spawn fnc_infiSTAR_custom;};
	if(!isNil 'fnc_infiSTAR_SafeZone')then{[] spawn fnc_infiSTAR_SafeZone;};
	'"+_randvar31+"' addPublicVariableEventHandler
	{
		_cdate = date;
		_cH = _cdate select 3;
		_cMin = _cdate select 4;
		
		_sdate = (_this select 1);
		_sH = _sdate select 3;
		_sMin = _sdate select 4;
		if(((abs(_cH - _sH)) > 1) || ((abs(_cMin - _sMin)) >= 3))then
		{
			setDate _sdate;
			[_sdate] spawn {
				_sdate = _this select 0;
				_sH = _sdate select 3;
				_sMin = _sdate select 4;
				uiSleep 3;
				_cdate = date;
				_cH = _cdate select 3;
				_cMin = _cdate select 4;
				if(((abs(_cH - _sH)) > 1) || (((abs(_cMin - _sMin)) >= 15) && ((abs(_cMin - _sMin)) < 60)))then
				{
					_log = format['ClientTime %1   is not equal to   ServerTime %2',_cdate,_sdate];
					_name = 'DEAD';if((alive player)&&(getPlayerUID player != ''))then{_name = name player;};
					_log = [_name,getPlayerUID player,'SLOG',toArray (_log)];
					['SERVER',_log] call "+_fnc_handlerandvar10+";
				};
			};
		};
	};
	'fnc_show_colorAdminMsg' addPublicVariableEventHandler
	{
		_array = _this select 1;
		_msg = _array select 0;
		_clr = _array select 1;
		['<t size=''0.55'' font=''Zeppelin32'' color='+(str _clr)+'>'+(_msg)+'</t>',
		safeZoneXAbs/safeZoneWAbs/4,SafeZoneY+0.02,10,0,0,3079] spawn bis_fnc_dynamicText;
	};
	[] spawn {
		waitUntil {uiSleep 1;!isNull player};
		waitUntil {uiSleep 1;str (player getVariable['"+_randvar3+"','']) != str (getPlayerUID player)};
		player setVariable['"+_randvar3+"', getPlayerUID player, true];
	};
};
"+_randvar19+" = _randvar19Local;
publicVariable """+_randvar19+""";


fnc_VoteTimeServer =
{
	_array = _this;
	
	_playerObj = _array select 0;
	if(_playerObj in [''])exitWith {};
	if(typeName _playerObj != 'OBJECT')exitWith {};
	if(isNull _playerObj)exitWith {};
	
	_clientUID = getPlayerUID _playerObj;
	_vote = _array select 1;
	
	if(isNil 'TimeVoteCooldown')then{TimeVoteCooldown = 300;};
	if(isNil 'LastVoteGoneThrough')then{LastVoteGoneThrough = 600;};
	if((LastVoteGoneThrough == 0) || ((TimeVoteCooldown + LastVoteGoneThrough) < time))then
	{
		if(isNil 'VoteArray')then{VoteArray = [];};
		if !(_clientUID in VoteArray)then
		{
			VoteArray = VoteArray + [_clientUID,_vote];
			_cntAll = count playableUnits;
			_cntVoted = {getPlayerUID _x in VoteArray} count playableUnits;
			if((_cntAll > 0) && (_cntVoted > 0))then
			{
				_cntday = 0;
				_cntnight = 0;
				if((_cntVoted / _cntAll) > 0.7)then
				{
					_oUIDs = [];
					{
						_xUID = getPlayerUID _x;
						if(_xUID != '')then
						{
							_oUIDs = _oUIDs + [_xUID];
						};
					} forEach playableUnits;
					for '_i' from 0 to (count VoteArray)-1 step 2 do
					{
						_cUID = VoteArray select _i;
						_cVOTE = VoteArray select (_i+1);
						if(_cUID in _oUIDs)then
						{
							if(_cVOTE == 'DAY')then{_cntday = _cntday + 1;};
							if(_cVOTE == 'NIGHT')then{_cntnight = _cntnight + 1;};
						};
					};
					
					_txt = format['%1 of %2 Players voted. %3 for Day and %4 for Night.',_cntVoted,_cntAll,_cntday,_cntnight];
					fnc_show_colorAdminMsg = [_txt,'#0B6121'];
					publicVariable 'fnc_show_colorAdminMsg';
					
					_date = date;
					_date set [3,11];
					if(_cntnight > _cntday)then
					{
						_date set [3,23];
					};
					if(!isNil 'dayzSetDate')then{
						dayzSetDate = _date;
						publicVariable 'dayzSetDate';
					};
					setDate _date;
					server_timeSync = {};
					VoteArray = [];
					LastVoteGoneThrough = time;
				}
				else
				{
					_txt = format['%1 of %2 Players voted (/vote day or /vote night).',_cntVoted,_cntAll];
					fnc_show_colorAdminMsg = [_txt,'#0B6121'];
					publicVariable 'fnc_show_colorAdminMsg';
				};
			};
		};
	}
	else
	{
		_txt = format['Wait %1s more until next daytime vote can be done!',round((TimeVoteCooldown + LastVoteGoneThrough) - time)];
		fnc_show_colorAdminMsg = [_txt,'#0B6121'];
		publicVariable 'fnc_show_colorAdminMsg';
	};
};
"+_fnc_handlerandvar10+" =
{
	_array = _this select 1;
	_cnt = count _array;
	if(_cnt == 2)exitWith
	{
		_playerObj = _array select 0;
		_what = _array select 1;
		if(_playerObj in [''])exitWith {};
		if(typeName _playerObj != 'OBJECT')exitWith {};
		if(isNull _playerObj)exitWith {};
		if(_what in ['DAY','NIGHT'])exitWith
		{
			_array call fnc_VoteTimeServer;
		};
	};
	if(_cnt == 4)exitWith
	{
		_name = _array select 0;
		_puid = _array select 1;
		if(_puid == '')exitWith {};
		_what = _array select 2;
		_work = _array select 3;
		if(typeName _work == 'ARRAY')then{_work = toString _work;};
		if((count PV_hackerL0og) > 100)then
		{
			for '_i' from 0 to 49 do
			{
				PV_hackerL0og = PV_hackerL0og - [PV_hackerL0og select 0];
			};
		};
		if((count PV_SurveillanceLog) > 100)then
		{
			for '_i' from 0 to 49 do
			{
				PV_SurveillanceLog = PV_SurveillanceLog - [PV_SurveillanceLog select 0];
			};
		};
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
		_log = format['%1 (%2) | %3',_name,_puid,_work];
		[_what,_log] call fn_remote_log;
		if(_what == 'TPCHECK')exitWith
		{
			private ['_sentKey'];
			_varName = format['AHpos%1',_puid];
			_tpKey = missionNameSpace getVariable [_varName,''];
			
			if(count _array >= 4)then{_sentKey = if(isNil{_array select 3})then{''}else{_array select 3};};
			if(isNil'_sentKey')then{_sentKey = '';};
			if(typeName _sentKey != 'STRING')then{_sentKey = '';};
			if(typeName _tpKey != 'STRING')then{_tpKey = '';};
			
			if(_sentKey != _tpKey || _sentKey == '' || _tpKey == '')then
			{
				_uidFromKey = missionNameSpace getVariable [format['AHposUID%1',_sentKey],''];
				if(_uidFromKey != '')then
				{
					_log = format['%1(%2) | Bad TP Key: %3 != %4',_name,_puid,_sentKey,_tpKey];
					[_what,_log] call fn_remote_log;
					
					_log2 = format['%3h %4min | %1 (%2) | Bad TP Key: %5 != %6',_name,_puid,_hours,_minutes2,_sentKey,_tpKey];
					PV_hackerL0og = PV_hackerL0og + [[_log2,'','0','1','0','0',[]]];
					publicVariable 'PV_hackerL0og';
					
					"+_randvar13+" = _log2;
					publicVariable '"+_randvar13+"';
				};
			};
		};
		if(_what in ['BAN','HLOG','HLOG_SKICK'])exitWith
		{
			[_what,_log] call fn_remote_log;
			
			_log2 = format['%3h %4min | %1 (%2) | %5',_name,_puid,_hours,_minutes2,_work];
			PV_hackerL0og = PV_hackerL0og + [[_log2,'','0','1','0','0',[]]];
			publicVariable 'PV_hackerL0og';
			
			"+_randvar13+" = _log2;
			publicVariable '"+_randvar13+"';
			
			if(_what in ['BAN','HLOG_SKICK'])exitWith
			{
				[_name,_puid,objNull,_log] call fnc_infiSTAR_ServerkickNew;
				if(_what=='BAN')exitWith
				{
					missionNameSpace setVariable [format['ban_status_%1',_puid],1];
					if(isNil 'PVAH_AHTMPBAN')then{PVAH_AHTMPBAN = [];} else {if(typeName PVAH_AHTMPBAN != 'ARRAY')then{PVAH_AHTMPBAN = [];};};
					if!(_puid in PVAH_AHTMPBAN)then{PVAH_AHTMPBAN = PVAH_AHTMPBAN + [_puid];publicVariable 'PVAH_AHTMPBAN';};
					
					_return = 'armalog' callExtension ('xban|'+ _puid);
					['BAN_DLL_RESPONSE',_return] call fn_custom_log;
				};
			};
		};
		if(_what in ['SLOG','SLOG_SKICK','SLOG_NP','SLOG_BK','SLOG_EC','SLOG_PP'])exitWith
		{
			[_what,_log] call fn_remote_log;
			
			if(_what == 'SLOG_NP')exitWith
			{
				"+_randvar13+"NEWPLAYER = format['%1 (%2)   Time: %3h %4min',_name,_puid,_hours,_minutes2];
				publicVariable '"+_randvar13+"NEWPLAYER';
			};
			
			_log2 = format['%3h %4min | %1 (%2) | %5',_name,_puid,_hours,_minutes2,_work];
			PV_SurveillanceLog = PV_SurveillanceLog + [[[_name,_puid,_log2],'','0','1','0','0',[]]];
			publicVariable 'PV_SurveillanceLog';
			
			if(_what == 'SLOG_SKICK')then{
				[_name,_puid,objNull,_log] call fnc_infiSTAR_ServerkickNew;
			};
		};
	};
};
'"+_randvar10+"' addPublicVariableEventHandler
{
	_this call "+_fnc_handlerandvar10+";
	['ANTIHACK_SERVER_HANDLE',_this] call fn_custom_log;
};


"; if(_MEH)then{ _AHstring = _AHstring + "
if(isNil 'AllowedVehiclesList')exitWith {diag_log 'infiSTAR.de: AllowedVehiclesList not defined..';};
if(isNil 'infiAllowedVehiclesList')then
{
	if(str AllowedVehiclesList != '[]')then
	{
		infiAllowedVehiclesList = [];
		{
			if(typeName _x == 'ARRAY')then
			{
				if(count _x == 2)then
				{
					_k = _x select 0;
					if !(_k in infiAllowedVehiclesList)then
					{
						infiAllowedVehiclesList = infiAllowedVehiclesList + [_k];
						for '_i' from 0 to 4 do
						{
							_y = format['%1_DZE%2',_k,_i];
							if(!(_y in infiAllowedVehiclesList) && (_y isKindOf 'AllVehicles'))then
							{
								infiAllowedVehiclesList = infiAllowedVehiclesList + [_y];
							};
						};
					};
				};
			};
		} forEach AllowedVehiclesList;
		publicVariable 'infiAllowedVehiclesList';
	};
};
"; }; _AHstring = _AHstring + "


";
['DEBUG','compiling _AHstring'] call fn_custom_log;
_AHstring = compile _AHstring;
['DEBUG','_AHstring compiled'] call fn_custom_log;
call _AHstring;
['DEBUG','_AHstring loaded.'] call fn_custom_log;






fnc_AdminReqProceed = {
	diag_log format['infiSTAR.de fnc_AdminReqProceed: %1',_array];
	if(_option == 0)then
	{
		private ['_sl','_type','_pos','_player','_dirPlr','_object','_key'];
		_sl = format['%1 (%2) spawned %3 @%4',_clientName,_clientUID,(_array select 2), mapGridPosition _playerObj];
		PVAH_WriteLogReq = [_playerObj,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
		
		[(_array select 2),(_array select 3),_playerObj] spawn
		{
			_type = _this select 0;
			_pos = _this select 1;
			_player = _this select 2;
			_dirPlr = getDir _player;
			_object = _type createVehicle _pos;
			_key = '';
			{
				_x = _x * 10;
				if( _x < 0 )then{ _x = _x * -10 };
				_key = _key + str(round(_x));
			} count _pos;
			_key = _key + str(round(_dirPlr));
			_object setVariable['ObjectID', '0', true];
			_object setVariable['ObjectUID', _key, true];
			_object setvelocity [0,0,1];
			clearWeaponCargoGlobal _object;
			clearMagazineCargoGlobal _object;
			_object setDir _dirPlr;
			dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_object];
		};
	};
	if(_option == -3)then
	{
		private ['_class','_worldspace','_keySelected','_location','_object','_characterID','_uid','_key','_sl'];
		_class = (_array select 2);
		_worldspace = (_array select 3);
		_keySelected = (_array select 4);
		
		_location = _worldspace select 1;
		_object = _class createVehicle _location;
		_object setDir (_worldspace select 0);
		
		_characterID = str(getNumber(configFile >> 'CfgWeapons' >> _keySelected >> 'keyid'));
		_uid = _worldspace call dayz_objectUID2;
		
		_key = format['CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:',dayZ_instance, _class, 0 , _characterID, _worldspace, [], [], 1,_uid];
		_key call server_hiveWrite;
		
		[_object,_uid,_characterID,_class] spawn {
			private ['_class','_worldspace','_keySelected','_location','_object','_characterID','_uid','_key','_done','_retry','_result','_outcome','_oid'];
			_object = _this select 0;
			_uid = _this select 1;
			_characterID = _this select 2;
			_class = _this select 3;
			
			_done = false;
			_retry = 0;
			while{_retry < 10}do
			{
				uiSleep 0.3;
				_key = format['CHILD:388:%1:',_uid];
				_result = _key call server_hiveReadWrite;
				_outcome = _result select 0;
				if(_outcome == 'PASS')then
				{
					_oid = _result select 1;
					_object setVariable['ObjectID', _oid, true];
					_done = true;
					_retry = 100;
				}
				else
				{
					_done = false;
					_retry = _retry + 1;
				};
			};
			
			_object setvelocity [0,0,1];
			_object setVehicleLock 'LOCKED';
			if(_object isKindOf 'Bicycle')then
			{
				_object setVehicleLock 'UNLOCKED';
			};
			clearWeaponCargoGlobal _object;
			clearMagazineCargoGlobal _object;
			_object allowDamage false;
			_object setVariable['lastUpdate',time];
			if(!isNil '_characterID')then{_object setVariable['CharacterID', _characterID, true];};
			dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_object];
			uiSleep 1;
			_object call fnc_veh_ResetEH;
			PVDZE_veh_Init = _object;publicVariable 'PVDZE_veh_Init';
			[_object,'all'] spawn server_updateObject;
			_object allowDamage true;
		};
		_sl = format['%1 (%2) hivespawned %3 @%4',_clientName,_clientUID,_class,_worldspace];
		PVAH_WriteLogReq = [_playerObj,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	if(_option == -2)then
	{
		private ['_deletethis','_sl','_objectID','_objectUID'];
		_deletethis = _array select 2;
		_sl = '';
		if(typeName _deletethis == 'ARRAY')then
		{
			{
				if(!isNull _x)then
				{
					_objectID 	= _x getVariable['ObjectID','0'];
					_objectUID	= _x getVariable['ObjectUID','0'];
					deleteVehicle _x;
					[_objectID,_objectUID] call server_deleteObjDirect;
				};
				true
			} count _deletethis;
			_sl = format['%1 (%2) deleted %3 objects @%4 - characterID %5 - objectID: %6 - objectUID: %7',_clientName,_clientUID,count _deletethis,mapGridPosition _playerObj];
		}
		else
		{
			if(!isNull _deletethis)then
			{
				_pos = getPos _deletethis;
				_type = typeOf _deletethis;
				
				_objectID 	= _deletethis getVariable['ObjectID','0'];
				_objectUID	= _deletethis getVariable['ObjectUID','0'];
				deleteVehicle _deletethis;
				[_objectID,_objectUID] call server_deleteObjDirect;
				
				_sl = format['%1 (%2) deleted %3 @%4 - characterID %5 - objectID: %6 - objectUID: %7',_clientName,_clientUID,_type,mapGridPosition _pos,_characterID,_objectID,_objectUID];
			};
		};
		PVAH_WriteLogReq = [_playerObj,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	if(_option == -1)then
	{
		private['_type','_pos','_player','_dirPlr','_object','_key','_typeObj','_posObj','_dirObj','_data','_result','_status','_temp'];
		_sl = format['%1 (%2) hivespawned %3 @%4',_clientName,_clientUID,(_array select 2), mapGridPosition _playerObj];
		PVAH_WriteLogReq = [_playerObj,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
		
		[(_array select 2),(_array select 3),_playerObj] spawn
		{
			_type = _this select 0;
			_pos = _this select 1;
			_player = _this select 2;
			_dirPlr = getDir _player;
			_object = _type createVehicle _pos;
			clearWeaponCargoGlobal _object;
			clearMagazineCargoGlobal _object;
			_object addMPEventHandler ['MPKilled',{_this call vehicle_handleServerKilled;}];
			_key = '';
			{
				_x = _x * 10;
				if( _x < 0 )then{ _x = _x * -10 };
				_key = _key + str(round(_x));
			} count _pos;
			_key = _key + str(round(_dirPlr));
			_object setVariable['ObjectID', '0', true];
			_object setVariable['ObjectUID', _key, true];
			_object setVariable['lastUpdate',time,true];
			_object setDir _dirPlr;
			dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_object];
			waitUntil {(!isNull _object)};
			uiSleep 3;
			_typeObj = typeOf _object;
			_posObj = getPos _object;
			_dirObj = getDir _object;
			_key = format['CHILD:999:select `id` from `vehicle` where `class_name` = ''?'' LIMIT 1:[''%1'']:',_typeObj];
			_data = 'HiveEXT' callExtension _key;             
			_result = call compile format['%1', _data];
			_status = _result select 0;
			if(_status == 'CustomStreamStart')then 
			{
				'HiveEXT' callExtension _key;
				_temp = _result select 1;
				if(_temp == 0)then
				{
					_data = 'HiveEXT' callExtension format['CHILD:999:Insert into vehicle 
					(class_name,damage_min, damage_max, fuel_min, fuel_max, limit_min, limit_max, parts, inventory)
					values
					(''?'',0,0,1.0,1.0,0,99,'''',''''):[''%1'']:', _typeObj];
				};	
			};
			_data = 'HiveEXT' callExtension format['CHILD:999:Insert into world_vehicle
			(vehicle_id, world_id, worldspace, chance)
			values
			((SELECT `id` FROM `vehicle` where `class_name` = ''?'' LIMIT 1), 1, ''%3'',1):[''%1'', ''%2'']:', _typeObj, worldName, [_dirObj, _posObj]];
			_data = 'HiveEXT' callExtension format['CHILD:999:Insert into instance_vehicle
			(world_vehicle_id, instance_id, worldspace, inventory, parts, fuel, damage)
			values
			((SELECT `id` FROM `world_vehicle` where `vehicle_id` = (SELECT `id` FROM `vehicle` where `class_name` = ''%1'' LIMIT 1) LIMIT 1), %3, ''%2'',''[[[],[]],[[],[]],[[],[]]]'',''[]'',1,0):[]:', _typeObj, [_dirObj, _posObj], dayZ_instance];
			_key = format['CHILD:999:SELECT `id` FROM `instance_vehicle` ORDER BY `id` DESC LIMIT 1:[]:'];
			_data = 'HiveEXT' callExtension _key;
			_result = call compile format['%1', _data];
			_status = _result select 0;
			if(_status == 'CustomStreamStart')then 
			{
				_temp = _result select 1;
				if(_temp == 1)then
				{
					_data = 'HiveEXT' callExtension _key;
					_result = call compile format['%1', _data];
					_status = _result select 0;
				};	
			};
			_object setVariable['lastUpdate',time];
			_object setVariable['ObjectID', str(_status), true];
			_object setVariable['CharacterID', '1337', true];
			[_object,'all'] spawn server_updateObject;
		};
	};
	if(_option == 2)then
	{
		private '_do';
		_do = format['if(getPlayerUID player == ''%1'')then
		{
			_unit = player;
			_selection = ''legs'';
			_damage = 1;
			_unit setHit[_selection,_damage];
		};', getPlayerUID (_array select 2)];
		_do call fn_executeGlobal;
	};
	if(_option == 3)then
	{
		if(_array select 2)then
		{
			_playerObj setVehicleInit 'this hideObject true;';
		}
		else
		{
			_playerObj setVehicleInit 'this hideObject false;';
		};
		processInitCommands;
	};
	if(_option == 4)then
	{
		(_array select 2) setDamage 1;
	};
	if(_option == 5)then
	{
		private ['_unit'];
		_unit = _array select 2;
		_do = format['if(getPlayerUID player == ''%1'')then
		{
			disableSerialization;
			r_player_blood = r_player_bloodTotal;
			r_player_unconscious = false;
			r_player_injured = false;
			r_player_Sepsis = [false, 0];
			r_player_lowblood = false;
			r_player_inpain = false;
			r_player_handler = false;
			r_player_cardiac = false;
			r_player_infected = false;
			r_player_dead = false;
			r_player_loaded = false;
			r_player_timeout = 0;
			r_player_Nutrition = 0;
			r_fracture_legs = false;
			r_fracture_arms = false;
			r_handlercount = 0;
			dayz_sourceBleeding = objNull;
			call fnc_usec_resetWoundPoints;
			player setVariable [''unconsciousTime'',0,true];
			player setVariable [''sepsisStarted'', nil];
			player setVariable [''USEC_Sepsis'', false, true];
			player setVariable [''USEC_isCardiac'',false, false];
			player setVariable[''USEC_infected'',false,true];
			player setVariable [''USEC_BloodQty'',r_player_bloodTotal,true];
			player setVariable [''USEC_lowBlood'',false,true];
			player setVariable [''USEC_isCardiac'',false,true];
			player setVariable[''USEC_injured'',false,true];
			player setVariable[''USEC_inPain'',false,true];
			player setVariable [''NORRN_unconscious'', false, false];
			player setVariable[''hit_legs'',0,true];
			player setVariable[''hit_hands'',0,true];
			player setHit[''legs'',0];
			player setHit[''hands'',0];
			player setdamage 0;
			_display = uiNamespace getVariable ''DAYZ_GUI_display'';
			(_display displayCtrl 1303) ctrlShow false;
			(_display displayCtrl 1203) ctrlShow false;
			dayz_temperatur = 37;
			dayz_nutrition = 0;
			dayz_hunger = 0;
			dayz_thirst = 0;
			dayz_lastMeal =	time;
			dayz_lastDrink = time;
			player setVariable[''medForceUpdate'',true,true];
		};', getPlayerUID (_array select 2)];
		_do call fn_executeGlobal;
	};
	if(_option == 51)then
	{
		private ['_plr','_vehicle','_type','_hitpoints','_selection','_strH','_sl'];
		_plr = _playerObj;
		_vehicle = _array select 2;
		_type = typeOf _vehicle;
		_vehicle setDamage 0;
		_vehicle setVehicleInit 'this setFuel 1';
		
		_hitpoints = _vehicle call vehicle_getHitpoints;
		{
			_hitpoint = _x;
			_selection = getText(configFile >> 'cfgVehicles' >> _type >> 'HitPoints' >> _hitpoint >> 'name');
			_vehicle setHit[_selection,0];
			_strH = ('hit_' + (_selection));
			_vehicle setVariable[_strH,0,true];
		} forEach _hitpoints;
		if(!isNil 'server_updateObject')then
		{
			[_vehicle,'repair'] call server_updateObject;
		};
		_sl = format['%1 AdminRepair %2',_clientName,_type];
		PVAH_WriteLogReq = [_playerObj,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	if(_option == 52)then
	{
		private['_pos','_vehicles','_sl'];
		_pos = _array select 2;
		_vehicles = _pos nearEntities [['LandVehicle','Air','Ship'],15];
		
		{
			if(!isNull _x)then
			{
				clearVehicleInit _x;
				_x setVehicleInit 'this setVectorUp [0,0,1];';
			};
		} forEach _vehicles;
		
		_sl = format['%1 Flipped vehicles @%2',_clientName,_pos];
		PVAH_WriteLogReq = [_playerObj,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	if(_option == 8)then
	{
		private '_do';
		_do = format['if(getPlayerUID player == ''%1'')then
		{
			{player removeMagazine _x;} forEach (magazines player);
			removeAllWeapons player;
			removebackpack player;
		};', getPlayerUID (_array select 2)];
		_do call fn_executeGlobal;
	};
	if(_option == 91)then
	{
		private['_msg','_clr'];
		_msg = _array select 2;
		_clr = _array select 3;
		if(typeName _msg == 'ARRAY')then{_msg = toString _msg;};
		fnc_show_colorAdminMsg = [_msg,_clr];
		publicVariable 'fnc_show_colorAdminMsg';
	};
	if(_option == 10)then
	{
		private '_do';
		_do = format['if(getPlayerUID player == ''%1'')then{ (findDisplay 46) closeDisplay 0; };', getPlayerUID (_array select 2)];
		_do call fn_executeGlobal;
	};
	if(_option == 111)then
	{
		private '_do';
		_do = format['if(hasInterface)then
		{
			{
				if(name _x == ''%1'')then
				{
					_i = [_x,4,time,false,false] spawn BIS_Effects_Burn;
				};
			} forEach ([0,0,0] nearEntities [''AllVehicles'', 10000000]);
			if(name player == ''%1'')then
			{
				[] spawn {
					_addup = 0;
					while{alive player}do
					{
						_xxx = (round(random 250));
						_yyy = (round(random 250));
						_equals = _xxx + _yyy;
						if(_equals < 300)then{_equals = 333;};
						r_player_blood = r_player_blood - _equals;
						_addup = _addup + _equals;
						if(_addup >= 12000)exitWith {(findDisplay 46) closeDisplay 0;};
						uiSleep 0.5;
					};
				};
			};
		};', name (_array select 2)];
		_do call fn_executeGlobal;
	};
	if(_option == 110)then
	{
		private '_do';
		_do = format['if(hasInterface)then
		{
			if(getPlayerUID player == ''%1'')then
			{
				_vehicle = vehicle player;
				_hitpoint = ''%2'';
				_type = typeOf _vehicle;
				_selection = getText(configFile >> ''cfgVehicles'' >> _type >> ''HitPoints'' >> _hitpoint >> ''name'');
				_vehicle setHit[_selection,%3];
				_strH = (''hit_'' + (_selection));
				_vehicle setVariable[_strH,%3,true];
			};
		};', getPlayerUID (_array select 2),_array select 3,_array select 4];
		_do call fn_executeGlobal;
	};
	if(_option == 112)then
	{
		private '_do';
		_do = format['if(hasInterface)then{if(getPlayerUID player == ''%1'')then{disableUserInput true;};};', getPlayerUID (_array select 2)];
		_do call fn_executeGlobal;
	};
	if(_option == 113)then
	{
		private '_do';
		_do = format['if(hasInterface)then{if(getPlayerUID player == ''%1'')then{disableUserInput false;};};', getPlayerUID (_array select 2)];
		_do call fn_executeGlobal;
	};
	if(_option == 11)then
	{
		private '_do';
		_do = format['if(getPlayerUID player == ''%1'')then
		{
			r_player_timeout = 30;
			r_player_unconscious = true;
			player setVariable[''medForceUpdate'',true];
			player setVariable [''unconsciousTime'', r_player_timeout, true];
			if (vehicle _unit != _unit) then
			{
				_unit spawn {
					_veh = vehicle player;
					waitUntil{(((getPosATL _veh select 2 < 1) and (speed _veh < 1)) or (!r_player_unconscious))};
					if (r_player_unconscious) then {
						player action [''eject'', _veh];
						waitUntil{((vehicle _this) != _this)};
						uiSleep 1;
						player setVariable[''NORRN_unconscious'', true, true];
						player playActionNow ''Die'';
					};
				};
			} else {
				player setVariable[''NORRN_unconscious'', true, true];
				player playActionNow ''Die'';
			};
		};', getPlayerUID (_array select 2)];
		_do call fn_executeGlobal;
	};
	if(_option == 14)then 
	{
		{deleteVehicle _x;} forEach allMissionObjects 'USOrdnanceBox';
		{deleteVehicle _x;} forEach allMissionObjects 'Foodbox0';
		{
			if((((count ((getWeaponCargo _x) select 1))+(count ((getMagazineCargo _x) select 1))) > 200) || (count ([currentWeapon _x] + (weapons _x) + (magazines _x)) > 40))then 
			{
				deleteVehicle _x;
			};
		} forEach allMissionObjects 'ALL';
	};
	if(_option == 15)then
	{
		private '_do';
		_do = format['if(getPlayerUID player == ''%1'')then
		{
			[] spawn {
				if(isNil ''druggedbiatch'')then
				{
					druggedbiatch = true;
					hint ''You took drugs YOLOLOLO'';
					_mytime = time;
					while{druggedbiatch}do
					{
						nonapsi_ef = ppEffectCreate [''colorCorrections'', 1555]; 
						nonapsi_ef ppEffectEnable true;
						nonapsi_ef ppEffectAdjust [1.0, 1.0, -0.03, [0.0, 0.0, 0.0, 0.0], [3.0, 5.0, 9.0, 5.0],[0.4,0.0,0.0, 0.7]];
						nonapsi_ef ppEffectCommit 1;
						uiSleep random(1);
						wetdist1 = ppEffectCreate [''wetDistortion'', 2006];
						wetdist1 ppEffectAdjust [0, 8, 0.8,8,8, 0.2, 1, 0, 0, 0.08, 0.08, 0, 0, 0, 0.77];
						wetdist1 ppEffectEnable true;
						wetdist1 ppEffectCommit 0;
						ppe = ppEffectCreate [''colorCorrections'', 1555]; 
						ppe ppEffectAdjust [1, 1, 0, [1.5,6,2.5,0.5], [5,3.5,5,-0.5], [-3,5,-5,-0.5]]; 
						ppe ppEffectCommit 1;
						ppe ppEffectEnable true; 
						ppe2 = ppEffectCreate [''chromAberration'', 1555]; 
						ppe2 ppEffectAdjust [0.01,0.01,true];
						ppe2 ppEffectCommit 1;
						ppe2 ppEffectEnable true;
						ppe3 = ppEffectCreate [''radialBlur'', 1555]; 
						ppe3 ppEffectEnable true;
						ppe3 ppEffectAdjust [0.02,0.02,0.15,0.15];
						ppe3 ppEffectCommit 1;
						uiSleep random(1);
						wetdist1 = ppEffectCreate [''wetDistortion'', 2006];
						wetdist1 ppEffectAdjust [1, 1.16, 0.32, 2.56, 0.8, 0.64, 2.64, 0, 0, 1.08, 0.08, 0, 0, 0, 1.77];
						wetdist1 ppEffectEnable true;
						wetdist1 ppEffectCommit 0;
						uiSleep random(1);
						nonapsi_ef = ppEffectCreate [''colorCorrections'', 1555]; 
						nonapsi_ef ppEffectEnable true;
						nonapsi_ef ppEffectAdjust [1.0, 1.0, -0.02, [9.5, 1.5, 2.5, 0.2], [2.0, 7.0, 6.0, 2.0],[0.4,0.0,0.0, 0.7]];
						nonapsi_ef ppEffectCommit 1;
						uiSleep random(1);
						if(_mytime + 30 < time)exitWith {};
					};
					ppEffectDestroy nonapsi_ef;
					ppEffectDestroy ppe;
					ppEffectDestroy ppe2;
					ppEffectDestroy ppe3;
					ppEffectDestroy wetdist1;
					setaperture 0;
					''dynamicBlur'' ppEffectAdjust [0];
					''dynamicBlur'' ppEffectCommit 16;
					''colorCorrections'' ppEffectAdjust [1, 1, 0, [1, 1, 1, 0.0], [1, 1, 1, 1],  [1, 1, 1, 0.0]];
					''colorCorrections'' ppEffectCommit 0;
				};
			};
		};', getPlayerUID (_array select 2)];
		_do call fn_executeGlobal;
	};
	if(_option == 16)then
	{
		{ missionNameSpace setVariable [format['ban_status_%1',_x],-1]; }forEach PVAH_AHTMPBAN;
		PVAH_AHTMPBAN = [];
		publicVariable 'PVAH_AHTMPBAN';
	};
	if(_option == 17)then
	{
		private ['_playerObj','_clientUID','_clientName'];
		_playerObj = _array select 2;
		_clientUID = (getPlayerUID _playerObj);
		_clientName = 'DEAD';if((alive _playerObj)&&(getPlayerUID _playerObj != ''))then{_clientName = name _playerObj;};
		[_clientName,_clientUID,_playerObj,'Kicked by Admin'] call fnc_infiSTAR_ServerkickNew;
	};
	if(_option == 18)then
	{
		private ['_playerObj','_clientUID','_clientName'];
		_playerObj = _array select 2;
		_clientUID = (getPlayerUID _playerObj);
		_clientName = 'DEAD';if((alive _playerObj)&&(getPlayerUID _playerObj != ''))then{_clientName = name _playerObj;};
		[_clientUID,_clientName,_playerObj,'Banned by Admin'] call fnc_infiSTAR_ServerkickNew;
		
		missionNameSpace setVariable [format['ban_status_%1',_clientUID],1];
		if(isNil 'PVAH_AHTMPBAN')then{PVAH_AHTMPBAN = [];} else {if(typeName PVAH_AHTMPBAN != 'ARRAY')then{PVAH_AHTMPBAN = [];};};
		if!(_clientUID in PVAH_AHTMPBAN)then{PVAH_AHTMPBAN = PVAH_AHTMPBAN + [_clientUID];publicVariable 'PVAH_AHTMPBAN';};
	};
	if(_option == 182)then
	{
		private ['_uid'];
		_uid = _array select 2;
		
		missionNameSpace setVariable [format['ban_status_%1',_uid],-1];
		if(isNil 'PVAH_AHTMPBAN')then{PVAH_AHTMPBAN = [];} else {if(typeName PVAH_AHTMPBAN != 'ARRAY')then{PVAH_AHTMPBAN = [];};};
		if!(_uid in PVAH_AHTMPBAN)then{PVAH_AHTMPBAN = PVAH_AHTMPBAN - [_uid];publicVariable 'PVAH_AHTMPBAN';};
	};
	if(_option == 19)then
	{
		private ['_selection','_intensity','_sl'];
		_selection = _array select 2;
		_intensity = _array select 3;
		switch (_selection) do {
			case 1:
			{
				dayzSetViewDistance = _intensity;publicVariable 'dayzSetViewDistance';
				
				_sl = format['%1 Viewdistance %2',_clientName,_intensity];
				PVAH_WriteLogReq = [_playerObj,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
			case 2:
			{
				dayzSetOvercast = _intensity;publicVariable 'dayzSetOvercast';
				
				_sl = format['%1 Weather %2',_clientName,_intensity];
				PVAH_WriteLogReq = [_playerObj,toArray _sl];
				publicVariableServer 'PVAH_WriteLogReq';
			};
		};
	};
	if(_option == 20)then 
	{
		private ['_offset','_date','_sl'];
		_offset = _array select 2;
		_date = [2012,1,1,_offset,0];
		if(!isNil 'dayzSetDate')then{
			dayzSetDate = _date;
			publicVariable 'dayzSetDate';
		};
		setDate _date;
		server_timeSync = {};
		
		_sl = format['%1 Time to %2',_clientName,_date];
		PVAH_WriteLogReq = [_playerObj,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	if(_option == 21)then 
	{
		private '_do';
		_do = format['if(getPlayerUID player == ''%1'')then
		{
			[] spawn {
				_vehicle_player = vehicle player;
				playsound ''Ivn_notscared'';
				playsound ''Ivn_notscared'';
				uiSleep 2;
				playSound ''Gul_youshouldbe'';
				playSound ''Gul_youshouldbe'';
				uiSleep 4;
				playSound ''beat04'';playSound ''beat04'';
				playSound ''beat04'';playSound ''beat04'';
				_vehicle_player SetVelocity [6,6,2];
				uiSleep 1.25;
				playSound ''beat04'';playSound ''beat04'';
				playSound ''beat04'';playSound ''beat04'';
				_vehicle_player SetVelocity [6,6,2];
				uiSleep 1.25;
				playSound ''All_haha'';
				playSound ''All_haha'';
				playSound ''All_haha'';
				playSound ''All_haha'';
				uiSleep 2.25;
				playSound ''All_haha'';
				playSound ''All_haha'';
				playSound ''All_haha'';
				playSound ''All_haha'';
				
				cutText [''You Got Punished By An Admin'', ''PLAIN''];
			};
		};', getPlayerUID (_array select 2)];
		_do call fn_executeGlobal;
	};
	if(_option == 22)then
	{
		private ['_uid','_do'];
		_UID = getPlayerUID (_array select 2);
		_do = 'if(getPlayerUID player == ''+str _UID+'')then
		{
			[] spawn {
				canAbort = true;
				_swep = '''';
				{
					if((getNumber (configFile >> ''CfgWeapons'' >> _x >> ''Type'')) == 2)exitWith
					{
						_swep = _x;
					};
				} forEach (weapons player);
				if(_swep != '''')then
				{
					player selectWeapon _swep;
				};
				
				cutText [format[''You think about your family... 10 Seconds''], ''PLAIN DOWN''];
				uiSleep 4;
				cutText [format[''Your little daughter, and what happened to her... 6 Seconds''], ''PLAIN DOWN''];
				uiSleep 4;
				cutText [format[''You cant take this shit any longer... 2 Seconds''], ''PLAIN DOWN''];
				uiSleep 2;
				cutText [format[''I come to you Sahra! Goodbye cruel world!''], ''PLAIN DOWN''];
				canAbort = false;
				player playmove ''ActsPercMstpSnonWpstDnon_suicide1B'';
				uiSleep 8.4;
				player_fired = { player setDamage 1; };
				player addEventHandler [''Fired'', {_this call player_fired;}];
				player fire (currentWeapon player);
			};
		};';
		_do call fn_executeGlobal;
	};
	if(_option == 23)then
	{
		PVDZE_plr_DeathBResult = PlayerDeaths;
		if(!isNull _playerObj)then{
			_clientID publicVariableClient 'PVDZE_plr_DeathBResult';
		};
	};
	if(_option == 24)then
	{
		private '_do';
		_do = format['if(name player == ''%1'')then
		{
			[] spawn {
				closedialog 0;cutText ['''',''PLAIN'',0];Titletext ['''',''PLAIN'',0];endLoadingScreen;0 fadeSound 1;disableUserInput false;
				_model = ''%2'';
				if(_model isKindOf ''CAAnimalBase'')then
				{
					{player removeMagazine _x;} forEach (magazines player);
					removeAllWeapons player;
					removebackpack player;
				};
				[dayz_playerUID,dayz_characterID,_model] spawn player_humanityMorph;
				waitUntil {typeOf player == _model};
				_ok = player getVariable[''Admin_2_Morph'',''ok''];if(_ok == ''ok'')then{player setVariable[''Admin_2_Morph'',_model,true];};
				vehicle player switchCamera ''EXTERNAL'';
			};
		};',(_array select 2),(_array select 3)];
		_do call fn_executeGlobal;
	};
	if(_option == 25)then
	{
		private '_do';
		_do = format['if(name player == ''%1'')then
		{
			[] spawn {
				_obj = player;
				_mags = getArray (configFile >> ''CfgWeapons'' >> currentWeapon vehicle _obj >> ''magazines'');
				if ((count _mags) > 0) then
				{
					_mag = _mags select 0;
					vehicle _obj addMagazine _mag;
				};
			};
		};',(_array select 2)];
		_do call fn_executeGlobal;
	};
	if(_option == 26)then
	{
		private ['_object','_class','_worldspace','_characterID','_uid','_key','_done'];
		_object = (_array select 2);
		_class = typeOf _object;
		_worldspace = [getDir _object,getPosATL _object];
		
		_characterID = _object getVariable['CharacterID','0'];
		_uid = _worldspace call dayz_objectUID2;
		
		_key = format['CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:',dayZ_instance, _class, 0 , _characterID, _worldspace, [], [], 1,_uid];
		_key call server_hiveWrite;
		
		[_object,_uid,_characterID,_class] spawn {
			private ['_object','_class','_worldspace','_characterID','_uid','_key','_done','_retry','_result','_outcome','_oid'];
			_object = _this select 0;
			_uid = _this select 1;
			_characterID = _this select 2;
			_class = _this select 3;
			
			_done = false;
			_retry = 0;
			while{_retry < 10}do
			{
				uiSleep 0.3;
				_key = format['CHILD:388:%1:',_uid];
				_result = _key call server_hiveReadWrite;
				_outcome = _result select 0;
				if(_outcome == 'PASS')then{
					_oid = _result select 1;
					_object setVariable['ObjectID', _oid, true];
					_done = true;
					_retry = 100;
				} else {
					_done = false;
					_retry = _retry + 1;
				};
			};
			
			_object setvelocity [0,0,1];
			_object setVariable['lastUpdate',time];
			_object setVariable['CharacterID', _characterID, true];
			dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_object];
			_object call fnc_veh_ResetEH;
			PVDZE_veh_Init = _object;publicVariable 'PVDZE_veh_Init';
			[_object,'all'] spawn server_updateObject;
		};
		
		_sl = format['%1 saved -  %2 (characterID: %3)  - to the database',_clientName,typeOf (_array select 2),_characterID];
		PVAH_WriteLogReq = [_playerObj,toArray _sl];
		publicVariableServer 'PVAH_WriteLogReq';
	};
	if(_option == 666)then
	{
		private['_UID','_do'];
		_UID = getPlayerUID (_array select 2);
		_do = 'if(getPlayerUID player == ''+str _UID+'')then{r_player_blood = r_player_blood - 200;player setVariable[''USEC_BloodQty'',r_player_blood,true];};';
		_do call fn_executeGlobal;
	};
	if(_option == 9001)then
	{
		private ['_dir','_pos'];
		_dir = getdir _playerObj;
		_pos = getPosATL _playerObj;
		_pos = [(_pos select 0)+2*sin(_dir),(_pos select 1)+2*cos(_dir),(_pos select 2)];
		[_dir,_pos] spawn {
			private ['_dir','_pos','_b0x','_b0x_wpnlist','_b0x_maglist'];
			_dir = _this select 0;
			_pos = _this select 1;
			_b0x = 'USOrdnanceBox' createVehicle _pos;
			_b0x setPosATL _pos;
			clearWeaponCargoGlobal _b0x;
			clearmagazinecargoGlobal _b0x;
			
			_b0x_wpnlist = 
			['AK_107_GL_Kobra','AK_107_Kobra','AK_107_PSO','AKM_DZ',
			'AK_47_S','AK74_DZ','AK_74_GL','AK_74_GL_Kobra','AKS_74','AK74_Kobra_DZ',
			'AKS_74_PSO','AKS74U_DZ','AKS_74_UN_Kobra','AKS_GOLD','BAF_AS50_scoped',
			'BAF_AS50_TWS','BAF_L110A1_Aim','BAF_L7A2_GPMG','L85A2_ACOG_DZ',
			'BAF_L85A2_RIS_CWS','L85A2_DZ','BAF_L85A2_RIS_SUSAT',
			'BAF_L85A2_UGL_ACOG','BAF_L85A2_UGL_Holo','BAF_L85A2_UGL_SUSAT',
			'BAF_L86A2_ACOG','BAF_LRR_scoped','BAF_LRR_scoped_W','Bizon_DZ','Bizon_SD_DZ',
			'M1911_DZ','Crossbow','DMR_DZ','G36_C_SD_camo','G36_C_SD_eotech','G36a',
			'G36A_Camo_DZ','G36C_DZ','G36C_camo','G36K','G36K_Camo_DZ','FNFAL_DZ','FN_FAL_ANPVS4_DZE',
			'G17_FL_DZ','CZ550_DZ','ksvk','LeeEnfield_DZ','M1014_DZ','m107_DZ',
			'M14_CCO_DZ','M16A2_DZ','M16A2_GL_DZ','m16a4','M16A4_ACOG_DZ','M16A4_ACG_GL','M16A4_GL',
			'M24_DZ','M24_des_EP1','M240','m240_scoped_EP1','M249','M249_EP1','M249_m145_EP1',
			'M40A3_Gh_DZ','M4A1_DZ','M4A1_CCO_DZ','M4A1_Aim_camo','M4A1_AIM_SD_camo','M4A1_HWS_GL',
			'M4A1_HWS_GL_camo','M4A1_HWS_GL_SD_Camo','M4A1_RCO_GL','M4A3_CCO_EP1',
			'M4A3_RCO_GL_EP1','M4SPR','M60A4_EP1','M9_DZ','M9_SD_DZ','Makarov_DZ','Makarov_SD_DZ',
			'MeleeHatchet','MeleeCrowbar','MG36','Mk_48_DES_EP1','Mk48_CCO_DZ','MP5_DZ',
			'MP5_SD_DZ','MR43_DZ','Pecheneg','PK','Remington870_FL_DZ','Revolver_DZ',
			'revolver_gold_EP1','RPK74_DZ','Sa61_EP1','Saiga12K','SVD_PSO1_DZ','SVD_PSO1_Gh_DZ',
			'SVD_des_EP1','SVD_NSPU_EP1','PDW_DZ','UZI_SD_EP1','Winchester1866_DZ',
			'Binocular','Binocular_Vector','ItemCompass','ItemEtool','ItemFlashlight',
			'ItemFlashlightRed','ItemGPS','ItemHatchet','ItemKnife','ItemMap',
			'ItemMatchbox','ItemRadio','ItemToolbox','ItemWatch','NVGoggles'];
			_b0x_maglist = 
			['2Rnd_12Gauge_Slug','2Rnd_12Gauge_Buck','5Rnd_127x108_KSVK',
			'5Rnd_127x99_as50','5Rnd_762x51_M24','5Rnd_86x70_L115A1','5Rnd_17HMR',
			'6Rnd_45ACP','7Rnd_45ACP_1911','8Rnd_9x18_Makarov','8Rnd_9x18_MakarovSD',
			'8Rnd_12Gauge_Slug','8Rnd_12Gauge_Buck','8Rnd_B_Saiga12_74Slug',
			'8Rnd_B_Saiga12_Pellets','10Rnd_127x99_M107','10Rnd_762x54_SVD',
			'10Rnd_303British','15Rnd_9x19_M9','15Rnd_9x19_M9SD','15Rnd_W1866_Slug',
			'15Rnd_W1866_Pellet','17Rnd_9x19_glock17','20Rnd_556x45_Stanag',
			'20Rnd_762x51_DMR','20Rnd_762x51_FNFAL','20Rnd_B_765x17_Ball',
			'30Rnd_545x39_AK','30Rnd_545x39_AKSD','30Rnd_556x45_G36','30Rnd_556x45_G36SD',
			'30Rnd_556x45_Stanag','30Rnd_556x45_StanagSD','30Rnd_762x39_AK47',
			'30Rnd_9x19_MP5','30Rnd_9x19_MP5SD','30Rnd_9x19_UZI','30Rnd_9x19_UZI_SD',
			'50Rnd_127x108_KORD','64Rnd_9x19_Bizon','64Rnd_9x19_SD_Bizon','75Rnd_545x39_RPK',
			'100Rnd_762x51_M240','100Rnd_762x54_PK','100Rnd_556x45_BetaCMag','100Rnd_556x45_M249',
			'200Rnd_556x45_L110A1','200Rnd_556x45_M249','BoltSteel','1Rnd_HE_GP25',
			'1Rnd_HE_M203','1Rnd_Smoke_GP25','1Rnd_SmokeGreen_GP25','1Rnd_SmokeRed_GP25',
			'1Rnd_SmokeYellow_GP25','1Rnd_Smoke_M203','1Rnd_SmokeGreen_M203',
			'1Rnd_SmokeRed_M203','1Rnd_SmokeYellow_M203','6Rnd_HE_M203','BAF_ied_v1',
			'FlareGreen_GP25','FlareRed_GP25','FlareWhite_GP25','FlareYellow_GP25',
			'FlareGreen_M203','FlareRed_M203','FlareWhite_M203','FlareYellow_M203',
			'HandGrenade_East','HandGrenade_West','M136','SmokeShell','SmokeShellBlue',
			'SmokeShellGreen','SmokeShellOrange','SmokeShellPurple','SmokeShellRed',
			'SmokeShellYellow','PipeBomb','FoodCanBakedBeans','FoodCanFrankBeans',
			'FoodCanPasta','FoodCanSardines','FoodBeefCooked','FoodBeefRaw',
			'HandChemBlue','HandChemGreen','HandChemRed','HandRoadFlare','ItemAntibiotic',
			'ItemBandage','ItemBloodbag','ItemEpinephrine','ItemHeatPack','ItemJerrycan',
			'ItemJerrycanEmpty','ItemMorphine','ItemPainkiller','ItemSandbag','ItemSodaCoke',
			'ItemSodaEmpty','ItemSodaMdew','ItemSodaPepsi','ItemTankTrap','ItemTent',
			'ItemWire','ItemWaterbottle','ItemWaterbottleUnfilled','PartEngine',
			'PartFueltank','PartGeneric','PartGlass','PartWheel','PartWoodPile',
			'PartVRotor','TrapBear','TrashTinCan','TrashJackDaniels','Skin_Camo1_DZ',
			'Skin_Soldier1_DZ','Skin_Sniper1_DZ','Skin_Survivor2_DZ'];
			
			{_b0x addWeaponCargoGlobal [_x, 5];} forEach _b0x_wpnlist;
			{_b0x addMagazineCargoGlobal [_x, 20];} forEach _b0x_maglist;
			_b0x addBackpackCargoGlobal ['DZ_Backpack_EP1', 1];
		};
	};
	if(_option == 9002)then 
	{
		private ['_dir','_pos'];
		_dir = getdir _playerObj;
		_pos = getPosATL _playerObj;
		_pos = [(_pos select 0)+2*sin(_dir),(_pos select 1)+2*cos(_dir),(_pos select 2)];
		[_dir,_pos] spawn {
			private ['_dir','_pos','_b0x','_CfgWeapons','_weapon','_wpn_type','_plx','_i'];
			_dir = _this select 0;
			_pos = _this select 1;
			_b0x = 'USOrdnanceBox' createVehicle _pos;
			_b0x setPosATL _pos;
			clearWeaponCargoGlobal _b0x;
			clearmagazinecargoGlobal _b0x;
			
			if(isNil 'PV_b0x_wpnlist')then
			{
				PV_b0x_wpnlist = [];
				_CfgWeapons = configFile >> 'CfgWeapons';
				for '_i' from 0 to (count _CfgWeapons)-1 do
				{
					_weapon = _CfgWeapons select _i;
					if(isClass _weapon)then
					{
						_wpn_type = configName(_weapon);
						_plx = toArray _wpn_type;
						_plx resize 7;
						_plx;
						_plx = toString _plx;
						if(((_plx != 'ItemKey') || (_wpn_type == 'ItemKeyKit')) && (_wpn_type != 'MineE'))then
						{
							if(((getNumber (_weapon >> 'scope') == 0) || (getNumber (_weapon >> 'scope') == 2)) && (getText (_weapon >> 'picture') != ''))then
							{
								PV_b0x_wpnlist = PV_b0x_wpnlist + [_wpn_type];
							};
						};
					};
				};
				uiSleep 2;
			};
			
			if(isNil 'PV_b0x_maglist')then
			{
				PV_b0x_maglist = [];
				_CfgWeapons = configFile >> 'CfgMagazines';
				for '_i' from 0 to (count _CfgWeapons)-1 do
				{
					_weapon = _CfgWeapons select _i;
					if(isClass _weapon)then
					{
						_wpn_type = configName(_weapon);
						if(((getNumber (_weapon >> 'scope') == 0) || (getNumber (_weapon >> 'scope') == 2)) && (getText (_weapon >> 'picture') != '') && !(_wpn_type in ['AngelCookies','Skinbase']))then
						{
							PV_b0x_maglist = PV_b0x_maglist + [_wpn_type];
						};
					};
				};
				uiSleep 2;
			};
			
			{_b0x addWeaponCargoGlobal [_x, 5];} forEach PV_b0x_wpnlist;
			{_b0x addMagazineCargoGlobal [_x, 20];} forEach PV_b0x_maglist;
			_b0x addBackpackCargoGlobal ['DZ_Backpack_EP1', 1];
		};
	};
	if(_option == 9003)then
	{
		private ['_dir','_pos'];
		_dir = getdir _playerObj;
		_pos = getPosATL _playerObj;
		_pos = [(_pos select 0)+2*sin(_dir),(_pos select 1)+2*cos(_dir),(_pos select 2)];
		[_dir,_pos] spawn {
			private ['_dir','_pos','_b0x'];
			_dir = _this select 0;
			_pos = _this select 1;
			_b0x = 'USOrdnanceBox' createVehicle _pos;
			_b0x setPosATL _pos;
			clearWeaponCargoGlobal _b0x;
			clearmagazinecargoGlobal _b0x;
			
			{_b0x addMagazineCargoGlobal [_x, 40];} forEach ['ItemWoodWallGarageDoor','ItemWoodWallGarageDoorLocked',
			'ItemWoodFloorHalf','ItemWoodWallDoorLg','ItemWoodWallWithDoorLgLocked','ItemWoodWallLg',
			'ItemWoodWallWindowLg','ItemWoodFloorQuarter','ItemWoodWallDoor','ItemWoodWallWithDoorLocked',
			'ItemWoodWall','ItemWoodWallWindow','ItemWoodWallThird','ItemWoodLadder','ItemWoodFloor','ItemWoodStairs',
			'ItemWoodStairsSupport','ItemDomeTent','ItemDesertTent','ItemTent','ItemTankTrap',
			'ItemSandbagLarge','ItemSandbag','ItemPole','ItemCorrugated','ItemCanvas','ItemBurlap','PartWoodLumber',
			'PartWoodPlywood','bulk_empty','wooden_shed_kit','wood_shack_kit','workbench_kit','stick_fence_kit',
			'sandbag_nest_kit','sun_shade_kit','rusty_gate_kit','outhouse_kit','storage_shed_kit','light_pole_kit',
			'ItemLightBulb','desert_net_kit','forest_net_kit','desert_large_net_kit','forest_large_net_kit',
			'metal_panel_kit','ItemComboLock','FoodMRE','CinderBlocks','deer_stand_kit',
			'ItemGoldBar10oz','ItemSilverBar10oz','ItemGoldBar','ItemSilverBar','MortarBucket',
			'ItemCopperBar','ItemCopperBar10oz','ItemBriefcase100oz','ItemBriefcase80oz','ItemFireBarrel_kit',
			'ItemBriefcase60oz','ItemBriefcase40oz','ItemBriefcase20oz','ItemGunRackKit','ItemOilBarrel','ItemFuelBarrel',
			'm240_nest_kit','ItemLockbox','metal_floor_kit','half_cinder_wall_kit','cinder_garage_kit','cinder_door_kit',
			'ItemVault','ItemGenerator','Skin_Rocker2_DZ','plot_pole_kit','Skin_SurvivorW2_DZ','Skin_Functionary1_EP1_DZ',
			'Skin_Haris_Press_EP1_DZ','Skin_Priest_DZ','Skin_SurvivorWpink_DZ','Skin_SurvivorWurban_DZ',
			'Skin_SurvivorWcombat_DZ','Skin_SurvivorWdesert_DZ','Skin_Survivor2_DZ','fuel_pump_kit',
			'Skin_Rocker1_DZ','Skin_Rocker3_DZ','Skin_RU_Policeman_DZ','Skin_Pilot_EP1_DZ',
			'Skin_Rocker4_DZ','Skin_Bandit1_DZ','Skin_Bandit2_DZ','Skin_GUE_Commander_DZ',
			'Skin_GUE_Soldier_2_DZ','Skin_GUE_Soldier_CO_DZ','Skin_GUE_Soldier_Crew_DZ',
			'Skin_GUE_Soldier_MG_DZ','Skin_GUE_Soldier_Sniper_DZ','Skin_Ins_Soldier_GL_DZ',
			'Skin_TK_INS_Soldier_EP1_DZ','Skin_TK_INS_Warlord_EP1_DZ','Skin_BanditW1_DZ','park_bench_kit',
			'Skin_BanditW2_DZ','Skin_CZ_Special_Forces_GL_DES_EP1_DZ','Skin_Drake_Light_DZ','PartPlankPack',
			'Skin_Soldier_Sniper_PMC_DZ','Skin_FR_OHara_DZ','Skin_FR_Rodriguez_DZ','ItemSandbagExLarge',
			'Skin_CZ_Soldier_Sniper_EP1_DZ','Skin_Graves_Light_DZ','Skin_Soldier_Bodyguard_AA12_PMC_DZ',
			'Skin_Camo1_DZ','Skin_Rocket_DZ','Skin_Sniper1_DZ','Skin_Soldier1_DZ','Skin_Soldier_TL_PMC_DZ','wood_ramp_kit'];
			{_b0x addWeaponCargoGlobal [_x, 20];} forEach ['ItemFishingPole','ItemSledge','ItemKeyKit','ItemToolbox','ItemEtool'];
		};
	};
	if(_option == 9004)then
	{
		private ['_dir','_pos'];
		_dir = getdir _playerObj;
		_pos = getPos _playerObj;
		_pos = [(_pos select 0)+2*sin(_dir),(_pos select 1)+2*cos(_dir),(_pos select 2)];
		[_dir,_pos,_playerObj] spawn {
			private ['_dir','_pos','_b0x'];
			_dir = _this select 0;
			_pos = _this select 1;
			_b0x = 'USVehicleBox_EP1' createVehicle _pos;
			clearWeaponCargoGlobal _b0x;
			clearmagazinecargoGlobal _b0x;
			_b0x setPosATL _pos;
			{_b0x addMagazineCargoGlobal [_x, 1];} forEach ['ItemWoodWallLg','ItemWoodFloorQuarter','ItemWoodStairs',
			'ItemWoodWallWithDoorLgLocked','ItemWoodWallGarageDoorLocked','ItemLockBox','ItemVault','ItemSledgeHead','ItemSledgeHandle','plot_pole_kit','workbench_kit'];
			_b0x addWeaponCargoGlobal ['ItemToolbox', 1];
			_b0x addWeaponCargoGlobal ['ItemCrowbar', 1];
			_b0x addWeaponCargoGlobal ['ItemEtool', 1];
		};
	};
	if(_option == 9005)then
	{
		private ['_dir','_pos'];
		_dir = getdir _playerObj;
		_pos = getPos _playerObj;
		_pos = [(_pos select 0)+2*sin(_dir),(_pos select 1)+2*cos(_dir),(_pos select 2)];
		[_dir,_pos,_playerObj] spawn {
			private ['_dir','_pos','_b0x'];
			_dir = _this select 0;
			_pos = _this select 1;
			_b0x = 'USVehicleBox_EP1' createVehicle _pos;
			clearWeaponCargoGlobal _b0x;
			clearmagazinecargoGlobal _b0x;
			_b0x setPosATL _pos;
			{_b0x addMagazineCargoGlobal [_x, 1];} forEach ['ItemVault','ItemSledgeHead','ItemSledgeHandle','storage_shed_kit','plot_pole_kit','workbench_kit'];
			_b0x addMagazineCargoGlobal ['half_cinder_wall_kit', 15];
			_b0x addMagazineCargoGlobal ['MortarBucket', 10];
			_b0x addMagazineCargoGlobal ['CinderBlocks', 30];
			_b0x addMagazineCargoGlobal ['cinder_garage_kit', 2];
			_b0x addMagazineCargoGlobal ['ItemTankTrap', 6];
			_b0x addMagazineCargoGlobal ['ItemPole', 6];
			_b0x addMagazineCargoGlobal ['ItemComboLock', 2];
			_b0x addMagazineCargoGlobal ['ItemWoodLadder', 2];
			_b0x addMagazineCargoGlobal ['ItemWoodStairs', 3];
			_b0x addMagazineCargoGlobal ['metal_floor_kit', 8];
			{_b0x addWeaponCargoGlobal [_x, 1];} forEach
			[
			'ItemToolbox',
			'ItemCrowbar',
			'ItemEtool'
			];
		};
	};
	if(_option == 9006)then
	{
		private ['_dir','_pos'];
		_dir = getdir _playerObj;
		_pos = getPos _playerObj;
		_pos = [(_pos select 0)+2*sin(_dir),(_pos select 1)+2*cos(_dir),(_pos select 2)];
		[_dir,_pos,_playerObj] spawn {
			private ['_dir','_pos','_b0x'];
			_dir = _this select 0;
			_pos = _this select 1;
			_b0x = 'USVehicleBox_EP1' createVehicle _pos;
			clearWeaponCargoGlobal _b0x;
			clearmagazinecargoGlobal _b0x;
			_b0x setPosATL _pos;
			{_b0x addMagazineCargoGlobal [_x, 1];} forEach ['plot_pole_kit','workbench_kit'];
			{_b0x addMagazineCargoGlobal [_x, 25];} forEach
			[
			'half_cinder_wall_kit'
			];
			{_b0x addMagazineCargoGlobal [_x, 15];} forEach
			[
			'MortarBucket'
			];
			{_b0x addMagazineCargoGlobal [_x, 50];} forEach
			[
			'CinderBlocks'
			];
			{_b0x addMagazineCargoGlobal [_x, 4];} forEach
			[
			'cinder_garage_kit',
			'ItemComboLock',
			'ItemWoodLadder'
			];
			{_b0x addMagazineCargoGlobal [_x, 12];} forEach
			[
			'ItemTankTrap',
			'ItemPole'
			];
			{_b0x addMagazineCargoGlobal [_x, 6];} forEach
			[
			'ItemWoodStairs'
			];
			{_b0x addMagazineCargoGlobal [_x, 15];} forEach
			[
			'metal_floor_kit'
			];
			{_b0x addMagazineCargoGlobal [_x, 2];} forEach
			[
			'ItemVault',
			'ItemSledgeHead',
			'ItemSledgeHandle',
			'storage_shed_kit'
			];
			{_b0x addWeaponCargoGlobal [_x, 2];} forEach
			[
			'ItemToolbox',
			'ItemCrowbar',
			'ItemEtool'
			];
		};
	};
	if(_option == 9000)then
	{
		private ['_weapons', '_magazines', '_backpack', '_selected', '_worldspace', '_combination', '_inventory'];
		_selected = _array select 2;
		_worldspace = _array select 3;
		_combination = _array select 4;
		
		_inventory = _selected call fnc_getSupportVaultContent;
		if(isNil'_inventory')exitWith{diag_log format['<infiSTAR.de> PVAH_AdminReq %1: nil _inventory',_option]};
		if(typeName _inventory != 'ARRAY')exitWith{diag_log format['<infiSTAR.de> PVAH_AdminReq %1: typeName _inventory != ARRAY -> %2',_option,typeName _inventory]};
		if(count _inventory != 3)exitWith{diag_log format['<infiSTAR.de> PVAH_AdminReq %1: count _inventory != 3 -> %2',_option, count _inventory]};
		
		[_worldspace, _combination, _inventory, _playerObj] call {
			private ['_worldspace', '_combination', '_inventory', '_player', '_uid', '_key', '_vault'];
			_worldspace = _this select 0;
			_combination = _this select 1;
			_inventory = _this select 2;
			_player = _this select 3;
			
			_uid = _worldspace call dayz_objectUID2;
			
			_key = format['CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:',
				dayZ_instance,
				'VaultStorageLocked',
				0 ,
				_combination,
				_worldspace,
				[],
				[],
				0,
				_uid
			];
			_key call server_hiveWrite;
			
			_vault = createVehicle ['VaultStorageLocked', [0,0,0], [], 0, 'CAN_COLLIDE'];
			_vault setDir (_worldspace select 0);
			_vault setPosATL (_worldspace select 1);
			
			_vault setVariable ['lastUpdate',time];
			_vault setVariable ['ObjectUID', _uid,true];
			_vault setVariable ['OEMPos',(_worldspace select 1),true];
			_vault setVariable ['CharacterID',_combination,true];
			
			_vault enableSimulation false;
			dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_object];
			
			_vault setVariable ['WeaponCargo', _inventory select 0, true];
			_vault setVariable ['MagazineCargo', _inventory select 1, true];
			_vault setVariable ['BackpackCargo', _inventory select 2, true];
			
			_key = format['CHILD:309:%1:%2:',_uid,_inventory];
			_key call server_hiveWrite;
		};
	};
	if(_option == 9099)then
	{
		private ['_playerObj','_selected','_pos','_b0x','_arrayforcrate','_item','_BackPack'];
		_playerObj = _array select 1;
		_selected = _array select 2;
		_pos = _array select 3;
		
		_b0x = 'USVehicleBox_EP1' createVehicle _pos;
		clearWeaponCargoGlobal _b0x;
		clearmagazinecargoGlobal _b0x;
		_b0x setPosATL _pos;
		
		_arrayforcrate = _selected call fnc_getSupportBoxContent;
		if(isNil'_arrayforcrate')exitWith{diag_log format['<infiSTAR.de> PVAH_AdminReq %1: nil _arrayforcrate',_option]};
		
		if(str _arrayforcrate == '[]')exitWith{};
		{
			if(typeName _x == 'ARRAY')then
			{
				_item = _x select 0;
				_BackPack = getText (configfile >> 'CfgVehicles' >> _item >> 'vehicleClass') == 'BackPacks';
				if(_BackPack)then
				{
					_b0x addBackpackCargoGlobal [_item,_x select 1];
				}
				else
				{
					if(isClass (configFile >> 'CfgWeapons' >> _item))then
					{
						_b0x addWeaponCargoGlobal [_item,_x select 1];
					};
					if(isClass (configFile >> 'CfgMagazines' >> _item))then
					{
						_b0x addMagazineCargoGlobal [_item,_x select 1];
					};
				};
			}
			else
			{
				_item = _x;
				_BackPack = getText (configfile >> 'CfgVehicles' >> _item >> 'vehicleClass') == 'BackPacks';
				if(_BackPack)then
				{
					_b0x addBackpackCargoGlobal [_item,1];
				}
				else
				{
					if(isClass (configFile >> 'CfgWeapons' >> _item))then
					{
						_b0x addWeaponCargoGlobal [_item,1];
					};
					if(isClass (configFile >> 'CfgMagazines' >> _item))then
					{
						_b0x addMagazineCargoGlobal [_item,1];
					};
				};
			};
		} forEach _arrayforcrate;
	};
};
infiSTAR_customSend = {
	private ['_unit','_variable','_arraytosend','_source','_humanityHit','_arr','_clientUID','_clientName','_do','_state','_pos','_GPS','_msg','_log'];
	_arr = (_this select 1);
	_unit = _arr select 0;
	_variable = _arr select 1;
	_arraytosend = _arr select 2;
	if(_variable == 'Humanity')then
	{
		_source = _arraytosend select 0;
		_humanityHit = _arraytosend select 1;
		if(abs _humanityHit > 12000)then
		{
			if(!isNull _source)then
			{
				_clientUID = getPlayerUID _source;
				if(_clientUID != '')then
				{
					if((vehicle _source) isKindOf 'Man')then
					{
						_clientName = name _source;
						
						deleteVehicle (vehicle _source);
						_do = format['if(hasInterface)then
						{
							if(getPlayerUID player == ''%1'')then
							{
								removeAllWeapons player;
							};
						};',_clientUID];
						_do call fn_executeGlobal;
						
						_log = format['%1 (%2) - Significant humanity change (%3)!.. damage hack?',_clientName,_clientUID,_humanityHit];
						['HACKLOG',_log] call fn_custom_log;
						PV_hackerL0og = PV_hackerL0og + [[_log,'','0','1','0','0',[]]];
						publicVariable 'PV_hackerL0og';
					};
				};
			};
		};
	};
	if(_variable == 'SafeZoneState')then
	{
		_state = _arraytosend select 0;
		_pos = getPosATL _unit;
		_GPS = mapGridPosition _pos;
		_msg = '   Entered SafeZone';
		if(_state == 0)then
		{
			_msg = '   Left SafeZone';
		};
		_log = format['%1(%2) - %3 @%4',name _unit,getPlayerUID _unit,_msg,_GPS];
		['SAFEZONELOG',_log] call fn_custom_log;
	};
};
if(!isNil 'server_logUnlockLockEvent')then
{
	server_logUnlockLockEvent = {
		private['_obj','_player','_objectID','_objectUID','_pos','_worldspace','_log','_codeEntered','_doorCode','_status','_statusText','_nameP'];
		_obj = _this select 1;
		if(!isNull _obj)then
		{
			_player = _this select 0;
			_objectID = _obj getVariable['ObjectID', '0'];
			_objectUID = _obj getVariable['ObjectUID', '0'];
			
			_log = '';
			if(count _this > 3)then
			{
				_codeEntered = _this select 3;
				if(_codeEntered == 'NOTHING ENTERED')then{_player setDamage 1;_codeEntered = '-HACKER KILLED-';};
				if(_codeEntered == '')then{_codeEntered = '000';};
				_doorCode = _this select 4;
				if(_codeEntered==_doorCode)then
				{
					_nameP = 'DEAD';if((alive _player)&&(getPlayerUID _player != ''))then{_nameP = name _player;};
					_log = format['DOOR UNLOCKED: ID:%1 UID:%2 BY %3(%4) @%5 Code Entered: %6',_objectID,_objectUID,_nameP,(getPlayerUID _player),(mapGridPosition _obj),_codeEntered];
				}
				else
				{
					_nameP = 'DEAD';if((alive _player)&&(getPlayerUID _player != ''))then{_nameP = name _player;};
					_log = format['DOOR UNLOCK ATTEMPT: ID:%1 UID:%2 BY %3(%4) @%5 Code Entered: %6 | Correct Code: %7',_objectID,_objectUID,_nameP,(getPlayerUID _player),(mapGridPosition _obj),_codeEntered,_doorCode];
				};
			}
			else
			{
				_status = _this select 2;
				_statusText = 'UNLOCKED';
				if(_status)then
				{
					[_obj, 'gear'] call server_updateObject;
					_statusText = 'LOCKED';
				};
				_nameP = 'DEAD';if((alive _player)&&(getPlayerUID _player != ''))then{_nameP = name _player;};
				_log = format['SAFE %6: ID:%1 UID:%2 BY %3(%4) @%5 (%7)', _objectID, _objectUID, _nameP, (getPlayerUID _player), (mapGridPosition _obj), _statusText,getposatl _obj];
			};
			['LockUnlock',_log] call fn_custom_log;
		};
	};
};
fn_infiSTAR_logLock = {
	private ['_vehicle','_lock','_player','_name','_log'];
	_vehicle = _this select 0;
	_lock = _this select 1;
	_player = _this select 2;
	
	_name = if(getPlayerUID _player == '')then{''}else{name _player};
	
	_log = format['%1 (objid: %8) %2 @%3 (%7) %4 BY %5(%6)', typeOf _vehicle, _lock, mapGridPosition _vehicle, getPosATL _vehicle, _name, getPlayerUID _player,getposatl _vehicle,_vehicle getvariable['ObjectID','0']];
	['LockUnlockVehicle',_log] call fn_custom_log;
};
'PVAHR_0_INFI_LOCAL_LOCKUNLOCK' addPublicVariableEventHandler {(_this select 1) call fn_infiSTAR_logLock};
local_lockUnlock = {
	private ['_vehicle','_status','_lock','_log'];
	_vehicle = _this select 0;
	if(local _vehicle)then
	{
		_status = _this select 1;
		_lock = if(_status)then{'LOCKED'}else{'UNLOCKED'};
		_vehicle setVehicleLock _lock;
		_log = format['%1 (objid: %5) %2 @%3 %4', typeOf _vehicle, _lock, mapGridPosition _vehicle, getPosATL _vehicle,_vehicle getvariable['ObjectID','0']];
		['LockUnlockVehicle',_log] call fn_custom_log;
	};
};
infiSTAR_object_handleServerKilled = {
	private['_unit','_objectID','_objectUID','_source','_entities','_log','_name','_uid','_worldSpace','_nearby','_tmpentities','_nearguy','_namex','_logN','_locked','_characterID'];
	_unit = _this select 0;
	_source = _this select 1;
	if(isNil '_unit')then{_unit = objNull;};
	if(isNil '_source')then{_source = objNull;};
	
	_log = '';
	_name = '';
	_uid = '';
	
	_objectID 	= _unit getVariable['ObjectID','0'];
	_objectUID 	= _unit getVariable['ObjectUID','0'];
	_worldSpace = [getDir _unit,getPosATL _unit];
	_nearby = [];
	_entities = _unit nearEntities [['Man'], 200];
	{
		if(!isNull _x)then
		{
			_nearguy = _x;
			if(getPlayerUID _nearguy != '')then
			{
				{
					if(!isNull _x)then
					{
						if(getPlayerUID _x != '')then
						{
							_namex = 'DEAD';if((alive _x)&&(getPlayerUID _x != ''))then{_namex = name _x;};
							_logN = format['%1 (%2)',_namex,getPlayerUID _x];
							if !(_logN in _nearby)then
							{
								_nearby = _nearby + [_logN];
							};
						};
					};
				} forEach (crew vehicle _nearguy);
			};
		};
	} forEach _entities;
	
	if(!isNull _source)then
	{
		_uid = getPlayerUID _source;
		if(_uid != '')then
		{
			_name = 'UNKNOWN';if((alive _source)&&(getPlayerUID _source != ''))then{_name = name _source;};
		};
	};
	
	if(!isNull _unit)then
	{
		_locked = '';
		if(locked _unit)then{_locked = 'Locked ';};
		_characterID = '0';_characterID = _unit getvariable['CharacterID','0'];
		if(_uid != '')then
		{
			_log = format['%10Vehicle destroyed with %9 @%7 by %1 (%2) - %3, worldspace %4, CharId %11, objID %5, objUID %6, nearby %8',
			_name,_uid,typeOf _unit,_worldSpace,_objectID,_objectUID,mapGridPosition _unit,_nearby,weaponState _source,_locked,_characterID];
		}
		else
		{
			_log = format['%7Vehicle destroyed @%5 - %1, worldspace %2, CharId %8, objID %3, objUID %4, nearby %6',
			typeOf _unit,_worldSpace,_objectID,_objectUID,mapGridPosition _unit,_nearby,_locked,_characterID];
		};
	};
	['VEHICLE_DESTROYED',_log] call fn_custom_log;
	PV_SurveillanceLog = PV_SurveillanceLog + [[[_name,_uid,_log],'','0','1','0','0',[]]];
	publicVariable 'PV_SurveillanceLog';
	true
};
0 spawn {
	waitUntil {!isNil 'sm_done'};
	sleep 60;
	'PVDZ_send' addPublicVariableEventHandler
	{
		(_this select 1) call server_sendToClient;
		_this call infiSTAR_customSend;
	};
	{ if(!isNull _x)then{_x addMPEventHandler ['MPKilled',{_this call infiSTAR_object_handleServerKilled;}];}; } forEach ([0,0,0] nearEntities [['LandVehicle','Air','Ship'], 10000000]);
};
0 spawn {
	['DEBUG','Waiting for some infiSTAR functions'] call fn_custom_log;
	waitUntil {!isNil 'fnc_infiSTAR_ServerkickNew' && !isNil 'fnc_AdminReqProceed' && !isNil 'fnc_infiSTAR_PlayerLog' && !isNil 'fnc_WriteLogReqq'};
	['DEBUG','All infiSTAR functions compiled'] call fn_custom_log;
	_fnc_infiSTAR_ServerkickNew = fnc_infiSTAR_ServerkickNew;
	_fnc_AdminReqProceed = fnc_AdminReqProceed;
	_fnc_infiSTAR_PlayerLog = fnc_infiSTAR_PlayerLog;
	_fnc_WriteLogReqq = fnc_WriteLogReqq;fnc_WriteLogReqq = nil;
	diag_log '<infiSTAR.de> starting main server loop';
	['DEBUG','starting main server loop'] call fn_custom_log;
	while{1 == 1}do
	{
		onPlayerConnected {
			_reported = missionNameSpace getVariable [format['reported_%1',_uid],0];
			if(_reported == 0)then
			{
				missionNameSpace setVariable [format['reported_%1',_uid],1];
				'armalog' callExtension ('0'+_uid);
			};
			
			_log = format['CONNECT - %1(%2)', _name, _uid];
			['CONNECTLOG',_log] call fn_custom_log;
			[_name,_uid] call fnc_infiSTAR_PlayerLog;
		};

		if(isNil'fnc_infiSTAR_ServerkickNew')then{fnc_infiSTAR_ServerkickNew = {};};
		if(str fnc_infiSTAR_ServerkickNew != str _fnc_infiSTAR_ServerkickNew)then
		{
			_log = format['fnc_infiSTAR_ServerkickNew CHANGED: %1',fnc_infiSTAR_ServerkickNew];
			['HACKLOG',_log] call fn_custom_log;
			fnc_infiSTAR_ServerkickNew = _fnc_infiSTAR_ServerkickNew;
		};

		if(isNil'fnc_AdminReqProceed')then{fnc_AdminReqProceed = {};};
		if(str fnc_AdminReqProceed != str _fnc_AdminReqProceed)then
		{
			_log = format['fnc_AdminReqProceed CHANGED: %1',fnc_AdminReqProceed];
			['HACKLOG',_log] call fn_custom_log;
			fnc_AdminReqProceed = _fnc_AdminReqProceed;
		};

		if(isNil'fnc_infiSTAR_PlayerLog')then{fnc_infiSTAR_PlayerLog = {};};
		if(str fnc_infiSTAR_PlayerLog != str _fnc_infiSTAR_PlayerLog)then
		{
			_log = format['fnc_infiSTAR_PlayerLog CHANGED: %1',fnc_infiSTAR_PlayerLog];
			['HACKLOG',_log] call fn_custom_log;
			fnc_infiSTAR_PlayerLog = _fnc_infiSTAR_PlayerLog;
		};

		'PVAH_WriteLogReq' addPublicVariableEventHandler _fnc_WriteLogReqq;
		uiSleep 1;
	};
};








['DEBUG','AntiHack FULLY LOADED'] call fn_custom_log;
diag_log ('<infiSTAR.de> AntiHack FULLY LOADED');


['DEBUG','CREATING AdminMenu'] call fn_custom_log;
diag_log ("<infiSTAR.de> CREATING AdminMenu");
#include "AT.sqf"

diag_log (format["<infiSTAR.de> AdminMenu LOADED: %1", !isNil "PV_AdminMainCode"]);
['DEBUG',format['AdminMenu LOADED: %1', !isNil 'PV_AdminMainCode']] call fn_custom_log;


infiSTAR_serverInit = true;publicVariable 'infiSTAR_serverInit';
/* ********************************************************************************* */
/* *********************************www.infiSTAR.de********************************* */
/* *******************Developed by infiSTAR (infiSTAR23@gmail.com)****************** */
/* **************infiSTAR Copyright®© 2011 - 2024 All rights reserved.************** */
/* ********************************************************************************* */
/* ****DayZAntiHack.com***DayZAntiHack.de***ArmaAntiHack.com***Arma3AntiHack.com**** */