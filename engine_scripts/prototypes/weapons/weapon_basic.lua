------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Weapon Basic 
------------------------------------------------------------------------

-- параметры для звуков, которые могут быть использованы для конкретных реализаций
-- оружия


snd_weapon_shot = {
	ai_min_dist = 5;
	ai_max_dist = 20;
	
	priority = 1;
	resource = 2;
	
	ai_type = AI_SOUND_DANGER;
}

snd_weapon_reload = {
	ai_min_dist = 1;
	ai_max_dist = 6;
	
	priority = 2;
	resource = 4;
	
	ai_type = AI_SOUND_DANGER;
}


snd_weapon_common = {
	ai_min_dist = 1;
	ai_max_dist = 6;
	
	priority = 1;
	resource = 1;
	
	ai_type = AI_SOUND_DANGER;
}



weapon_basic = {};

-- общая часть
weapon_basic.properties_design =
{
	{ "sound_on_take",	"Player_Take_Weapons.wav"},
};

-- Настройка параметров визуализации моделей от первого лица
weapon_basic.fp_model_render_params = {
	depth_near	= 0.0,
	depth_far	= 0.2,
	aspect		= 1024/768,
	z_near		= 1.0,
	z_far		= 200.0,
}

----------------------------------------------------------------------
function weapon_basic:prepare_visual_state_info()
	-- таблица в которую будут записаны индексы для проинициализированных
	-- анимаций и звуков
	self.state_visual_info = {};
	
	-- предварительная обработка таблицы описания состояний
	for i,v in pairs(self.states_design) do
		self.state_visual_info[i] = {};
		
		local total_weight = 0;
		for j,w in ipairs(v) do
			self.state_visual_info[i][j] = {};
			
			-- проинициализировать различные варианты визуализации
			
			self.state_visual_info[i][j].anim_hands		= {}
			self.state_visual_info[i][j].anim_fp		= {}
			self.state_visual_info[i][j].anim_playback	= {}
			
			if(w.snd ~= nil) then
				local snd_idx = self:read_sound(w, true, 0, 1, 1, SND_MAX_DISTANCE);
				self.state_visual_info[i][j].snd = snd_idx;
			end	
			
			local weight = 1;
			if(w.weight ~= nil) then weight = w.weight; end
			total_weight = total_weight + weight;
		end
		
		-- перевести веса в соответствующие
		-- разбиения отрезка от 0 до 1
		for j,w in ipairs(v) do
		
			local weight = 1;
			if(w.weight ~= nil) then weight = w.weight; end	
		
			local distribution = weight/total_weight;
			if(j > 1) then
				distribution = distribution + self.state_visual_info[i][j-1].distribution;
			end
			self.state_visual_info[i][j].distribution = distribution;
		end
	end
end

----------------------------------------------------------------------
-- Добавляет анимации в соответствии с именем игрока
function weapon_basic:add_animations(_player_name)

	for i,v in pairs(self.states_design) do
		for j,w in ipairs(v) do
			if(w.anim == nil) then
				console.print("ERROR!!! no valid animation provided "..j.." "..i);
				assert(nil and "no valid animation provided");
			end
			
			local anim_speed = v.anim_speed and v.anim_speed or 1;
			if(w.anim_speed ~= nil) then
				anim_speed = w.anim_speed;
			end
			
			local anim_playback = v.anim_playback and v.anim_playback or ANIM_PB_ONCE;
			if(w.anim_playback ~= nil) then
				anim_playback = w.anim_playback;
			end
						
			local anim_bone_group = v.anim_bone_group and v.anim_bone_group or "";
			if(w.anim_bone_group ~= nil) then
				anim_bone_group = w.anim_bone_group;
			end
			
			local anim_blend_in_time = v.anim_blend_in_time;
			if(w.anim_blend_in_time ~= nil) then
				anim_blend_in_time = w.anim_blend_in_time;
			end
			
			local anim_blend_out_time = v.anim_blend_out_time;
			if(w.anim_blend_out_time ~= nil) then
				anim_blend_out_time = w.anim_blend_out_time;
			end			

			
			------------------------------------------			
			local anim_idx_hands = self:add_animation(self.m_model_hands[_player_name], w.anim, anim_playback, anim_speed, anim_bone_group, anim_blend_in_time, anim_blend_out_time);
			local anim_idx_fp = self:add_animation(self.m_model_fp[_player_name], w.anim, anim_playback, anim_speed, anim_bone_group, anim_blend_in_time, anim_blend_out_time);
			
			self.state_visual_info[i][j].anim_hands[_player_name] = anim_idx_hands;
			self.state_visual_info[i][j].anim_fp[_player_name] = anim_idx_fp;
			self.state_visual_info[i][j].anim_playback[_player_name] = anim_playback;
		end
	end
