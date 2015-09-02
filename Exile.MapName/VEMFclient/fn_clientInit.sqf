if (hasInterface) then
{
	"VEMFChatMsg" addPublicVariableEventHandler
	{
		_data = _this select 1;
		_msg = _data select 0;
		switch (_data select 1) do
		{
			case "sys":
			{
				systemChat (_data select 0);
			};
			default
			{
				[
					[
						[(_msg select 0),"<t align = 'left' shadow = '1' size = '1' font='RobotoMedium'>%1</t><br />"],
						[(_msg select 1),"<t align = 'left' shadow = '1' size = '1'>%1</t><br/>"],
						[(_msg select 2),"<t align = 'left' shadow = '1' size = '0.6' font='RobotoMedium'>%1</t><br />"],
						[(_msg select 3),"<t align = 'left' shadow = '1' size = '0.5'>%1</t>"]
					]
				] spawn VEMF_fnc_typeText;
			};
		};
	};
};
