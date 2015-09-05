/*
	Author: VAMPIRE, rebooted by IT07

	Description:
	will alert players

	Params:
	_this select 0: FORMATTED STRING - thing to send
	_this select 1: STRING - mode to send to client

	Returns:
	BOOL - true if no errors encountered during process
*/

private ["_msg","_mode","_sent"];
_sent = false;
_msg = [_this, 0, format[""], [format[""]]] call BIS_fnc_param;
if not(_msg isEqualTo format[""]) then
{
	_mode = [_this, 1, "", [""]] call BIS_fnc_param;
	if (count playableUnits > 0) then
	{
		{
			if (isPlayer _x) then
			{
				if (side _x isEqualTo independent) then
				{
					VEMFChatMsg = [_msg, _mode];
					(owner _x) publicVariableClient "VEMFChatMsg";
				};
			};
		} forEach playableUnits;
		_sent = true;
	};
};
_sent