end

----------------------------------------------------------------------
function weapon_basic:get_cur_player_name()
	local cur_player_name = self:get_property_value_by_name("cur_player_name")
	return (cur_player_name ~= "-nil-") and cur_player_name or nil
end

----------------------------------------------------------------------
-- Играет ли указанный игрок на уровне
function weapon_basic:is_player_playing(_player_name, _level_name)
	
	local is_playing = false
	
	if g_players_on_levels then
		-- Если используется таблица g_players_on_levels, то имя игрока должно быть
		-- в данной таблице для текущего уровня
		if _level_name then
			local players_on_this_level = g_players_on_levels[_level_name]
			if players_on_this_level then
				for i, p in pairs(players_on_this_level) do
					if p == _player_name then
						is_playing = true
						break
					end
				end
			else
				-- Такого уровня нет в таблице g_players_on_levels. Играют все.
				is_playing = true
			end
		end
	else
		-- Таблица g_players_on_levels не используется. Играют все.
		is_playing = true
	end
	
	return is_playing
end

----------------------------------------------------------------------
function weapon_basic:register_properties(prop_registry)

	-- Имя текущего игрока, подобравшего данное оружие.
	self:register_property(prop_registry, "cur_player_name", "-nil-")
	
	-- Приоритет данного оружия. Влияет на то, какое оружие автоматически
	-- выбирается следующим, когда у текущего оружия заканчиваются патроны.
	self:register_property(prop_registry, "priority", 0)
	
	-- Объект подлежит уничтожению
	self:register_property(prop_registry, "marked_to_delete", false)

	-- запомнить ссылки на properties для быстрого доступа к ним
	self.m_enable_ammo_prop	= self:get_property_by_name("enable_ammo");
	self.m_loaded_ammo_prop	= self:get_property_by_name("loaded_ammo");
	self.m_all_ammo_prop	= self:get_property_by_name("all_ammo");
end

----------------------------------------------------------------------
function weapon_basic:on_init()
		
	-- Массив моделей рук для всех игроков
	self.m_model_hands = {}
	-- Массив моделей оружия для всех игроков
	self.m_model_fp = {}
	
	-- Загружаем модели рук и оружия для игроков
	-- Инстанцироваться же они будут на cl_weapon_basic:on_take
	for player_name, v in pairs(self.m_models_names) do
	
		-- Загружаем модели только для тех игроков, которые играют на текущем уровне
		if g_players_on_levels then
		
			-- Играет ли игрок на данном уровне
			local is_playing = false
			
			local level_name = engine.get_level_name()
			
			if level_name then
			
				local players_on_this_level = g_players_on_levels[level_name]
				
				if players_on_this_level then
				
					for j, p in pairs(players_on_this_level) do
					
						if p == player_name then
							is_playing = true
							break
						end
						
					end
					
				else
					-- Такой уровень не задан в таблице. Предполагаем, что на нем играют все игроки.
					is_playing = true
				end
				
				if not is_playing then 
					-- Игрок не играет на данном уровне. Не загружаем модели для него.
					continue
				end
			end
			
		end
		
		self.m_model_hands[player_name] = self:add_model(v[1], true);
		self.m_model_fp[player_name] = self:add_model(v[2], true);
	end
	
	self:prepare_visual_state_info();
end


------------------------------------
-- серверная часть 
sv_weapon_basic = utils.inherit(sv_game_object, weapon_basic);

