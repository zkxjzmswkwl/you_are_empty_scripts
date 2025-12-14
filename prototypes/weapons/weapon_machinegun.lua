------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Базовый класс для автоматов
------------------------------------------------------------------------

include("ammo_ppsh.lua")

weapon_machinegun = {};

-------------------------------------------	
-- properties
-------------------------------------------	
weapon_machinegun.properties_design = utils.merge_arrays(weapon_basic.properties_design, {
	{"model_name",			"ItemPPS"},
	{"hit_material",		"mat_hit_ppsh" },
	{ "slot_name",			g_weapon_slots[5] }, -- слот в котором может быть оружие
	{ "priority",			7 }, -- приоритет оружия
--	{ "icon_id",			4 }, -- иконка для HUD
	
	{ "loaded_ammo",		35 },	-- кол-во заряженных патронов в стволе (не больше чем m_clip_size)
	{ "all_ammo",			0 },	-- кол-во дополнительных, патронов, которые добавляются в инвентарь при подборе данного оружия
	{ "max_ammo",			210 },	-- максимальное кол-во патронов, которое может быть у нас в инвентаре	

	{ "light_enable",		true }, -- подсветка во время выстрела
});

-- Модели оружия и модели рук данного оружия для различных игроков
weapon_machinegun.m_models_names = {
--	Имя игрока				Имя модели рук		Имя модели оружия		
	["-unknown-"]		= {	"ppsh_hands",		"ppsh"			},
}
	
-- иконка для HUD
weapon_machinegun.m_ammo_icon_id		= 4
weapon_machinegun.m_holdable_icon_id	= 6

---------------------------------------
-- параметры выстрела
---------------------------------------
weapon_machinegun.m_bullets_in_shot		= 1;
weapon_machinegun.m_bullet_damage		= 50;
weapon_machinegun.m_bullet_impulse		= .5;
weapon_machinegun.m_bullet_min_dist		= 15;
weapon_machinegun.m_bullet_max_dist		= 70;

weapon_machinegun.m_shot_disp			= 6.3;
weapon_machinegun.m_shot_disp_zoomed	= 3;

weapon_machinegun.m_shot_recoil			= 4;
weapon_machinegun.m_shot_recoil_zoomed	= 3;

weapon_machinegun.m_shot_effect_name			= "pfx_shot_machinegun.lua" -- эффект при выстреле
weapon_machinegun.m_shot_point_name				= "#shoot_point"			-- точка привязки эффекта в модели
weapon_machinegun.m_trace_bullet_effect_name	= "pfx_shot_trace_fp.lua"		-- эффект трейса пули

-- Скорострельность оружия
weapon_machinegun.m_rate_of_fire		= 1.4
----------------------------------------
-- параметры патронов
----------------------------------------
weapon_machinegun.m_ammo_class			= "ammo_ppsh"	-- класс используемых патронов
weapon_machinegun.m_ammo_type			= "ppsh ammo"	-- тип используемых патронов
weapon_machinegun.m_clip_size			= 71			-- вместимость обоймы
weapon_machinegun.m_ammo_for_shot		= 1				-- кол-во патронов расходуемых на один выстрел

-- FOV дляразных режимов
weapon_machinegun.m_normal_fov			= 90;
weapon_machinegun.m_zoomed_fov			= 45;
weapon_machinegun.m_model_fov			= 45;

-- Чувствительность мыши (коэффициент масштабирования)
weapon_machinegun.m_zoomed_mouse_sens_scale	= 0.3;
weapon_machinegun.m_normal_mouse_sens_scale	= 1;

-------------------------------------------	
-- анимации и звуки состояний FSM
-------------------------------------------	
weapon_machinegun.states_design = {};
weapon_machinegun.states_design["show"] = {{anim = "taking", anim_speed = 2, snd = "ppsha_taking", snd_params = snd_weapon_common},};
weapon_machinegun.states_design["hide"] = {{anim = "hiding", anim_speed = 2, snd = "ppsha_hiding"},};

