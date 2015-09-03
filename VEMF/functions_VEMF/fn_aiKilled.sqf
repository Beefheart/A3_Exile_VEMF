/*
	VEMF AI Killed by Vampire, rewritten by IT07

	Description:
	removes launchers if desired and announces the kill if enabled in config.cpp

	Params:
	_this select 0: OBJECT - the killed AI
	_this select 1: STRING - name of killed AI
	_this select 2: OBJECT - killer
	_this select 3: STRING - name of killer

	Returns:
	nothing
*/

private ["_unit","_killer","_nameKiller","_dist","_unitType","_settings","_aiGear","_remLaunchers","_launchers","_say","_kMsg","_missiles","_allowSmall"];
_unit = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_killer = [_this, 1, objNull, [objNull]] call BIS_fnc_param;
if not isNull _killer then
{
	_nameKiller = [_this, 2, "", [""]] call BIS_fnc_param;
	if not(_nameKiller isEqualTo "") then
	{
		_dist = [_this, 3, -1, [0]] call BIS_fnc_param;
		if (_dist > -1) then
		{
			_say = "sayKilled" call VEMF_fnc_getSetting;
			// Send kill message if enabled
			if (_say isEqualTo 1) then
			{
				if (isPlayer _killer) then // Should prevent Error:NoUnit
				{
					_kMsg = format["[VEMF] %1 killed an AI from %2m", _nameKiller, round _dist];
					_sent = [_kMsg, "sys"] call VEMF_fnc_broadCast;
				};
			};
		};
	};
};

_settings = [["removeLaunchers","removeAIbodies"]] call VEMF_fnc_getSetting;
_remLaunchers = _settings select 0;
if (_remLaunchers isEqualTo 1) then
{
	_secWeapon = secondaryWeapon _unit;
	if not(_secWeapon isEqualTo "") then
	{
		_unit removeWeaponGlobal _secWeapon;
		_missiles = getArray (configFile >> "cfgWeapons" >> _secWeapon >> "magazines");
		{
			if (_x in (magazines _unit)) then
			{
				_unit removeMagazine _x;
			};
		} forEach _missiles;
	};
};

if ((_settings select 1) isEqualTo 1) then // If killEffect enabled
{
	playSound3D ["A3\Missions_F_Bootcamp\data\sounds\vr_shutdown.wss", _unit, false, getPosASL _unit, 2, 1, 60];
	for "_u" from 1 to 8 do
	{
		if not(isObjectHidden _unit) then
		{
			_unit hideObjectGlobal true;
		} else
		{
			_unit hideObjectGlobal false;
		};
		uiSleep 0.15;
	};
	_unit hideObjectGlobal true;
	removeAllWeapons _unit;
	// Automatic cleanup yaaay
	deleteVehicle _unit;
};
