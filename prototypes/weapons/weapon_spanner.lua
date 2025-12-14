------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Оружие - разводной ключ
------------------------------------------------------------------------

weapon_spanner = {};

-- properties
weapon_spanner.properties_design = utils.merge_arrays(weapon_basic.properties_design, {
	{"model_name",			"ItemSpanner" },
	{"hit_material",		"mat_hit_spanner" },
	{ "slot_name",			g_weapon_slots[1] }, -- слот в котором может быть оружие
	{ "priority",			2 }, -- приоритет оружия
--	{ "icon_id",			1 }, -- иконка для HUD
	
	{"enable_ammo",			false},	-- патроны не нужны
});

-- Модели оружия и модели рук данного оружия для различных игроков
weapon_spanner.m_models_names = {
--	Имя игрока				Имя модели рук			Имя модели оружия		
	["-unknown-"]		= {	"spanner_hands",		"spanner"			},
}

-- иконка для HUD
weapon_spanner.m_holdable_icon_id	= 4
	
-- параметры
-- атака
weapon_spanner.m_fire_damage		= 70;
weapon_spanner.m_fire_impulse		= .5;
weapon_spanner.m_fire_dist			= 2;
weapon_spanner.m_fire_disp			= 5;
weapon_spanner.m_recoil_angle		= 0;			
-- FOV
weapon_spanner.m_model_fov			= 65;

-- Скорострельность оружия
weapon_spanner.m_rate_of_fire		= 2


-- анимации и звуки состояний FSM
weapon_spanner.states_design = {};
weapon_spanner.states_design["show"] = {{anim = "taking", anim_speed = 2.5, snd = "klych_taking"},};
weapon_spanner.states_design["hide"] = {{anim = "hiding", anim_speed = 2.5, snd = "klych_hiding"},};
weapon_spanner.states_design["idle"] = {
											{anim = "idle1", anim_playback = ANIM_PB_REPEATEDLY,},
											{anim = "idle2", anim_playback = ANIM_PB_REPEATEDLY,},
											{anim = "idle3", anim_playback = ANIM_PB_REPEATEDLY,},
											{anim = "idle4", anim_playback = ANIM_PB_REPEATEDLY,},
											{anim = "idle5", anim_playback = ANIM_PB_REPEATEDLY,},
											{anim = "idle6", anim_playback = ANIM_PB_REPEATEDLY,},
											{anim = "idle7", anim_playback = ANIM_PB_REPEATEDLY,},
											{anim = "idle8", anim_playback = ANIM_PB_REPEATEDLY,},
										};
weapon_spanner.states_design["fire_in"] = {
											{anim = "attack1", anim_speed = weapon_spanner.m_rate_of_fire, snd = "klych", snd_params = snd_weapon_common},
											{anim = "attack2", anim_speed = weapon_spanner.m_rate_of_fire, snd = "klych", snd_params = snd_weapon_common},
											{anim = "attack3", anim_speed = weapon_spanner.m_rate_of_fire, snd = "klych", snd_params = snd_weapon_common},
											{anim = "attack4", anim_speed = weapon_spanner.m_rate_of_fire, snd = "klych", snd_params = snd_weapon_common},
									   };
weapon_spanner.states_design["fire_out"] = {
											{anim = "attack1_out", anim_speed = weapon_spanner.m_rate_of_fire},
											{anim = "attack2_out", anim_speed = weapon_spanner.m_rate_of_fire},
											{anim = "attack3_out", anim_speed = weapon_spanner.m_rate_of_fire},
											{anim = "attack4_out", anim_speed = weapon_spanner.m_rate_of_fire},
									   };

---------------------------------------------------------------------------------
-- общая часть
weapon_spanner.guid = {0xee3f119, 0x283b, 0x4051, 0x83, 0x94, 0x4b, 0xd9, 0x14, 0x3d, 0x7d, 0x6d};

function weapon_spanner:on_init()
end


------------------------------------
-- серверная часть 
sv_weapon_spanner = utils.inherit(sv_weapon_basic, weapon_spanner);

function sv_weapon_spanner:register_properties(prop_registry)
	sv_weapon_basic.register_properties(self, prop_registry);
end

function sv_weapon_spanner:on_init()
	sv_weapon_basic.on_init(self);
	weapon_spanner.on_init(self);
	
	-- дополнительное состояние для атаки
	self.fire_finish_state	= self:add_fsm_state(self.main_fsm, "fire_finish_state", self.on_enter_fire_finish, self.on_update_fire_finish, nil, nil);
end

---------------------------------------------------------------------------------
function sv_weapon_spanner:event_reload()
end

---------------------------------------------------------------------------------
function sv_weapon_spanner:event_lever1_down()

	-- Если был нажат удар во время fire_finish,
	-- то прерываем текущую атаку и начинаем новую атаку.
	local fsm_state = self:get_cur_fsm_state(self.main_fsm)
	if fsm_state == self.fire_finish_state then
		self:change_fsm_state(self.main_fsm, self.fire_state, true)
	else
		sv_weapon_basic.event_lever1_down(self)
	end
	
end

---------------------------------------------------------------------------------
function sv_weapon_spanner:on_enter_fire()
	self:visualize_state(self.main_fsm, self.state_visual_info, "fire_in");
end

---------------------------------------------------------------------------------
function sv_weapon_spanner:on_update_fire()

	-- нанести хит
	self:fire_trace(self. m_fire_damage, g_damage_type.KNOCK, self.m_fire_impulse, 
				self.m_fire_dist, self.m_fire_dist, self.m_fire_disp, self.m_recoil_angle);

	self:change_fsm_state(self.main_fsm, self.fire_finish_state, true);
	
end

---------------------------------------------------------------------------------
function sv_weapon_spanner:on_enter_fire_finish()
	self:visualize_state(self.main_fsm, self.state_visual_info, "fire_out");
end

---------------------------------------------------------------------------------
function sv_weapon_spanner:on_update_fire_finish()
	self:change_fsm_state(self.main_fsm, self.idle_state, true);
end

------------------------------------
-- клиентская
cl_weapon_spanner = utils.inherit(cl_weapon_basic, weapon_spanner);

function cl_weapon_spanner:on_init()
	cl_weapon_basic.on_init(self);
	weapon_spanner.on_init(self);
end