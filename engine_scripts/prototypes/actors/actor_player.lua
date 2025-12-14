------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Player, скриптовое представление актера, которым управляет игрок
------------------------------------------------------------------------

actor_player = {};

-- Настройки актера
include("actor_player_design.lua");

-------------------------------------
-- общая часть
function actor_player:register_properties(prop_registry)
	-- Символическое имя игрока
	self:register_property(prop_registry, "player_name", "-unknown-")

	-- запомнить ссылки на properties для быстрого доступа к ним
	self.health_prop = self:get_property_by_name("health");
end

function actor_player:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_player = utils.inherit(sv_game_object, actor_player);

function sv_actor_player:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry);
	actor_player.register_properties(self, prop_registry);
end

function sv_actor_player:on_init(data_reader)
	self:init_properties_from_table(self.properties_design);

	sv_game_object.on_init(self);
	actor_player.on_init(self);
	
	-- запомнить ссылки на properties для быстрого доступа к ним
	self.run_forward_speed_prop		= self:get_property_by_name("run_forward_speed");
	self.run_backward_speed_prop	= self:get_property_by_name("run_backward_speed");
	self.run_strafe_speed_prop		= self:get_property_by_name("run_strafe_speed");
	self.walk_forward_speed_prop	= self:get_property_by_name("walk_forward_speed");
	self.walk_backward_speed_prop	= self:get_property_by_name("walk_backward_speed");
	self.walk_strafe_speed_prop		= self:get_property_by_name("walk_strafe_speed");
	
	-- Создаем эффекты получения повреждений
	if type(self.m_damage_levels) == "table" then
	
		-- Перебираем уровни повреждений
		for k, level in pairs(self.m_damage_levels) do
		
			if type(level) == "table" then
			
				-- Таблица визуализации полученного повреждения
				local damage_vis = level.damage_visualization	
				if type(damage_vis) == "table" then
			
					-- Перебираем типы повреждений
					for k, v in pairs(damage_vis) do
					
						if type(v) == "table" then
						
							-- Создаем постпроцесс. Id сохраним в той же таблице damage_visualization
							if type(v.pp_name) == "string" then
								
								local pp_id = engine.get_post_process_id( v.pp_name )
								if pp_id ~= -1 then
									v.pp_id = pp_id
								else
									engine.warning("Cannon create '" .. v.pp_name .. "' damage postprocess")
								end
							end
							
							-- Эффекты создаются при первом использовании. 
							-- При полученнии повреждения.
							
						end
					end
				end
			end
		end
	end
	
	-- Таблица, хранящая идентификаторы загруженных эффектов повреждения
	self.m_damage_effects = {}
	
	-- Постпроцесс смерти	
	self.m_pp_death_id		= engine.get_post_process_id("death");
end

-------------------------------------
function sv_actor_player:on_load_state(dreader)
	sv_game_object.on_load_state(self,  dreader);

	if dreader then 
		-- Загрузка из сейва
		-- Не требуется инициализировать инвентарь
		self.m_inventory_initialized = true
	end
end

