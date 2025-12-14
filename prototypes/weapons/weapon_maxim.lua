------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Класс пулемет "Максим"
------------------------------------------------------------------------

include("ammo_maxim.lua")

weapon_maxim = {};

-------------------------------------------	
-- properties
-------------------------------------------	
weapon_maxim.properties_design = utils.merge_arrays(weapon_basic.properties_design, {
	{"model_name",			"ItemMauzer"},
	{"hit_material",		"mat_hit_ppsh" },
	{"slot_name",			g_weapon_slots[6] }, -- слот в котором может быть оружие
	{"priority",			0 }, -- приоритет оружия
--	{"icon_id",				5 }, -- иконка для HUD
	
	{ "loaded_ammo",		150 },	-- кол-во заряженных патронов в стволе (не больше чем m_clip_size)
	{ "all_ammo",			0 },	-- кол-во дополнительных, патронов, которые добавляются в инвентарь при подборе данного оружия	
	
	{ "light_enable",		true }, -- подсветка во время выстрела
});

-- Модели оружия и модели рук данного оружия для различных игроков
weapon_maxim.m_models_names = {
--	Имя игрока				Имя модели рук		Имя модели оружия		
	["-unknown-"]		= {	"maxim_hands",		"maxim"			},
}

-- иконка для HUD
weapon_maxim.m_ammo_icon_id		= 3
weapon_maxim.m_holdable_icon_id	= 8

---------------------------------------
-- параметры выстрела
---------------------------------------
weapon_maxim.m_bullets_in_shot		= 1;
weapon_maxim.m_bullet_damage		= 63;
weapon_maxim.m_bullet_impulse		= 3.7;
weapon_maxim.m_bullet_min_dist		= 30;
weapon_maxim.m_bullet_max_dist		= 150;
weapon_maxim.m_bullet_dist			= 150;

weapon_maxim.m_shot_disp_zoomed		= 10;
weapon_maxim.m_shot_recoil_zoomed	= 3;

weapon_maxim.m_shot_effect_name			= "pfx_shot_mauzer.lua" -- эффект при выстреле
weapon_maxim.m_shot_point_name			= "#shoot_point"		-- точка привязки эффекта в модели
weapon_maxim.m_trace_bullet_effect_name	= "pfx_shot_trace_fp.lua"	-- эффект трейса пули

-- Скорострельность оружия
weapon_maxim.m_rate_of_fire			= 1.7
----------------------------------------
-- параметры патронов
----------------------------------------
weapon_maxim.m_ammo_class			= "ammo_maxim"	-- класс используемых патронов
weapon_maxim.m_ammo_type			= "maxim ammo"	-- тип используемых патронов
weapon_maxim.m_clip_size			= 371			-- вместимость обоймы
weapon_maxim.m_ammo_for_shot		= 1				-- кол-во патронов расходуемых на один выстрел

-- FOV дляразных режимов
weapon_maxim.m_normal_fov			= 90;
weapon_maxim.m_zoomed_fov			= 75;
weapon_maxim.m_model_fov			= 45;

-- Чувствительность мыши (коэффициент масштабирования)
weapon_maxim.m_zoomed_mouse_sens_scale	= 0.3;
weapon_maxim.m_normal_mouse_sens_scale	= 1;

-------------------------------------------	
-- анимации и звуки состояний FSM
-------------------------------------------	
weapon_maxim.states_design = {};
weapon_maxim.states_design["show"] = {{anim = "taking", snd = "maxim_taking", snd_params = snd_weapon_common},};
weapon_maxim.states_design["hide"] = {{anim = "hiding", snd = "maxim_hiding", snd_params = snd_weapon_common},};

