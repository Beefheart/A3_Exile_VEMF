/*
    Author: IT07

    Description:
    selects random element from given ARRAY

    Params:
    _this: ARRAY(s)

    Returns:
    ARRAY - result of random selection(s)
*/

private ["_return","_given","_data"];
_return = [];
_given = [];
_given pushBack _this;
_data = [_given, 0, [], [[]]] call BIS_fnc_param;
if (count _data > 0) then
{
    _return = _this select floor random count _this;
};
_return
