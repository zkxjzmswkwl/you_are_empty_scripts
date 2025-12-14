------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Оружие Thunder Fire
------------------------------------------------------------------------

include("ammo_thunder.lua")

weapon_thunder_fire = {};

-------------------------------------------	
-- properties
-------------------------------------------	
weapon_thunder_fire.properties_design = utils.merge_arrays(weapon_basic.properties_design, {
	{"model_name",			"ItemMauzer"},
	{"hit_material",		"mat_hit_ppsh" },
	{ "slot_name",			g_weapon_slots[8] },	-- слот в котором может быть оружие
	{ "priority",			0 },					-- приоритет оружия
--	{ "icon_id",			6 },					-- иконка для HUD
	
	{ "loaded_ammo",		35 },	-- кол-во заряженных патронов в стволе (не больше чем m_clip_size)
	{ "all_ammo",			0 },	-- кол-во дополнительных, патронов, которые добавляются в инвентарь при подборе данного оружия

	
	{ "light_enable",		true }, -- подсветка во время выстрела
});

-- Модели оружия и модели рук данного оружия для различных игроков
weapon_thunder_fire.m_models_names = {
--	Имя игрока				Имя модели рук			Имя модели оружия		
	["-unknown-"]		= {	"Thunder_hands",		"Thunder"			},
}

-- иконка для HUD
weapon_thunder_fire.m_ammo_icon_id		= 5
weapon_thunder_fire.m_holdable_icon_id	= 12

---------------------------------------
-- параметры выстрела
---------------------------------------
weapon_thunder_fire.m_missile_type		= "ammo_missile_fireball"	-- тип снаряда
weapon_thunder_fire.m_missile_velocity	= 5000						-- скорость снаряда
weapon_thunder_fire.m_shot_disp			= 0
weapon_thunder_fire.m_shot_recoil		= 7

-- Скорострельность оружия
weapon_thunder_fire.m_rate_of_fire		= 1
----------------------------------------
-- параметры патронов
----------------------------------------
weapon_thunder_fire.m_ammo_class			= "ammo_thunder"	-- класс используемых патронов
weapon_thunder_fire.m_ammo_type			= "thunder ammo"	-- тип используемых патронов
weapon_thunder_fire.m_clip_size			= 71				-- объем патронтажа
weapon_thunder_fire.m_ammo_for_shot		= 1					-- кол-во патронов расходуемых на один выстрел
weapon_thunder_fire.m_loaded_ammo		= 35				-- кол-во заряженных патронов

-- FOV дляразных режимов
weapon_thunder_fire.m_normal_fov			= 90
weapon_thunder_fire.m_zoomed_fov			= 45
weapon_thunder_fire.m_model_fov			= 55

-- Эффект выброса огня
weapon_thunder_fire.flame_effect_name	= "pfx_flamethrower1.lua"
-- Эффект горелки
weapon_thunder_fire.nozzle_effect_name	= "pfx_flamethrower1_nozzle.lua"
-- Точка выброса огня
weapon_thunder_fire.flame_shoot_point	= "#shoot_point"

-------------------------------------------	
-- анимации и звуки состояний FSM
-------------------------------------------	
weapon_thunder_fire.states_design = {};

weapon_thunder_fire.states_design["show"] = {{anim = "taking", snd = "thunder_taking"},};
weapon_thunder_fire.states_design["hide"] = {{anim = "hiding", snd = "thunder_hiding"},};

