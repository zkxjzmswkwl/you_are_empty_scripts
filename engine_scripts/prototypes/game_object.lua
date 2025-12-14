------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Базовый прототип для игрового объекта
------------------------------------------------------------------------

-- общая часть
game_object = {
	-- указатель на соответствующий объект из CPP,
	-- инициализируется фабрикой при создании объекта
	-- __object будет хранить указатель
};

function game_object:register_properties(prop_registry)
end

-- Читаем параметры звука и добавляем звук через add_sound.
-- Используется в weapon_basic и actor_basic
function game_object:read_sound(w, head_mode, 
									default_vol, 
									default_pitch, 
									default_min_dist, 
									default_max_dist)
	assert(w.snd ~= nil);

	local snd_vol = default_vol;
	local snd_pitch = default_pitch;
	local snd_min_dist = default_min_dist;
	local snd_max_dist = default_max_dist;
	
	local snd_resource = SND_ALL_RESOURCES;
	local snd_priority = 0;
				
	local snd_ai_min_dist = nil;
	local snd_ai_max_dist = nil;
	local snd_ai_type = nil;
	
	local snd_play_once = nil;

	-- если задана специальная таблица с параметрами звуками, читаем из нее
	if(w.snd_params ~= nil) then
		if(w.snd_params.vol ~= nil) then snd_vol = w.snd_params.vol end
		if(w.snd_params.pitch ~= nil) then snd_pitch = w.snd_params.pitch end
		if(w.snd_params.min_dist ~= nil) then snd_min_dist = w.snd_params.min_dist end
		if(w.snd_params.max_dist ~= nil) then snd_max_dist = w.snd_params.max_dist end
		if(w.snd_params.resource ~= nil) then snd_resource = w.snd_params.resource; end
		if(w.snd_params.priority ~= nil) then snd_priority = w.snd_params.priority; end

		snd_ai_min_dist = w.snd_params.ai_min_dist;
		snd_ai_max_dist = w.snd_params.ai_max_dist;
		snd_ai_type = w.snd_params.ai_type;
		snd_play_once = w.snd_params.play_once;
	end
		
	-- параметры из таблицы могут быть перетерты
	if(w.snd_vol ~= nil) then snd_vol = w.snd_vol end
	if(w.snd_pitch ~= nil) then snd_pitch = w.snd_pitch end
	if(w.snd_min_dist ~= nil) then snd_min_dist = w.snd_min_dist end
	if(w.snd_max_dist ~= nil) then snd_max_dist = w.snd_max_dist end
	
	if(w.snd_resource ~= nil) then snd_resource = w.snd_resource; end
	if(w.snd_priority ~= nil) then snd_priority = w.snd_priority; end
		
	if(w.snd_ai_min_dist ~= nil) then snd_ai_min_dist = w.snd_ai_min_dist; end
	if(w.snd_ai_max_dist ~= nil) then snd_ai_max_dist = w.snd_ai_max_dist; end
	if(w.snd_ai_type ~= nil) then snd_ai_type = w.snd_ai_type; end
	
	if(w.snd_play_once ~= nil) then snd_play_once = w.snd_play_once; end

	local snd_idx = self:add_sound(w.snd, head_mode, snd_vol, 
									snd_pitch, snd_min_dist, snd_max_dist, snd_resource, snd_priority);
				
	if(self:is_server_object()) then
		self:set_sound_ai_params(snd_idx, snd_ai_min_dist, snd_ai_max_dist, snd_ai_type);
	end
	
	w.snd_play_once = snd_play_once;
				
	return snd_idx;
end


------------------------------------
-- серверная часть 
sv_game_object = utils.inherit(game_object);

-- подтаблица в объекте, в которой нужно создавать
-- переменные, которые должны сериализироваться на 
-- функциях on_save_state и on_load_state
sv_game_object.io = {};

function sv_game_object:on_init()
end


function sv_game_object:on_load_state(dreader)
	if (dreader == nil) then return end
	
	self.io = engine.load_lua_object(dreader);
end

-- запись текущего состояния
function sv_game_object:on_save_state(dwriter)
	engine.save_lua_object(self.io, dwriter);
end

function sv_game_object:on_shutdown()
	self.m_destroyed = true;
end

function sv_game_object:on_update(dt)
end

-- передается таблица в которой записаны пары - {имя, значение}
function sv_game_object:init_properties_from_table(properties_table)
	for i,v in ipairs(properties_table) do
		self:set_property_value_by_name(v[1], v[2]);
	end
end

function sv_game_object:is_destroyed()
	return (self.m_destroyed == true);
end

function sv_game_object:is_server_object()
	return true;
end

function sv_game_object:is_client_object()
	return false;
end
------------------------------------
-- клиентская
cl_game_object = utils.inherit(game_object);

function cl_game_object:on_init()
end

function cl_game_object:on_shutdown()
	self.m_destroyed = true;
end

function cl_game_object:on_update(dt)
end


function cl_game_object:is_server_object()
	return false;
end

function cl_game_object:is_client_object()
	return true;
end

function cl_game_object:is_destroyed()
	return (self.m_destroyed == true);
end
