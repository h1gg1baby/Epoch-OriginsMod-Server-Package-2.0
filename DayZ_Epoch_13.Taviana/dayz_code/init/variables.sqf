if (isServer) then {
	
};

if (!isDedicated) then {
	dayz_resetSelfActions1 = dayz_resetSelfActions;
	dayz_resetSelfActions = {
		call dayz_resetSelfActions1;
		//    Add custom reset actions here
	
	};
	call dayz_resetSelfActions;	
};

    OriProtectedVeh=["ori_ZAZ968M","ori_taviander","ori_buchanka","ori_m3","ori_maniac","ori_KaTransp","ori_ScrapRaft","ori_bike_d2","ori_col_truck_tent","ori_col_truck_fuel","ori_gaika","ori_rth_originsmod_bathmobile","ori_ScrapBuggy","ori_survivorBus","ori_bigRaft"];