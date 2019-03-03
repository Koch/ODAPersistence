[
    QGVAR(enabled),
    "CHECKBOX",
    [ACELSTRING(Common,Enabled), LSTRING(EnabledDesc)],
    format ["ODA %1", QUOTE(COMPONENT_BEAUTIFIED)],
    false,
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enabledPlayers),
    "CHECKBOX",
    [LSTRING(EnabledPlayers), LSTRING(EnabledPlayersDesc)],
    format ["ODA %1", QUOTE(COMPONENT_BEAUTIFIED)],
    true,
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(enabledVehicles),
    "CHECKBOX",
    [LSTRING(EnabledVehicles), LSTRING(EnabledVehiclesDesc)],
    format ["ODA %1", QUOTE(COMPONENT_BEAUTIFIED)],
    true,
    true
] call CBA_Settings_fnc_init;
