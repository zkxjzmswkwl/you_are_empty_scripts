------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Оружие снайперская винтовка 
------------------------------------------------------------------------

include("ammo_rifle.lua")

weapon_rifle_sniper = {};

weapon_rifle_sniper.guid = {0x9520cf42, 0x5743, 0x4121, 0xa3, 0x26, 0xfe, 0xee, 0xda, 0x66, 0xbc, 0xa8};

-------------------------------------------	
-- properties
-------------------------------------------	
weapon_rifle_sniper.properties_design = utils.merge_arrays(weapon_basic.properties_design, {
	{"model_name",			"ItemRifleOPTIC"},
	{"hit_material",		"mat_hit_mauzer" },
	{ "slot_name",			g_weapon_slots[11] }, -- слот в котором может быть оружие
	{ "priority",			6.5 }, -- приоритет оружия
--	{ "icon_id",			8 }, -- иконка для HUD
	
	{ "loaded_ammo",		5 },	-- кол-во заряженных патронов в стволе (не больше чем m_clip_size)
	{ "all_ammo",			0 },	-- кол-во дополнительных, патронов, которые добавляются в инвентарь при подборе данного оружия
	{ "max_ammo",			25 },	-- максимальное кол-во патронов, которое может быть у нас в инвентаре
	
	{ "light_enable",		true }, -- подсветка во время выстрела
});

-- Модели оружия и модели рук данного оружия для различных игроков
weapon_rifle_sniper.m_models_names = {
--	Имя игрока				Имя модели рук		Имя модели оружия		
	["-unknown-"]		= {	"snayper_hands",		"snayper"		},
}

-- иконка для HUD
weapon_rifle_sniper.m_ammo_icon_id		= 3
weapon_rifle_sniper.m_holdable_icon_id	= 9

weapon_rifle_sniper.fp_model_render_params = {}
weapon_rifle_sniper.fp_model_render_params.z_far = 500.0
	
---------------------------------------
-- параметры скорострельности
---------------------------------------
-- время через которое, 
-- можно не дожидаясь начала анимации сделать новый выстрел,
-- если nil, то обязательно ждем конца всей анимации
weapon_rifle_sniper.fire_finish_interruption_time = nil;
---------------------------------------
-- параметры выстрела
---------------------------------------
weapon_rifle_sniper.m_bullets_in_shot					= 1;
weapon_rifle_sniper.m_bullet_damage						= 500;
weapon_rifle_sniper.m_bullet_impulse					= .8;
weapon_rifle_sniper.m_bullet_min_dist					= 15;
weapon_rifle_sniper.m_bullet_max_dist					= 500;

weapon_rifle_sniper.m_shot_disp							= 3;
weapon_rifle_sniper.m_shot_disp_zoomed					= weapon_rifle_sniper.m_shot_disp / 3;

weapon_rifle_sniper.m_shot_recoil						= 7;
weapon_rifle_sniper.m_shot_recoil_zoomed				= weapon_rifle_sniper.m_shot_recoil;

weapon_rifle_sniper.m_not_visualize_last_fire_finish	= true;

-- Скорострельность оружия
weapon_rifle_sniper.m_rate_of_fire				= 1

-- Эффекты
weapon_rifle_sniper.m_shot_effect_name			= "pfx_shot_rifle.lua"		-- эффект при выстреле
weapon_rifle_sniper.m_shot_point_name			= "#shoot_point"			-- точка привязки эффекта в модели
weapon_rifle_sniper.m_trace_bullet_effect_name	= "pfx_shot_trace_fp.lua"	-- эффект трейса пули

----------------------------------------
-- параметры патронов
----------------------------------------
weapon_rifle_sniper.m_ammo_class		= "ammo_rifle";	-- класс используемых патронов
weapon_rifle_sniper.m_ammo_type			= "rifle ammo";	-- тип используемых патронов
weapon_rifle_sniper.m_clip_size			= 5;			-- вместимость обоймы
weapon_rifle_sniper.m_ammo_for_shot		= 1;			-- кол-во патронов расходуемых на один выстрел

-- FOV дляразных режимов
weapon_rifle_sniper.m_normal_fov		= 90;
weapon_rifle_sniper.m_zoomed_fov		= 45;
weapon_rifle_sniper.m_model_fov			= 25;

-- Чувствительность мыши (коэффициент масштабирования)
weapon_rifle_sniper.m_zoomed_mouse_sens_scale	= 0.3;
weapon_rifle_sniper.m_normal_mouse_sens_scale	= 1;

-------------------------------------------	
-- анимации и звуки состояний FSM
-------------------------------------------	
weapon_rifle_sniper.states_design = {};
weapon_rifle_sniper.states_design["show"] = {{anim = "taking", anim_speed = 1, snd = "rifle_taking", snd_params = snd_weapon_common},};
weapon_rifle_sniper.states_design["hide"] = {{anim = "hiding", anim_speed = 1, snd = "rifle_hiding"},};

-- IDLE
weapon_rifle_sniper.states_design["idle"] = {
	{anim = "idle1", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle2", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle3", anim_playback = ANIM_PB_REPEATEDLY,},
};