-----------------------------------------------------------------------------
-- запустить анимацию и звук, ассоцированные с текущим записью в таблице
function sv_weapon_basic:visualize_state(fsm, states_visual_info_table, state_name, visual_idx)

	if not self:get_cur_player_name() then return end
	
	local visual_info = states_visual_info_table[state_name];
	
	--console.print("visualize_state name:"..state_name);
	assert(type(visual_info) == "table", "visual_info for state:"..state_name.." is not table");
	
	-- выбрать одну из записей используя вероятность
	local rnd = math.random();
	
	if(visual_idx == nil) then
		for i,v in ipairs(visual_info) do
			visual_idx = i;
			if(rnd < v.distribution) then break; end
		end
	end
	
	if(self:is_animation_playing(visual_info[visual_idx].anim_hands[self:get_cur_player_name()]) == false or
			visual_info[visual_idx].anim_playback[self:get_cur_player_name()] == ANIM_PB_ONCE) then
		self:play_animation(visual_info[visual_idx].anim_hands[self:get_cur_player_name()]);
		self:play_animation(visual_info[visual_idx].anim_fp[self:get_cur_player_name()]);
	end
	
	-----------------
	local anim_length = self:get_animation_length_speed(visual_info[visual_idx].anim_hands[self:get_cur_player_name()]);
	self:set_fsm_update_time(fsm, anim_length);
	
	-----------
	--console.print(" play anim length = "..anim_length.." get_game_time "..engine.get_game_time());
	-----------	
	if(visual_info[visual_idx].snd ~= nil) then
		local owner = self:get_owner(); 
		if owner ~= nil then
			self:play_sound(visual_info[visual_idx].snd, owner:get_id(), false, true);
		end
	end
	
	self.m_current_anim_length = anim_length;
	
	return visual_idx, anim_length;
end

-----------------------------------------------------------------------------
function sv_weapon_basic:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry);
	weapon_basic.register_properties(self, prop_registry);

	self:init_properties_from_table(self.properties_design);
end

----------------------------------------------------------------------
function sv_weapon_basic:on_init()
		
	sv_game_object.on_init(self);
	weapon_basic.on_init(self);

	self.main_fsm		= self:add_fsm("main_fsm");
	self.show_state		= self:add_fsm_state(self.main_fsm, "show_state", self.on_enter_show, self.on_update_show, nil, nil, true);
	self.hide_state		= self:add_fsm_state(self.main_fsm, "hide_state", self.on_enter_hide, self.on_update_hide, nil, nil, true);
	self.hidden_state	= self:add_fsm_state(self.main_fsm, "hidden_state", self.on_enter_hidden, nil, nil, nil);
	self.idle_state		= self:add_fsm_state(self.main_fsm, "idle_state", self.on_enter_idle, self.on_update_idle, nil, nil);
	self.fire_state		= self:add_fsm_state(self.main_fsm, "fire_state", self.on_enter_fire, self.on_update_fire, nil, nil, true);
	
	self:change_fsm_state(self.main_fsm, self.hidden_state, true);
	self:set_fsm_update_time(self.main_fsm, 0);

end

----------------------------------------------------------------------
function sv_weapon_basic:on_event(event_id, event)
	
	local cur_state = self:get_cur_fsm_state(self.main_fsm);

	if event_id == EVENT_HOLDABLE_SELECT then
		self:change_fsm_state(self.main_fsm, self.show_state, true);
	end
	if event_id == EVENT_HOLDABLE_DESELECT then
		if (cur_state ~= self.hide_state) then
			self:change_fsm_state(self.main_fsm, self.hide_state, true);
		end
	end
	if event_id == EVENT_LEVER1_DOWN then
		self:event_lever1_down();
	end
	if event_id == EVENT_LEVER1_UP then
		self:event_lever1_up();
	end
	if event_id == EVENT_LEVER2_DOWN then
		self:event_lever2_down();
	end
	if event_id == EVENT_LEVER2_UP then
		self:event_lever2_up();
	end
	if event_id == EVENT_RELOAD then
		self:event_reload();
	end
end

----------------------------------------------------------------------
function sv_weapon_basic:event_lever1_down()
	if(self:get_cur_fsm_state(self.main_fsm) == self.idle_state) then
		self:change_fsm_state(self.main_fsm, self.fire_state, true);
	end
end

----------------------------------------------------------------------
function sv_weapon_basic:event_lever1_up()
end

----------------------------------------------------------------------
function sv_weapon_basic:event_lever2_down()
end

----------------------------------------------------------------------
function sv_weapon_basic:event_lever2_up()
end