-------------------------------------
function sv_actor_player:init_inventory()

	-- Инициализируем только один раз
	if self.m_inventory_initialized then
		return
	else
		self.m_inventory_initialized = true
	end

	local actor_props = self.spawn_props
	
	if type(actor_props) ~= "table" then
		-- У актера нет таблицы инициализации инвентаря
		
		local actor_spawn_props_default = _G["actor_spawn_props_default"]
	
		if type(actor_spawn_props_default) == "table" then
			-- Есть ли таблица для уровня
			actor_props = actor_spawn_props_default[engine.get_level_name()]

			if type(actor_props) ~= "table" then
				-- Нет таблицы для уровня, пытаемся использовать таблицу по умолчанию
				actor_props = actor_spawn_props_default["default"]	
			end
		end
	end
	
	-- Если не смогли найти таблицу инициализации инвентаря, то уходим
	if type(actor_props) ~= "table" then return end
	
	-- Считываем и устанавливаем здоровье актера
	if actor_props.health then
		self:set_health(actor_props.health)
	end

	-- Считываем и устанавливаем броню
	if actor_props.armor then
		self:set_armor(actor_props.armor)
	end
	
	-- Синхронизируем, чтобы клиент как можно скорее узнал о новом значении
	self:instant_properties_synchronize();
	
	-- Добавляем предметы в инвентарь
	if (type(actor_props.inventory) == "table") then
		for i, v in pairs(actor_props.inventory) do
			if (type(v) == "table")	then
				-- Создаем необходимое количество указанных предметов
				for cnt = 1, v.count do
					local entity = engine.spawn_entity(v.name);
					engine.add_entity_to_world(entity);
					
					-- Если это оружие, то нужно его зарядить
					if (entity.m_clip_size) then
						entity:set_property_value_by_name("loaded_ammo", entity.m_clip_size)
					end
					
					-- Объект будет уничножен, если он окажется лишним
					local destroy_prop = entity:get_property_by_name("destroy_if_not_taken");			
					if destroy_prop ~= nil then
						entity:set_property_value(destroy_prop, true);
					end
					
					self:add_to_inventory(entity);
										
				end
			end
		end
	end
end

-------------------------------------
function sv_actor_player:on_update(dt)
	sv_game_object.on_update(dt);
	
	local max_health = self:get_max_health();
	local health_to_add = self.m_health_regeneration; -- скорость регенерации в секунду
	health_to_add = (health_to_add * dt)/1000;
	if(max_health > self:get_health()) then
		if(health_to_add + self:get_health() > max_health) then
			health_to_add = max_health - self:get_health();
		end
		self:add_health(health_to_add);
	end

--	if(self.m_need_jump == true and	self:get_behavior_state() ~= BHV_JUMP and self:get_behavior_state() ~= BHV_FALL) then
		-- выполняем отложенный прыжок
--		self:set_behavior_move(0, 0, 0, 0, 1, 0);
--		self.m_need_jump = false
--	end
end

-------------------------------------
function sv_actor_player:on_event(event_id, event)
	if event_id == EVENT_DAMAGE
	then
		--local damage_type, damage, impulse, dir, pos, normal, element_id = parse_event(event)
	end
end

-------------------------------------
function sv_actor_player:on_damage(damage, damage_type)

	--console.print("player damage "..damage)
	
	if not self.m_visualize_damage then return end
	
	-- Определяем степень повреждения и отображаем эффект, проигрываем постпроцесс
	if type(self.m_damage_levels) == "table" then
	
		for k, level in pairs(self.m_damage_levels) do
		
			if type(level) == "table" then
			
				if level.low <= damage then
					
					if level.high == nil or damage <= level.high then
						-- Данный уровень повреждения соответствует полученному повреждению 
						
						-- Таблица визуализации полученного повреждения
						local damage_vis = level.damage_visualization
						if type(damage_vis) == "table" then
						
							-- Есть ли запись для полученного типа повреждения
							local damage_type_tbl = damage_vis[damage_type]
							if type(damage_type_tbl) == "table" then
							
								-- Проигрываем постпроцесс
								if damage_type_tbl.pp_id then
									self:apply_post_process( damage_type_tbl.pp_id )
								end
								
								-- Создаем эффект. Id сохраним в той же таблице damage_visualization
								-- Создаем только при первом использовании
								if damage_type_tbl.effect_id == nil then
								
									if type(damage_type_tbl.effect_name) == "string" then
									
										local template_id = self:add_effect_template(damage_type_tbl.effect_name)
										local effect_id = self:create_effect(template_id)
										if effect_id ~= -1 then
											damage_type_tbl.effect_id = effect_id
											table.insert(self.m_damage_effects, effect_id)
										else
											engine.warning("Cannon create '" .. damage_type_tbl.effect_name .. "' damage effect")
										end
									end
								else
									-- Проигрываем эффект	
									self:reset_effect(damage_type_tbl.effect_id)
								end
								
								-- Прекращаем поиск
								break;
							end
						end
					end	
				end	
			end
		end
	end
	
