/*
	Author: VAMPIRE, rebooted by IT07

	Description:
	fn_waitForPlayers - waits for player to be nearby given pos

	Params:
	_this select 0: POSITION - center of area to check for players
	_this select 1: SCALAR - radius to check around POSITION

	Returns:
	BOOL - true if there is a player present
*/

private ["_playerNear","_pos","_rad","_time","_timeOutTime","_stopLoop","_pp"];
_playerNear = false;
_pos = [_this, 0, [], [[]]] call BIS_fnc_param;
if (count _pos isEqualTo 3) then
{
	_rad = [_this, 1, 0, [0]] call BIS_fnc_param;
	if (_rad > 0) then
	{
		_time = time;
		// Define _settings
		_timeOutTime = "timeOutTime" call VEMF_fnc_getSetting;
		// _pp = playerPresence
		_pp = [_pos, _rad] call VEMF_fnc_checkPlayerPresence;
		if not _pp then
		{
			_stopLoop = false;
			while {not _stopLoop} do
			{
				if ([_pos, _rad] call VEMF_fnc_checkPlayerPresence) then { _stopLoop = true; _playerNear = true };
				if not _playerNear then
				{
					if not _stopLoop then
					{
						uiSleep 1;
						if (_timeOutTime > 4) then
						{
							if (time - _time > _timeOutTime * 60) then { _stopLoop = true };
							if not _stopLoop then { uiSleep 2 };
						};
						if (_timeOutTime < 5) then
						{
							uiSleep 2
						};
					};
				};
			};
		};
		if _pp then
		{
			_playerNear = true;
		};
	};
};

_playerNear