-- IDLE
weapon_maxim.states_design["idle"] = {
	{anim = "idle1", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle2", anim_playback = ANIM_PB_REPEATEDLY,},
};

weapon_maxim.states_design["idle_zoomed"] = {
	{anim = "idle_down1", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle_down2", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle_down3", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle_down4", anim_playback = ANIM_PB_REPEATEDLY,},
	{anim = "idle_down5", anim_playback = ANIM_PB_REPEATEDLY,},
};

weapon_maxim.states_design["idle_lenta_end"] = {
	{anim = "lenta_end_idle", anim_playback = ANIM_PB_REPEATEDLY,},
};

-- FIRE
weapon_maxim.states_design["fire_finish"] = {
	{anim = "fire1", snd = "maxim_fire1", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire2", snd = "maxim_fire2", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire3", snd = "maxim_fire3", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire4", snd = "maxim_fire4", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire5", snd = "maxim_fire1", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire6", snd = "maxim_fire2", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire7", snd = "maxim_fire3", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire8", snd = "maxim_fire4", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire9", snd = "maxim_fire1", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire10", snd = "maxim_fire2", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire11", snd = "maxim_fire3", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire12", snd = "maxim_fire4", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire13", snd = "maxim_fire1", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire14", snd = "maxim_fire2", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire15", snd = "maxim_fire3", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire16", snd = "maxim_fire4", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire17", snd = "maxim_fire1", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire18", snd = "maxim_fire2", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire19", snd = "maxim_fire3", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire20", snd = "maxim_fire4", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
	{anim = "fire21", snd = "maxim_fire1", anim_speed = weapon_maxim.m_rate_of_fire, snd_params = snd_weapon_shot},
};

weapon_maxim.states_design["fire_finish_zoomed"] = utils.clone(weapon_maxim.states_design["fire_finish"])

-- анимации для zoom in/out
weapon_maxim.states_design["zoom_in"]				= {{anim = "down", snd = "maxim_down"},};
weapon_maxim.states_design["zoom_out"]				= {{anim = "up", snd = "maxim_up"},};
weapon_maxim.states_design["zoom_in_lenta_end"]		= {{anim = "lenta_end_down"},};
weapon_maxim.states_design["zoom_out_lenta_end"]	= {{anim = "lenta_end_up"},};

-- закончилась лента
weapon_maxim.states_design["lenta_end"] = {{anim = "lenta_end", snd = "maxim_lenta_end2"},};

-- перезарядка
weapon_maxim.states_design["reload"] = {{anim = "reload", snd = "maxim_reload", snd_params = snd_weapon_common},};
weapon_maxim.states_design["pull_out_lenta"] = {{anim = "lenta_end2", snd = "maxim_lenta_end2"},};

-- общая часть
weapon_maxim.guid = {0x4117be19, 0xba50, 0x4350, 0xa4, 0x3c, 0xb6, 0x53, 0xc6, 0xb6, 0x78, 0x74};

function weapon_maxim:on_init()
end

------------------------------------
-- серверная часть 
sv_weapon_maxim = utils.inherit(sv_weapon_firearm, weapon_maxim);

function sv_weapon_maxim:register_properties(prop_registry)
	sv_weapon_firearm.register_properties(self, prop_registry);
end

---------------------------------------------------------------------------
function sv_weapon_maxim:on_init()
	sv_weapon_firearm.on_init(self);
	weapon_maxim.on_init(self);
end

---------------------------------------------------------------------------
function sv_weapon_maxim:event_lever1_down()
	local cur_state = self:get_cur_fsm_state(self.main_fsm);
	if(cur_state == self.idle_state and self.m_is_zoomed == true) then
		sv_weapon_firearm.event_lever1_down(self);
	end
end

---------------------------------------------------------------------------
function sv_weapon_maxim:event_lever1_up()
	sv_weapon_firearm.event_lever1_up(self)
	local cur_state = self:get_cur_fsm_state(self.main_fsm);
	if cur_state == self.fire_state or cur_state == self.fire_finish_state then
		self.m_need_to_stop_firing = true;
		self:change_fsm_state(self.main_fsm, self.idle_state, true);
	end
end

---------------------------------------------------------------------------
function sv_weapon_maxim:event_lever2_down()
	self.m_getup_after_reload = false	
	-- для включения режима "ZOOM"
	if( self:get_cur_fsm_state(self.main_fsm) == self.idle_state ) then
		if( self.m_is_zoomed ) then
			self:change_fsm_state(self.main_fsm, self.zoom_out_state, true);
		else
			self:change_fsm_state(self.main_fsm, self.zoom_in_state, true);
		end
	elseif( self.m_is_zoomed and self:get_cur_fsm_state(self.main_fsm) == self.reload_state) then
		-- Если встаем во время лежачей перезарядки, то		
		-- Восстанавливаем FOV
		self:set_camera_fov(self.m_normal_fov, self.m_zoom_in_anim_length );
		engine.mouse_set_sensetivity_scale(self.m_normal_mouse_sens_scale)
		-- Возвращаем возможность управления игроком
		local owner = self:get_owner();
		owner:set_property_value_by_name("block_movement", false);
		self.m_getup_after_reload = true
	end
	
	if(cur_state == self.zoom_out_state) then
		self.m_reload_after_zoom = false;
	end
end

---------------------------------------------------------------------------
function sv_weapon_maxim:on_enter_idle()
	if(self.m_is_zoomed == true) then
		if not self:can_fire() then
			self:visualize_state(self.main_fsm, self.state_visual_info, "idle_lenta_end");
		else
			self:visualize_state(self.main_fsm, self.state_visual_info, "idle_zoomed");
		end
	else
		self:visualize_state(self.main_fsm, self.state_visual_info, "idle");
	end		
	-- обновлять оружие в idle не нужно, idle - зацикленная
	self:set_fsm_update_time(self.main_fsm, 0);
end

---------------------------------------------------------------------------
function sv_weapon_maxim:event_reload()
	if(self:get_cur_fsm_state(self.main_fsm) == self.idle_state) then
		if(self:can_reload()) then
			self:change_fsm_state(self.main_fsm, self.reload_state, true);
		else
			if self:is_empty() then
				-- Закончились патроны - преключаемся на следующее оружие (по приоритету)
				self:select_next_weapon()
			end
		end
	end	
end

---------------------------------------------------------------------------
function sv_weapon_maxim:on_enter_reload()
	
	if self:can_fire() and not self.pull_out_lenta_played then
		self:visualize_state(self.main_fsm, self.state_visual_info, "pull_out_lenta")
		self.pull_out_lenta_played = true
	else
		self:visualize_state(self.main_fsm, self.state_visual_info, "reload");
		self.pull_out_lenta_played = false
	end
end

---------------------------------------------------------------------------
function sv_weapon_maxim:on_update_reload()
	self.lenta_end_played = false
	if self.pull_out_lenta_played then
		sv_weapon_maxim.on_enter_reload(self)
	else
		sv_weapon_firearm.on_update_reload(self)
		if self.m_getup_after_reload then
			self:change_fsm_state(self.main_fsm, self.zoom_out_state, true);
		end 
	end
	
end

---------------------------------------------------------------------------
function sv_weapon_maxim:on_enter_fire_finish()
	self.m_need_to_stop_firing = false;
	sv_weapon_firearm.on_enter_fire_finish(self);
end

---------------------------------------------------------------------------
function sv_weapon_maxim:on_update_fire_finish()
	if(self:can_fire() and self.m_need_to_stop_firing ~= true) then
		self:change_fsm_state(self.main_fsm, self.fire_state, true, true);
	elseif( not self.lenta_end_played ) then
		self:visualize_state(self.main_fsm, self.state_visual_info, "lenta_end");
		self.lenta_end_played = true
	else
		sv_weapon_firearm.on_update_fire_finish(self);
	end
end

---------------------------------------------------------------------------
function sv_weapon_maxim:on_enter_zoom_in()
	local state_name = self:can_fire() and "zoom_in" or "zoom_in_lenta_end"
	local visual_idx, anim_length = self:visualize_state(self.main_fsm, self.state_visual_info, state_name);
	self.m_zoom_in_anim_length = anim_length 
	self:set_camera_fov(self.m_zoomed_fov, anim_length);
	engine.mouse_set_sensetivity_scale(self.m_zoomed_mouse_sens_scale)

	local owner = self:get_owner();
	owner:set_property_value_by_name("block_movement", true);
	--.HACK.Slava Пока передаем явно число 32, так как в Lua нет побитовых операций
	owner:set_property_value_by_name("block_movement_flags", 32); 
end

---------------------------------------------------------------------------
function sv_weapon_maxim:on_enter_zoom_out()
	local state_name = self:can_fire() and "zoom_out" or "zoom_out_lenta_end"
	local visual_idx, anim_length = self:visualize_state(self.main_fsm, self.state_visual_info, state_name);
	self:set_camera_fov(self.m_normal_fov, anim_length);
	engine.mouse_set_sensetivity_scale(self.m_normal_mouse_sens_scale)
	
	local owner = self:get_owner();
	owner:set_property_value_by_name("block_movement", false);
end

---------------------------------------------------------------------------
function sv_weapon_maxim:on_update_zoom_in()
	self:set_zoom(true)
	if(self.m_reload_after_zoom) then
		self:change_fsm_state(self.main_fsm, self.reload_state, true);
	else
		self:change_fsm_state(self.main_fsm, self.idle_state, true);
	end;
end

---------------------------------------------------------------------------
function sv_weapon_maxim:on_enter_hide()
	sv_weapon_firearm.on_enter_hide(self)
	local owner = self:get_owner();
	owner:set_property_value_by_name("block_movement", false);
end

---------------------------------------------------------------------------
-- клиентская
cl_weapon_maxim = utils.inherit(cl_weapon_firearm, weapon_maxim);

function cl_weapon_maxim:on_init()
	cl_weapon_firearm.on_init(self);
	weapon_maxim.on_init(self);
end