-- FIRE
weapon_rifle_sniper.states_design["fire"] = {
--	{anim = "fire_in", snd = "rifle_fire_in", anim_speed = weapon_rifle_sniper.m_rate_of_fire},
	{anim = "fire_in2", snd = "rifle_fire_in2a", anim_speed = weapon_rifle_sniper.m_rate_of_fire, snd_params = snd_weapon_shot},
}

weapon_rifle_sniper.states_design["fire_finish"] = {
--	{anim = "fire", snd = "", anim_speed = weapon_rifle_sniper.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire2", snd = "rifle_fire_in2b", anim_speed = weapon_rifle_sniper.m_rate_of_fire, snd_params = snd_weapon_reload},
}

-- анимации для zoom in/out
weapon_rifle_sniper.states_design["zoom_in"] = {{anim = "sight_in", anim_speed = 1}};
weapon_rifle_sniper.states_design["zoom_out"] = {{anim = "sight_out", anim_speed = 1}};
weapon_rifle_sniper.states_design["idle_zoomed"] = {
	{anim = "idle4_in_s", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle5_in_s", anim_playback = ANIM_PB_REPEATEDLY,},
}
weapon_rifle_sniper.states_design["fire_zoomed"] = {{anim = "fire_in_s", snd = "rifle_fire_in2",
	anim_speed = weapon_rifle_sniper.m_rate_of_fire},};
weapon_rifle_sniper.states_design["fire_finish_zoomed"] = {{anim = "fire2", 
	anim_speed = weapon_rifle_sniper.m_rate_of_fire, snd_params = snd_weapon_shot},};

-- RELOAD
weapon_rifle_sniper.states_design["reload"] = {{anim = "reload", snd = "rifle_reload", snd_params = snd_weapon_common},};

---------------------------------------------------------------------------
-- общая часть
function weapon_rifle_sniper:on_init()
end

---------------------------------------------------------------------------
-- серверная часть 
sv_weapon_rifle_sniper = utils.inherit(sv_weapon_firearm, weapon_rifle_sniper);

---------------------------------------------------------------------------
function sv_weapon_rifle_sniper:register_properties(prop_registry)
	sv_weapon_firearm.register_properties(self, prop_registry);
end

---------------------------------------------------------------------------
function sv_weapon_rifle_sniper:on_init()
	sv_weapon_firearm.on_init(self);
	weapon_rifle_sniper.on_init(self);
end


---------------------------------------------------------------------------------

function sv_weapon_rifle_sniper:on_update_zoom_in()
	sv_weapon_firearm.on_update_zoom_in(self);

	self:hide_model(self.m_model_hands[self:get_cur_player_name()], true);
	self:hide_model(self.m_model_fp[self:get_cur_player_name()], true);
end


---------------------------------------------------------------------------------

function sv_weapon_rifle_sniper:on_enter_zoom_out()
	sv_weapon_firearm.on_enter_zoom_out(self);

	--self.m_object_state_elements.weapon_basic.sight_weapon_rifle_sniper_zoom = nil

	self:hide_model(self.m_model_hands[self:get_cur_player_name()], false);
	self:hide_model(self.m_model_fp[self:get_cur_player_name()], false);
 
end

---------------------------------------------------------------------------------
function sv_weapon_rifle_sniper:on_enter_fire_finish()

	sv_weapon_firearm.on_enter_fire_finish(self);
	
	if(self.m_is_zoomed == true) then
		self:hide_model(self.m_model_hands[self:get_cur_player_name()], true);
		self:hide_model(self.m_model_fp[self:get_cur_player_name()], true);
	end	
end	

function sv_weapon_rifle_sniper:on_update_fire_finish()
	sv_weapon_firearm.on_update_fire_finish(self)

--	if(self.m_is_zoomed == true) then
--		self:hide_model(self.m_model_hands[self:get_cur_player_name()], true);
--		self:hide_model(self.m_model_fp[self:get_cur_player_name()], true);
--	end	

end

---------------------------------------------------------------------------
-- клиентская
cl_weapon_rifle_sniper = utils.inherit(cl_weapon_firearm, weapon_rifle_sniper);

---------------------------------------------------------------------------
function cl_weapon_rifle_sniper:on_init()
	cl_weapon_firearm.on_init(self);
	weapon_rifle_sniper.on_init(self);

	self.m_hide_crosshair_in_zoom = true
end

----------------------------------------------------------------------------------
function cl_weapon_rifle_sniper:on_enter_zoom_in()
	cl_weapon_firearm.on_enter_zoom_in(self)

	local element = {}
	element.__val = 1
	self.m_object_state_elements.weapon_basic.__sight_weapon_rifle_sniper_zoom = element
end

----------------------------------------------------------------------------------
function cl_weapon_rifle_sniper:on_enter_zoom_out()
	cl_weapon_firearm.on_enter_zoom_out(self)

	self.m_object_state_elements.weapon_basic.__sight_weapon_rifle_sniper_zoom = nil
end

----------------------------------------------------------------------------------
function cl_weapon_rifle_sniper:on_enter_hide()
	cl_weapon_firearm.on_enter_hide(self)

	self.m_object_state_elements.weapon_basic.__sight_weapon_rifle_sniper_zoom = nil
end
