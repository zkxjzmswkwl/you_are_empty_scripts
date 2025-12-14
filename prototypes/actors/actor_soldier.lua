------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Actor Soldier - солдат
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть
actor_soldier.guid = {0x60c234e3, 0x4297, 0x4d34, 0xb0, 0x98, 0xaa, 0x42, 0x13, 0x21, 0xf8, 0x84};

------------------------------------
function actor_soldier:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_soldier = utils.inherit(sv_actor_basic, actor_soldier);

------------------------------------
function sv_actor_soldier:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end


------------------------------------
function sv_actor_soldier:on_init()
	sv_actor_basic.on_init(self);
	actor_soldier.on_init(self);
--[[	
	-- Переход из стоячего положения в сидячее и обратно
	self.transition_state = self:add_fsm_state(self.body_fsm, "transition", self.on_enter_transition, self.on_update_transition, nil, nil);
	self.m_attack_begin_str	= "attack_begin"
	self.m_attack_end_str	= "attack_end"
	self.m_reload_str		= "reload"
	self.m_pain_str			= "pain"
--]]
end

-------------------------------------
-- ATTACK SHOT RUN
-------------------------------------
function sv_actor_soldier:on_enter_attack_shot_run()
	-- Встаем, если сидим
	if self.m_is_sitting then
		self:change_fsm_state(self.body_fsm, self.transition_state, true);
		return
	end
	
	sv_actor_basic.on_enter_attack_shot_run(self)
end

--[[
-------------------------------------
-- RELOAD
-------------------------------------
function sv_actor_soldier:on_enter_reload()
	self.m_reload_ended = false;	

	self.io.m_block_movement = true;
	self:block_carrier_turn(true);
	self:stop_movement();

	self:visualize_state(self.body_fsm, self.state_visual_info, self.m_reload_str);
end

------------------------------------
function sv_actor_soldier:on_update_reload()
	sv_actor_basic.on_update_reload(self)
	
	-- Меняем положение
	self:change_fsm_state(self.body_fsm, self.transition_state, false);
end

-------------------------------------
-- PAIN
-------------------------------------
function sv_actor_soldier:on_enter_pain()
		self.m_pain_finished = false;
		self.io.m_block_movement = true;
		self:stop_movement();
		self:send_callback(CALLBACK_ANIM_END);
		
		self:visualize_state(self.body_fsm, self.state_visual_info, self.m_pain_str);
		self.m_aggresive_stance_time_left = self.params.aggresive_stance_time;
end

-------------------------------------
-- Переходы из стоячего положения в сидячее и обратно
-------------------------------------
function sv_actor_soldier:on_enter_transition()
	
	self.m_is_sitting = not self.m_is_sitting
		
	if not self.m_is_sitting then 
		self.m_attack_begin_str	= "attack_begin"
		self.m_attack_end_str	= "attack_end"
		self.m_reload_str		= "reload"
		self.m_pain_str			= "pain"
	else
		self.m_attack_begin_str	= "attack_sit_begin"
		self.m_attack_end_str	= "attack_sit_end"
		self.m_reload_str		= "reload_sit"
		self.m_pain_str			= "pain_sit"
	end
		
end

-------------------------------------
function sv_actor_soldier:on_update_transition()
	if not self.m_is_sitting then
		self:visualize_state(self.body_fsm, self.state_visual_info, "transition_sit_to_stay");
	else
		self:visualize_state(self.body_fsm, self.state_visual_info, "transition_stay_to_sit");
	end
end
--]]

---------------------------------------------------------------------------
-- клиентская
cl_actor_soldier = utils.inherit(cl_actor_basic, actor_soldier);

------------------------------------
function cl_actor_soldier:on_init()
	cl_actor_basic.on_init(self);
	actor_soldier.on_init(self);
end