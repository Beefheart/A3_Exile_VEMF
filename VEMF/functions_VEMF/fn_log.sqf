/*
    Author: IT07

    Description:
    will log given data if debug is enabled

    Params:
    _this: ARRAY - contains data required for logging
    _this select 0: STRING - prefix. Use "" if none
    _this select 1: SCALAR - 0 for error, 1 for info
    _this select 2: STRING - the thing to log

    Returns:
    nothing
*/

private ["_param","_prefix","_mode","_logThis","_logModesAllowed","_loggingEnabled"];
_loggingEnabled = "enableDebug" call VEMF_fnc_getSetting;
if (_loggingEnabled > -1) then
{
    _logModesAllowed = [3];
    if (_loggingEnabled isEqualTo 0) then
    {
        _logModesAllowed pushBack 0;
    };
    if (_loggingEnabled isEqualTo 1) then
    {
        _logModesAllowed pushBack 1;
    };
    if (_loggingEnabled isEqualTo 2) then
    {
        _logModesAllowed pushBack 0;
        _logModesAllowed pushBack 1;
    };

    _prefix = [_this, 0, "", [""]] call BIS_fnc_param;
    if not(_prefix isEqualTo "") then
    {
        _mode = [_this, 1, -1, [0]] call BIS_fnc_param;
        if (_mode > -1) then
        {
            if (_mode < 4) then
            {
                _logThis = [_this, 2, "", [""]] call BIS_fnc_param;
                if not(_logThis isEqualTo "") then
                {
                    if (_mode isEqualTo 0) then
                    {
                        _mode = "ERROR";
                    };
                    if (_mode isEqualTo 1) then
                    {
                        _mode = "INFO";
                    };
                    if (_mode isEqualTo 3) then
                    {
                        _mode = "";
                    };
                    diag_log format["[VEMF] %1 %2: %3", _prefix, _mode, _logThis];
                };
            };
        };
    };
};