-- IDLE
weapon_thunder_fire.states_design["idle"] = {
--	{anim = "fire_long2", anim_playback = ANIM_PB_REPEATEDLY,},
-- [[
	{anim = "idle1", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle2", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle3", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle4", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle5", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle6", anim_playback = ANIM_PB_REPEATEDLY,},
--]]
};

-- FIRE
weapon_thunder_fire.states_design["fire"] = {
	{anim = "fire1_in", snd = "thunder_fire_in123"},
	{anim = "fire2_in", snd = "thunder_fire_in123"},
	{anim = "fire3_in", snd = "thunder_fire_in123"},
};

weapon_thunder_fire.states_design["fire_finish"] = {
	{anim = "fire1", snd = "thunder_fire1", anim_speed = weapon_thunder_fire.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire2", snd = "thunder_fire2", anim_speed = weapon_thunder_fire.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire3", snd = "thunder_fire3", anim_speed = weapon_thunder_fire.m_rate_of_fire, snd_params = snd_weapon_shot},
};

weapon_thunder_fire.states_design["fire_finish_chain"] = {
	{anim = "fire_long2", snd = "thunder_firelong2", anim_speed = weapon_thunder_fire.m_rate_of_fire * 3},
};

-- RELOAD
weapon_thunder_fire.states_design["reload"] = {{anim = "reload", snd = "thunder_reload", snd_params = snd_weapon_common},};

-- общая часть
weapon_thunder_fire.guid = {0xc72f5a07, 0x64c8, 0x4913, 0xad, 0x2d, 0x86, 0x59, 0x2d, 0x1, 0x95, 0x5f};

function weapon_thunder_fire:on_init()
end

---------------------------------------------------------------------------
-- серверная часть 
sv_weapon_thunder_fire = utils.inherit(sv_weapon_firearm, weapon_thunder_fire);

---------------------------------------------------------------------------
function sv_weapon_thunder_fire:register_properties(prop_registry)
	sv_weapon_firearm.register_properties(self, prop_registry);
end

---------------------------------------------------------------------------
function sv_weapon_thunder_fire:on_init()
	sv_weapon_firearm.on_init(self);
	weapon_thunder_fire.on_init(self);
end

---------------------------------------------------------------------------
function sv_weapon_thunder_fire:event_lever1_down()
	sv_weapon_firearm.event_lever1_down(self)
		
	local cur_state = self:get_cur_fsm_state(self.main_fsm);
	if cur_state == self.fire_state then
	
		-- Загружаем эффект выброса огня
		if self.m_flamethrow_effect == nil then
			local template_id = self:add_effect_template(self.flame_effect_name)
			local effect_id = self:create_effect(template_id, self.m_model_fp[self:get_cur_player_name()], self.flame_shoot_point)
			if effect_id == -1 then
				assert(nil, "cannot create effect: " .. self.flame_effect_name);
			else
				self.m_flamethrow_effect = effect_id
			end
		end
		
		-- Включаем эффект выброса огня
		self:activate_effect(self.m_flamethrow_effect)
	end
	
end

---------------------------------------------------------------------------
function sv_weapon_thunder_fire:on_selected()
	sv_weapon_firearm.on_selected(self)
	
	-- Загружаем эффект горелки (если оружие выбрано в первый раз)
	if self.m_nozzle_effect == nil then
		template_id = self:add_effect_template(self.nozzle_effect_name)
		effect_id = self:create_effect(template_id, self.m_model_fp[self:get_cur_player_name()], self.flame_shoot_point)
		if effect_id == -1 then
			assert(nil, "cannot create effect: " .. self.nozzle_effect_name);
		else
			self.m_nozzle_effect = effect_id
		end
	end
	
	-- Включаем эффект горелки
	self:activate_effect(self.m_nozzle_effect)
	
end

---------------------------------------------------------------------------
function sv_weapon_thunder_fire:on_deselected()
	sv_weapon_firearm.on_deselected(self)
	
	-- Выключаем эффект горелки
	self:deactivate_effect(self.m_nozzle_effect)
end

---------------------------------------------------------------------------
function sv_weapon_thunder_fire:event_lever1_up()
	sv_weapon_firearm.event_lever1_up(self)
	
	local cur_state = self:get_cur_fsm_state(self.main_fsm);
	if cur_state == self.fire_state or cur_state == self.fire_finish_state then
		self.m_need_to_stop_firing = true
	end
end

---------------------------------------------------------------------------
function sv_weapon_thunder_fire:event_lever2_down()
	--Ничего не делаем
end

---------------------------------------------------------------------------
function sv_weapon_thunder_fire:on_enter_fire()
	self.m_need_to_stop_firing = false
	sv_weapon_firearm.on_enter_fire(self);
end

--------------------------------------------------------------------------------
-- завершение выстрела
function sv_weapon_thunder_fire:on_enter_fire_finish()

	local owner = self:get_owner();
--[[	
	if owner then
	
		-- Направление атаки: прямо перед собой
		local attack_dir = owner:calc_target_dir({0, 0, 0}, 0, 0, 0);
				
		-- Стреляем снарядом
		owner:fire_missile(
			{2, 0, 1.5},
			attack_dir,
			self.m_missile_type,
			self.m_shot_disp,
			self.m_missile_velocity,
			{0, 20, 0}
		);		
		
		-- Уменьшаем количество патронов
		self:set_property_value(self.m_loaded_ammo_prop, 
			self:get_property_value(self.m_loaded_ammo_prop) - self.m_ammo_for_shot);
	end
--]]
	
	if(not self.m_need_to_stop_firing) then
		self:visualize_state(self.main_fsm, self.state_visual_info, "fire_finish_chain");
	else
		self:visualize_state(self.main_fsm, self.state_visual_info, "fire_finish");
	end		
end

---------------------------------------------------------------------------
function sv_weapon_thunder_fire:on_update_fire_finish()
	if (self:can_fire() and self.m_need_to_stop_firing ~= true) then
		self:change_fsm_state(self.main_fsm, self.fire_finish_state, true, true);
	else
		-- Выключаем эффект выброса огня
		self:deactivate_effect(self.m_flamethrow_effect)
		
		sv_weapon_firearm.on_update_fire_finish(self);
	end
end

---------------------------------------------------------------------------
function sv_weapon_thunder_fire:on_shutdown()
	sv_weapon_firearm.on_shutdown(self)
	
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
cl_weapon_thunder_fire = utils.inherit(cl_weapon_firearm, weapon_thunder_fire);

function cl_weapon_thunder_fire:on_init()
	cl_weapon_firearm.on_init(self);
	weapon_thunder_fire.on_init(self);
end
