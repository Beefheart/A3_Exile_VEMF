/*
   	Author: IT07

   	Description:
   	hpp config file for Vampire's Exile Mission Framework (a.k.a. VEMF)

	Little back story:
	VEMF is originally made by Vampire (for Epoch) but he kind of gave up on the project.
	Now, I (IT07) am carrying on with the project and I have now made it for Exile too.
	Please keep in mind that some of VEMF's code is still left-over from before I took over VEMF.
	Want to report an issue? Then either PM me on the Exilemod.com forums or reply to the VEMF forum post.
	Do you like and appreciate my work? Please leave a like or a nice comment for me on the forums :)
*/

class VEMFconfig
{
	/////////////////////////////
	VEMF_version = 1.0718.11; /// Do NOT change
	/////////////////////////////
	/////// Configure VEMF here ///////
	// Global settings
	allowHeadLessClient = -1; // HC support is currently broken // Set to 1 if you have (a) headless client(s) | -1 = DISABLED
	minServerFPS = 20; // Missions will not spawn if server's FPS is below this number
	validateLoot = 1; // Use -1 to disable. Checks if defined classes in loot and ai gear (except blacklist) are valid. Will output test result to RPT if ERROR logs enabled
	minPlayers = 1; // Missions will not start until player count reaches this number OR when player count goes below this amount
	maxGlobalMissions = 5; // Max amount of missions that are allowed to run at the same time
 	timeOutTime = 20; // In minutes. Use -1 to disable mission timeout; Minimal: 5
	minNew = 1; // Minimum time before new mission can run
	maxNew = 2; // Maximum time before new mission can run
	missionList[] = {"DynamicLocationInvasion"}; // Speaks for itself, right?
	addons[] = {}; // Not used for now
	noMissionPos[] = {}; // Works | Format: {{position},radius}
	locationBlackList[] = {"Sagonisi","Monisi","Fournos","Savri","Atsalis","Polemista","Cap Makrinos","Pyrgi","Makrynisi","Chelonisi","Almyra","Surf Club"};  // Works
	killPercentage = 100; // In percent. 100 means all AI that belong to mission need to be killed
	sayKilled = 1; // Set to -1 if you do not want AI killed messages
	allowSmall = 1; // Set to -1 if you do not want missions to target very small unusual locations
	removeLaunchers = 1; // Set to -1 if you do not want the launchers to be removed from AI's body when killed
	removeAIbodies = -1; // Set to -1 if you want the AI's body to stay after they are killed

	/////// Debugging/learning mode ///////
	enableDebug = 2; // -1 to disable, 0 = ERRORS only | 1 = INFO only | 2 = ERRORS & INFO
	///////////////////////////////////////

	// Global AI skill settings. They affect each VEMF unit for any default VEMF mission
	class aiSkill // Minimum: 0 | Maximum: 1
	{
		difficulty = "Veteran"; // Options: "Easy" "Normal" "Veteran" "Hardcore" | Default: Veteran
		class Easy // AI looks stupid with this setting xD
		{
			accuracy = 0.1;
			aimingShake = 0.25;
			aimingSpeed = 0.075;
			endurance = 0.15;
			spotDistance = 0.3;
			spotTime = 0.1;
			courage = 0.35;
			reloadSpeed = 0.1;
			commanding = 0.3;
			general = 0.15;
		};
		class Normal
		{
			accuracy = 0.15;
			aimingShake = 0.2;
			aimingSpeed = 0.1;
			endurance = 0.2;
			spotDistance = 0.4;
			spotTime = 0.15;
			courage = 0.5;
			reloadSpeed = 0.15;
			commanding = 0.4;
			general = 0.15;
		};
		class Veteran
		{
			accuracy = 0.2;
			aimingShake = 0.25;
			aimingSpeed = 0.15;
			endurance = 0.25;
			spotDistance = 0.5;
			spotTime = 0.2;
			courage = 0.7;
			reloadSpeed = 0.15;
			commanding = 0.5;
			general = 0.15;
		};
		class Hardcore // Also known as Aimbots
		{
			accuracy = 0.3;
			aimingShake = 0.3;
			aimingSpeed = 0.2;
			endurance = 0.5;
			spotDistance = 0.7;
			spotTime = 0.25;
			courage = 1;
			reloadSpeed = 0.3;
			commanding = 0.8;
			general = 0.2;
		};
	};

