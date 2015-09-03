/*
    Author: IT07

    Description:
    selects a headless client with least (VEMF) load

    Params:
    None

    Returns:
    OBJECT - the headless client
*/

_hcEnabled = if(("allowHeadLessClient" call VEMF_fnc_getSetting) < 1) then { false } else { true };
if _hcEnabled then
{
    // Ok, Headless Clients enabled. let us continue
    _hcList = "hcUIDs" call VEMF_fnc_getSetting;
    // We have the names now, check if any of them is actually ingame
    _ingameHCs = [];
    {
        if (typeOf _x isEqualTo "HeadlessClient_F") then
        {
            _ingameHCs pushBack [_x, name _x];
        };
    } forEach playableUnits;
    if (count _ingameHCs > 0) then
    {
        // At least 1 of given headless clients is ingame, lets check their load
        _globalLoad = uiNamespace getVariable "vemfHcLoad";
        _lowestLoad = 99999;
        _hasLowest = "";
        { // Find the lowest load number
            _load = _x select 1;
            if (_load < _lowestLoad) then
            {
                _lowestLoad = _load;
                _hasLowest = _x select 0;
            };
        } forEach _globalLoad;
        // HC with lowest load found, add +1 to its current load
        _index = _globalLoad find [_hasLowest, _lowestLoad];
        if (_index > -1) then
        {
            _globalLoad set [_index,[_hasLowest, _lowestLoad +1]]
        };
    };
};
// Lowest load found, send it
_hasLowest