----------------------------------------------------------------------
function sv_weapon_basic:is_hidden()
	if(self:get_cur_fsm_state(self.main_fsm) == self.hidden_state) then
		return true;
	else
		return false;
	end
end

----------------------------------------------------------------------
function sv_weapon_basic:on_selected()
end

----------------------------------------------------------------------
function sv_weapon_basic:on_deselected()
end

----------------------------------------------------------------------
function sv_weapon_basic:on_take(_actor)

	local marked_to_delete = self:get_property_value_by_name("marked_to_delete")
	
	if _actor:is_player_controlled() and not marked_to_delete then 
		-- Выбираем модель оружия и модель рук, соответствующие подобравшему игроку
		if self:get_cur_player_name() then
			self:hide_model(self.m_model_hands[self:get_cur_player_name()], true);
			self:hide_model(self.m_model_fp[self:get_cur_player_name()], true);
		end
		
		-- переопределить свой fov, как fov хозяина
		self.m_normal_fov = _actor:get_property_value_by_name("view_fov");
		
		-- Сообщение об ошибке, если для данного игрока в таблице m_models_names нет записи.
		local player_name = _actor:get_property_value_by_name("player_name")
		assert(type(self.m_models_names[player_name]) == "table", "Proper models not found in '"..self.class_name..".m_models_names' for player '"..player_name.."'\n");
		
		local level_name = engine.get_level_name()
		assert(self:is_player_playing(player_name, level_name), 
			"Player '"..player_name.."' not specified for level '"..level_name.."' in table 'g_players_on_levels'");
		
		-- Запоминаем игрока, подобравшего данное оружие.
		self:set_property_value_by_name("cur_player_name", player_name);
		
		-- Синхронизируем, чтобы клиент как можно скорее узнал о новом значении
		self:instant_properties_synchronize();
		
		-- Добавляем анимации к предварительно загруженной модели
		self:add_animations(player_name)	
	end
end

----------------------------------------------------------------------
function sv_weapon_basic:on_drop()

	if self:get_cur_player_name() then
		self:hide_model(self.m_model_hands[self:get_cur_player_name()], true);
		self:hide_model(self.m_model_fp[self:get_cur_player_name()], true);
	end
	
end

----------------------------------------------------------------------
function sv_weapon_basic:on_enter_show()
	--engine.show_msg_string(""..self.class_name)

	if self:get_cur_player_name() then
		self:hide_model(self.m_model_hands[self:get_cur_player_name()], false);
		self:hide_model(self.m_model_fp[self:get_cur_player_name()], false);
	end

	self:visualize_state(self.main_fsm, self.state_visual_info, "show");
end

function sv_weapon_basic:on_update_show()
	self:change_fsm_state(self.main_fsm, self.idle_state, true);
end

----------------------------------------------------------------------------------
function sv_weapon_basic:on_enter_idle()
	self:visualize_state(self.main_fsm, self.state_visual_info, "idle");
end

function sv_weapon_basic:on_update_idle()
	self:change_fsm_state(self.main_fsm, self.idle_state, true);
end

----------------------------------------------------------------------------------
function sv_weapon_basic:on_enter_hide()
	self:visualize_state(self.main_fsm, self.state_visual_info, "hide");
end

----------------------------------------------------------------------
function sv_weapon_basic:on_update_hide()

	self:hide_model(self.m_model_hands[self:get_cur_player_name()], true);
	self:hide_model(self.m_model_fp[self:get_cur_player_name()], true);

	self:change_fsm_state(self.main_fsm, self.hidden_state, true);
end

----------------------------------------------------------------------------------
function sv_weapon_basic:on_enter_hidden()
end

----------------------------------------------------------------------------------
function sv_weapon_basic:on_enter_fire()
	self:visualize_state(self.main_fsm, self.state_visual_info, "fire");
end

----------------------------------------------------------------------------------
function sv_weapon_basic:on_update_fire()
	self:change_fsm_state(self.main_fsm, self.idle_state, true);
end

----------------------------------------------------------------------------------
function sv_weapon_basic:on_shutdown()
	sv_game_object.on_shutdown(self);
end

----------------------------------------------------------------------------------
function sv_weapon_basic:on_update(dt)
	sv_game_object.on_update(self,dt);
end


----------------------------------------------------------------------------------
-- клиентская
cl_weapon_basic = utils.inherit(cl_game_object, weapon_basic);

