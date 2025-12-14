------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Базовый класс для огненстрельного оружия.
-- Под огнестрельным понимается оружие с патронами, которое необходимо
-- перезаряжать
------------------------------------------------------------------------

-- общая часть
weapon_firearm = {}

function weapon_firearm:on_init()
end

function weapon_firearm:register_properties(prop_registry)
end	

---------------------------------------------------------------------------------
-- серверная часть 
sv_weapon_firearm = utils.inherit(sv_weapon_basic, weapon_firearm);

---------------------------------------------------------------------------
-- коррекция параметров стрельбы
sv_weapon_firearm.m_sit_disp_k						= 1		-- коэффициент масштабирования разброса в режиме сидя
sv_weapon_firearm.m_sit_recoil_k					= 1		-- коэффициент масштабирования отдачи в режиме сидя
sv_weapon_firearm.m_last_shots_number				= 0		-- число учитываемых последних выстрелов
sv_weapon_firearm.m_one_shot_energy					= 0		-- энергия одного выстрела
sv_weapon_firearm.m_recoil_time_correction_k_min	= 1		-- минимальное значение коэффициента (1 - нет коррекции)
sv_weapon_firearm.m_recoil_time_correction_k_max	= 1		-- максимальное значение коэффициента
sv_weapon_firearm.m_disp_time_correction_k_min		= 1		-- минимальное значение коэффициента (1 - нет коррекции)
sv_weapon_firearm.m_disp_time_correction_k_max		= 1		-- максимальное значение коэффициента

---------------------------------------------------------------------------------
function sv_weapon_firearm:register_properties(prop_registry)
	weapon_firearm.register_properties(self, prop_registry);
	sv_weapon_basic.register_properties(self, prop_registry);
	
	self.m_max_ammo_prop = self:get_property_by_name("max_ammo");
	self:set_property_value(self.m_enable_ammo_prop, true);
end

---------------------------------------------------------------------------------
function sv_weapon_firearm:on_init()
	sv_weapon_basic.on_init(self);
	weapon_firearm.on_init(self);

	-- для включения и выключения режима приближения	
	self.zoom_in_state		= self:add_fsm_state(self.main_fsm, "zoom_in_state", self.on_enter_zoom_in, self.on_update_zoom_in, nil, nil, true);
	self.zoom_out_state		= self:add_fsm_state(self.main_fsm, "zoom_out_state", self.on_enter_zoom_out, self.on_update_zoom_out, nil, nil, true);
	-- дополнительное состояние для выстрела
	self.fire_finish_state	= self:add_fsm_state(self.main_fsm, "fire_finish_state", self.on_enter_fire_finish, self.on_update_fire_finish, nil, nil);
	-- перезарядка обоймы
	self.reload_state	= self:add_fsm_state(self.main_fsm, "reload_state", self.on_enter_reload, self.on_update_reload, nil, nil);
	
	-- параметры для выстрела
	--self.m_bullets_in_shot = 1;
	--self.m_bullet_damage = 10;
	--self.m_bullet_impulse = 10;
	--self.m_bullet_dist = 30;
	--self.m_shot_disp = 2;			-- (град.) дисперсия выстрела 
	--self.m_shot_recoil = 0;		-- (град.) отдача от выстрела 
	----------------------------------------
	-- параметры патронов
	--self.m_ammo_type = "unknown ammo";	-- тип используемых патронов
	--self.m_clip_size = 20;				-- вместимость обоймы
	--self.m_ammo_for_shot = 1;			-- кол-во патронов расходуемых на один выстрел
	
	-- FOV дляразных режимов
	--self.m_normal_fov = 90;
	--self.m_zoomed_fov = 45;
end

---------------------------------------------------------------------------------
function sv_weapon_firearm:set_zoom(zoom_on)
	-- вначале режим приближения выключен
	self.m_is_zoomed = zoom_on;
end

---------------------------------------------------------------------------------
function sv_weapon_firearm:on_event(event_id, event)
	sv_weapon_basic.on_event(self, event_id, event);
end

