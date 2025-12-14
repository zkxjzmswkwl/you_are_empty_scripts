-- глобальные переменные для настройкии ИИ
ai_thinking_disable = false; -- включает или выключает ИИ
ai_attack_disable = false; -- включает или выключает режим атаки для ИИ

-- включаются из движка
--include("flares.lua");
--include("materials.lua");
--include("postprocesses.lua");
--include("effectors.lua");
--include("hud.lua");

-- прототипы классов
include("prototypes_you_are_empty.lua");

-- Инициализация актера
include("actor_spawn_props_default.lua");

-- Свойства отображения игровых объектов в редакторе
include("entities_editing_properties.lua");

-- Создание таблиц(HTML), отображающих параметры актеров и оружия.
include("params_view.lua");

-- Тестирование препроцессора
--include("preprocessor_test.lua");
