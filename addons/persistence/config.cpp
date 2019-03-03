#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"oda_core"};
        author = ECSTRING(core,Author);
        authors[]= {"Jonpas", "Ryder"};
        url = ECSTRING(core,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
