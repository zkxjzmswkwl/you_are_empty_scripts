------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Оружие винтовка 
------------------------------------------------------------------------

include("ammo_rifle.lua")

weapon_rifle = {};

weapon_rifle.guid = {0x4da7b27e, 0x74a, 0x45c5, 0x82, 0xc8, 0x85, 0xb9, 0x73, 0xfc, 0x14, 0xab};

-------------------------------------------	
-- properties
-------------------------------------------	
weapon_rifle.properties_design = utils.merge_arrays(weapon_basic.properties_design, {
	{"model_name",			"ItemRifle"},
	{"hit_material",		"mat_hit_mauzer" },
	{ "slot_name",			g_weapon_slots[4] }, -- слот в котором может быть оружие
	{ "priority",			6 }, -- приоритет оружия
--	{ "icon_id",			8 }, -- иконка для HUD
	
	{ "loaded_ammo",		3 },	-- кол-во заряженных патронов в стволе (не больше чем m_clip_size)
	{ "all_ammo",			0 },	-- кол-во дополнительных, патронов, которые добавляются в инвентарь при подборе данного оружия
	{ "max_ammo",			25 },	-- максимальное кол-во патронов, которое может быть у нас в инвентаре	

	{ "light_enable",		true }, -- подсветка во время выстрела
});

-- Модели оружия и модели рук данного оружия для различных игроков
weapon_rifle.m_models_names = {
--	Имя игрока				Имя модели рук		Имя модели оружия		
	["-unknown-"]		= {	"rifle_hands",		"rifle"			},
}

-- иконка для HUD
weapon_rifle.m_ammo_icon_id		= 3
weapon_rifle.m_holdable_icon_id	= 9

weapon_rifle.fp_model_render_params = {}
weapon_rifle.fp_model_render_params.z_far = 500.0
	
---------------------------------------
-- параметры скорострельности
---------------------------------------
-- время через которое, 
-- можно не дожидаясь начала анимации сделать новый выстрел,
-- если nil, то обязательно ждем конца всей анимации
weapon_rifle.fire_finish_interruption_time = nil;
---------------------------------------
-- параметры выстрела
---------------------------------------
weapon_rifle.m_bullets_in_shot					= 1;
weapon_rifle.m_bullet_damage					= 500;
weapon_rifle.m_bullet_impulse					= .8;
weapon_rifle.m_bullet_min_dist					= 15;
weapon_rifle.m_bullet_max_dist					= 500;

weapon_rifle.m_shot_disp						= 3;
weapon_rifle.m_shot_disp_zoomed					= weapon_rifle.m_shot_disp / 3;

weapon_rifle.m_shot_recoil						= 7;
weapon_rifle.m_shot_recoil_zoomed				= weapon_rifle.m_shot_recoil;

weapon_rifle.m_not_visualize_last_fire_finish	= true;

-- Скорострельность оружия
weapon_rifle.m_rate_of_fire				= 1

-- Эффекты
weapon_rifle.m_shot_effect_name			= "pfx_shot_rifle.lua"		-- эффект при выстреле
weapon_rifle.m_shot_point_name			= "#shoot_point"			-- точка привязки эффекта в модели
weapon_rifle.m_trace_bullet_effect_name	= "pfx_shot_trace_fp.lua"	-- эффект трейса пули

----------------------------------------
-- параметры патронов
----------------------------------------
weapon_rifle.m_ammo_class			= "ammo_rifle";	-- класс используемых патронов
weapon_rifle.m_ammo_type			= "rifle ammo";	-- тип используемых патронов
weapon_rifle.m_clip_size			= 5;			-- вместимость обоймы
weapon_rifle.m_ammo_for_shot		= 1;			-- кол-во патронов расходуемых на один выстрел

---------------------------------------
-- параметры атаки штыком
---------------------------------------
weapon_rifle.m_fire_damage			= 50;
weapon_rifle.m_fire_impulse			= 1;
weapon_rifle.m_fire_dist			= 2;
weapon_rifle.m_fire_disp			= 5;
weapon_rifle.m_recoil_angle			= 0;

weapon_rifle.m_rate_of_bayonet_attack	= 1

-- FOV дляразных режимов
weapon_rifle.m_normal_fov			= 90;
weapon_rifle.m_zoomed_fov			= 45;
weapon_rifle.m_model_fov			= 45;

-- Чувствительность мыши (коэффициент масштабирования)
weapon_rifle.m_zoomed_mouse_sens_scale	= 0.3;
weapon_rifle.m_normal_mouse_sens_scale	= 1;

-------------------------------------------	
-- анимации и звуки состояний FSM
-------------------------------------------	
weapon_rifle.states_design = {};
weapon_rifle.states_design["show"] = {{anim = "taking", anim_speed = 1, snd = "rifle_taking", snd_params = snd_weapon_common},};
weapon_rifle.states_design["hide"] = {{anim = "hiding", anim_speed = 1, snd = "rifle_hiding"},};

-- IDLE
weapon_rifle.states_design["idle"] = {
	{anim = "idle1", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle2", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle3", anim_playback = ANIM_PB_REPEATEDLY,},
};

