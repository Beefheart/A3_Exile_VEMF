/*
    Author: IT07

    Description:
    checks for players within given distance of given location/position

    Params:
    _this select 0: POSITION - center of area to check around
    _this select 1: SCALAR - radius around the position to check for players

    Returns:
    BOOL - true if player(s) found
*/

private ["_pos","_rad","_objs","_found"]; // Prevents these variables overwriting existing vars from where this was called from
// By default, we assume that there are no players close. The distance check below should prove otherwise if there are players close
_found = false;
_pos = [_this, 0, [], [[]]] call BIS_fnc_param;
if (count _pos isEqualTo 3) then
{
    _rad = [_this, 1, -1, [0]] call BIS_fnc_param;
    if (_rad > -1) then
    { // Check all player distances from _loc
        {
            if not _found then
            {
                if (([1] call VEMF_fnc_playerCount) AND (speed _x) < 200) then // Ignore fast moving players
                {
                    _isClose = if (((position _x) distance _pos) < _rad) then { true } else { false };
                    if _isClose then { _found = true };
                };
            };
        } forEach playableUnits;
    };
};

_found
