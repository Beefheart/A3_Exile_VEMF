/*
	DynamicLocationInvasion by Vampire, rewritten by IT07
*/
private ["_settings","_grpCount","_groupUnits","_playerCheck","_loc","_hasPlayers","_marker","_spawned","_grpArr","_unitArr","_done","_boxes","_box","_chute","_colors","_lightType","_light","_smoke"];

// Define _settings
_settings = [["DLI"],["maxInvasions","groupCount","groupUnits","distanceCheck","distanceTooClose","distanceMaxPrefered","playerCheck","crateAltitude"]] call VEMF_fnc_getSetting;
_maxInvasions = _settings select 0;
if isNil"VEMF_invasCount" then { VEMF_invasCount = 0; };
if (VEMF_invasCount < _maxInvasions) then
{
	_grpCount = _settings select 1;
	_groupUnits = _settings select 2;
	_range = _settings select 3;
	_tooClose = _settings select 4;
	_maxPref = _settings select 5;
	_playerCheck = _settings select 6;
	_crateAltitude = _settings select 7;

	// Find A Town to Invade
	_loc = ["loc", false, position (playableUnits select floor random count playableUnits), _range, _tooClose, _maxPref, _playerCheck] call VEMF_fnc_findPos;
	if (typeName _loc isEqualTo "ARRAY") then
	{
		_locName = _loc select 0;
		if (_locName isEqualTo "") then { _locName = "Area"; };
		["DLI", 1, format["Invading %1...", _locName]] call VEMF_fnc_log;
		VEMF_invasCount = VEMF_invasCount + 1;
		// Send message to all players
		_newMissionMsg = [format["%1 invaded near %2", _locName, mapGridPosition (_loc select 1)], ""] call VEMF_fnc_broadCast;
		if _newMissionMsg then
		{
			// Create/place the marker
			_marker = createMarker [format["VEMF_DynaLocInva_ID%1", random 9000], (_loc select 1)];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "o_inf";
			_marker setMarkerColor "ColorBlack";

			// Usage: COORDS, Radius
			_playerNear = [_loc select 1, 800] call VEMF_fnc_waitForPlayers;
			if _playerNear then
			{
				// Player is Near, so Spawn the Units
				_spawned = [_loc select 1, _locName, _grpCount, _groupUnits] call VEMF_fnc_spawnAI;
				if (count _spawned > 0) then
				{
					// Place mines if enabled
					private ["_minesPlaced","_placeMines"];
					_placeMines = [[["DLI"],["placeMines"]] call VEMF_fnc_getSetting, 0, [0]] call BIS_fnc_param;
					if (_placeMines isEqualTo 1) then
					{
						_minesPlaced = [[_loc select 1, 5, 100] call VEMF_fnc_placeMines, 0, [], [[]]] call BIS_fnc_param;
						if (count _minesPlaced > 0) then
						{
							["DLI", 1, format["Successfully placed mines at %1", _locName]] call VEMF_fnc_log;
						};
						if (count _minesPlaced isEqualto 0) then
						{
							["DLI", 0, format["Failed to place mines at %1", _locName]] call VEMF_fnc_log;
							_minesPlaced = nil;
						};
					};

					// Wait for Mission Completion
					_done = [_loc select 1, _spawned, _playerCheck] call VEMF_fnc_waitForMissionDone;
					_usedLocs = uiNamespace getVariable "vemfUsedLocs";
					_index = _usedLocs find _loc;
					_usedLocs deleteAt _index;
					if _done then
					{
						// Broadcast
						_completeMsg = [format["%1 has been cleared by the exiled near %2", _locName, mapGridPosition (_loc select 1)], ""] call VEMF_fnc_broadCast;
						if _completeMsg then
						{
							// Choose a box
							_boxes = [["DLI"],["crateTypes"]] call VEMF_fnc_getSetting;
							_box = (_boxes select 0) call BIS_fnc_selectRandom;
							_cratePos = [_loc select 1, 0, 100, 0, 0, 300, 0] call bis_fnc_findSafePos;
							_chute = createVehicle ["I_Parachute_02_F", _cratePos, [], 0, "FLY"];
							if not isNull _chute then
							{
								_chute flyInHeight _crateAltitude;
								_crate = createVehicle [_box, getPos _chute, [], 0, "NONE"];
								clearWeaponCargoGlobal _crate;
								clearMagazineCargoGlobal _crate;
								clearBackpackCargoGlobal  _crate;
								clearItemCargoGlobal _crate;
								 _crate attachTo [_chute, [0,0,0]];
								_crate allowDamage false;
								["DLI", 1, format ["Crate parachuted at: %1 / Grid: %2", (getPosATL _crate), mapGridPosition (getPosATL _crate)]] call VEMF_fnc_log;

								// Mark the crate
								// If night, attach a chemlight
								if (dayTime < 5 OR dayTime > 19) then
								{
									_colors = ([["DLI"],["flairTypes"]] call VEMF_fnc_getSetting) select 0;
									_lightType = _colors select floor random count _colors;
									_light = _lightType createVehicle (position _crate);
									_light attachTo [_chute,[0,0,0]];
								};
								// If day, attach smoke
								if (dayTime > 5 OR dayTime < 19) then
								{
									_colors = ([["DLI"],["smokeTypes"]] call VEMF_fnc_getSetting) select 0;
									_rndmColor = _colors select floor random count _colors;
									_smoke = createVehicle [_rndmColor, getPos _crate, [], 0, "CAN_COLLIDE"];
									_smoke attachTo [_chute,[0,0,0]];
								};
								_loaded = [_crate] call VEMF_fnc_loadLoot;
								if _loaded then { ["DLI", 1, "Loot loaded successfully into crate"] call VEMF_fnc_log };
								waitUntil { uiSleep 1; (((getPos _crate) select 2) < 7) };
								detach _crate;
								deleteMarker _marker;
								VEMF_invasCount = VEMF_invasCount - 1;
								VEMF_missionCount = VEMF_missionCount - 1;

								// Explode or remove the mines
								if not isNil"_minesPlaced" then
								{
									private ["_cleanMines"];
									_cleanMines = [[["DLI"],["cleanMines"]] call VEMF_fnc_getSetting, 0, 1, [0]] call BIS_fnc_param;
									if (_cleanMines isEqualTo 2) then
									{
										{
											if not isNull _x then
											{
												_x setDamage 1;
												uiSleep (2 + round random 2);
											};
										} forEach _minesPlaced;
									};
									if (_cleanMines isEqualTo 1) then
									{
										{
											if not isNull _x then
											{
												deleteVehicle _x;
											};
										} forEach _minesPlaced;
									};
								};

								// Put a marker on the crate if enabled
								if not isNull _crate then
								{
									if not ([getPos _crate, 5] call VEMF_fnc_checkPlayerPresence) then
									{
										_addMarker = [[["DLI"],["crateMarker"]] call VEMF_fnc_getSetting, 0, 1, [0]] call BIS_fnc_param;
										if (_addMarker isEqualTo 1) then
										{
											private ["_crateMarker"];
											_crateMarker = createMarker [format["VEMF_lootCrate_ID%1", random 9000], position _crate];
											_crateMarker setMarkerShape "ICON";
											_crateMarker setMarkerType "mil_box";
											_crateMarker setMarkerColor "colorBlack";
											_crateMarker setMarkerText " Loot";
										};
									};
								};
							};
						};
						if not _completeMsg then
						{
							["DLI", 0, "Mission success broadcast returned false."] call VEMF_fnc_log;
							deleteMarker _marker;
							VEMF_invasCount = VEMF_invasCount - 1;
							VEMF_missionCount = VEMF_missionCount - 1;
						};
					};
				};
				if isNil"_spawned" then
				{
					["DLI", 0, format["Failed to spawn AI in %1", _locName]] call VEMF_fnc_log;
					deleteMarker _marker;
					VEMF_invasCount = VEMF_invasCount - 1;
					VEMF_missionCount = VEMF_missionCount - 1;
				};
			};
			if not _playerNear then
			{
				["DLI", 1, format["Invasion of %1 timed out.", _locName]] call VEMF_fnc_log;
				deleteMarker _marker;
				VEMF_invasCount = VEMF_invasCount - 1;
				VEMF_missionCount = VEMF_missionCount - 1;
			};
		};
	};
};