---------------------------------------------------------------------------------
function sv_weapon_firearm:event_lever1_down()
	--console.print("----------- sv_weapon_firearm:event_lever1_down()");
	local cur_state = self:get_cur_fsm_state(self.main_fsm);
	if self:can_fire() then
		if(cur_state == self.idle_state or 
			(self.fire_finish_interruption_time and 
			cur_state == self.fire_finish_state and 
			self:get_cur_fsm_state_time(self.main_fsm) >= self.fire_finish_interruption_time))
		then
			--console.print("---- self:get_cur_fsm_state_time(self.main_fsm) "..self:get_cur_fsm_state_time(self.main_fsm))	
		
			self:change_fsm_state(self.main_fsm, self.fire_state, true);
		end
	else
		self:event_reload();
	end
	
	if(cur_state == self.zoom_out_state) then
		self.m_reload_after_zoom = false;
	end
end

---------------------------------------------------------------------------------
function sv_weapon_firearm:event_lever2_down()
	-- для включения режима "ZOOM"
	if(self:get_cur_fsm_state(self.main_fsm) == self.idle_state) then
		if(self.m_is_zoomed) then
			self:change_fsm_state(self.main_fsm, self.zoom_out_state, true);
		else
			self:change_fsm_state(self.main_fsm, self.zoom_in_state, true);
		end
	end
	
	if(cur_state == self.zoom_out_state) then
		self.m_reload_after_zoom = false;
	end
end

---------------------------------------------------------------------------------
function sv_weapon_firearm:event_reload()
	if(self:get_cur_fsm_state(self.main_fsm) == self.idle_state or 
		self:get_cur_fsm_state(self.main_fsm) == self.fire_finish_state) then
		if(self:can_reload()) then
			if (self.m_is_zoomed == false) then
				self:change_fsm_state(self.main_fsm, self.reload_state, true);
			else
				self:change_fsm_state(self.main_fsm, self.zoom_out_state, true);
				self.m_reload_after_zoom = true;
			end
		else
			if self:is_empty() then
				-- Закончились патроны - преключаемся на следующее оружие (по приоритету)
				local owner = self:get_owner()
				if owner then
					if not owner:select_weapon(BEST_WEAPON) then
						owner:deselect_current_holdable()
					end
				end
			end
		end
	end	
end

---------------------------------------------------------------------------------
function sv_weapon_firearm:on_use(_actor)

	assert(_actor)
	
	-- Монстры не подбирают патроны
	if not _actor:is_player_controlled() then return end
	
	-- Если в инвентаре есть еще место для патронов, то забираем патроны с оружия,
	-- а само оружие будет удалено при попытке поместить его в инвентарь.
	-- Иначе ничего не делаем с данным оружием.
	
	-- Добавить в инвентарь патроны из оружия
	local taken_ammo = 0
	local all_inventory_ammo = 0
	local already_have = false
	local loaded_ammo = self:get_property_value(self.m_loaded_ammo_prop)
	local all_ammo = self:get_property_value(self.m_all_ammo_prop)
	local max_ammo = self:get_property_value(self.m_max_ammo_prop);
	
	-- Подсчитываем сколько таких предметов уже есть в инвентаре
	local inv_items = _actor:get_all_from_inventory( self.guid )	
	local inv_items_count = table.getn(inv_items)
	
	if (inv_items_count > 0) then
		-- Такое оружие уже есть в инвентаре. Берем все патроны.
		taken_ammo = all_ammo + loaded_ammo
		
		already_have = true
		
		-- Узнаем, сколько патронов в данный момент в инвентаре для такого оружия
		for j, inv_weapon in pairs(inv_items) do
			all_inventory_ammo = inv_weapon:get_property_value_by_name("all_ammo")
			break
		end
	else
		-- Такого оружия еще не было в инвентаре. Берем все патроны, кроме тех которые, в стволе.
		taken_ammo = all_ammo
	end
	
	--engine.warning(self.class_name .. ":\ntaken: "..taken_ammo.."\nall_inventory_ammo: "..all_inventory_ammo.."\nmax: "..max_ammo);
	
	-- После подбора, количество патронов в инвентаре не должно превышать допустимый максимум
	taken_ammo = ((all_inventory_ammo + taken_ammo) > max_ammo) and (max_ammo - all_inventory_ammo) or taken_ammo;
				
	--engine.warning(self.class_name .. "\ntaken: "..taken_ammo);			
	
	-- Добавляем патроны в инвентарь.
	-- Создаем коробку с патронами. Подгоняем размер коробки под "taken_ammo"
	if taken_ammo ~= 0 and self.m_ammo_class then
		local ammo = engine.spawn_entity(self.m_ammo_class)
		ammo:set_property_value_by_name("ammo_capacity", taken_ammo);
		ammo:set_property_value_by_name("ammo_stored", taken_ammo);
		ammo:set_property_value_by_name("destroy_if_not_taken", true);
		engine.add_entity_to_world(ammo)
		_actor:add_to_inventory(ammo)
	end
	
	-- Запрещаем или разрешаем подбор оружия
	if taken_ammo ~= 0 or not already_have then
		self:set_property_value_by_name("is_can_take", true);
		self:set_property_value_by_name("all_ammo", 0);
	else
		self:set_property_value_by_name("is_can_take", false);
	end
	
	if already_have then
		self:set_property_value_by_name("marked_to_delete", true);
		-- Синхронизируем, чтобы клиент как можно скорее узнал о новом значении
		self:instant_properties_synchronize();
	end

