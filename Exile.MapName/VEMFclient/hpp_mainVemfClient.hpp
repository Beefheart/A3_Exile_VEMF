class vemfClientMsg
{
	idd = 2991;
	fadeIn = 0.5;
	fadeOut = 1;
	duration = 20;
	onLoad = "uiNamespace setVariable ['vemfClientDsp', _this select 0]";
	onUnload = "uiNamespace setVariable ['vemfClientDsp', nil]";
	movingEnable = 0;
	class controls
	{
		#include "hpp_rscVemfClient.hpp"
	};
};
