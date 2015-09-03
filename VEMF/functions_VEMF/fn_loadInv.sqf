/*
	Author: VAMPIRE, rebooted by IT07

	Description:
	loads AI inventory

	Param:
	_this: ARRAY
	_this select 0: ARRAY - units to load inventory for
	_this select 1: STRING - what type of mission the loadout should be for

	Returns:
	BOOLEAN - true if nothing failed
*/

_ok = false;
private ["_params","_units","_mode","_settings","_useLaunchers","_aiGear","_uniforms","_headGear","_vests","_backpacks","_launchers","_rifles","_pistols"];
_params = _this;
if (typeName _this isEqualTo "ARRAY") then
{
	_units = [_this, 0, [], [[]]] call BIS_fnc_param;
	if (count _units > 0) then
	{
		_mode = [_this, 1, "", [""]] call BIS_fnc_param;
		if not(_mode isEqualTo "") then
		{
			// Define settings
			_aiGear = [["aiGear"],["aiUniforms","aiHeadGear","aiVests","aiBackpacks","aiLaunchers","aiRifles","aiPistols"]] call VEMF_fnc_getSetting;
			_uniforms = [_aiGear, 0, [], [[]]] call BIS_fnc_param;
			if (count _uniforms > 0) then
			{
				_headGear = [_aiGear, 1, [], [[]]] call BIS_fnc_param;
				if (count _headGear > 0) then
				{
					_vests = [_aiGear, 2, [], [[]]] call BIS_fnc_param;
					if (count _vests > 0) then
					{
						_backpacks = [_aiGear, 3, [], [[]]] call BIS_fnc_param;
						if (count _backpacks > 0) then
						{
							_rifles = [_aiGear, 5, [], [[]]] call BIS_fnc_param;
							if (count _rifles > 0) then
							{
								_pistols = [_aiGear, 6, [], [[]]] call BIS_fnc_param;
								if (count _pistols > 0) then
								{
									_useLaunchers = [[["DLI"],["useLaunchers"]] call VEMF_fnc_getSetting, 0, -1, [0]] call BIS_fnc_param;
									if (_useLaunchers isEqualTo 1) then
									{
										_launchers = [_aiGear, 4, [], [[]]] call BIS_fnc_param;
										if (count _launchers > 0) then
										{
											_useLaunchers = true;
										};
									};
									{
										private ["_unit","_gear","_ammo"];
										_unit = _x;
										// Strip it
										removeAllWeapons _unit;
										removeAllItems _unit;
										removeUniform _unit;
										removeVest _unit;
										removeBackpack _unit;
										removeGoggles _unit;
										removeHeadGear _unit;
										{ // Remove all magazines
											_unit removeMagazine _x;
										} foreach (magazines _unit);

										_gear = _uniforms call VEMF_fnc_random;
										_unit forceAddUniform _gear; // Give the poor naked guy some clothing :)

										_gear = _headGear call VEMF_fnc_random;
										_unit addHeadGear _gear;

										_gear = _vests call VEMF_fnc_random;
										_unit addVest _gear;

										if ((floor random 2) isEqualTo 0) then
										{
											_gear = _backpacks call VEMF_fnc_random;
											_unit addBackpack _gear;
											if _useLaunchers then
											{
												if ((floor random 4) isEqualTo 0) then
												{
													private ["_ammo"];
													_gear = _launchers call VEMF_fnc_random;
													_unit addWeapon _gear;
													_ammo = getArray (configFile >> "cfgWeapons" >> _gear >> "magazines");
													if (count _ammo > 2) then
													{
														_ammo resize 2;
													};
													for "_i" from 0 to (2 + (round random 1)) do
													{
														_unit addMagazine (_ammo select floor random count _ammo);
													};
												};
											};
										};

										// Add Weapons & Ammo
										_gear = _rifles call VEMF_fnc_random;
										_unit addWeapon _gear;
										_unit selectWeapon _gear;

										_ammo = getArray (configFile >> "cfgWeapons" >> _gear >> "magazines");
										if (count _ammo > 2) then
										{
											_ammo resize 2;
										};
										for "_i" from 0 to (3 + (round random 2)) do
										{
											_unit addMagazine (_ammo select floor random count _ammo);
										};

										_gear = _pistols call VEMF_fnc_random;
										_unit addWeapon _gear;
										_ammo = getArray (configFile >> "cfgWeapons" >> _gear >> "magazines");
										for "_i" from 0 to (2 + (round random 2)) do
										{
											_unit addMagazine (_ammo select floor random count _ammo);
										};
									} forEach _units;
									_ok = true;
								};
							};
						};
					};
				};
			};
		};
	};
};

_ok
