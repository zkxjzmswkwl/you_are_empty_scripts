------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Сопрограммы
------------------------------------------------------------------------

-- Общее пространство имен для сопрограмм
coroutines.common = {}

-------------------------------------------------------------------------------
-- Общие действия для каждого уровня
-------------------------------------------------------------------------------
coroutines.levels_common = {}

--     Для каждого уровня по окончанию загрузки выполняется сопрограмма [имя_уровня].on_level_loaded,
-- при старте выполняется сопрограмма [имя_уровня].on_level_start, а в конце уровня - [имя_уровня].on_level_end.
--     Общие действия при старте и в конце уровня вынесены в coroutines.levels_common.
-- Сопрограммы уровня можно унаследовать от общих сопрограмм. Если уровню требуются
-- какие-то специфические действия(напр. проигрывание видеороликов) при старте и в конце,
-- то он, унаследовавшись, может перепределить базовую функциональность общих сопрограмм.

-- Окончание загрузки нового уровня
coroutines.levels_common.on_level_loaded = {}
-------------------------------------------------------------------------------
function coroutines.levels_common.on_level_loaded:run()

	-- Инициализируем инвентарь актера
	g_actor_player:init_inventory()
end

-- старт нового уровня
coroutines.levels_common.on_level_start = {}
-------------------------------------------------------------------------------
function coroutines.levels_common.on_level_start:run()

	-- Сохраняем начало уровня
	engine.save_level_start()
	
	-- сообщаем о том, что началась игра
	engine.game_start();
end

-- конец уровня
coroutines.levels_common.on_level_end = {}
-------------------------------------------------------------------------------
function coroutines.levels_common.on_level_end:run()
	
	-- Запускаем следующий уровень, если есть
	local next_level_name = g_world_props:get_property_value_by_name("next_level")
	local it = g_world_props:get_property_value_by_name("next_level_it")
	
	if next_level_name ~= "" then
		engine:next_level( next_level_name, it )
	end

	-- Сбрасываем свойство next_level
	g_world_props:set_property_value_by_name("next_level", "")

end