end

---------------------------------------------------------------------------------
function sv_weapon_firearm:on_selected()
	sv_weapon_basic.on_selected(self);
	self:set_camera_fov(self.m_normal_fov, 0);
	self:set_zoom(false);
	if self.m_normal_mouse_sens_scale then
		engine.mouse_set_sensetivity_scale(self.m_normal_mouse_sens_scale)
	end
	
	self:calc_ammo_count();
end

---------------------------------------------------------------------------------
function sv_weapon_firearm:on_deselected()
	sv_weapon_basic.on_deselected(self);
	self:set_camera_fov(self.m_normal_fov, 0);
	if self.m_normal_mouse_sens_scale then
		engine.mouse_set_sensetivity_scale(self.m_normal_mouse_sens_scale)
	end	
	self:deactivate_shoot_effects()
end

---------------------------------------------------------------------------------
function sv_weapon_firearm:on_enter_hide()
	sv_weapon_basic.on_enter_hide(self);
	self:set_camera_fov(self.m_normal_fov, 300);
	if self.m_normal_mouse_sens_scale then
		engine.mouse_set_sensetivity_scale(self.m_normal_mouse_sens_scale)
	end
end
---------------------------------------------------------------------------------
-- подсчитать кол-во доступных в инвентаре патронов 
-- и занести результат в 
function sv_weapon_firearm:calc_ammo_count()
	local actor = self:get_owner();
	assert(actor);

	--console.print("-- ----------------- self.m_ammo_type "..self.m_ammo_type);	
	local ammo_list = actor:get_all_from_inventory(self.m_ammo_type);
	
	local ammo_count = 0;
	for k, v in ammo_list do
		assert(v);
		local ammo_in_box = v:get_property_value_by_name("ammo_stored");
		ammo_count = ammo_count + ammo_in_box;
	end
	
	self:set_property_value(self.m_all_ammo_prop, ammo_count);
	
	--console.print("-- ----------------- ammo_count "..ammo_count);
end

----------------------------------------------------------------------------------
function sv_weapon_firearm:can_fire()
	local loaded_ammo = self:get_property_value(self.m_loaded_ammo_prop);
	return (loaded_ammo >= self.m_ammo_for_shot);
end

----------------------------------------------------------------------------------
function sv_weapon_firearm:is_empty()
	local all_ammo = self:get_property_value(self.m_all_ammo_prop) + self:get_property_value(self.m_loaded_ammo_prop)
	return ( all_ammo <= 0 )
end

----------------------------------------------------------------------------------
function sv_weapon_firearm:can_reload()
	if(self:get_property_value(self.m_all_ammo_prop) > 0 and
		self:get_property_value(self.m_loaded_ammo_prop) < self.m_clip_size)
	then
		return true;
	else
		return false;
	end
end

----------------------------------------------------------------------------------
function sv_weapon_firearm:reload_ammo()
--	console.print("-- before m_all_ammo_prop"..self:get_property_value(self.m_all_ammo_prop));
--	console.print("m_loaded_ammo_prop"..self:get_property_value(self.m_loaded_ammo_prop));
	local ammo_current = self:get_property_value(self.m_loaded_ammo_prop);
--	assert(ammo_current < self.m_clip_size); -- THIS BUG WAS!
	if( ammo_current > self.m_clip_size ) 
			then return;
			end
	
	local need_to_load = self.m_clip_size - ammo_current;
	
