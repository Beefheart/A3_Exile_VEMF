/*
	Author: VAMPIRE, rebooted by IT07

	Description:
	loads loot crate inventory

	Returns:
	BOOL - true if everything went ok
*/
private
[
	"_crate","_settings","_loot","_amount","_quant","_prim","_sec","_mags","_att","_items","_vests","_packs","_primaries","_secondaries",
	"_magazines","_attachments","_items","_vests","_backpacks","_headGear","_blackList","_maxPrim","_minPrim","_maxSec","_minSec",
	"_maxMagSlots","_minMagSlots","_maxAttSlots","_minAttSlots","_maxItemSlots","_minItemSlots","_maxVestSlots","_minVestSlots",
	"_maxHeadGearSlots","_minHeadGearSlots","_maxBagSlots","_minBagSlots","_ok"
];

_ok = false;
// Define _vars
_crate = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if not isNull _crate then
{
	_settings = [["crateLoot"],["maxPrimarySlots"]] call VEMF_fnc_getSetting;
	_maxPrim = [_settings, 0, -1, [0]] call BIS_fnc_param;
	if (_maxPrim > 1) then
	{
		_settings = [["crateLoot"],["minPrimarySlots"]] call VEMF_fnc_getSetting;
		_minPrim = [_settings, 0, -1, [0]] call BIS_fnc_param;
		if (_minPrim > 0) then
		{
			_settings = [["crateLoot"],["maxSecondarySlots"]] call VEMF_fnc_getSetting;
			_maxSec = [_settings, 0, -1, [0]] call BIS_fnc_param;
			if (_maxSec > 1) then
			{
				_settings = [["crateLoot"],["minSecondarySlots"]] call VEMF_fnc_getSetting;
				_minSec = [_settings, 0, -1, [0]] call BIS_fnc_param;
				if (_minSec > 0) then
				{
					_settings = [["crateLoot"],["maxMagSlots"]] call VEMF_fnc_getSetting;
					_maxMagSlots = [_settings, 0, -1, [0]] call BIS_fnc_param;
					if (_maxMagSlots > 1) then
					{
						_settings = [["crateLoot"],["minMagSlots"]] call VEMF_fnc_getSetting;
						_minMagSlots = [_settings, 0, -1, [0]] call BIS_fnc_param;
						if (_minMagSlots > 0) then
						{
							_settings = [["crateLoot"],["maxAttSlots"]] call VEMF_fnc_getSetting;
							_maxAttSlots = [_settings, 0, -1, [0]] call BIS_fnc_param;
							if (_maxAttSlots > 1) then
							{
								_settings = [["crateLoot"],["minAttSlots"]] call VEMF_fnc_getSetting;
								_minAttSlots = [_settings, 0, -1, [0]] call BIS_fnc_param;
								if (_minAttSlots > 0) then
								{
									_settings = [["crateLoot"],["maxItemSlots"]] call VEMF_fnc_getSetting;
									_maxItemSlots = [_settings, 0, -1, [0]] call BIS_fnc_param;
									if (_maxItemSlots > 1) then
									{
										_settings = [["crateLoot"],["minItemSlots"]] call VEMF_fnc_getSetting;
										_minItemSlots = [_settings, 0, -1, [0]] call BIS_fnc_param;
										if (_minItemSlots > 0) then
										{
											_settings = [["crateLoot"],["maxVestSlots"]] call VEMF_fnc_getSetting;
											_maxVestSlots = [_settings, 0, -1, [0]] call BIS_fnc_param;
											if (_maxVestSlots > 1) then
											{
												_settings = [["crateLoot"],["minVestSlots"]] call VEMF_fnc_getSetting;
												_minVestSlots = [_settings, 0, -1, [0]] call BIS_fnc_param;
												if (_minVestSlots > 0) then
												{
													_settings = [["crateLoot"],["maxHeadGearSlots"]] call VEMF_fnc_getSetting;
													_maxHeadGearSlots = [_settings, 0, -1, [0]] call BIS_fnc_param;
													if (_maxHeadGearSlots > 1) then
													{
														_settings = [["crateLoot"],["minHeadGearSlots"]] call VEMF_fnc_getSetting;
														_minHeadGearSlots = [_settings, 0, -1, [0]] call BIS_fnc_param;
														if (_minHeadGearSlots > 0) then
														{
															_settings = [["crateLoot"],["maxBagSlots"]] call VEMF_fnc_getSetting;
															_maxBagSlots = [_settings, 0, -1, [0]] call BIS_fnc_param;
															if (_maxBagSlots > 1) then
															{
																_settings = [["crateLoot"],["minBagSlots"]] call VEMF_fnc_getSetting;
																_minBagSlots = [_settings, 0, -1, [0]] call BIS_fnc_param;
																if (_minBagSlots > 0) then
																{
																	_loot = [["crateLoot"],["primaryWeaponLoot"]] call VEMF_fnc_getSetting;
																	_primaries = [_loot, 0, [], [[]]] call BIS_fnc_param;
																	if (count _primaries > 0) then
																	{
																		_loot = [["crateLoot"],["secondaryWeaponLoot"]] call VEMF_fnc_getSetting;
																		_secondaries = [_loot, 0, [], [[]]] call BIS_fnc_param;
																		if (count _secondaries > 0) then
																		{
																			_loot = [["crateLoot"],["magazinesLoot"]] call VEMF_fnc_getSetting;
																			_magazines = [_loot, 0, [], [[]]] call BIS_fnc_param;
																			if (count _magazines > 0) then
																			{
																				_loot = [["crateLoot"],["attachmentsLoot"]] call VEMF_fnc_getSetting;
																				_attachments = [_loot, 0, [], [[]]] call BIS_fnc_param;
																				if (count _attachments > 0) then
																				{
																					_loot = [["crateLoot"],["itemsLoot"]] call VEMF_fnc_getSetting;
																					_items = [_loot, 0, [], [[]]] call BIS_fnc_param;
																					if (count _items > 0) then
																					{
																						_loot = [["crateLoot"],["vestsLoot"]] call VEMF_fnc_getSetting;
																						_vests = [_loot, 0, [], [[]]] call BIS_fnc_param;
																						if (count _vests > 0) then
																						{
																							_loot = [["crateLoot"],["backpacksLoot"]] call VEMF_fnc_getSetting;
																							_backpacks = [_loot, 0, [], [[]]] call BIS_fnc_param;
																							if (count _backpacks > 0) then
																							{
																								_loot = [["crateLoot"],["headGearLoot"]] call VEMF_fnc_getSetting;
																								_headGear = [_loot, 0, [], [[]]] call BIS_fnc_param;
																								if (count _headGear > 0) then
																								{
																									_loot = [["crateLoot"],["blackListLoot"]] call VEMF_fnc_getSetting;
																									_blackList = [_loot, 0, [], [[]]] call BIS_fnc_param;

																									// Add primary weapons
																									for "_j" from 0 to (_maxPrim - _minPrim + floor random _minPrim) do
																									{
																										_prim = _primaries call BIS_fnc_selectRandom;
																										if not((_prim select 0) in _blackList) then
																										{
																											_crate addWeaponCargoGlobal [_prim select 0, _prim select 1];
																										};
																									};

																									// Secondary weapons
																									for "_j" from 0 to (_maxSec - _minSec + floor random _minSec) do
																									{
																										_sec = _secondaries call BIS_fnc_selectRandom;
																										if not((_sec select 0) in _blackList) then
																										{
																											_crate addWeaponCargoGlobal [_sec select 0, _sec select 1];
																										};
																									};

																									// Magazines
																									for "_j" from 0 to (_maxMagSlots - _minMagSlots + floor random _minMagSlots) do
																									{
																										_mag = _magazines call BIS_fnc_selectRandom;
																										if not((_mag select 0) in _blackList) then
																										{
																											_crate addMagazineCargoGlobal [_mag select 0, _mag select 1];
																										};
																									};

																									// Weapon attachments
																									for "_j" from 0 to (_maxAttSlots - _minAttSlots + floor random _minAttSlots) do
																									{
																										_att = _attachments call BIS_fnc_selectRandom;
																										if not((_att select 0) in _blackList) then
																										{
																											_crate addItemCargoGlobal [_att select 0, _att select 1];
																										};
																									};

																									// Items
																									for "_j" from 0 to (_maxItemSlots - _minItemSlots + floor random _minItemSlots) do
																									{
																										_item = _items call BIS_fnc_selectRandom;
																										if not((_item select 0) in _blacklist) then
																										{
																											_crate addItemCargoGlobal [_item select 0, _item select 1];
																										};
																									};

																									// Vests
																									for "_j" from 0 to (_maxVestSlots - _minVestSlots + floor random _minVestSlots) do
																									{
																										_vest = _vests call BIS_fnc_selectRandom;
																										if not((_vest select 0) in _blackList) then
																										{
																											_crate addItemCargoGlobal [_vest select 0, _vest select 1];
																										};
																									};

																									// Helmets / caps / berets / bandanas
																									for "_j" from 0 to (_maxHeadGearSlots - _minHeadGearSlots + floor random _minHeadGearSlots) do
																									{
																										_headGearItem = _headGear call BIS_fnc_selectRandom;
																										if not((_headGearItem select 0) in _blackList) then
																										{
																											_crate addItemCargoGlobal [_headGearItem select 0, _headGearItem select 1];
																										};
																									};

																									// Backpacks
																									for "_j" from 0 to (_maxBagSlots - _minBagSlots + floor random _minBagSlots) do
																									{
																										_pack = _backpacks call BIS_fnc_selectRandom;
																										if not((_pack select 0) in _blackList) then
																										{
																											_crate addBackpackCargoGlobal [_pack select 0, _pack select 1];
																										};
																									};
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
				};
			};
		};
	};
};
_ok