-- FIRE
weapon_rifle.states_design["fire"] = {
--	{anim = "fire_in", snd = "rifle_fire_in", anim_speed = weapon_rifle.m_rate_of_fire},
	{anim = "fire_in2", snd = "rifle_fire_in2a", anim_speed = weapon_rifle.m_rate_of_fire, snd_params = snd_weapon_shot},
}

weapon_rifle.states_design["fire_finish"] = {
--	{anim = "fire", snd = "", anim_speed = weapon_rifle.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire2", snd = "rifle_fire_in2b", anim_speed = weapon_rifle.m_rate_of_fire, snd_params = snd_weapon_reload},
}

-- BAYONET ATTACK (атака штыком)
weapon_rifle.states_design["bayonet_attack"] = {
	{anim = "attack1", snd = "rifle_attack1", anim_speed = weapon_rifle.m_rate_of_bayonet_attack, snd_params = snd_weapon_common},
	{anim = "attack2", snd = "rifle_attack2", anim_speed = weapon_rifle.m_rate_of_bayonet_attack, snd_params = snd_weapon_common},
}

weapon_rifle.states_design["bayonet_attack_out"] = {
	{anim = "attack1_out", snd = "", anim_speed = weapon_rifle.m_rate_of_bayonet_attack},
	{anim = "attack2_out", snd = "", anim_speed = weapon_rifle.m_rate_of_bayonet_attack},
}

-- анимации для zoom in/out
weapon_rifle.states_design["zoom_in"] = {{anim = "sight_in", anim_speed = 1}};
weapon_rifle.states_design["zoom_out"] = {{anim = "sight_out", anim_speed = 1}};
weapon_rifle.states_design["idle_zoomed"] = {
	{anim = "idle4_in_s", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle5_in_s", anim_playback = ANIM_PB_REPEATEDLY,},
}
weapon_rifle.states_design["fire_zoomed"] = {{anim = "fire_in_s", snd = "rifle_fire_in", anim_speed = weapon_rifle.m_rate_of_fire},};
weapon_rifle.states_design["fire_finish_zoomed"] = {{anim = "fire_s", snd = "rifle_fire_in", anim_speed = weapon_rifle.m_rate_of_fire, snd_params = snd_weapon_shot},};

-- RELOAD
weapon_rifle.states_design["reload"] = {{anim = "reload", snd = "rifle_reload", snd_params = snd_weapon_common},};

---------------------------------------------------------------------------
-- общая часть
function weapon_rifle:on_init()
end

---------------------------------------------------------------------------
-- серверная часть 
sv_weapon_rifle = utils.inherit(sv_weapon_firearm, weapon_rifle);

---------------------------------------------------------------------------
function sv_weapon_rifle:register_properties(prop_registry)
	sv_weapon_firearm.register_properties(self, prop_registry);
end

---------------------------------------------------------------------------
function sv_weapon_rifle:on_init()
	sv_weapon_firearm.on_init(self);
	weapon_rifle.on_init(self);
end

---------------------------------------------------------------------------
function sv_weapon_rifle:event_lever1_down()
	-- Сбрасываем флаг, означающий атаку штыком
	self.m_bayonet_attack = false
	
	sv_weapon_firearm.event_lever1_down(self);
end

---------------------------------------------------------------------------
function sv_weapon_rifle:event_lever2_down()
	
	-- Атака штыком по нажатию правой кнопки
	local cur_state = self:get_cur_fsm_state(self.main_fsm);
	
	if(cur_state == self.idle_state or 
		(self.fire_finish_interruption_time and 
		cur_state == self.fire_finish_state and 
		self:get_cur_fsm_state_time(self.main_fsm) >= self.fire_finish_interruption_time))
	then
		self.m_bayonet_attack = true
		self:change_fsm_state(self.main_fsm, self.fire_state, true);
	end

end

---------------------------------------------------------------------------
function sv_weapon_rifle:on_enter_fire()
	if self.m_bayonet_attack then
		-- Атака штыком
		self:visualize_state(self.main_fsm, self.state_visual_info, "bayonet_attack");
	else
		-- Обычная атака
		sv_weapon_firearm.on_enter_fire(self);
	end
end

---------------------------------------------------------------------------
function sv_weapon_rifle:on_update_fire()
	if self.m_bayonet_attack then
		-- Атака штыком
		-- нанести хит
		self:fire_trace(self. m_fire_damage, g_damage_type.KNOCK, self.m_fire_impulse, 
					self.m_fire_dist, self.m_fire_dist, self.m_fire_disp, self.m_recoil_angle);

		self:change_fsm_state(self.main_fsm, self.fire_finish_state, true);
	else
		-- Обычная атака
		sv_weapon_firearm.on_update_fire(self);
	end
end

---------------------------------------------------------------------------
function sv_weapon_rifle:on_enter_fire_finish()
	if self.m_bayonet_attack then
		-- Атака штыком
		self:visualize_state(self.main_fsm, self.state_visual_info, "bayonet_attack_out");
	else
		-- Обычная атака
		sv_weapon_firearm.on_enter_fire_finish(self);
	end
end

---------------------------------------------------------------------------
-- клиентская
cl_weapon_rifle = utils.inherit(cl_weapon_firearm, weapon_rifle);

---------------------------------------------------------------------------
function cl_weapon_rifle:on_init()
	cl_weapon_firearm.on_init(self);
	weapon_rifle.on_init(self);
end