------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Actor Flamethrower - огнеметчик
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть
actor_flamethrower.guid = {0x9b8f11c4, 0xf436, 0x4973, 0xbf, 0x38, 0xcb, 0xe3, 0x18, 0x9f, 0xff, 0x22};

----------------------------------------
function actor_flamethrower:on_init()
	-- Загружаем звук начала атаки
	self.m_begin_flame_snd = self:add_sound(self.params.begin_flame_snd_name, false, -5000, 1, SND_ACTOR_MIN_DIST, SND_ACTOR_MAX_DIST);
end

------------------------------------
-- серверная часть 
sv_actor_flamethrower = utils.inherit(sv_actor_basic, actor_flamethrower);

----------------------------------------
function sv_actor_flamethrower:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

----------------------------------------
function sv_actor_flamethrower:on_init()
	sv_actor_basic.on_init(self);
	actor_flamethrower.on_init(self);
	
	if self:get_property_value_by_name("is_enabled") == true then
		self:on_inslot_enable()
	end
end

----------------------------------------
-- ATTACK SHOT BURST (Стрельба очередью)
----------------------------------------
function sv_actor_flamethrower:on_enter_attack_shot_burst()
	sv_actor_basic.on_enter_attack_shot_burst(self)
	self:play_sound(self.m_begin_flame_snd)
	
	-- Загружаем эффект выброса огня (только при первом выстреле)
	if self.m_flamethrow_effect == nil then
		local template_id = self:add_effect_template(self.params.flame_effect_name)
		local effect_id = self:create_effect(template_id, self.m_model_body, self.params.flame_shoot_point)
		if effect_id == -1 then
			assert(nil, "cannot create effect: " .. self.params.flame_effect_name);
		else
			self.m_flamethrow_effect = effect_id
		end
	end
	
	-- Включаем эффект выброса огня
	self:activate_effect(self.m_flamethrow_effect)
		
end

----------------------------------------
function sv_actor_flamethrower:on_exit_attack_shot_burst()
	sv_actor_basic.on_exit_attack_shot_burst(self)
	
	-- Выключаем эффект выброса огня
	self:deactivate_effect(self.m_flamethrow_effect)
end


----------------------------------------
-- Обработка эффектов при enable/disable
----------------------------------------
function sv_actor_flamethrower:on_inslot_disable(sender, activator, input_data)

	-- Выключаем все эффекты.
	if self.m_flamethrow_effect then
		self:deactivate_effect(self.m_flamethrow_effect)
	end
	
	if self.m_nozzle_effect then
		self:deactivate_effect(self.m_nozzle_effect)
	end
	
end

----------------------------------------
function sv_actor_flamethrower:on_inslot_enable(sender, activator, input_data)
	
	-- Загружаем эффект горелки (только при первом enable)
	if self.m_nozzle_effect == nil then
		template_id = self:add_effect_template(self.params.nozzle_effect_name)
		effect_id = self:create_effect(template_id, self.m_model_body, self.params.flame_shoot_point)
		if effect_id == -1 then
			assert(nil, "cannot create effect: " .. self.params.nozzle_effect_name);
		else
			self.m_nozzle_effect = effect_id
		end
	end
	-- Включаем эффект горелки
	self:activate_effect(self.m_nozzle_effect)
	
	-- Если жжем, то включаем эффект выброса огня.
	local cur_state = self:get_cur_fsm_state(self.body_fsm)
	if cur_state == self.attack_shot_burst_state then
		self:activate_effect(self.m_flamethrow_effect)
	end
end

----------------------------------------
function sv_actor_flamethrower:on_shutdown()
	sv_actor_basic.on_shutdown(self);
	
	-- Освобождаем эффекты
	if self.m_nozzle_effect then
		self:release_effect(self.m_nozzle_effect)
	end
	
	if self.m_flamethrow_effect then
		self:release_effect(self.m_flamethrow_effect)
	end
end


---------------------------------------------------------------------------
-- клиентская
cl_actor_flamethrower = utils.inherit(cl_actor_basic, actor_flamethrower);

function cl_actor_flamethrower:on_init()
	cl_actor_basic.on_init(self);
	actor_flamethrower.on_init(self);
end