----------------------------------------------------------------------------------
function cl_weapon_basic:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	weapon_basic.register_properties(self, prop_registry);
end

----------------------------------------------------------------------------------
function cl_weapon_basic:on_init()
	cl_game_object.on_init(self);
	weapon_basic.on_init(self);

	self.main_fsm		= self:add_fsm("main_fsm");
	self.show_state		= self:add_fsm_state(self.main_fsm, "show_state", self.on_enter_show, nil, nil, nil);
	self.hide_state		= self:add_fsm_state(self.main_fsm, "hide_state", self.on_enter_hide, nil, nil, nil);
	self.fire_state		= self:add_fsm_state(self.main_fsm, "fire_state", self.on_enter_fire, self.on_update_fire, nil, nil);

	-- object state
	local weapon = create_object_state_element(self, "weapon_basic")
	self.m_object_state_element_sight = create_object_state_element(weapon, "sight_"..self.class_name, 1)
	
	local weapon_icons = create_object_state_element(self, "weapon_icons")
	weapon_icons.__val = self.m_weapon_icon_id
end

----------------------------------------------------------------------------------
function cl_weapon_basic:on_take()
	
	local player_name = self:get_cur_player_name()
	local marked_to_delete = self:get_property_value_by_name("marked_to_delete")
	
	if player_name and not marked_to_delete then
	
		local level_name = engine.get_level_name()
		assert(self:is_player_playing(player_name, level_name), 
			"Player '"..player_name.."' not specified for level '"..level_name.."' in table 'g_players_on_levels'");

		-- Добавляем анимации к предварительно загруженной модели
		self:add_animations(player_name)
		
		-- Инстанцируем предварительно загруженные модели
		self:instantiate_model(self.m_model_hands[player_name])
		self:instantiate_model(self.m_model_fp[player_name])
		
		--render-свойства для модели, чтоб она корректно выглядела для вида от 1-го лица
		self:set_model_first_person(self.m_model_hands[player_name],
			self.m_model_fov,
			self.fp_model_render_params.depth_near,
			self.fp_model_render_params.depth_far,
			self.fp_model_render_params.aspect,
			self.fp_model_render_params.z_near,
			self.fp_model_render_params.z_far);
			
		self:set_model_first_person(self.m_model_fp[player_name],
			self.m_model_fov,
			self.fp_model_render_params.depth_near,
			self.fp_model_render_params.depth_far,
			self.fp_model_render_params.aspect,
			self.fp_model_render_params.z_near,
			self.fp_model_render_params.z_far);
	end
	
end

----------------------------------------------------------------------------------
function cl_weapon_basic:on_enter_fire()
end

----------------------------------------------------------------------------------
function cl_weapon_basic:on_enter_show()
	--engine.show_msg_string(""..self.class_name)

	--console.print("================== cl_weapon_basic:on_enter_show()");
	--render-свойства для модели, чтоб она корректно выглядела для вида от 1-го лица
	if self:get_cur_player_name() then
		
		self:set_model_first_person(self.m_model_hands[self:get_cur_player_name()],
			self.m_model_fov,
			self.fp_model_render_params.depth_near,
			self.fp_model_render_params.depth_far,
			self.fp_model_render_params.aspect,
			self.fp_model_render_params.z_near,
			self.fp_model_render_params.z_far);
			
		self:set_model_first_person(self.m_model_fp[self:get_cur_player_name()],
			self.m_model_fov,
			self.fp_model_render_params.depth_near,
			self.fp_model_render_params.depth_far,
			self.fp_model_render_params.aspect,
			self.fp_model_render_params.z_near,
			self.fp_model_render_params.z_far);
	end

end

----------------------------------------------------------------------------------
function cl_weapon_basic:on_enter_hide()
	--console.print("================== cl_weapon_basic:on_enter_hide()");
end

----------------------------------------------------------------------------------
-- callbacks
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
function cl_weapon_basic:on_loaded_ammo_changed()
	self.m_object_state_element_ammo_loaded.__val	= self:get_property_value(self.m_loaded_ammo_prop)
end

----------------------------------------------------------------------------------
function cl_weapon_basic:on_all_ammo_changed()
	self.m_object_state_element_ammo_all.__val		= self:get_property_value(self.m_all_ammo_prop)
end