--	self:set_property_value(self.m_loaded_ammo_prop, self.m_clip_size);
--	self:get_property_value(self.m_loaded_ammo_prop);
	
	local actor = self:get_owner();
	if not actor then return end
	
	local ammo_list = actor:get_all_from_inventory(self.m_ammo_type);
	local ammo_loaded = 0;	
	
	for k, v in ammo_list do
		if (need_to_load == 0) then break end 	 
		
		assert(v);
		local ammo_in_box_prop = v:get_property_by_name("ammo_stored");
		local ammo_in_box = v:get_property_value(ammo_in_box_prop);
		
		if(need_to_load < ammo_in_box) then
			ammo_loaded = ammo_loaded + need_to_load;
			v:set_property_value(ammo_in_box_prop, ammo_in_box - need_to_load);
			need_to_load = 0;
		else
			need_to_load = need_to_load - ammo_in_box;
			v:set_property_value(ammo_in_box_prop, 0);
			ammo_loaded = ammo_loaded + ammo_in_box;
			ammo_in_box = 0;
			v:destroy_object();
		end

				
		self:set_property_value(self.m_loaded_ammo_prop, ammo_current + ammo_loaded);
		--.hack не совсем рационально, self.m_all_ammo_prop надо вычислить из уже имеющихся данных
		self:calc_ammo_count();
		--self:set_property_value(self.m_all_ammo_prop, 
		--		self:get_property_value(self.m_all_ammo_prop) - ammo_loaded);
	end
	
	--console.print("-- after m_all_ammo_prop"..self:get_property_value(self.m_all_ammo_prop));
	--console.print("m_loaded_ammo_prop"..self:get_property_value(self.m_loaded_ammo_prop));
	
	self.m_reload_after_zoom = false;

end

----------------------------------------------------------------------------------
-- Отображает эффекты выстрела
function sv_weapon_firearm:visualize_shoot_effects()
	-- Загружаем и прячем эффект выстрела (только при первом выстреле)
	if self.m_shot_effect_id == nil then
		if (self.m_shot_effect_name and self.m_shot_point_name) then
			local template_id = self:add_effect_template(self.m_shot_effect_name)
			self.m_shot_effect_id = self:create_effect(template_id, self.m_model_fp[self:get_cur_player_name()], self.m_shot_point_name)
		end
	end
	
	-- Запускаем эффект выстрела (если он есть, конечно)
	if self.m_shot_effect_id and self.m_shot_effect_id ~= -1 then
		self:reset_effect(self.m_shot_effect_id)
	end
end

----------------------------------------------------------------------------------
-- Прячет эффекты выстрела
function sv_weapon_firearm:deactivate_shoot_effects()
	if self.m_shot_effect_id and self.m_shot_effect_id ~= -1 then
		self:deactivate_effect(self.m_shot_effect_id)
	end
end

----------------------------------------------------------------------------------
function sv_weapon_firearm:on_enter_idle()
	if(self.m_is_zoomed == true) then
		self:visualize_state(self.main_fsm, self.state_visual_info, "idle_zoomed");
	else
		self:visualize_state(self.main_fsm, self.state_visual_info, "idle");
	end		
end
---------------------------------------------------------------------------------
-- начало выстрела
function sv_weapon_firearm:on_enter_fire()
	--console.print("..............sv_weapon_firearm:on_enter_fire()");
	if(self.m_is_zoomed == true) then
		if(self.state_visual_info["fire_zoomed"] ~= nil) then
			self:visualize_state(self.main_fsm, self.state_visual_info, "fire_zoomed");
		else
			self:set_fsm_update_time(self.main_fsm, 1);
		end
	else
		if(self.state_visual_info["fire"] ~= nil) then
			self:visualize_state(self.main_fsm, self.state_visual_info, "fire");
		else
			self:set_fsm_update_time(self.main_fsm, 1);
		end
	end	
	
	self:set_property_value(self.m_loaded_ammo_prop, 
			self:get_property_value(self.m_loaded_ammo_prop) - self.m_ammo_for_shot);
	
	self:visualize_shoot_effects()
end

---------------------------------------------------------------------------------
function sv_weapon_firearm:on_update_fire()
	self:change_fsm_state(self.main_fsm, self.fire_finish_state, true);
end

