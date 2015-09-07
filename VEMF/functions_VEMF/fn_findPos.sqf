/*
	Author: VAMPIRE, rewritten by IT07

	Description:
	can find a location or pos randomly on the map where there are no players

	Params:
	_this select 0: STRING - Mode to use. Options: "loc" or "pos"
	_this select 1: BOOLEAN - True if _pos needs to be a road
	_this select 2: OBJECT - Center for nearestLocations check
	_this select 3: SCALAR - Max distance in meters from center to search for _pos
	_this select 4: SCALAR - Distance in meters. Locations closer than that will be excluded
	_this select 5: SCALAR - Max prefered distance in meters from center. If not achievable, further dest will be selected
	_this select 6: SCALAR - Distance in meters to check from _cntr for players

	Returns:
	ARRAY - [name of town, town position]
*/

private ["_settings","_locPos","_loc","_locName","_ret","_continue","_settings","_blackList","_usedLocs","_checkRange","_tooCloseRange","_maxPrefered","_playerCheck","_allowSmall","_mode","_pos","_hasPlayers","_blackPos","_checkBlackPos"];

_ret = false;
// Define settings
_settings = [["locationBlackList","allowSmall","noMissionPos"]] call VEMF_fnc_getSetting;
_blackList = [_settings, 0, [], [[]]] call BIS_fnc_param;
_allowSmall = [_settings, 1, 1, [0]] call BIS_fnc_param;
_blackPos = [_settings, 2, [], [[]]] call BIS_fnc_param;
_checkBlackPos = false;
if (count _blackPos > 0) then
{
	_checkBlackPos = true;
};
_mode = [_this, 0, "", [""]] call BIS_fnc_param;
if not(_mode isEqualTo "") then
{
	_onRoad = [_this, 1, false, [false]] call BIS_fnc_param;
	_roadRange = 5000;
	_cntr = [_this, 2, [], [[]]] call BIS_fnc_param;
	if (count _cntr > 0) then
	{
		_rad = [_this, 3, -1, [0]] call BIS_fnc_param;
		if (_rad > -1) then
		{
			_tooCloseRange = [_this, 4, -1, [0]] call BIS_fnc_param;
			if (_tooCloseRange > -1) then
			{
				_maxPrefered = [_this, 5, -1, [0]] call BIS_fnc_param;
				if (_maxPrefered > -1) then
				{
					_playerCheck = [_this, 6, -1, [0]] call BIS_fnc_param;
					if (_playerCheck > -1) then
					{
						if (_mode isEqualTo "loc") then
						{
							// Get a list of locations close to _cntr (position of player)
							_locs = nearestLocations [_cntr, ["Area","BorderCrossing","CityCenter","Hill","fakeTown","Name","RockArea","Strategic","StrongpointArea","ViewPoint","NameVillage","NameCity","NameCityCapital",if(_allowSmall isEqualTo 1)then{"nameLocal"}], _rad];
							if (count _locs > 0) then
							{
								_usedLocs = uiNamespace getVariable "vemfUsedLocs";
								_remLocs = [];
								{ // Check _locs for invalid locations (too close, hasPlayers or inBlacklist)
									_hasPlayers = [locationPosition _x, _playerCheck] call VEMF_fnc_checkPlayerPresence;
									if _hasPlayers then
									{
										_remLocs pushBack _x;
									};
									if not _hasPlayers then
									{
										if _checkBlackPos then
										{
											private ["_locPos","_loc"];
											_locPos = locationPosition _x;
											_loc = _x;
											{
												if (count _x isEqualTo 2) then
												{
													_pos = [_x, 0, [0,0,0], [[]]] call BIS_fnc_param;
													if not(_pos isEqualTo [0,0,0]) then
													{
														_range = [_x, 1, 600, [0]] call BIS_fnc_param;
														if ((_pos distance _locPos) < _range) then
														{
															_remLocs pushBack _loc;
														};
													};
												};
												if not(count _x isEqualTo 2) then
												{
													["fn_findPos", 0, format["found invalid entry in mission blacklist: %1", _x]] call VEMF_fnc_log;
												};
											} forEach _blackPos;
										};
										if ((text _x) in _blackList) then
										{
											_remLocs pushBack _x;
										};
										if not((text _x) in _blacklist) then
										{
											if (_cntr distance (locationPosition _x) < _tooCloseRange) then
											{
												_remLocs pushBack _x;
											};
											if (_cntr distance (locationPosition _x) > _tooCloseRange) then
											{
												if (([text _x, locationPosition _x]) in _usedLocs) then
												{
													_remLocs pushBack _x;
												};
											};
										};
									};
								} forEach _locs;

								{ // Remove all invalid locations from _locs
									_index = _locs find _x;
									_locs deleteAt _index;
								} forEach _remLocs;

								// Check what kind of distances we have
								_far = []; // Further than _maxPrefered
								_pref = []; // Closer then _maxPrefered
								{
									_dist = _cntr distance (locationPosition _x);
									if (_dist > _maxPrefered) then
									{
										_far pushBack _x;
									};
									if (_dist < _maxPrefered) then
									{
										_pref pushBack _x;
									};
								} forEach _locs;

								// Check if there are any prefered locations. If yes, randomly select one
								if (count _pref > 0) then
								{
									_loc = _pref select floor random count _pref;
								};

								// Check if _far has any locations and if _pref is empty
								if (count _far > 0) then
								{
									if (count _pref isEqualTo 0) then
									{
										_loc = _far select floor random count _far;
									};
								};

								// Validate _locs just to prevent the .RPT from getting spammed
								if (count _locs > 0) then
								{
									// Return Name and POS
									_ret = [text _loc, locationPosition _loc];
									(uiNamespace getVariable "vemfUsedLocs") pushBack _ret;
								};
							};
						};
						if (_mode isEqualTo "pos") then
						{
							_valid = false;
							for "_p" from 1 to 10 do
							{
								if (typeName _ret isEqualTo "BOOL") then
								{
									if not _ret then
									{
										_pos = [_cntr, _tooCloseRange, _rad, 2, 0, 500, 0] call BIS_fnc_findSafePos;
										if _onRoad then
										{
											_roads = _pos nearRoads _roadRange;
											if (count _roads > 0) then
											{
												private ["_closest","_dist"];
												_closest = ["", _roadRange];
												{ // Find the closest road
													_dist = _x distance _pos;
													if (_dist < (_closest select 1)) then
													{
														_closest = [_x, _dist];
													};
												} forEach _roads;
												_pos = position (_closest select 0);
											};
										};
										_hasPlayers = [_pos, _playerCheck] call VEMF_fnc_checkPlayerPresence;
										if not(_hasPlayers) then
										{
											_ret = _pos;
										};
									};
								};
							};
						};
					};
				};
			};
		};
	};
};

_ret
