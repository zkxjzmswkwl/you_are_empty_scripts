------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Оружие Thunder
------------------------------------------------------------------------

include("ammo_thunder.lua")

weapon_thunder = {};

-------------------------------------------	
-- properties
-------------------------------------------	
weapon_thunder.properties_design = utils.merge_arrays(weapon_basic.properties_design, {
	{"model_name",			"ItemTUNDER"},
	{"hit_material",		"mat_hit_ppsh" },
	{ "slot_name",			g_weapon_slots[8] },	-- слот в котором может быть оружие
	{ "priority",			9 },					-- приоритет оружия
--	{ "icon_id",			6 },					-- иконка для HUD
	
	{ "loaded_ammo",		35 },	-- кол-во заряженных патронов в стволе (не больше чем m_clip_size)
	{ "all_ammo",			0 },	-- кол-во дополнительных, патронов, которые добавляются в инвентарь при подборе данного оружия
	{ "max_ammo",			350 },	-- максимальное кол-во патронов, которое может быть у нас в инвентаре
	
	{ "light_enable",		true }, -- подсветка во время выстрела
});

-- Модели оружия и модели рук данного оружия для различных игроков
weapon_thunder.m_models_names = {
--	Имя игрока				Имя модели рук			Имя модели оружия		
	["-unknown-"]		= {	"Thunder_hands",		"Thunder"			},
}
	
-- иконка для HUD
weapon_thunder.m_ammo_icon_id		= 5
weapon_thunder.m_holdable_icon_id	= 12

---------------------------------------
-- параметры выстрела
---------------------------------------
weapon_thunder.m_missile_type		= "ammo_missile_fireball";	-- тип снаряда
weapon_thunder.m_missile_velocity	= 5000;						-- скорость снаряда
weapon_thunder.m_shot_disp			= 0;
weapon_thunder.m_shot_recoil		= 7;
weapon_thunder.m_throw_point_offset	= {0, 0.2, 1.5};			-- смещение точки выброса метательного патрона
weapon_thunder.m_angular_velocity	= {0, 20, 0};				-- вращение после броска

			

-- Скорострельность оружия
weapon_thunder.m_rate_of_fire		= .5
----------------------------------------
-- параметры патронов
----------------------------------------
weapon_thunder.m_ammo_class			= "ammo_thunder"	-- класс используемых патронов
weapon_thunder.m_ammo_type			= "thunder ammo"	-- тип используемых патронов
weapon_thunder.m_clip_size			= 71				-- вместимость обоймы
weapon_thunder.m_ammo_for_shot		= 1					-- кол-во патронов расходуемых на один выстрел

-- FOV дляразных режимов
weapon_thunder.m_normal_fov			= 55
--weapon_thunder.m_zoomed_fov			= 65
weapon_thunder.m_model_fov			= 55

weapon_thunder.m_min_force			= 0.001	-- минимальная сила броска предмета
weapon_thunder.m_max_force			= 1		-- максимальная сила броска предмета
weapon_thunder.m_time_to_gain_max_force	= 1500	-- время, в течение которого сила броска приобретает максимум


-------------------------------------------	
-- анимации и звуки состояний FSM
-------------------------------------------	
weapon_thunder.states_design = {};

weapon_thunder.states_design["show"] = {{anim = "taking", snd = "thunder_taking", snd_params = snd_weapon_common},};
weapon_thunder.states_design["hide"] = {{anim = "hiding", snd = "thunder_hiding"},};

