local _Ratio1 = 1;
local _Ratio2 = 2;
local _Ratio3 = 3;

if (MaxVehicleLimit > 300) then {
	_Ratio1 = round(MaxVehicleLimit * 0.0034);
	_Ratio2 = round(MaxVehicleLimit * 0.0067);
	_Ratio3 = round(MaxVehicleLimit * 0.01);
};
AllowedVehiclesList = [
	["AH6X_DZ",_Ratio3],
	["AN2_DZ",_Ratio1], //Green
	["AN2_2_DZ",_Ratio1], //Red and white
	["An2_2_TK_CIV_EP1_DZ",_Ratio1], //Green and white
	["ArmoredSUV_PMC_DZE",_Ratio1],
	["ATV_CZ_EP1_DZE",_Ratio1],
	["BAF_ATV_W_DZE",_Ratio1],
	["car_hatchback_DZE",_Ratio3],
	["car_sedan_DZE",_Ratio3],
	["CH_47F_EP1_DZE",_Ratio1],
	["CH53_DZE",_Ratio1],
	["CSJ_GyroC_DZE",_Ratio3],
	["CSJ_GyroCover",_Ratio3],
	["CSJ_GyroP",_Ratio3],
	["MTVR_Bird_DZE",_Ratio2],
	["datsun1_civil_1_open_DZE",_Ratio3],
	["datsun1_civil_2_covered_DZE",_Ratio3],
	["datsun1_civil_3_open_DZE",_Ratio3],
	["GAZ_Vodnik_DZE",_Ratio1],
	["GAZ_Vodnik_MedEvac_DZE",_Ratio1],
	["GLT_M300_LT_DZE",_Ratio3],
	["GLT_M300_ST_DZE",_Ratio3],
	["GNT_C185_DZ",_Ratio1],
	["GNT_C185C_DZ",_Ratio1],
	["GNT_C185R_DZ",_Ratio1],
	["GNT_C185U_DZ",_Ratio1],
	["hilux1_civil_1_open_DZE",_Ratio3],
	["hilux1_civil_2_covered_DZE",_Ratio3],
	["hilux1_civil_3_open_DZE",_Ratio3],
	["HMMWV_Ambulance_DZE",_Ratio1],
	["HMMWV_Ambulance_CZ_DES_EP1_DZE",_Ratio1],
	["HMMWV_DES_EP1_DZE",_Ratio3],
	["HMMWV_DZ",_Ratio3],
	["HMMWV_M1035_DES_EP1_DZE",_Ratio1],
	["HMMWV_M1151_M2_CZ_DES_EP1_DZE",_Ratio1],
	["HMMWV_M998A2_SOV_DES_EP1_DZE",_Ratio1],
	["Ikarus_DZE",_Ratio3],
	["Ikarus_TK_CIV_EP1_DZE",_Ratio3],
	["Kamaz_DZE",_Ratio3],
	["KamazRefuel_DZ",_Ratio1],
	["Lada1_DZE",_Ratio3],
	["Lada1_TK_CIV_EP1_DZE",_Ratio3],
	["Lada2_DZE",_Ratio3],
	["Lada2_TK_CIV_EP1_DZE",_Ratio3],
	["LadaLM_DZE",_Ratio3],
	["Jeep_DZE",_Ratio3],
	["LandRover_CZ_EP1_DZE",_Ratio3],
	["LandRover_MG_TK_EP1_DZE",_Ratio1],
	["LandRover_Special_CZ_EP1_DZE",_Ratio1],
	["LandRover_TK_CIV_EP1_DZE",_Ratio3],
	["M1030_US_DES_EP1_DZE",_Ratio3],
	["MH6J_DZ",_Ratio3],
	["Mi17_Civilian_DZ",_Ratio1],
	["Mi17_DZE",_Ratio1],
	["MMT_Civ_DZE",(_Ratio3 * 2)],
	["MtvrRefuel_DES_EP1_DZ",_Ratio1],
	["MTVR_DES_EP1_DZE",_Ratio3],
	["MTVR_DZE",_Ratio3],
	["MTVR_Open_DZE",_Ratio3],
	["MV22_DZ",_Ratio1],
	["Offroad_DSHKM_Gue_DZE",_Ratio3],
	["Old_moto_TK_Civ_EP1_DZE",_Ratio3],
	["Pickup_PK_GUE_DZE",_Ratio3],
	["Pickup_PK_INS_DZE",_Ratio3],
	["Pickup_PK_TK_GUE_EP1_DZE",_Ratio3],
	["S1203_ambulance_EP1_DZE",_Ratio3],
	["S1203_TK_CIV_EP1_DZE",_Ratio3],
	["Skoda_DZE",_Ratio3],
	["SkodaBlue_DZE",_Ratio3],
	["SkodaGreen_DZE",_Ratio3],
	["SkodaRed_DZE",_Ratio3],
	["SUV_Blue",_Ratio1],
	["SUV_Camo",_Ratio1],
	["SUV_Charcoal",_Ratio1],
	["SUV_Green",_Ratio1],
	["SUV_Orange",_Ratio1],
	["SUV_Pink",_Ratio1],
	["SUV_Red",_Ratio1],
	["SUV_Silver",_Ratio1],
	["SUV_TK_CIV_EP1_DZE",_Ratio1],
	["SUV_White",_Ratio1],
	["SUV_Yellow",_Ratio1],
	["SUV_Blue_White",_Ratio1],
	["Tractor_DZE",_Ratio3],
	["TT650_Civ_DZE",_Ratio3],
	["TT650_Ins_DZE",_Ratio3],
	["TT650_TK_CIV_EP1_DZE",_Ratio3],
	["UAZ_CDF_DZE",_Ratio3],
	["UAZ_INS_DZE",_Ratio3],
	["UAZ_MG_TK_EP1_DZE",_Ratio3],
	["UAZ_RU_DZE",_Ratio3],
	["UAZ_Unarmed_TK_CIV_EP1_DZE",_Ratio3],
	["UAZ_Unarmed_TK_EP1_DZE",_Ratio3],
	["UAZ_Unarmed_UN_EP1_DZE",_Ratio3],
	["UH1H_DZE",_Ratio2],
	["UH1Y_DZE",_Ratio1],
	["UH60M_EP1_DZE",_Ratio1],
	["UralRefuel_TK_EP1_DZ",_Ratio1],
	["Ural_CDF_DZE",_Ratio3],
	["Ural_TK_CIV_EP1_DZE",_Ratio3],
	["Ural_UN_EP1_DZE",_Ratio3],
	["V3S_Open_TK_CIV_EP1_DZE",_Ratio3],
	["V3S_Open_TK_EP1_DZE",_Ratio3],
	["V3S_Camper_DZE",_Ratio3],
	["V3S_Refuel_TK_GUE_EP1_DZ",_Ratio1],
	["V3S_RA_TK_GUE_EP1_DZE",_Ratio1],
	["VolhaLimo_TK_CIV_EP1_DZE",_Ratio3],
	["Volha_1_TK_CIV_EP1_DZE",_Ratio3],
	["Volha_2_TK_CIV_EP1_DZE",_Ratio3],
	["VWGolf_DZE",_Ratio3],
	["Mini_Cooper_DZE",_Ratio3],
	["ScrapAPC_DZE",_Ratio3],
	["ATV_CIV_CP_DZE",_Ratio1],
	["ATV_CIV_Grey_CP_DZE",_Ratio1],
	["ATV_CIV_Red_CP_DZE",_Ratio1],
	["ATV_CIV_Green_CP_DZE",_Ratio1],
	["ATV_CIV_Blue_CP_DZE",_Ratio1],
	["ATV_CIV_Yellow_CP_DZE",_Ratio1],
	["ATV_CIV_Purple_CP_DZE",_Ratio1],
	["ATV_CIV_Black_CP_DZE",_Ratio1],
	["Ikarus_White_DZE",_Ratio1],
	["car_hatchback_red_DZE",_Ratio1],
	["datsun1_red_covered_DZE",_Ratio1],
	["datsun1_green_open_DZE",_Ratio1],
	["Octavia_ACR_DZE",_Ratio1],
	["T810A_ACR_DZE",_Ratio1],
	["T810A_ACR_DES_DZE",_Ratio1],
	["T810A_ACR_OPEN_DZE",_Ratio1],
	["T810A_ACR_DES_OPEN_DZE",_Ratio1],
	["T810A_ACR_REFUEL_DZE",_Ratio1],
	["T810A_ACR_REFUEL_DES_DZE",_Ratio1],
	["T810_ACR_REAMMO_DZE",_Ratio1],
	["T810_ACR_REAMMO_DES_DZE",_Ratio1],
	["T810_ACR_REPAIR_DZE",_Ratio1],
	["T810_ACR_REPAIR_DES_DZE",_Ratio1],
	["CH_47F_EP1_Black_DZE",_Ratio1],
	["CH_47F_EP1_GREY_DZE",_Ratio1],
	["CH_47F_EP1_DES_DZE",_Ratio1],
	["UH1H_2_DZE",_Ratio1],
	["UH1H_CDF_DZE",_Ratio1],
	["UH1H_WD_DZE",_Ratio1],
	["UH1H_DES_DZE",_Ratio1],
	["UH1H_GREY_DZE",_Ratio1],
	["UH1H_BLACK_DZE",_Ratio1],
	["UH1H_SAR_DZE",_Ratio1],
	["Mi17_TK_EP1_DZE",_Ratio1],
	["Mi17_UN_CDF_EP1_DZE",_Ratio1],
	["Mi17_CDF_DZE",_Ratio1],
	["Mi171Sh_CZ_EP1_DZE",_Ratio1],
	["Mi17_DES_DZE",_Ratio1],
	["Mi17_GREEN_DZE",_Ratio1],
	["Mi17_BLUE_DZE",_Ratio1],
	["Mi17_BLACK_DZE",_Ratio1],
	["Mi17_GREEN_DZE",_Ratio1],
	["Mi17_medevac_CDF_DZ",_Ratio1],
	["Mi17_medevac_Ins_DZ",_Ratio1],
	["Mi17_medevac_RU_DZ",_Ratio1],
	["pook_medevac_DZE",_Ratio1],
	["pook_medevac_CDF_DZE",_Ratio1],
	["pook_medevac_CIV_DZE",_Ratio1],
	["pook_gunship_DZE",_Ratio1],
	["pook_gunship_CDF_DZE",_Ratio1],
	["pook_transport_DZE",_Ratio1],
	["pook_transport_CDF_DZE",_Ratio1],
	["pook_H13_civ_DZE",_Ratio1],
	["pook_H13_civ_white_DZE",_Ratio1],
	["pook_H13_civ_slate_DZE",_Ratio1],
	["pook_H13_civ_black_DZE",_Ratio1],
	["pook_H13_civ_yellow_DZE",_Ratio1],
	["MH60S_DZE",_Ratio1],
	["UH60M_MEV_EP1_DZ",_Ratio1],
	["BAF_Merlin_DZE",_Ratio1],
	["Ka60_GL_PMC_DZE",_Ratio1],
	["AW159_Lynx_BAF_DZE",_Ratio1],
	["BTR40_MG_TK_GUE_EP1_DZE",_Ratio1],
	["BTR40_MG_TK_INS_EP1_DZE",_Ratio1],
	["BRDM2_HQ_TK_GUE_EP1_DZE",_Ratio1],
	["HMMWV_Armored_DZE",_Ratio1],
	["HMMWV_M2_DZE",_Ratio1],
	["T810A_PKT_ACR_DZE",_Ratio1],
	["T810A_PKT_DES_ACR_DZE",_Ratio1],
	["BAF_Jackal2_L2A1_D_DZE",_Ratio1],
	["BAF_Jackal2_L2A1_W_DZE",_Ratio1],
	["BAF_Jackal2_GMG_D_DZE",_Ratio1],
	["BAF_Jackal2_GMG_W_DZE",_Ratio1],
	["Hummer_DZE",_Ratio1],
	["Tractor_Armored_DZE",_Ratio1],
	["Ikarus_Armored_DZE",_Ratio1]
];