end

-------------------------------------
function sv_actor_player:on_death()
	--console.print("apply_post_process(self.m_pp_death_id)")
	self:apply_post_process(self.m_pp_death_id);
	self:activate_death(0, false);
end

-------------------------------------
function sv_actor_player:on_shutdown()
	
	-- Освобождаем эффекты повреждений
	if self.m_damage_effects then
		
		for k, v in pairs(self.m_damage_effects) do
			self:release_effect(v)	
		end		
	end
end

-- изменение состояния carrier-а
function sv_actor_player:on_bhv_state_change(bhv_state, bhv_prev_state)
	--sv_actor_basic.on_bhv_state_change(self, bhv_state, bhv_prev_state)
	
	local bhv_state = self:get_behavior_state();
	if(bhv_state == BHV_JUMP) then
		self.m_need_jump = 0
	end	
end

-------------------------------------
-- описание actions

-------------------------------------
-- ACTION_MOVE действие передвижения
-------------------------------------
function sv_actor_player:action_move(id, input_params, output_params)

	forward, backward, left, right, up, down, acceleration, deceleration = engine.data_stream_parse(input_params, actor.get_action_input_types(id));

	-- .hack кнопка acceleration для игрока работает на оборот - замедляет игрока
	if(acceleration == 1) then
		self.m_acceleration = 0;
	else
		self.m_acceleration = 1;
	end	

	----------------------------------------
	if(forward == 1) then
		if(self.m_acceleration == 1) then
			self:set_walk_speed(self:get_property_value(self.run_forward_speed_prop));
		else
			self:set_walk_speed(self:get_property_value(self.walk_forward_speed_prop));
		end
	elseif(backward == 1) then
		if(self.m_acceleration == 1) then
			self:set_walk_speed(self:get_property_value(self.run_backward_speed_prop));
		else
			self:set_walk_speed(self:get_property_value(self.walk_backward_speed_prop));
		end
	elseif(left == 1 or right == 1) then
		if(self.m_acceleration == 1) then
			self:set_walk_speed(self:get_property_value(self.run_strafe_speed_prop));
		else
			self:set_walk_speed(self:get_property_value(self.walk_strafe_speed_prop));
		end
	end
	
	if(up == 1 and self.m_prev_up ~= 1) then
		-- нажатие клавишы прыжка (фронт)
		self.m_need_jump = 1
	elseif(self.m_prev_up == 1 and up ~= 1) then
		-- отпускание клавишы прыжка (спад)
		self.m_need_jump = 0
	end
	self.m_prev_up = up
	
	-- передать команды физическому carrier-у
	self:set_behavior_move(forward, backward, left, right, self.m_need_jump, down);
end

-------------------------------------
-- ACTION_ATTACK действие атаки
-------------------------------------
function sv_actor_player:action_attack(id, input_params, output_params)
	target_id, attack_type = engine.data_stream_parse(input_params, actor.get_action_input_types(id));
	
	if(attack_type == ATTACK_PRIMARY) then
		self:attack_primary(target_id);
	elseif(attack_type == ATTACK_SECONDARY) then
		self:attack_secondary(target_id);
	end
end

function sv_actor_player:attack_primary(target_id)
end

function sv_actor_player:attack_secondary(target_id)
end


-- отыгрывание эффекта шагов
function sv_actor_player:make_step()

	if(self.m_acceleration == 1) then
		engine.broadcast_ai_sound_event(self, self, self:get_pos(), 
					snd_actor_steps_run.ai_min_dist,	
					snd_actor_steps_run.ai_max_dist,
					snd_actor_steps_run.ai_type);
	end				
