#define COMPONENT persistence
#define COMPONENT_BEAUTIFIED Persistence
#include "\x\oda\addons\core\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_PERSISTENCE
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_PERSISTENCE
    #define DEBUG_SETTINGS DEBUG_SETTINGS_PERSISTENCE
#endif

#include "\x\oda\addons\core\script_macros.hpp"

#define REQUIRED_PERSISTENCECLIENT_VERSION "1.0.0"

#define SAVE_DELAY_PERIODIC 30
#define SAVE_DELAY_INV_CHANGE 10
