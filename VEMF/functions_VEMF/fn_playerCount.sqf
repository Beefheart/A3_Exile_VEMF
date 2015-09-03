/*
    Author: IT07

    Description:
    checks if player count is above or equal to given number. If no number given, default of 1 will be used.

    Params:
    none

    Returns:
    ARRAY - [false if current player count is below minimum, true of more than minimum]
*/

private ["_minimum","_players","_ok"];
_ok = false;
_minimum = [_this, 0, 1, [0]] call BIS_fnc_param;
_players = 0;
{
    if ((isPlayer _x) AND ((side _x) isEqualTo independent)) then
    {
        _players = _players + 1;
    };
} forEach playableUnits;

if (_players >= _minimum) then
{
    _ok = true
};

_ok
