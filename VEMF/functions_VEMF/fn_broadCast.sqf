/*
	Author: VAMPIRE, rebooted by IT07

	Description:
	will alert players

	Params:
	_this select 0: ANYTHING - thing to send
	_this select 1: STRING - mode to send to client

	Returns:
	BOOL - true if no errors encountered during process
*/

private ["_msg","_mode","_sent"];
_msg = _this select 0;
_mode = _this select 1;
_sent = false;
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
_sent