	class DLI // DynamicLocationInvasion settings
	{
		maxInvasions = 5; // Max amount of active uncompleted invasions allowed at the same time
		groupCount = 3; // Amount of groups that spawn at location
		groupUnits = 4; // Amount of units in each group
		/* TIP: increase groupCount and decrease groupUnits to make it harder for players. Easier to get flanked from all sides */
		useLaunchers = 1; // Set to 0 if you do NOT want the AI to have launchers
		remLaunchers = 1; // Set to 0 if you do NOT want the launcher (and its ammo) to be removed from AI when they die
		hasLauncherChance = 25; // In percentage. How big the chance is that a unit gets a launcher
		playerCheck = 650; // If player(s) within this range of location, location gets skipped. Distance in m (meters)
		distanceCheck = 15000; // Check for locations around random player within this distance in m (meters)
		/* distanceCheck NOTE: set it to the minimal distance between ANY town on the map you are using. Otherwise location selection will fail */
		distanceTooClose = 2500; // Mission will not spawn closer to random player than this distance in meters
		distanceMaxPrefered = 4500; // Mission will prefer locations closer than this distance (in meters) to random player
		crateAltitude = 200; // Crate with parachute will spawn at this altitude (meters)
		crateSound = 1; // Use -1 to disable the crate from emitting a sound. 1 makes it easier for players to find the crate
			crateSoundDuration = 120; // How many times with an interval of 2 seconds should the crate emit sound
		crateTypes[] = {"I_CargoNet_01_ammo_F","O_CargoNet_01_ammo_F","B_CargoNet_01_ammo_F","I_supplyCrate_F","Box_East_AmmoVeh_F","Box_NATO_AmmoVeh_F"};
		smokeTypes[] = {"SmokeShell","SmokeShellBlue","SmokeShellGreen","SmokeShellOrange","SmokeShellRed","SmokeShellYellow"};
		flairTypes[] = {"Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue"};
		placeMines = 1; // Set to -1 if you do not want Anti-Armor mines at missions | using infiSTAR? set _RAM to false
		minesMode = 1; // 1 = Anti-Armor | 2 = Anti-Personell | 3 = Both Anti-Armor and Anti-Personell
		minesAmount = 40; // Ignore if placeMines = -1;
		cleanMines = 1; // 1 = remove mines when mission done | 2 = explode mines when mission done :D guarenteed chaos, LOL!
	};

	// Loot crate configuration
	class crateLoot
	{
		maxPrimarySlots = 10; // Maximum primary weapons in each loot crate
		minPrimarySlots = 4; // Minimum primary weapons in each loot crate
		primaryWeaponLoot[] =
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DOTS!!!
			{"srifle_DMR_01_F",2},{"srifle_EBR_F",3},{"srifle_GM6_F",1},{"LMG_Mk200_F",3},{"LMG_Zafir_F",3},{"arifle_Katiba_F",3},{"arifle_Katiba_GL_F",2},{"arifle_Mk20_F",2},
			{"arifle_Mk20_plain_F",2},{"arifle_Mk20C_F",2},{"arifle_Mk20C_plain_F",2},{"arifle_Mk20_GL_F",2},{"arifle_Mk20_GL_plain_F",2},{"arifle_MXC_F",2},{"arifle_MX_F",2},
			{"arifle_MX_GL_F",2},{"arifle_MX_SW_F",2},{"arifle_MXM_F",2},{"arifle_MXC_Black_F",2},{"arifle_MX_Black_F",2},{"arifle_MX_GL_Black_F",2},{"arifle_MX_SW_Black_F",2},
			{"arifle_MXM_Black_F",2},{"arifle_SDAR_F",2},{"arifle_TRG21_F",2},{"arifle_TRG20_F",2},{"arifle_TRG21_GL_F",2},{"SMG_01_F",2},{"SMG_02_F",2},{"srifle_GM6_camo_F",2},
			{"srifle_LRR_camo_F",2},{"srifle_DMR_02_F",2},{"srifle_DMR_02_camo_F",2},{"srifle_DMR_02_sniper_F",2},{"srifle_DMR_03_F",2},{"srifle_DMR_03_khaki_F",2},{"srifle_DMR_03_tan_F",2},
			{"srifle_DMR_03_multicam_F",2},{"srifle_DMR_03_woodland_F",2},{"srifle_DMR_04_F",2},{"srifle_DMR_04_Tan_F",2},{"srifle_DMR_05_blk_F",2},{"srifle_DMR_05_hex_F",2},{"srifle_DMR_05_tan_f",2},{"srifle_DMR_06_camo_F",2},{"srifle_DMR_06_olive_F",2},{"MMG_01_hex_F",2},{"MMG_01_tan_F",2},{"MMG_02_camo_F",2},
			{"MMG_02_black_F",2},{"MMG_02_sand_F",2}
		};