--------------------------------------------------------------------------------
-- завершение выстрела, нанести хит
function sv_weapon_firearm:on_enter_fire_finish()

	local min_dist;
	local max_dist;
	
	if(self.m_bullet_dist ~= nil) then
		min_dist = self.m_bullet_dist;
		max_dist = self.m_bullet_dist
	else
		min_dist = self.m_bullet_min_dist;
		max_dist = self.m_bullet_max_dist
	end

	-- зависимость параметров стрельбы от режима прицеливания
	local shot_disp		= (not self.m_is_zoomed) and self.m_shot_disp	or self.m_shot_disp_zoomed
	local shot_recoil	= (not self.m_is_zoomed) and self.m_shot_recoil	or self.m_shot_recoil_zoomed

	-- зависимость параметров стрельбы от состояния тела (стоя/сидя)
	local owner = self:get_owner();	assert(owner)
	if owner:get_property_value_by_name("is_sitting") then
		shot_disp	= shot_disp	  * self.m_sit_disp_k
		shot_recoil	= shot_recoil * self.m_sit_recoil_k
	end

	-- зависимость параметров стрельбы от времени	
	local curr_time = engine.get_game_time()

	-- таблица с информацией о последних выстрелах
	if self.m_last_shots == nil then
		self.m_last_shots = {}
		self.m_last_shots_idx = 1
	end

	-- просчет энергии выстрелов, переданной оружию, с учетом времени
	local energy_aver = 0
	for i = 1, self.m_last_shots_number, 1 do
		if(self.m_last_shots[i]) then
			local shot_energy = self.m_last_shots[i].shot_energy
			local shot_delta_time = curr_time - self.m_last_shots[i].shot_time
			if(shot_delta_time > 0) then
				energy_aver = energy_aver + shot_energy/shot_delta_time
			end
		end
	end

	-- сохраним параметры текущего выстрела
	local shot_rec = {}
	shot_rec.shot_energy = self.m_one_shot_energy
	shot_rec.shot_time = curr_time
	if(self.m_last_shots_idx > self.m_last_shots_number) then self.m_last_shots_idx = 1	end
	self.m_last_shots[self.m_last_shots_idx] = shot_rec
	self.m_last_shots_idx = self.m_last_shots_idx + 1

	-- коррекция отдачи
	local recoil_time_correction_k = energy_aver
	if recoil_time_correction_k > self.m_recoil_time_correction_k_max then
		recoil_time_correction_k = self.m_recoil_time_correction_k_max
	end
	if recoil_time_correction_k < self.m_recoil_time_correction_k_min then
		recoil_time_correction_k = self.m_recoil_time_correction_k_min
	end

	shot_recoil = shot_recoil*recoil_time_correction_k

	-- коррекция разброса
	local disp_time_correction_k = energy_aver
	if disp_time_correction_k > self.m_disp_time_correction_k_max then
		disp_time_correction_k = self.m_disp_time_correction_k_max
	end
	if disp_time_correction_k < self.m_disp_time_correction_k_min then
		disp_time_correction_k = self.m_disp_time_correction_k_min
	end

	shot_disp = shot_disp*disp_time_correction_k
			
	--console.print("recoil_time_correction_k "..recoil_time_correction_k)
	--console.print("disp_time_correction_k   "..disp_time_correction_k)
	
	-- производим выстрелы		
	for i = 1, self.m_bullets_in_shot, 1 do
		self:fire_trace(self.m_bullet_damage, g_damage_type.GUNSHOT, self.m_bullet_impulse, 
						min_dist, max_dist, shot_disp, shot_recoil);
	end
	
	if self.m_not_visualize_last_fire_finish and not self:can_fire() then 
		-- Не отображаем последний fire_finish, если не можем стрелять
		-- (не отображать анимацию перезарядки, если нет патронов)
	else
		if(self.m_is_zoomed == true) then
			self:visualize_state(self.main_fsm, self.state_visual_info, "fire_finish_zoomed");
		else
			self:visualize_state(self.main_fsm, self.state_visual_info, "fire_finish");
		end		
	end
end

---------------------------------------------------------------------------------
function sv_weapon_firearm:on_update_fire_finish()
	self:change_fsm_state(self.main_fsm, self.idle_state, true);
end

---------------------------------------------------------------------------------
function sv_weapon_firearm:on_enter_zoom_in()
	local visual_idx, anim_length = self:visualize_state(self.main_fsm, self.state_visual_info, "zoom_in");
	self:set_camera_fov(self.m_zoomed_fov, anim_length);
	engine.mouse_set_sensetivity_scale(self.m_zoomed_mouse_sens_scale)