end

----------------------------------------------------------------------------------
-- Выбирает следущее оружие, учитывая приоритет
function sv_actor_player:select_weapon(_select_type, _cur_priority)
	
	local max_priority = 0
	local min_priority_diff = 1000000 -- заведомо большое число
	local next_weapon = nil
	
	-- Перебираем все слоты и пытаемся найти оружие с максимальным приоритетом
	for i, slot_name in pairs(g_weapon_slots) do
		
		local weapons = self:get_all_from_inventory(slot_name)
		if type(weapons) ~= "table" then
			continue
		end
			
		-- Перебираем все оружия данного слота
		for k, weapon in pairs(weapons) do	
			
			-- Нельзя выбрать weapon_missile без патронов
			if weapon.m_missile_ammo_class ~= nil and weapon:is_empty() then
				continue
			end
		
			local priority = weapon:get_property_value_by_name("priority")
			
			if _select_type == NEXT_WEAPON then
				-- Ищем оружие с приоритетом больше текущего, но максимально близким к текущему приоритету
				local priority_diff = math.abs(_cur_priority - priority)
				if (priority_diff < min_priority_diff) and (priority > _cur_priority) then
					min_priority_diff = priority_diff
					next_weapon = weapon
				end
			elseif _select_type == PREV_WEAPON then
				-- Ищем оружие с приоритетом меньше текущего, но максимально близким к текущему приоритету
				local priority_diff = math.abs(_cur_priority - priority)
				if (priority_diff < min_priority_diff) and (priority < _cur_priority) then
					min_priority_diff = priority_diff
					next_weapon = weapon
				end
			elseif  _select_type == BEST_WEAPON then
				-- Ищем оружие с наибольшим приоритетом
				if priority > max_priority then
				
					-- Незаряженный weapon_firearm не попадает в эту категорию
					if (weapon.is_empty ~= nil) and weapon:is_empty() then
						continue
					end
					
					max_priority = priority
					next_weapon = weapon
				end
			end
		end
			
	end
	
	-- Если ничего подходящего не нашли, то остаемся с текущим оружием
	if not next_weapon then 
		return false
	end
	
	-- Нашли следующее оружие. Выбираем его.
	self:select_holdable(next_weapon)
	
	return true;

end

------------------------------------
-- клиентская
cl_actor_player = utils.inherit(cl_game_object, actor_player);

function cl_actor_player:on_hit(hit_pos, hit_dir, hit_amount, damage_type)

	local damage = hit_amount*100
	local effector_name = "camera_hit"
		
	-- Определяем степень повреждения и отыгрываем эффектор
	if type(self.m_damage_levels) == "table" then
	
		for k, level in pairs(self.m_damage_levels) do
		
			if type(level) == "table" then
			
				if level.low <= damage then
					
					if level.high == nil or damage <= level.high then
						-- Данный уровень повреждения соответствует полученному повреждению 
						
						-- Таблица визуализации полученного повреждения
						local damage_vis = level.damage_visualization
						if type(damage_vis) == "table" then
						
							-- Есть ли запись для полученного типа повреждения
							local damage_type_tbl = damage_vis[damage_type]
							if type(damage_type_tbl) == "table" then
							
								if type(damage_type_tbl.effector_name) == "string" then
				
									effector_name = damage_type_tbl.effector_name
									-- Прекращаем поиск
									break;
								end
							end
						end
					end	
				end	
			end
		end
	end

	self:apply_effector(EFF_TARGET_CAMERA, effector_name, hit_pos, hit_dir, hit_amount*1000/2);
end

function cl_actor_player:on_player_death()
	self:apply_effector(EFF_TARGET_CAMERA, "camera_death");
end

function cl_actor_player:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	actor_player.register_properties(self, prop_registry);
end

function cl_actor_player:on_init()
	cl_game_object.on_init(self);
	actor_player.on_init(self);