// There are no good spawn locations for C130 on Namalsk or Caribou Frontier.
if !(toLower worldName in ["namalsk","caribou"]) then {
	AllowedVehiclesList set [count AllowedVehiclesList, ["C130J_US_EP1_DZ",_Ratio1]];
};

if (toLower worldName in ["caribou","chernarus","cmr_ovaron","dayznogova","dingor","dzhg","fallujah","fapovo","fdf_isle1_a","isladuala","lingor","mbg_celle2","namalsk","napf","oring","panthera2","ruegen","sara","sauerland","smd_sahrani_a2","tasmania2010","tavi","trinity","utes"]) then {
	// water map, add boats

	AllowedVehiclesList = AllowedVehiclesList + [
		// ["Fishing_Boat_DZE",_Ratio3],
		// ["JetSkiYanahui_Case_Blue",_Ratio1],
		// ["JetSkiYanahui_Case_Green",_Ratio1],
		// ["JetSkiYanahui_Case_Red",_Ratio1],
		// ["JetSkiYanahui_Case_Yellow",_Ratio1],
		// ["PBX_DZE",_Ratio3],
		// ["RHIB_DZE",_Ratio1],
		// ["RHIB2Turret_DZE",_Ratio1],
		// ["Smallboat_1_DZE",_Ratio3],
		// ["Smallboat_2_DZE",_Ratio3],
		// ["Zodiac_DZE",_Ratio3],
		// ["Submarine_DZE",_Ratio3]
	];
};