end

---------------------------------------------------------------------------------
function sv_weapon_firearm:on_update_zoom_in()
	self:set_zoom(true);
	self:change_fsm_state(self.main_fsm, self.idle_state, true);
end

---------------------------------------------------------------------------------
function sv_weapon_firearm:on_enter_zoom_out()
	local visual_idx, anim_length = self:visualize_state(self.main_fsm, self.state_visual_info, "zoom_out");
	self:set_camera_fov(self.m_normal_fov, anim_length);
	engine.mouse_set_sensetivity_scale(self.m_normal_mouse_sens_scale)
end

---------------------------------------------------------------------------------
function sv_weapon_firearm:on_update_zoom_out()
	self:set_zoom(false);
	
	if(self.m_reload_after_zoom) then
		self:change_fsm_state(self.main_fsm, self.reload_state, true);
	else
		self:change_fsm_state(self.main_fsm, self.idle_state, true);
	end
end

---------------------------------------------------------------------------------
function sv_weapon_firearm:on_enter_reload()
	self:visualize_state(self.main_fsm, self.state_visual_info, "reload");
end

---------------------------------------------------------------------------------
function sv_weapon_firearm:on_update_reload()
	self:reload_ammo();
	self:change_fsm_state(self.main_fsm, self.idle_state, true);
end

---------------------------------------------------------------------------------
function sv_weapon_firearm:on_shutdown()
	sv_weapon_basic.on_shutdown(self)
	
	-- Освобождаем эффект
	if self.m_shot_effect_id and self.m_shot_effect_id ~= -1 then
		self:release_effect(self.m_shot_effect_id)
	end
end

---------------------------------------------------------------------------------
-- клиентская
---------------------------------------------------------------------------------
cl_weapon_firearm = utils.inherit(cl_weapon_basic, weapon_firearm);

---------------------------------------------------------------------------------
function cl_weapon_firearm:register_properties(prop_registry)
	weapon_firearm.register_properties(self, prop_registry);
	cl_weapon_basic.register_properties(self, prop_registry);
		
	if self.m_ammo_icon_id == nil then
		self.m_ammo_icon_id = 0
	end
end

---------------------------------------------------------------------------------
function cl_weapon_firearm:on_init()
	cl_weapon_basic.on_init(self);
	weapon_firearm.on_init(self);
	--self:hide_model(self.m_model_hands, true);
	--self:hide_model(self.m_model_fp, true);

	self.zoom_in_state	= self:add_fsm_state(self.main_fsm, "zoom_in_state", self.on_enter_zoom_in, self.on_update_zoom_in, nil, nil);
	self.zoom_out_state	= self:add_fsm_state(self.main_fsm, "zoom_out_state", self.on_enter_zoom_out, self.on_update_zoom_out, nil, nil);

	-- object state
	local weapon = create_object_state_element(self, "weapon_firearm")
	local ammo = create_object_state_element(weapon, "ammo")
	self.m_object_state_element_ammo_all = create_object_state_element(ammo, "all", self:get_property_value(self.m_all_ammo_prop))
	self.m_object_state_element_ammo_loaded = create_object_state_element(ammo, "loaded", self:get_property_value(self.m_loaded_ammo_prop))
	self.m_object_state_element_ammo_icons = create_object_state_element(ammo, "ammo_icons", self.m_ammo_icon_id)
end

----------------------------------------------------------------------------------
function cl_weapon_firearm:on_enter_zoom_in()
	if self.m_hide_crosshair_in_zoom == true then
		self.m_object_state_elements.weapon_basic["sight_"..self.class_name] = nil
	end
end

----------------------------------------------------------------------------------
function cl_weapon_firearm:on_enter_zoom_out()
	if self.m_hide_crosshair_in_zoom == true then
		local element = {}
		element.__val = 1
		self.m_object_state_elements.weapon_basic["sight_"..self.class_name] = element
	end
end

----------------------------------------------------------------------------------
function cl_weapon_firearm:on_enter_show()
	local element = {}
	element.__val = 1
	self.m_object_state_elements.weapon_basic["sight_"..self.class_name] = element
end

----------------------------------------------------------------------------------
function cl_weapon_firearm:on_enter_hide()
	self.m_object_state_elements.weapon_basic["sight_"..self.class_name] = nil
end
