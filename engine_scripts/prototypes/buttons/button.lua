------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Yuri Dobronravin
--				Andrey Frolov
------------------------------------------------------------------------
-- Прототип объекта кнопка
------------------------------------------------------------------------

------------------------------------
-- общая часть
button = {
	guid = {0x4eaff5e, 0x2b15, 0x4f7f, 0xaf, 0xaa, 0x9f, 0x75, 0xd8, 0xe7, 0x21, 0x41},
}

function button:register_properties(prop_registry)
	self:register_property(prop_registry, "is_static",		true);
	self:register_property(prop_registry, "switch_state",	false);

	self:register_property(prop_registry, "switch_on_snd",	"-unknown-");
	self:register_property(prop_registry, "switch_off_snd",	"-unknown-");
	self:register_property(prop_registry, "locked_snd",		"-unknown-");
	self:register_property(prop_registry, "lock_snd",		"-unknown-");
	self:register_property(prop_registry, "unlock_snd",		"-unknown-");
end

function button:on_init()
	-- ожидаем что RigidBody загрузили одну модель, ее и используем
	self.m_model					= 0;
	self.m_turn_on_anim				= self:add_animation(self.m_model, "turn_on", ANIM_PB_ONCE);
	self.m_turn_off_anim			= self:add_animation(self.m_model, "turn_off", ANIM_PB_ONCE);

	local switch_on_snd_prop		= self:get_property_by_name("switch_on_snd");
	local switch_off_snd_prop		= self:get_property_by_name("switch_off_snd");
	local locked_snd_prop			= self:get_property_by_name("locked_snd");
	local lock_snd_prop				= self:get_property_by_name("lock_snd");
	local unlock_snd_prop			= self:get_property_by_name("unlock_snd");
	
	self.m_switch_on_snd			= self:add_sound(self:get_property_value(switch_on_snd_prop));
	self.m_switch_off_snd			= self:add_sound(self:get_property_value(switch_off_snd_prop));
	self.m_locked_snd				= self:add_sound(self:get_property_value(locked_snd_prop));
	self.m_lock_snd					= self:add_sound(self:get_property_value(lock_snd_prop));
	self.m_unlock_snd				= self:add_sound(self:get_property_value(unlock_snd_prop));
end
	
------------------------------------
-- серверная часть 
sv_button = utils.inherit(sv_game_object, button);

function sv_button:register_properties(prop_registry)
	---------------------------------------------------------------------------------------
	sv_game_object.register_properties(self, prop_registry);
	button.register_properties(self, prop_registry);
	---------------------------------------------------------------------------------------
	self.in_switch_on		= self:register_input_slot("switch_on", self.in_switch_on);
	self.in_switch_off		= self:register_input_slot("switch_off", self.in_switch_off);
	self.in_switch_toggle	= self:register_input_slot("switch_toggle", self.in_switch_toggle);
	---------------------------------------------------------------------------------------
	self.out_switch_on		= self:register_output_slot("on_switch_on", nil);
	self.out_switch_off		= self:register_output_slot("on_switch_off", nil);
	---------------------------------------------------------------------------------------
end

function sv_button:on_init(dreader)
	sv_game_object.on_init(self);
	button.on_init(self);
	---------------------------------------------------------------------------------------
	self:hide_model(self.m_model, false)
	---------------------------------------------------------------------------------------
	self.main_fsm			= self:add_fsm("main_fsm");
	self.switch_on_state	= self:add_fsm_state(self.main_fsm, "switch_on_state",	self.on_enter_switch_on, self.on_update_switch_on, nil, nil);
	self.switch_off_state	= self:add_fsm_state(self.main_fsm, "switch_off_state",	self.on_enter_switch_off, self.on_update_switch_off, nil, nil);
	---------------------------------------------------------------------------------------
	if(self:get_property_value_by_name("is_static") == true) then
		self:set_property_value_by_name("mass", 0)
	end
	self:set_property_value_by_name("auto_disable", false)
	
	if self:get_property_value_by_name("switch_state") == true	then
		self:play_animation(self.m_turn_off_anim);
		self:stop_animation(self.m_turn_off_anim);
	else
		self:play_animation(self.m_turn_on_anim);
		self:stop_animation(self.m_turn_on_anim);
	end
	---------------------------------------------------------------------------------------
end

function sv_button:on_shutdown()
	sv_game_object.on_shutdown(self)
end

function sv_button:on_update(dt)
	sv_game_object.on_update(self,dt)
end

function sv_button:is_locked()
	return self:get_property_value_by_name("is_locked");
end

function sv_button:on_use()
	if self:is_locked() == false then
		self:switch_toggle();
	end
end

function sv_button:switch_on()
	self:change_fsm_state(self.main_fsm, self.switch_on_state, true)
	self:set_property_value_by_name("switch_state", true)
	self:play_sound(self.m_switch_on_snd);
	--console.print("button: on")
end

function sv_button:switch_off()
	self:change_fsm_state(self.main_fsm, self.switch_off_state, true)
	self:set_property_value_by_name("switch_state", false)
	self:play_sound(self.m_switch_off_snd);
	--console.print("button: off")
end

function sv_button:switch_toggle()
	if (self:get_property_value_by_name("switch_state") == true) then
		self:switch_off()
	else
		self:switch_on()
	end
end

-----------------------------------
-- input slots
-----------------------------------
function sv_button:in_switch_on()
	if self:is_locked() == false then
		self:switch_on()
	end
end

function sv_button:in_switch_off()
	if self:is_locked() == false then
		self:switch_off()
	end
end

function sv_button:in_switch_toggle()
	if self:is_locked() == false then
		self:switch_toggle()
	end
end

function sv_button:InLock()
	--console.print("sv_button:InLock()");
	self:play_sound(self.m_lock_snd);
end

function sv_button:InUnlock()
	--console.print("sv_button:InUnlock()");
	self:play_sound(self.m_unlock_snd);
end

function sv_button:OnLocked()
	--console.print("sv_button:OnLocked()");
	self:play_sound(self.m_locked_snd);
end
-----------------------------------
-- FSM states functions
-----------------------------------
-- on
function sv_button:on_enter_switch_on()
	--console.print("sv_button:on_enter_switch_on()")
	self:play_animation(self.m_turn_on_anim);
	self:set_fsm_update_time(self.main_fsm, self:get_animation_length(self.m_turn_on_anim));
	self:set_enable(true);
end

function sv_button:on_update_switch_on()
	self:emit_signals(self.out_switch_on);
	self:set_fsm_update_time(self.main_fsm, 0);
end

-- off
function sv_button:on_enter_switch_off()
	--console.print("sv_button:on_enter_switch_off()")
	self:play_animation(self.m_turn_off_anim);
	self:set_fsm_update_time(self.main_fsm, self:get_animation_length(self.m_turn_off_anim));
	self:set_enable(true);
end

function sv_button:on_update_switch_off()
	self:emit_signals(self.out_switch_off);
	self:set_fsm_update_time(self.main_fsm, 0);
end

------------------------------------
-- клиентская часть
cl_button = utils.inherit(cl_game_object, button);

function cl_button:on_init()
	cl_game_object.on_init(self);
	button.on_init(self);
end