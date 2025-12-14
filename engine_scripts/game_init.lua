-------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
-- Author: Yuri Dobronravin
-------------------------------------------------------------------
-- Предварительная инициализация игры
-------------------------------------------------------------------

-- типы атак для ИИ персонажей
ATTACK_MELEE = 0; -- атака с близкого расстояния при непосредственном контакте
ATTACK_JUMP = 1; -- атака с прыжка
ATTACK_DISTANT = 2; -- атака на расстоянии при помощи оружия
				 
-------------------------------------------------
-- серверная часть
function sv_game_init()
	
	-- регистрация событий
	-- для ИИ, которого тригер "позвал" идти в его позицию);
	engine.register_event("EVENT_WALK_HERE",	"pos_to_go = %vec3");
		
	-- actions и callbacks для актеров и контроллеров
	-- зовем NPC идти в позицию
	actor.register_callback("CALLBACK_WALK_HERE", "pos_to_go = %vec3");
	-- режим GUARD
	actor.register_callback("CALLBACK_GUARD", "set = %i, data = %lo");
	-- нужно перезарядить оружие
	actor.register_callback("CALLBACK_NEED_TO_RELOAD", "data = %lo");
	-- выбор типа атаки
	actor.register_callback("CALLBACK_SET_ATTACK_TYPE", "attack_type = %i, status = %i");
	-- игнорировать наличие врагов
	actor.register_callback("CALLBACK_IGNORE_ENEMIES", "need_to_ignore = %i");
	
	init_diff_levels()
	
	-- установить начальное значение для генератора случайных чисел
	math.randomseed(engine.get_system_time());
end

-------------------------------------------------
-- клиентская часть
function cl_game_init()
end


------------------------------------------------
-- создание произвольной entity в run-time
------------------------------------------------
function spawn_entity(CLASS_NAME, ENTITY_NAME, PROP_TABLE, POS)
	assert(CLASS_NAME, "spawn_entity CLASS_NAME cant be nil!");
	
	-- Создаем объект
	local new_obj = nil
	if ENTITY_NAME then
		new_obj = engine.spawn_entity(CLASS_NAME, ENTITY_NAME)
	else
		new_obj = engine.spawn_entity(CLASS_NAME)
	end 

	-- Задаем свойства
	if type(PROP_TABLE) == "table" then
		for i,v in pairs(PROP_TABLE) do
			new_obj:set_property_value_by_name(i, v);
		end
	end
	
	-- Добавляем объект
	engine.add_entity_to_world(new_obj);
	if type(POS) == "table" then
		new_obj:set_pos( POS )
	end
	
	return new_obj;
end

function spawn_entity_from_table(entity_desc_table, pos)
	if(entity_desc_table == nil) then
		engine.warning( " spawn_entity_from_table, table must be specified!");
		return;
	end
	
	return spawn_entity(entity_desc_table.classname,
						nil, entity_desc_table.props, pos);
end