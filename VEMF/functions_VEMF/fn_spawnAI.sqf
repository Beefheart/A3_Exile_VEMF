/*
	Author: original by Vampire, completely rewritten by IT07

	Description:
	spawns AI using given _pos and unit/group count.

	Params:
	_this select 0: POSITION - where to spawn the units around
	_this select 1: SCALAR - how many groups to spawn
	_this select 2: SCALAR - how many units to put in each group

	Returns:
	ARRAY of UNITS
*/

private // Make sure that the vars in this function do not interfere with vars in the calling script
[
	"_pos","_locName","_grpCount","_unitsPerGrp","_sldrClass","_groups","_settings","_hc","_skills","_newPos","_return","_waypoints","_wp","_cyc","_units",
	"_accuracy","_aimShake","_aimSpeed","_stamina","_spotDist","_spotTime","_courage","_reloadSpd","_commanding","_general","_loadInv"
];

_units = [];
_pos = [_this, 0, [], [[]]] call BIS_fnc_param;
if (count _pos isEqualTo 3) then
{
	_locName = [_this, 1, "", [""]] call BIS_fnc_param;
	if not(_locName isEqualTo "") then
	{
		_grpCount = [_this, 2, -1, [0]] call BIS_fnc_param;
		if (_grpCount > 0) then
		{
			_unitsPerGrp = [_this, 3, -1, [0]] call BIS_fnc_param;
			if (_unitsPerGrp > 0) then
			{
				_sldrClass = "B_G_Soldier_AR_F";
				_groups = [];
				_hc = "allowHeadLessClient" call VEMF_fnc_getSetting;
				_aiDifficulty = [[["aiSkill"],["difficulty"]] call VEMF_fnc_getSetting, 0, "Veteran", [""]] call BIS_fnc_param;
				_skills = [["aiSkill", _aiDifficulty],["accuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"]] call VEMF_fnc_getSetting;
				_accuracy = _skills select 0;
				_aimShake = _skills select 1;
				_aimSpeed = _skills select 2;
				_stamina = _skills select 3;
				_spotDist = _skills select 4;
				_spotTime = _skills select 5;
				_courage = _skills select 6;
				_reloadSpd = _skills select 7;
				_commanding = _skills select 8;
				_general = _skills select 9;

				_units = [];
				// Spawn Groups near Position
				for "_g" from 1 to _grpCount do
				{
					private ["_grp","_unit"];
					_grp = createGroup WEST;
					_grp setBehaviour "AWARE";
					_grp setCombatMode "RED";
					_grp allowFleeing 0;

					for "_u" from 1 to _unitsPerGrp do
					{
						_newPos = [_pos,0,200,1,0,200,0] call BIS_fnc_findSafePos; // Find Nearby Position
						_unit = _grp createUnit [_sldrClass, _newPos, [], 0, "FORM"]; // Create Unit There
						_unit addMPEventHandler ["mpkilled","if (isDedicated) then { _killed = _this select 0; _killer = _this select 1; _nameKiller = name (_this select 1); _dist = _killed distance _killer; [_killed, _killer, _nameKiller, _dist] call VEMF_fnc_aiKilled }"];
						_unit addRating -8000;
						_units pushBack _unit;
						// Set skills
						_unit setSkill ["aimingAccuracy", _accuracy];
						_unit setSkill ["aimingShake", _aimShake];
						_unit setSkill ["aimingSpeed", _aimSpeed];
						_unit setSkill ["endurance", _stamina];
						_unit setSkill ["spotDistance", _spotDist];
						_unit setSkill ["spotTime", _spotTime];
						_unit setSkill ["courage", _courage];
						_unit setSkill ["reloadSpeed", _reloadSpd];
						_unit setSkill ["commanding", _commanding];
						_unit setSkill ["general", _general];
						_unit setRank "Private"; // Set rank
					};
					_grp selectLeader _unit; // Leader Assignment
					_groups pushBack _grp; // Push it into the _groups array
				};

				_invLoaded = [_units,"Invasion"] call VEMF_fnc_loadInv; // Load the AI's inventory
				if isNil"_invLoaded" then
				{
					["fn_spawnAI", 0, "failed to load AI's inventory..."] call VEMF_fnc_log;
				};

				if (count _groups isEqualTo _grpCount) then
				{
					_waypoints =
					[
						[(_pos select 0), (_pos select 1)+50, 0],
						[(_pos select 0)+50, (_pos select 1), 0],
						[(_pos select 0), (_pos select 1)-50, 0],
						[(_pos select 0)-50, (_pos select 1), 0]
					];
					{ // Make them Patrol
						for "_z" from 1 to (count _waypoints) do
						{
							_wp = _x addWaypoint [(_waypoints select (_z-1)), 10];
							_wp setWaypointType "SAD";
							_wp setWaypointCompletionRadius 20;
						};
						_cyc = _x addWaypoint [_pos,10];
						_cyc setWaypointType "CYCLE";
						_cyc setWaypointCompletionRadius 20;
						[_x] spawn VEMF_fnc_signAI;
					} forEach _groups;
				};
			};
		};
	};
};
_units