-- IDLE
weapon_thunder.states_design["idle"] = {
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
weapon_thunder.states_design["fire"] = {
	{anim = "fire1_in", snd = "thunder_fire_in123"},
	{anim = "fire2_in", snd = "thunder_fire_in123"},
	{anim = "fire3_in", snd = "thunder_fire_in123"},
};

weapon_thunder.states_design["fire_finish"] = {
	{anim = "fire1", snd = "thunder_fire1", anim_speed = weapon_thunder.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire2", snd = "thunder_fire2", anim_speed = weapon_thunder.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire3", snd = "thunder_fire3", anim_speed = weapon_thunder.m_rate_of_fire, snd_params = snd_weapon_shot},
};

weapon_thunder.states_design["fire_finish_chain"] = {
	{anim = "fire_long2", snd = "thunder_firelong2", anim_speed = weapon_thunder.m_rate_of_fire * 3},
};

-- RELOAD
weapon_thunder.states_design["reload"] = {{anim = "reload", snd = "thunder_reload", snd_params = snd_weapon_common},};

-- общая часть
weapon_thunder.guid = {0xf115cb21, 0x3aba, 0x4a5f, 0x96, 0x82, 0xc0, 0x78, 0x4d, 0xff, 0x9, 0x3d};

function weapon_thunder:on_init()
end

---------------------------------------------------------------------------
-- серверная часть 
sv_weapon_thunder = utils.inherit(sv_weapon_firearm, weapon_thunder);

---------------------------------------------------------------------------
function sv_weapon_thunder:register_properties(prop_registry)
	sv_weapon_firearm.register_properties(self, prop_registry);
end

---------------------------------------------------------------------------
function sv_weapon_thunder:on_init()
	sv_weapon_firearm.on_init(self);
	weapon_thunder.on_init(self);
end

---------------------------------------------------------------------------
function sv_weapon_thunder:event_lever1_up()
	sv_weapon_firearm.event_lever1_up(self)
	
	local cur_state = self:get_cur_fsm_state(self.main_fsm);
	if cur_state == self.fire_state or cur_state == self.fire_finish_state then
		self.m_need_to_stop_firing = true
	end
end

---------------------------------------------------------------------------
function sv_weapon_thunder:event_lever2_down()
	self.m_lever_down_time = engine.get_game_time()
end

---------------------------------------------------------------------------
function sv_weapon_thunder:event_lever2_up()
	self.m_lever_up_time = engine.get_game_time()
	
	local owner = self:get_owner()
	if not owner:arms_has_thing() then
		-- Подбираем предмет
		owner:execute_action(ACTION_USE)
	else
		-- Бросаем предмет
		local old_throw_on_drop		= engine.get_var("ph_throw_on_drop")
		local old_throw_force		= engine.get_var("ph_throw_force")
		local old_throw_torque_x	= engine.get_var("ph_throw_torque_x")
		local old_throw_torque_y	= engine.get_var("ph_throw_torque_y")
		
		-- Время удерживания кнопки
		local hold_time = self.m_lever_up_time - self.m_lever_down_time
		-- Определим силу пропорционально времени удержания
		local force
		if hold_time > self.m_time_to_gain_max_force then 
			force = self.m_max_force
		else
			force = self.m_min_force + (self.m_max_force - self.m_min_force) * hold_time / self.m_time_to_gain_max_force
		end
		
		engine.set_var("ph_throw_on_drop", 1)
		engine.set_var("ph_throw_force", force)
		engine.set_var("ph_throw_torque_x", 1)
		engine.set_var("ph_throw_torque_y", 1)
		
		owner:execute_action(ACTION_USE)
		
		-- Восстанавливаем значения переменных
		engine.set_var("ph_throw_on_drop", old_throw_on_drop)
		engine.set_var("ph_throw_force", old_throw_force)
		engine.set_var("ph_throw_torque_x", old_throw_torque_x)
		engine.set_var("ph_throw_torque_y", old_throw_torque_y)
	end
end

---------------------------------------------------------------------------
function sv_weapon_thunder:on_enter_fire()
	self.m_need_to_stop_firing = false
	sv_weapon_firearm.on_enter_fire(self);
end

--------------------------------------------------------------------------------
-- завершение выстрела
function sv_weapon_thunder:on_enter_fire_finish()

	local owner = self:get_owner();
	if owner then
	
		-- Направление атаки: прямо перед собой
		local attack_dir = owner:calc_target_dir({0, 0, 0}, 0, 0, 0);
				
		-- Стреляем снарядом
		owner:fire_missile(
			self.m_throw_point_offset,
			attack_dir,
			self.m_missile_type,
			self.m_shot_disp,
			self.m_missile_velocity,
			self.m_angular_velocity
		);		
		
		-- Уменьшаем количество патронов
		self:set_property_value(self.m_loaded_ammo_prop, 
			self:get_property_value(self.m_loaded_ammo_prop) - self.m_ammo_for_shot);
	else
		-- Актер наверное мертв. Хватит стрелять.
		self.m_need_to_stop_firing = true 
	end
	
	if(not self.m_need_to_stop_firing) then
		self:visualize_state(self.main_fsm, self.state_visual_info, "fire_finish_chain");
	else
		self:visualize_state(self.main_fsm, self.state_visual_info, "fire_finish");
	end		
end

---------------------------------------------------------------------------
function sv_weapon_thunder:on_update_fire_finish()
	if (self:can_fire() and self.m_need_to_stop_firing ~= true) then
		self:change_fsm_state(self.main_fsm, self.fire_finish_state, true, true);
	else
		sv_weapon_firearm.on_update_fire_finish(self);
	end
end

---------------------------------------------------------------------------
-- клиентская
cl_weapon_thunder = utils.inherit(cl_weapon_firearm, weapon_thunder);

function cl_weapon_thunder:on_init()
	cl_weapon_firearm.on_init(self);
	weapon_thunder.on_init(self);
end
