--[[

Пути для функции
	include_from_path(path, file_name);

path одно из:

FS_PATH_ROOT
FS_PATH_LOGS
FS_PATH_CONFIGS_USER
FS_PATH_CONFIGS_COMPILER
FS_PATH_CONFIGS_ENGINE
FS_PATH_DSMFILES
FS_PATH_MATERIALS
FS_PATH_TEXTURES
FS_PATH_SCREENSHOTS
FS_PATH_PROGRAMS
FS_PATH_MAPS
FS_PATH_MODELS
FS_PATH_SOUNDS
FS_PATH_DEMOS
FS_PATH_CINEMATICS
FS_PATH_SCRIPTS
FS_PATH_DEBUG_INFO
FS_PATH_GAME_EXECUTABLES
FS_PATH_GAME_SAVE

include_from_path(FS_PATH_SCRIPTS, "prototypes.lua");
]]--

engine.load_script("utils.lua");

-- Глобальные переменные и структуры для конкретной игры
include("game_globals.lua");

include("game_init.lua");

include("sound_system.lua");

include("prototypes.lua");

-- Вспомогательные макросы
include("script_helpers.lua");

-- файл, должен переписываться в каждом конкретном проекте
-- для подключения скриптов, специфических для конкретной игры
include("scripts_for_concrete_game.lua");