--[[
	-- hud
	self:create_hud_page("hud_actor", "hud_actor");
	self.m_hud_health			= self:get_hud_element("health_indicator");
	self.m_hud_ammo_group		= self:get_hud_element("ammo_group");
	self.m_hud_ammo_loaded		= self:get_hud_element("ammo_loaded_indicator");
	self.m_hud_ammo_all			= self:get_hud_element("ammo_all_indicator");
	self.m_hud_ammo_icons		= self:get_hud_element("ammo_icons");
	self.m_hud_holdable_icons	= self:get_hud_element("holdable_icons");
	self.m_last_ammo_type		= nil
	self.m_hud_last_hold_time	= 0
	self:hud_event(self.m_hud_holdable_icons, HUD_EVENT_HIDE);
--]]
	self.m_last_hold_time = 0
	
	self:apply_effector(EFF_TARGET_CAMERA, "camera_bobbing");
	self:apply_effector(EFF_TARGET_CAMERA, "camera_bobbing_sit");
	self:apply_effector(EFF_TARGET_CAMERA, "camera_sit", false);
	self:apply_effector(EFF_TARGET_CAMERA, "camera_roll");

	self:apply_effector(EFF_TARGET_HOLDABLE, "hand_item_bobbing");
	self:apply_effector(EFF_TARGET_HOLDABLE, "hand_item_bobbing_sit");
	self:apply_effector(EFF_TARGET_HOLDABLE, "camera_sit", true);
	self:apply_effector(EFF_TARGET_HOLDABLE, "hand_item_roll");
end                             

function cl_actor_player:on_hold_item(item)
	-- иконка предмета
	if	(item.class_name ~= nil) and
		(item:get_property_value_by_name("silent_hold") == false) and
		(item.m_holdable_icon_id ~= nil) then
		
		-- object state
		self.m_object_state_last_hold_item			= create_object_state_element(self, "last_hold_item")
		self.m_object_state_last_hold_item.__val	= item.m_holdable_icon_id
		self.m_last_hold_time = engine.get_game_time()
	end
end

function cl_actor_player:on_update(dt)
	cl_game_object.on_init(self, dt);
	actor_player.on_init(self, dt);

	if self.m_last_hold_time + actor_holdable_icon_show_time <= engine.get_game_time() then
		self.m_object_state_elements.last_hold_item = nil
	end
	
--[[
	-- жизнь
	self:hud_event(self.m_hud_health, HUD_EVENT_SET_INT, self:get_property_value(self.health_prop));

	-- параметры оружия
	local holdable = self:get_current_holdable();
	if holdable ~= nil and 
			holdable.m_enable_ammo_prop ~= nil and holdable:get_property_value(holdable.m_enable_ammo_prop) then
			
		self:hud_event(self.m_hud_ammo_group, HUD_EVENT_SHOW);

		local ammo_prop = holdable.m_loaded_ammo_prop
		if ammo_prop ~= nil then
			self:hud_event(self.m_hud_ammo_loaded, HUD_EVENT_SET_INT, holdable:get_property_value(ammo_prop));
		end
	
		local ammo_prop = holdable.m_all_ammo_prop
		if ammo_prop ~= nil then
			self:hud_event(self.m_hud_ammo_all, HUD_EVENT_SET_INT, holdable:get_property_value(ammo_prop));
		end
		
		-- иконка типа патронов
		local ammo_type = holdable.m_ammo_type
		if ammo_type ~= nil	and ammo_type ~= self.m_last_ammo_type then
			self.m_last_ammo_type = ammo_type
			for i,field in actor_ammo_icons_table do
				if field[1] == ammo_type then
					self:hud_event(self.m_hud_ammo_icons, HUD_EVENT_SET_INT, field[2]);
					break
				end
			end
		end
	else
		self:hud_event(self.m_hud_ammo_group, HUD_EVENT_HIDE);
	end
--]]
end