		maxSecondarySlots = 4; // Maximum number of secondary weapons to be in each loot crate
		minSecondarySlots = 2; // Minimum number of secondary weapons to be in each loot crate
		secondaryWeaponLoot[] =
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DOTS!!!
			{"hgun_ACPC2_F",3},{"hgun_P07_F",3},{"hgun_Pistol_heavy_01_F",3},{"hgun_Pistol_heavy_02_F",3},{"hgun_Rook40_F",3}
		};

		maxMagSlots = 6; // Maximum number of magazine slots in each loot crate
		minMagSlots = 4; // Minimum number of magazine slots in each loot crate
		magazinesLoot[] =
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DOTS!!!
			{"30Rnd_556x45_Stanag",20},{"30Rnd_556x45_Stanag_Tracer_Red",20},{"30Rnd_556x45_Stanag_Tracer_Green",20},
			{"30Rnd_556x45_Stanag_Tracer_Yellow",20},{"30Rnd_65x39_caseless_mag",20},{"30Rnd_65x39_caseless_green",20},{"30Rnd_65x39_caseless_mag_Tracer",20},
			{"30Rnd_65x39_caseless_green_mag_Tracer",20},{"20Rnd_762x51_Mag",20},{"7Rnd_408_Mag",20},{"5Rnd_127x108_Mag",20},{"100Rnd_65x39_caseless_mag",20},
			{"100Rnd_65x39_caseless_mag_Tracer",20},{"200Rnd_65x39_cased_Box",20},{"200Rnd_65x39_cased_Box_Tracer",20},{"30Rnd_9x21_Mag",20},{"16Rnd_9x21_Mag",20},
			{"30Rnd_45ACP_Mag_SMG_01",20},{"30Rnd_45ACP_Mag_SMG_01_Tracer_Green",20},{"9Rnd_45ACP_Mag",20},{"150Rnd_762x51_Box",20},{"150Rnd_762x51_Box_Tracer",20},
			{"150Rnd_762x54_Box",20},{"150Rnd_762x54_Box_Tracer",20},{"11Rnd_45ACP_Mag",20},{"6Rnd_45ACP_Cylinder",20},{"10Rnd_762x51_Mag",20},{"10Rnd_762x54_Mag",20},
			{"5Rnd_127x108_APDS_Mag",20},{"10Rnd_338_Mag",20},{"130Rnd_338_Mag",20},{"10Rnd_127x54_Mag",20},{"150Rnd_93x64_Mag",20},{"10Rnd_93x64_DMR_05_Mag",20}
		};

		maxAttSlots = 4; // Maximum number of attachment slots in each loot crate
		minAttSlots = 2; // Minimum number of attachment slots in each loot crate
		attachmentsLoot[] =
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DOTS!!!
			{"ItemGPS",5},{"ItemRadio",4},{"ItemMap",6},{"MineDetector",1},{"Binocular",4},{"Rangefinder",2},{"Medikit",3},{"ToolKit",1},
			{"muzzle_snds_H",2},{"muzzle_snds_L",2},{"muzzle_snds_M",2},{"muzzle_snds_B",2},{"muzzle_snds_H_MG",2},{"muzzle_snds_H_SW",2},
			{"optic_Arco",3},{"optic_Aco",3},{"optic_ACO_grn",3},{"optic_Aco_smg",3},{"optic_ACO_grn_smg",3},{"optic_Holosight",3},
			{"optic_Holosight_smg",3},{"optic_SOS",3},{"acc_flashlight",3},{"acc_pointer_IR",3},{"optic_MRCO",3},{"muzzle_snds_acp",3},
			{"optic_NVS",3},{"optic_DMS",3},{"optic_Yorris",2},{"optic_MRD",2},{"optic_LRPS",3},{"muzzle_snds_338_black",3},{"muzzle_snds_338_green",3},
			{"muzzle_snds_338_sand",3},{"muzzle_snds_93mmg",3},{"muzzle_snds_93mmg_tan",3},{"optic_AMS",3},{"optic_AMS_khk",3},{"bipod_03_F_oli",3},
			{"optic_AMS_snd",3},{"optic_KHS_blk",3},{"optic_KHS_hex",3},{"optic_KHS_old",3},{"optic_KHS_tan",3},{"bipod_01_F_snd",3},
			{"bipod_01_F_blk",3},{"bipod_01_F_mtp",3},{"bipod_02_F_blk",3},{"bipod_02_F_tan",3},{"bipod_02_F_hex",3},{"bipod_03_F_blk",3}
		};

		maxItemSlots = 4; // Maximum number of attachment slots in each loot crate
		minItemSlots = 2; // Minimum number of attachment slots in each loot crate
		itemsLoot[] =
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DOTS!!!
			{"Exile_Item_Flag",3},{"Exile_Item_FuelCanisterFull",2},{"Exile_Item_FuelCanisterEmpty",1},{"Exile_Item_InstaDoc",4},{"Exile_Item_Matches",3},{"Exile_Item_PlasticBottleFreshWater",5}
		};

		maxVestSlots = 4; // Maximum number of vest slots in each loot crate
		minVestSlots = 2; // Minimum number of vest slots in each loot crate
		vestsLoot[] = // NOTE ABOUT VESTS: it is recommended to keep amount for each vest at 1 because vests do not stack unlike weapons, items and magazines
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DOTS!!!
			{"V_PlateCarrier1_rgr",1},{"V_PlateCarrier2_rgr",1},{"V_PlateCarrier3_rgr",1},{"V_PlateCarrierGL_rgr",1},{"V_PlateCarrier1_blk",1},
			{"V_PlateCarrierSpec_rgr",1},{"V_Chestrig_khk",1},{"V_Chestrig_rgr",1},{"V_Chestrig_blk",1},{"V_Chestrig_oli",1},{"V_TacVest_khk",1},
			{"V_TacVest_brn",1},{"V_TacVest_oli",1},{"V_TacVest_blk",1},{"V_TacVest_camo",1},{"V_TacVest_blk_POLICE",1},{"V_TacVestIR_blk",1},{"V_TacVestCamo_khk",1},
			{"V_HarnessO_brn",1},{"V_HarnessOGL_brn",1},{"V_HarnessO_gry",1},{"V_HarnessOGL_gry",1},{"V_HarnessOSpec_brn",1},{"V_HarnessOSpec_gry",1},
			{"V_PlateCarrierIA1_dgtl",1},{"V_PlateCarrierIA2_dgtl",1},{"V_PlateCarrierIAGL_dgtl",1},{"V_RebreatherB",1},{"V_RebreatherIR",1},{"V_RebreatherIA",1},
			{"V_PlateCarrier_Kerry",1},{"V_PlateCarrierL_CTRG",1},{"V_PlateCarrierH_CTRG",1},{"V_I_G_resistanceLeader_F",1},{"V_Press_F",1}
		};

		maxHeadGearSlots = 4; // Maximum number of headGear slots in each loot crate
		minHeadGearSlots = 2; // Minimum number of headGear slots in each loot crate
		headGearLoot[] = // NOTE ABOUT HEADGEAR: it is recommended to keep amount for each headGear item at 1 because headGear items do not stack unlike weapons, items and magazines
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DOTS!!!
			{"H_HelmetB",1},{"H_HelmetB_camo",1},{"H_HelmetB_paint",1},{"H_HelmetB_light",1},{"H_Booniehat_khk",1},{"H_Booniehat_oli",1},{"H_Booniehat_indp",1},
			{"H_Booniehat_mcamo",1},{"H_Booniehat_grn",1},{"H_Booniehat_tan",1},{"H_Booniehat_dirty",1},{"H_Booniehat_dgtl",1},{"H_Booniehat_khk_hs",1},{"H_HelmetB_plain_mcamo",1},
			{"H_HelmetB_plain_blk",1},{"H_HelmetSpecB",1},{"H_HelmetSpecB_paint1",1},{"H_HelmetSpecB_paint2",1},{"H_HelmetSpecB_blk",1},{"H_HelmetIA",1},{"H_HelmetIA_net",1},
			{"H_HelmetIA_camo",1},{"H_Helmet_Kerry",1},{"H_HelmetB_grass",1},{"H_HelmetB_snakeskin",1},{"H_HelmetB_desert",1},{"H_HelmetB_black",1},{"H_HelmetB_sand",1},
			{"H_Cap_red",1},{"H_Cap_blu",1},{"H_Cap_oli",1},{"H_Cap_headphones",1},{"H_Cap_tan",1},{"H_Cap_blk",1},{"H_Cap_blk_CMMG",1},{"H_Cap_brn_SPECOPS",1},{"H_Cap_tan_specops_US",1},
			{"H_Cap_khaki_specops_UK",1},{"H_Cap_grn",1},{"H_Cap_grn_BI",1},{"H_Cap_blk_Raven",1},{"H_Cap_blk_ION",1},{"H_Cap_oli_hs",1},{"H_Cap_press",1},{"H_Cap_usblack",1},{"H_Cap_police",1},
			{"H_HelmetCrew_B",1},{"H_HelmetCrew_O",1},{"H_HelmetCrew_I",1},{"H_PilotHelmetFighter_B",1},{"H_PilotHelmetFighter_O",1},{"H_PilotHelmetFighter_I",1},
			{"H_PilotHelmetHeli_B",1},{"H_PilotHelmetHeli_O",1},{"H_PilotHelmetHeli_I",1},{"H_CrewHelmetHeli_B",1},{"H_CrewHelmetHeli_O",1},{"H_CrewHelmetHeli_I",1},{"H_HelmetO_ocamo",1},
			{"H_HelmetLeaderO_ocamo",1},{"H_MilCap_ocamo",1},{"H_MilCap_mcamo",1},{"H_MilCap_oucamo",1},{"H_MilCap_rucamo",1},{"H_MilCap_gry",1},{"H_MilCap_dgtl",1},
			{"H_MilCap_blue",1},{"H_HelmetB_light_grass",1},{"H_HelmetB_light_snakeskin",1},{"H_HelmetB_light_desert",1},{"H_HelmetB_light_black",1},{"H_HelmetB_light_sand",1},{"H_BandMask_blk",1},
			{"H_BandMask_khk",1},{"H_BandMask_reaper",1},{"H_BandMask_demon",1},{"H_HelmetO_oucamo",1},{"H_HelmetLeaderO_oucamo",1},{"H_HelmetSpecO_ocamo",1},{"H_HelmetSpecO_blk",1},
			{"H_Bandanna_surfer",1},{"H_Bandanna_khk",1},{"H_Bandanna_khk_hs",1},{"H_Bandanna_cbr",1},{"H_Bandanna_sgg",1},{"H_Bandanna_sand",1},{"H_Bandanna_surfer_blk",1},{"H_Bandanna_surfer_grn",1},
			{"H_Bandanna_gry",1},{"H_Bandanna_blu",1},{"H_Bandanna_camo",1},{"H_Bandanna_mcamo",1},{"H_Shemag_khk",1},{"H_Shemag_tan",1},{"H_Shemag_olive",1},{"H_Shemag_olive_hs",1},
			{"H_ShemagOpen_khk",1},{"H_ShemagOpen_tan",1},{"H_Beret_blk",1},{"H_Beret_blk_POLICE",1},{"H_Beret_red",1},{"H_Beret_grn",1},{"H_Beret_grn_SF",1},{"H_Beret_brn_SF",1},
			{"H_Beret_ocamo",1},{"H_Beret_02",1},{"H_Beret_Colonel",1},{"H_Watchcap_blk",1},{"H_Watchcap_cbr",1},{"H_Watchcap_khk",1},{"H_Watchcap_camo",1},{"H_Watchcap_sgg",1},
			{"H_TurbanO_blk",1},{"H_Cap_marshal",1}
		};

		maxBagSlots = 4;
		minBagSlots = 2;
		backpacksLoot[] = // NOTE ABOUT BACKPACKS: it is recommended to keep amount for each bag at 1 because bags do not stack unlike weapons, items and magazines
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DOTS!!!
			{"B_AssaultPack_khk",1},{"B_AssaultPack_dgtl",1},{"B_AssaultPack_rgr",1},{"B_AssaultPack_sgg",1},{"B_AssaultPack_cbr",1},
			{"B_AssaultPack_mcamo",1},{"B_TacticalPack_rgr",1},{"B_TacticalPack_mcamo",1},{"B_TacticalPack_ocamo",1},{"B_TacticalPack_blk",1},
			{"B_TacticalPack_oli",1},{"B_FieldPack_khk",1},{"B_FieldPack_ocamo",1},{"B_FieldPack_oucamo",1},{"B_FieldPack_cbr",1},
			{"B_FieldPack_blk",1},{"B_Carryall_ocamo",1},{"B_Carryall_oucamo",1},{"B_Carryall_mcamo",1},{"B_Carryall_khk",1},{"B_Carryall_cbr",1},
			{"B_Parachute",1},{"B_FieldPack_oli",1},{"B_Carryall_oli",1},{"B_Kitbag_Base",1},{"B_Kitbag_cbr",1},{"B_Kitbag_mcamo",1},
			{"B_Kitbag_rgr",1},{"B_Kitbag_sgg",1},{"B_OutdoorPack_Base",1},{"B_OutdoorPack_blk",1},{"B_OutdoorPack_blu",1},
			{"B_OutdoorPack_tan",1}
		};

		blackListLoot[] =
		{
			"DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","ATMine_Range_Mag","ClaymoreDirectionalMine_Remote_Mag",
			"APERSMine_Range_Mag","APERSBoundingMine_Range_Mag","SLAMDirectionalMine_Wire_Mag","APERSTripMine_Wire_Mag",
			"ChainSaw","srifle_DMR_03_spotter_F"
		};
		// End of loot crate configuration
	};
	class aiGear
	{
		// Configuration of what AI have
		aiHeadGear[] =
		{
			"H_HelmetB","H_HelmetB_camo","H_HelmetB_paint","H_HelmetB_light","H_Booniehat_khk","H_Booniehat_oli","H_Booniehat_indp",
			"H_Booniehat_mcamo","H_Booniehat_grn","H_Booniehat_tan","H_Booniehat_dirty","H_Booniehat_dgtl","H_Booniehat_khk_hs","H_HelmetB_plain_mcamo",
			"H_HelmetB_plain_blk","H_HelmetSpecB","H_HelmetSpecB_paint1","H_HelmetSpecB_paint2","H_HelmetSpecB_blk","H_HelmetIA","H_HelmetIA_net",
			"H_HelmetIA_camo","H_Helmet_Kerry","H_HelmetB_grass","H_HelmetB_snakeskin","H_HelmetB_desert","H_HelmetB_black","H_HelmetB_sand",
			"H_Cap_red","H_Cap_blu","H_Cap_oli","H_Cap_headphones","H_Cap_tan","H_Cap_blk","H_Cap_blk_CMMG","H_Cap_brn_SPECOPS","H_Cap_tan_specops_US",
			"H_Cap_khaki_specops_UK","H_Cap_grn","H_Cap_grn_BI","H_Cap_blk_Raven","H_Cap_blk_ION","H_Cap_oli_hs","H_Cap_press","H_Cap_usblack","H_Cap_police",
			"H_HelmetCrew_B","H_HelmetCrew_O","H_HelmetCrew_I","H_PilotHelmetFighter_B","H_PilotHelmetFighter_O","H_PilotHelmetFighter_I",
			"H_PilotHelmetHeli_B","H_PilotHelmetHeli_O","H_PilotHelmetHeli_I","H_CrewHelmetHeli_B","H_CrewHelmetHeli_O","H_CrewHelmetHeli_I","H_HelmetO_ocamo",
			"H_HelmetLeaderO_ocamo","H_MilCap_ocamo","H_MilCap_mcamo","H_MilCap_oucamo","H_MilCap_rucamo","H_MilCap_gry","H_MilCap_dgtl",
			"H_MilCap_blue","H_HelmetB_light_grass","H_HelmetB_light_snakeskin","H_HelmetB_light_desert","H_HelmetB_light_black","H_HelmetB_light_sand","H_BandMask_blk",
			"H_BandMask_khk","H_BandMask_reaper","H_BandMask_demon","H_HelmetO_oucamo","H_HelmetLeaderO_oucamo","H_HelmetSpecO_ocamo","H_HelmetSpecO_blk",
			"H_Bandanna_surfer","H_Bandanna_khk","H_Bandanna_khk_hs","H_Bandanna_cbr","H_Bandanna_sgg","H_Bandanna_sand","H_Bandanna_surfer_blk","H_Bandanna_surfer_grn",
			"H_Bandanna_gry","H_Bandanna_blu","H_Bandanna_camo","H_Bandanna_mcamo","H_Shemag_khk","H_Shemag_tan","H_Shemag_olive","H_Shemag_olive_hs",
			"H_ShemagOpen_khk","H_ShemagOpen_tan","H_Beret_blk","H_Beret_blk_POLICE","H_Beret_red","H_Beret_grn","H_Beret_grn_SF","H_Beret_brn_SF",
			"H_Beret_ocamo","H_Beret_02","H_Beret_Colonel","H_Watchcap_blk","H_Watchcap_cbr","H_Watchcap_khk","H_Watchcap_camo","H_Watchcap_sgg",
			"H_TurbanO_blk","H_Cap_marshal"
		};
		aiUniforms[] =
		{
			"U_I_CombatUniform","U_I_CombatUniform_tshirt","U_I_CombatUniform_shortsleeve","U_I_pilotCoveralls",
			"U_I_GhillieSuit","U_I_OfficerUniform","U_MillerBody","U_KerryBody","U_IG_Guerilla1_1","U_IG_Guerilla2_1",
			"U_IG_Guerilla2_2","U_IG_Guerilla2_3","U_IG_Guerilla3_1","U_IG_Guerilla3_2","U_IG_leader","U_BG_Guerilla1_1",
			"U_BG_Guerilla2_1","U_BG_Guerilla2_3","U_BG_Guerilla3_1","U_BG_Guerilla3_2","U_BG_leader","U_OG_Guerilla1_1",
			"U_OG_Guerilla2_1","U_OG_Guerilla2_2","U_OG_Guerilla2_3","U_OG_Guerilla3_1","U_OG_Guerilla3_2","U_OG_leader",
			"U_C_WorkerCoveralls","U_C_HunterBody_grn","U_C_HunterBody_brn","U_B_CTRG_1","U_B_CTRG_2","U_B_CTRG_3","U_B_survival_uniform",
			"U_I_G_Story_Protagonist_F","U_I_G_resistanceLeader_F","U_IG_Guerrilla_6_1","U_BG_Guerrilla_6_1","U_OG_Guerrilla_6_1",
			"U_B_FullGhillie_lsh","U_B_FullGhillie_sard","U_B_FullGhillie_ard","U_O_FullGhillie_lsh","U_O_FullGhillie_sard",
			"U_O_FullGhillie_ard","U_I_FullGhillie_lsh","U_I_FullGhillie_sard","U_I_FullGhillie_ard"
		};
		aiVests[] =
		{
			"V_PlateCarrier1_rgr","V_PlateCarrier2_rgr","V_PlateCarrier3_rgr","V_PlateCarrierGL_rgr","V_PlateCarrier1_blk",
			"V_PlateCarrierSpec_rgr","V_Chestrig_khk","V_Chestrig_rgr","V_Chestrig_blk","V_Chestrig_oli","V_TacVest_khk",
			"V_TacVest_brn","V_TacVest_oli","V_TacVest_blk","V_TacVest_camo","V_TacVest_blk_POLICE","V_TacVestIR_blk","V_TacVestCamo_khk",
			"V_HarnessO_brn","V_HarnessOGL_brn","V_HarnessO_gry","V_HarnessOGL_gry","V_HarnessOSpec_brn","V_HarnessOSpec_gry",
			"V_PlateCarrierIA1_dgtl","V_PlateCarrierIA2_dgtl","V_PlateCarrierIAGL_dgtl","V_RebreatherB","V_RebreatherIR","V_RebreatherIA",
			"V_PlateCarrier_Kerry","V_PlateCarrierL_CTRG","V_PlateCarrierH_CTRG","V_I_G_resistanceLeader_F","V_Press_F"
		};
		aiRifles[] =
		{
			"srifle_EBR_F","srifle_DMR_01_F","arifle_Katiba_F","arifle_Katiba_C_F","arifle_Katiba_GL_F","arifle_MXC_F",
			"arifle_MX_F","arifle_MX_GL_F","arifle_MXM_F","arifle_SDAR_F","arifle_TRG21_F","arifle_TRG20_F",
			"arifle_TRG21_GL_F","arifle_Mk20_F","arifle_Mk20C_F","arifle_Mk20_GL_F","arifle_Mk20_plain_F",
			"arifle_Mk20C_plain_F","arifle_Mk20_GL_plain_F","SMG_01_F","SMG_02_F","hgun_PDW2000_F","arifle_MXM_Black_F",
			"arifle_MX_GL_Black_F","arifle_MX_Black_F","arifle_MXC_Black_F","LMG_Mk200_F","arifle_MX_SW_F",
			"LMG_Zafir_F","arifle_MX_SW_Black_F"
		};
		aiBackpacks[] =
		{
			"B_AssaultPack_khk","B_AssaultPack_dgtl","B_AssaultPack_rgr","B_AssaultPack_sgg","B_AssaultPack_cbr",
			"B_AssaultPack_mcamo","B_TacticalPack_rgr","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_TacticalPack_blk",
			"B_TacticalPack_oli","B_FieldPack_khk","B_FieldPack_ocamo","B_FieldPack_oucamo","B_FieldPack_cbr",
			"B_FieldPack_blk","B_Carryall_ocamo","B_Carryall_oucamo","B_Carryall_mcamo","B_Carryall_khk","B_Carryall_cbr",
			"B_Parachute","B_FieldPack_oli","B_Carryall_oli","B_Kitbag_Base","B_Kitbag_cbr","B_Kitbag_mcamo",
			"B_Kitbag_rgr","B_Kitbag_sgg","B_OutdoorPack_Base","B_OutdoorPack_blk","B_OutdoorPack_blu",
			"B_OutdoorPack_tan"
		};
		aiLaunchers[] =
		{
			"launch_NLAW_F","launch_RPG32_F","launch_Titan_F","launch_Titan_short_F"
		};
		aiPistols[] =
		{
			"hgun_ACPC2_F","hgun_Rook40_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F"
		};
	};
};
class CfgPatches
{
	class VEMF
	{
		units[] = {"O_Soldier_F"};
		requiredAddons[] = {"exile_server"};
		fileName = "VEMF.pbo";
		requiredVersion = 1.50;
		author[]= {"Vampire","IT07"}; // Original author: Vampire. Permission to continue/remake VEMF given to IT07
	};
};
class cfgFunctions
{
	class VEMF
	{
		tag = "VEMF";
		class functions
		{
			file = "\VEMF\functions_VEMF";
			class random {};
			class log {};
			class getSetting {};
			class aiKilled {};
			class findPos {};
			class broadCast {};
			class playerCount {};
			class headLessClient {};
			class signAI {};
			class transferOwner {};
			class checkPlayerPresence {};
			class loadInv {};
			class spawnAI {};
			class loadLoot {};
			class placeMines {};
			class waitForPlayers {};
			class waitForMissionDone {};
			class checkLoot {};
			class missionTimer {};
			class launchVEMF { postInit = 1; };
			class REMOTEguard { postInit = 1; };
		};
	};
};
