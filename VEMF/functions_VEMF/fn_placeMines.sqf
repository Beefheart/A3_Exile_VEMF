/*
    Author: IT07

    Description:
    places mines around given position within given radius

    Params:
    _this select 0: POSITION - center of area to place mines around
    _this select 1: SCALAR - the minimum distance
    _this select 2: SCALAR - the maximum distance (must be higher than minimum of course)

    Returns:
    BOOL - true if all OK
*/

private ["_ok","_enabled","_pos","_min","_max","_amount","_minePos","_mine","_mines","_minesMode","_mineTypes"];
_ok = false;
_enabled = ([["DLI"],["placeMines"]] call VEMF_fnc_getSetting) select 0;
if (_enabled isEqualTo 1) then
{
    _pos = [_this, 0, [], [[]]] call BIS_fnc_param;
    if (count _pos isEqualTo 3) then
    {
        _min = [_this, 1, -1, [0]] call BIS_fnc_param;
        if (_min > -1) then
        {
            _max = [_this, 2, -1, [0]] call BIS_fnc_param;
            if (_max > _min) then
            {
                _amount = ([["DLI"],["minesAmount"]] call VEMF_fnc_getSetting) select 0;
                if (_amount > -1) then
                {
                    _minesMode = [[["DLI"],["minesMode"]] call VEMF_fnc_getSetting, 0, 1, [0]] call BIS_fnc_param;
                    if (_minesMode isEqualTo 1) then { _mineTypes = ["ATMine"] };
                    if (_minesMode isEqualTo 2) then { _mineTypes = ["APERSMine"] };
                    if (_minesMode isEqualTo 3) then { _mineTypes = ["ATMine","APERSMine"] };
                    _mines = [];
                    ["fn_placeMines", 1, format["Placing %1 mines at %2", _amount, _pos]] call VEMF_fnc_log;
                    for "_m" from 1 to _amount do
                    {
                        _mine = createMine [_mineTypes select floor random count _mineTypes, ([_pos, _min, _max, 2, 0, 20, 0] call BIS_fnc_findSafePos), [], 0];
                        _mines pushBack _mine;
                    };
                    _ok = [_mines];
                };
            };
        };
    };
};

_ok