-- IDLE
weapon_machinegun.states_design["idle"] = {
	{anim = "idle1", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle2", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle3", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle4", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle5", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle6", anim_playback = ANIM_PB_REPEATEDLY,},
};

--weapon_machinegun.states_design["fire"] = {{anim = "fire_in", snd = "ppsha_fire1"},};
weapon_machinegun.states_design["fire_finish"] = {
	{anim = "fire1", snd = "ppsha_fire1", anim_speed = weapon_machinegun.m_rate_of_fire, snd_params = snd_weapon_shot,},
	{anim = "fire2", snd = "ppsha_fire2", anim_speed = weapon_machinegun.m_rate_of_fire, snd_params = snd_weapon_shot,},
	{anim = "fire3", snd = "ppsha_fire3", anim_speed = weapon_machinegun.m_rate_of_fire, snd_params = snd_weapon_shot,},
	{anim = "fire4", snd = "ppsha_fire4", anim_speed = weapon_machinegun.m_rate_of_fire, snd_params = snd_weapon_shot,},
	{anim = "fire5", snd = "ppsha_fire5", anim_speed = weapon_machinegun.m_rate_of_fire, snd_params = snd_weapon_shot,},
	{anim = "fire6", snd = "ppsha_fire6", anim_speed = weapon_machinegun.m_rate_of_fire, snd_params = snd_weapon_shot,},
	{anim = "fire7", snd = "ppsha_fire1", anim_speed = weapon_machinegun.m_rate_of_fire, snd_params = snd_weapon_shot,},
	{anim = "fire8", snd = "ppsha_fire2", anim_speed = weapon_machinegun.m_rate_of_fire, snd_params = snd_weapon_shot,},
	{anim = "fire9", snd = "ppsha_fire3", anim_speed = weapon_machinegun.m_rate_of_fire, snd_params = snd_weapon_shot,},
	{anim = "fire10", snd = "ppsha_fire4", anim_speed = weapon_machinegun.m_rate_of_fire,snd_params = snd_weapon_shot,},
	{anim = "fire11", snd = "ppsha_fire5", anim_speed = weapon_machinegun.m_rate_of_fire,snd_params = snd_weapon_shot,},
	{anim = "fire12", snd = "ppsha_fire6", anim_speed = weapon_machinegun.m_rate_of_fire,snd_params = snd_weapon_shot,},
};

-- анимации для zoom in/out
weapon_machinegun.states_design["zoom_in"] = {{anim = "sight_in"},};
weapon_machinegun.states_design["zoom_out"] = {{anim = "sight_out"},};

weapon_machinegun.states_design["idle_zoomed"] = {
	{anim = "idle_in_s7", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle_in_s8", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle_in_s9", anim_playback = ANIM_PB_REPEATEDLY,},
};

--weapon_machinegun.states_design["fire_zoomed"] = {{anim = "fire_in_s", snd = "ppsha_fire1"},};
weapon_machinegun.states_design["fire_finish_zoomed"] = {
	{anim = "fire_in_s1", snd = "ppsha_fire1", anim_speed = weapon_machinegun.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire_in_s2", snd = "ppsha_fire2", anim_speed = weapon_machinegun.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire_in_s3", snd = "ppsha_fire3", anim_speed = weapon_machinegun.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire_in_s4", snd = "ppsha_fire4", anim_speed = weapon_machinegun.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire_in_s5", snd = "ppsha_fire5", anim_speed = weapon_machinegun.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire_in_s6", snd = "ppsha_fire6", anim_speed = weapon_machinegun.m_rate_of_fire, snd_params = snd_weapon_shot},
};

-- перезарядка
weapon_machinegun.states_design["reload"] = {{anim = "reload", snd = "ppsha_reload", snd_params = snd_weapon_common},};

-- общая часть
weapon_machinegun.guid = {0x6bef7b7c, 0xd02d, 0x42ab, 0x96, 0x9, 0x9f, 0x25, 0x23, 0x32, 0xdd, 0xd3};

---------------------------------------------------------------------------
function weapon_machinegun:on_init()
end

---------------------------------------------------------------------------
-- серверная часть 
sv_weapon_machinegun = utils.inherit(sv_weapon_firearm, weapon_machinegun);

---------------------------------------------------------------------------
function sv_weapon_machinegun:register_properties(prop_registry)
	sv_weapon_firearm.register_properties(self, prop_registry);
end

---------------------------------------------------------------------------
function sv_weapon_machinegun:on_init()
	sv_weapon_firearm.on_init(self);
	weapon_machinegun.on_init(self);
end

---------------------------------------------------------------------------
function sv_weapon_machinegun:event_lever1_up()
	sv_weapon_firearm.event_lever1_up(self)
	
	local cur_state = self:get_cur_fsm_state(self.main_fsm);
	if cur_state == self.fire_state or cur_state == self.fire_finish_state then
		self.m_need_to_stop_firing = true
	end
end

---------------------------------------------------------------------------
function sv_weapon_machinegun:on_enter_fire()
	self.m_need_to_stop_firing = false
	sv_weapon_firearm.on_enter_fire(self);
end

---------------------------------------------------------------------------
function sv_weapon_machinegun:on_update_fire_finish()
	if (self:can_fire() and self.m_need_to_stop_firing ~= true) then
		self:change_fsm_state(self.main_fsm, self.fire_state, true, true);
	else
		sv_weapon_firearm.on_update_fire_finish(self);
	end
end

---------------------------------------------------------------------------
-- клиентская
cl_weapon_machinegun = utils.inherit(cl_weapon_firearm, weapon_machinegun);

function cl_weapon_machinegun:on_init()
	cl_weapon_firearm.on_init(self);
	weapon_machinegun.on_init(self);

	self.m_hide_crosshair_in_zoom = true
end
