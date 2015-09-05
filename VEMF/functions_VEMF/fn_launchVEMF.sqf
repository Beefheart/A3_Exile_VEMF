/*
	Author: Vampire

	Description:
	launches VEMF (duuuuuuuuuuuuuuuuh) :P
*/

_version = "VEMF_version" call VEMF_fnc_getSetting;
diag_log "////////////////////////////////////////////";
["Launcher", 3, format["Starting VEMF %1", _version]] call VEMF_fnc_log;
diag_log "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\";
uiNamespace setVariable ["vemfUsedLocs", []];
uiNamespace setVariable ["vemfHCload", []];
[] spawn VEMF_fnc_checkLoot; // Check loot tables if enabled
[] spawn VEMF_fnc_missionTimer; // Launch mission timer
west setFriend [independent, 0];
independent setFriend [west, 0];
