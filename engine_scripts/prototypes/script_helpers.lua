------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Вспомогательные макросы для более удобного и короткого задания часто 
-- иcпользуемых операций
------------------------------------------------------------------------

------------------------------------------------------------------------
-- Создает игровой объект
#define_begin SPAWN_ENTITY(CLASS_NAME, ENTITY_NAME, PROP_TABLE, POS)

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
	
#define_end

------------------------------------------------------------------------
-- Уничтожает игровые объекты с указанным именем
#define_begin DESTROY_ENTITY(ENTITY_NAME)

	local entities = engine.get_entities_by_name(ENTITY_NAME)
	if type(entities) == "table" then
		for i,entity in pairs(entities) do
			engine.destroy_entity(entity)
		end
	end
	
#define_end

------------------------------------------------------------------------
-- Устанавливает указанное свойство игрового объекта
#define_begin SET_ENTITY_PROPERTY(ENTITY_NAME, PROP_NAME, PROP_VALUE)

	local entities = engine.get_entities_by_name(ENTITY_NAME)
	if type(entities) == "table" then
		for i,entity in pairs(entities) do
			entity:set_property_value_by_name(PROP_NAME, PROP_VALUE)
		end
	end
	
#define_end

------------------------------------------------------------------------
-- Посылает сигнал на входящий слот получателя
#define_begin SEND_EVENT(SENDER_NAME, RECEIVER_NAME, EVENT_NAME, PARAMS_TABLE)
	
	local sender = engine.get_entities_by_name(SENDER_NAME)[1]
	
	local receiver	= engine.get_entities_by_name(RECEIVER_NAME)[1]
	if not receiver then
		engine.warning("SEND_EVENt macro:"
			.. "\nReceiver with name '" .. RECEIVER_NAME .. "' does not exists")	
	else
		receiver:signal(EVENT_NAME, sender, PARAMS_TABLE)
	end
	
#define_end

------------------------------------------------------------------------
-- Добавить связь
#define_begin ADD_LINK(OUTPUT_OBJECT_NAME, OUTPUT_SLOT_NAME, INPUT_OBJECT_NAME, INPUT_SLOT_NAME, DELAY, COUNT, PARAMS)

	local output_obj = engine.get_entities_by_name(OUTPUT_OBJECT_NAME)[1]
	if not output_obj then
		engine.warning("ADD_LINk macro:"
			.. "\noutput object '" .. OUTPUT_OBJECT_NAME .. "' does not exists")
	else
		local output_slot = output_obj:get_output_slot(OUTPUT_SLOT_NAME)
		if not output_slot then
			engine.warning("ADD_LINk macro: object '" .. OUTPUT_OBJECT_NAME .. "':"
			.. "\noutput slot '" .. OUTPUT_SLOT_NAME .. "' does not exists")
		else		
			local input_obj = engine.get_entities_by_name(INPUT_OBJECT_NAME)[1]
			if not input_obj then
				engine.warning("ADD_LINk macro:"
					.. "\ninput object '" .. INPUT_OBJECT_NAME .. "' does not exists")
			else
				local input_slot = input_obj:get_input_slot(INPUT_SLOT_NAME)
				if not input_slot then
					engine.warning("ADD_LINk macro: object '" .. INPUT_OBJECT_NAME .. "':"
					.. "\ninput slot '" .. INPUT_SLOT_NAME .. "' does not exists")
				else
					local params = (type(PARAMS) == "table") and PARAMS or nil
					local delay = (type(DELAY) == "number") and DELAY or 0
					local count = (type(COUNT) == "number" or COUNT == "INF") and COUNT or -1
					output_obj:add_link(output_slot, input_slot, delay, count, params)
				end
			end			
		end
	end
	
#define_end