DZE_Hangar_positions = [];
DZE_Runway_Positions = [];

// Runway and hangar positions for plane spawning
call {
	if (toLower worldName in ["chernarus","chernarus_winter"]) exitWith {
		DZE_Hangar_positions = [[[4974.1201, 10012.304],240],[[4948.4419, 10055.036],240],[[4927.4048, 10098.72],240],[[4874.5693, 10179.009],240],[[4848.5073, 10218.326],240],[[4899.5508, 10138.02],240],[[4526.0156, 10783.658],240],[[4587.6855, 10685.194],240],[[4796.3179, 2584.4021],210],[[4762.417, 2606.4893],210],[[12007.119, 12628.267],18.522324]];
		DZE_Runway_Positions = [[[4825.3115, 9606.0107],351.2749786],[[4962.5381, 9685.8887],308.361824],[[4244.3516, 10919.782],164.96837],[[4124.9233, 10850.859],122.84861],[[4498.4043, 10694.304],170.83557],[[4452.0508, 10799.156],293.729195],[[11794.814, 12848.633],132.00909],[[12433.607, 12511.798],322],[[4644.8433, 2578.2515],138.79065],[[4598.5522, 2492.5886],80.181107],[[5262.187, 2244.1062],270]];
	};
	if (toLower worldName == "napf") exitWith {
		DZE_Hangar_positions = [[[18302.373, 2296.6174],128.92664],[[18219.572, 2201.1204],131.85796],[[18163.936, 2138.0906],130.08537],[[5012.1724, 4871.896],260.887802],[[4651.1582, 4806.9653],77.901695],[[4782.9136, 4831.3003],260.053566],[[14391.086, 16890.748],139.26932],[[14482.736, 16787.213],317.649258]];
		DZE_Runway_Positions = [[[14339.543, 17166.994],138.43173],[[14254.993, 17096.977],78.634995],[[14742.884, 16617.965],135.36357],[[15147.044, 16147.293],345.509653],[[18139.805, 1965.5642],39.729259],[[3902.3901, 4476.9971],79.775864],[[3876.8308, 4604.3208],128.58391],[[3930.5286, 4311.0532],16.60323],[[3888.5801, 4372.7026],51.806969],[[5208.6802, 4621.9556],286.741859]];
	};
	if (toLower worldName == "panthera2") exitWith {
		DZE_Hangar_positions = [[[1949.4359, 3594.7795],180],[[793.6474, 9659.5859],270],[[740.60645, 9729.6523],180],[[4215.5635, 7454.7695],0],[[4141.9292, 7458.936],0]];
		DZE_Runway_Positions = [[[1906.2429, 3540.8784],180],[[1863.5885, 3541.5037],180],[[2119.3586, 3533.1587],90],[[2356.3647, 3533.0906],90],[[2610.7517, 3528.6604],180],[[2208.2322, 3389.563],0],[[2162.8445, 3388.5747],0],[[728.3725, 9558.4209],270],[[690.87726, 9716.6924],233],[[690.87726, 9716.6924],270],[[742.43134, 9412.1094],270],[[742.31244, 9453.2158],270],[[746.93304, 9279.5293],270],[[684.96716, 8895.043],310],[[703.25922, 8938.5254],310],[[534.59473, 9684.0137],142],[[4847.2583, 7483.0718],0],[[4847.2583, 7483.0718],337],[[4926.7358, 7521.2285],300],[[4866.1216, 7679.3901],220],[[4783.2251, 7689.8706],191],[[4422.0762, 7677.5386],190],[[4259.5239, 7489.2754],0],[[4179.1602, 7478.1289],0],[[4052.2502, 7517.8276],30]];
	};
	if (toLower worldName in ["tavi","taviana"]) exitWith {
		DZE_Hangar_positions = [[[16779.148, 10230.397],270],[[16778.303, 10280.438],270],[[16780.025, 10330.855],270],[[16781.834, 10380.041],270],[[16780.201, 10430.32],270],[[16782.045, 10480.558],270],[[16774.957, 10530.657],270],[[16779.676, 10580.657],270],[[10351.289, 18383.271],244],[[10327.586, 18427.346],244],[[10305.973, 18472.592],244],[[10283.948, 18518.41],244],[[10258.651, 18567.479],244],[[10234.805, 18616.689],244],[[7779.6982, 7893.582],219],[[7746.2954, 7931.6772],220],[[7705.2095, 7963.9487],220],[[7666.1587, 7995.0244],220],[[7628.3447, 8026.1821],220],[[7588.1636, 8055.9268],220],[[7547.3433, 8089.1045],220],[[7507.02, 8118.4521],220]];
		DZE_Runway_Positions = [[[16653.684, 11617.686],180],[[16612.551, 11617.791],180],[[16570.965, 11617.984],180],[[16529.477, 11618.151],180],[[16366.49, 11397.132],119],[[16664.465, 11363.812],240],[[16666.48, 11312.685],240],[[16371.202, 10807.039],0],[[16363.222, 10648.133],0],[[16368.655, 11096.011],0],[[10595.511, 17683.322],244],[[10578.067, 17720],244],[[10560.043, 17756.557],244],[[10541.788, 17792.898],244],[[10317.844, 18244.363],155],[[10192.272, 18643.762],244],[[10175.395, 18680.395],244],[[10050.024, 18803.342],210],[[9991.7871, 18794.641],187],[[7792.293, 7816.6943],236],[[7572.9966, 7544.4141],39],[[7449.0269, 7597.1348],77],[[7408.0615, 7634.4272],77],[[7367.7822, 7673.5029],77],[[7073.5825, 7933.1563],308],[[6590.1455, 8270.4609],39],[[6827.6729, 8570.6074],215],[[6866.8408, 8542.7178],218],[[6935.6777, 8489.0615],218],[[6901.3486, 8515.8848],218],[[7120.8623, 8347.0342],218],[[7253.2144, 8233.7725],189],[[7344.647, 8161.6055],218],[[7381.7729, 8133.5376],218],[[7612.292, 7825.8555],270],[[7583.9072, 7875.2861],270]];
	};
	if (toLower worldName == "namalsk") exitWith {
		//DZE_Hangar_positions = []; // No hangars on Namalsk
		DZE_Runway_Positions = [[[6290.9497, 9623.7148],262],[[6292.8301, 9602.7422],267],[[6293.0767, 9582.04],269],[[6302.499, 9272.9336],283],[[6298.9512, 9304.6895],265],[[6296.9683, 9527.4414],265],[[6305.7607, 9235.8584],263],[[6305.5845, 9196.5742],258],[[6308.4282, 9171.084],272],[[6316.1602, 9120.333],289]];
	};
	if (toLower worldName == "lingor") exitWith {
		DZE_Hangar_positions = [[[4157.8389, 1733.3982],90],[[4159.2427, 1694.8923],90],[[6132.001, 6867.8154],0],[[6171.1382, 6866.2905],0],[[6551.5654, 6747.1553],0],[[6596.1216, 6745.4463],0]];
		DZE_Runway_Positions = [[[4210.1953, 1008.3441],60],[[4195.4409, 1051.4297],60],[[4344.1079, 1135.9297],275],[[4157.6406, 1367.108],90],[[4224.4678, 1908.2092],126],[[4205.958, 1865.4332],123],[[4171.7158, 1768.3271],90],[[4381.0615, 1797.5585],270],[[4378.8569, 1755.0103],270],[[4379.6816, 1577.699],270],[[4346.5088, 1201.3105],272],[[6843.6704, 6906.4585],0],[[6803.332, 6906.2168],0],[[6717.9673, 6906.7051],0],[[6676.981, 6907.2285],0],[[6444.7749, 6863.8208],0],[[6539.0391, 6910.8267],0],[[6093.625, 6887.2275],0],[[6027.8408, 6887.0762],0],[[5956.3789, 6938.2183],24],[[7010.3965, 6939.4941],0],[[3008.9871, 6429.1279],47],[[3098.365, 6597.5874],265],[[2989.0854, 6636.6699],87],[[2986.136, 6677.3818],85],[[2943.5073, 7171.521],112],[[2950.8511, 6930.5005],42]];
	};
	if (toLower worldName == "sauerland") exitWith {
		DZE_Hangar_positions = [[[15262.892, 18276.533],0],[[15226.063, 18277.277],0],[[15374.349, 18520.734],270],[[15380.229, 18557.535],270],[[15206.892, 18562.439],270],[[15204.131, 18525.342],270],[[15090.723, 18594.041],90],[[15093.469, 18631.123],90],[[15262.248, 18589.803],90],[[15261.465, 18626.906],90],[[17105.355, 1730.1416],0],[[17064.814, 1726.3314],0],[[16989.188, 1756.3535],0],[[16942.273, 1757.369],0]];
		DZE_Runway_Positions = [[[15359.572, 18635.889],236],[[15255.382, 18536.854],180],[[15595.105, 18334.383],321],[[15532.063, 18447.068],225],[[15487.508, 18335.965],330],[[15391.456, 18302.332],0],[[15173.691, 18314.725],0],[[15081.61, 18312.48],0],[[14944.665, 18320.264],0],[[14773.483, 18339.674],40],[[15091.576, 18540.818],184],[[15189.433, 18640.248],229],[[16782.379, 1774.917],0],[[17181.027, 1798.4741],320],[[17097.693, 1875.9081],180],[[16916.193, 1877.0327],229],[[16612.512, 1797.4282],0],[[16682.809, 1890.4918],181]];
	};
	if (toLower worldName == "fdf_isle1_a") exitWith { // Podagorsk
		DZE_Hangar_positions = [[[9788.2529, 4244.8711],184],[[9800.8926, 3881.4368],62],[[9663.9092, 4086.3181],90],[[8109.9312, 4661.8569],31],[[8163.625, 4629.3784],31],[[8370.3965, 4681.3882],110],[[8499.707, 4834.9629],249],[[8479.6836, 4881.9771],249],[[8464.2666, 4930.7236],249],[[8094.8618, 4197.229],270]];
		DZE_Runway_Positions = [[[8268.7236, 4562.5786],70],[[8306.2471, 4505.3193],138],[[8655.916, 4443.8525],252],[[8341.2051, 4915.9854],119],[[8529.582, 4736.3374],349.5],[[8601.5479, 4573.9819],218.5],[[9291.082, 4222.4561],0],[[9749.0908, 4031.1191],28.5],[[9647.9492, 4210.8892],44.6],[[9017.3711, 4345.874],202.5],[[8752.8799, 4343.0947],197.5],[[8559.9521, 4389.9805],30.7],[[8210.1367, 4376.4561],168],[[8467.5479, 4603.2041],203.7]];
	};
	if (toLower worldName == "takistan") exitWith {
		DZE_Hangar_positions = [[[8185.729, 2072.853],148],[[8144.0083, 2049.1345],149.5],[[5762.7642, 11248.219],315],[[5804.0205, 11293.321],315],[[5845.9746, 11334.919],315]];
		DZE_Runway_Positions = [[[8097.0645, 1971.9525],96],[[8037.8257, 1941.2324],197],[[7964.6133, 1903.0758],187],[[7847.5947, 1836.0383],208],[[7771.8823, 1784.0323],190],[[7731.0894, 1605.4257],60],[[8181.1729, 1752.5686],330],[[8222.8252, 1776.8198],330],[[8263.2832, 1800.2097],330],[[5944.2656, 11488.032],9],[[6044.8335, 11584.635],0],[[6105.9688, 11646.589],0],[[6139.2588, 11787.021],250],[[5978.5229, 11787.973],187],[[5878.377, 11707.521],134],[[5916.1074, 11746.493],134],[[5840.6494, 11669.358],134],[[5627.48, 11151.527],270],[[5333.2065, 10913.021],320],[[5417.6602, 10938.269],300],[[5480.7227, 11000.981],311],[[5542.3745, 11066.867],317]];
	};
	if (toLower worldName == "caribou") exitWith {
		DZE_Hangar_positions = [[[1931.1724, 3222.0276],231]];
		DZE_Runway_Positions = [[[1907.5873, 3248.3806],242],[[1897.8859, 3266.9893],242],[[1804.6925, 3462.7156],87],[[1874.5695, 3857.1729],211],[[1825.8583, 3931.4707],146],[[1747.6074, 3627.5881],90],[[1876.1652, 3567.8455],270],[[1876.1274, 3546.8982],270],[[1876.2861, 3524.1584],270],[[1874.3091, 3470.6697],270],[[1798.4554, 3059.9192],27],[[1884.0266, 3146.2952],321],[[1871.2059, 3344.2656],270],[[1872.6899, 3398.9255],270],[[1873.6082, 3439.7576],270]];
	};
	if (toLower worldName == "cmr_ovaron") exitWith {
		DZE_Hangar_positions = [[[484.29846, 7396.8892],88.6],[[484.28625, 7430.1152],88.6],[[508.64578, 7556.8716],124],[[9758.9688, 2844.075],270],[[9759.8779, 2809.9143],270],[[9734.4736, 2680.5979],303.4]];
		DZE_Runway_Positions = [[[641.89874, 7583.2739],270],[[660.71973, 7531.5244],270],[[706.20728, 7412.0298],270],[[663.34924, 7095.9355],270],[[664.23773, 7054.3511],270],[[641.50488, 6885.5479],270],[[658.19489, 6995.0098],242],[[649.28943, 6940.707],242],[[668.6698, 7450.6777],226],[[531.98523, 7361.5596],61],[[536.2215, 7492.4556],90],[[9597.3701, 2655.803],87],[[9571.1973, 2795.7207],73],[[9546.9268, 2840.2507],73],[[9573.9385, 2940.2646],73],[[9580.2891, 3156.8792],87],[[9581.7305, 3248.5847],87],[[9593.2344, 3355.6165],90],[[9717.9961, 2879.8501],240],[[9701.8115, 2755.5862],270]];
	};
	if (toLower worldName == "isladuala") exitWith {
		DZE_Hangar_positions = [[[4206.3638, 2137.2808],0],[[4125.5474, 2134.4885],0],[[5952.8066, 6126.1646],0],[[5856.9976, 6154.4399],0],[[5825.5732, 6149.5454],0]];
		DZE_Runway_Positions = [[[4056.5996, 2155.8013],0],[[4092.5444, 2323.322],181],[[4167.5967, 2154.3792],0],[[4251.6528, 2168.9683],0],[[4363.4614, 2159.783],0],[[4419.4434, 2159.2407],0],[[4551.4912, 2157.761],0],[[5082.5586, 2174.3755],0],[[5029.6553, 2174.2185],0],[[4974.084, 2174.7053],0],[[4928.833, 2174.7107],0],[[4881.8442, 2174.7852],0],[[4835.6523, 2175.2559],0],[[4507.2793, 2348.5867],174],[[4551.2729, 2350.7454],180],[[4606.3218, 2351.1897],180],[[4678.4517, 2343.6565],180],[[4732.3481, 2345.4229],177],[[4808.1777, 2350.335],180],[[7134.8789, 2308.7634],77],[[7180.7354, 2194.2275],38],[[7151.7651, 2250.1301],77],[[6806.7422, 6186.7549],0],[[6756.6646, 6186.2607],0],[[6710.748, 6186.0947],0],[[6652.3911, 6187.0112],0],[[6588.5942, 6184.8599],0],[[6016.4927, 6179.5308],0],[[6071.5977, 6177.2432],0],[[6145.7241, 6173.9126],0],[[5759.4888, 6167.3564],0],[[5785.1899, 6347.1733],180],[[5885.7339, 6345.1587],185],[[2934.3931, 6180.5464],110],[[2954.2786, 6238.8765],110],[[3036.1111, 6584.4858],110],[[3106.0913, 6337.4688],294],[[2901.9998, 6026.458],100]];
	};
	if (toLower worldName == "smd_sahrani_a2") exitWith {
		DZE_Hangar_positions = [[[9838.8105, 9948.7129],0],[[9804.4814, 9949.8838],0],[[9767.9063, 9960.3486],0],[[19221.193, 13884.556],42.5],[[19196.141, 13909.83],42.5]];
		DZE_Runway_Positions = [[[18968.033, 14320.386],223],[[19008.047, 14295.18],223],[[19046.576, 14255.652],223],[[19122.35, 14216.478],223],[[19187.141, 14165.009],223],[[19225.107, 14119.406],223],[[19306.145, 14021.929],223],[[19273.789, 14078.427],223],[[19017.391, 14124.187],76],[[9627.5947, 9961.833],0],[[9565.3711, 9952.9395],0],[[9495.8574, 9957.5947],0],[[9441.2363, 9959.6631],0],[[9330.1396, 9982.6484],0],[[9250.7705, 10024.167],0],[[9261.8711, 10211.065],180],[[9311.2334, 10200.271],180],[[9674.8145, 10203.702],180],[[9749.0088, 10211.506],180],[[9816.8672, 10206.438],180],[[10162.383, 10202.894],180],[[10229.846, 9974.875],0],[[10178.965, 9975.7041],0],[[10025.214, 9955.583],10],[[10110.359, 9975.7979],353],[[10213.082, 10205.972],180]];
	};
	if (toLower worldName == "ruegen") exitWith {
		DZE_Hangar_positions = [[[5152.5142, 21600.607],148.90527],[[5018.2661, 21518.488],148.90527],[[4951.4629, 21472.211],148.90527]];
		DZE_Runway_Positions = [[[5241.4678, 21601.275],148],[[5115.0171, 21508.145],146],[[5009.5713, 21455.387],146],[[4884.1641, 21360.277],146],[[4762.4004, 21271.303],146],[[4702.1157, 21237.779],146],[[4657.9302, 21203.23],146],[[4836.416, 20986.725],356],[[5205.2969, 21224.213],324],[[5259.4844, 21255.742],324],[[5323.1025, 21302.303],324],[[5495.7344, 21422.35],324],[[5664.5303, 21546.35],324],[[5584.3071, 21722.311],145],[[5358.6919, 21663.223],145],[[5630.3857, 21754.127],145]];
	};
};

DZE_AllAircraftPositions = DZE_Hangar_positions + DZE_Runway_Positions;
