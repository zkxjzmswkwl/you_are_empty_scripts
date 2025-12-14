------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Andrey Frolov
------------------------------------------------------------------------
-- лифт
------------------------------------------------------------------------

-- общая часть
lift = {
	guid = {0x94c6150e, 0x8d75, 0x4898, 0xb4, 0xfe, 0x29, 0x8d, 0xf0, 0x9d, 0x93, 0x92},
};

function lift:register_properties(prop_registry)
	game_object.register_properties(self, prop_registry);
	self:register_property(prop_registry, "locked_snd", "DyorganieDveri3");
	self:register_property(prop_registry, "move_snd", "DyorganieDveri3");
	self:register_property(prop_registry, "stop_snd", "LiftStop");
	self:register_property(prop_registry, "power_on_snd", " ");
	self:register_property(prop_registry, "power_off_snd", " ");
	self:register_property(prop_registry, "moved_snd", " ");
	self:register_property(prop_registry, "stopped_snd", " ");
	self:register_property(prop_registry, "blocked_snd", " ");
end

function lift:on_init()
	local locked_snd_prop		= self:get_property_by_name("locked_snd");
	local move_snd_prop			= self:get_property_by_name("move_snd");
	local stop_snd_prop			= self:get_property_by_name("stop_snd");
	local power_on_snd_prop		= self:get_property_by_name("power_on_snd");
	local power_off_snd_prop	= self:get_property_by_name("power_off_snd");
	local moved_snd_prop		= self:get_property_by_name("moved_snd");
	local stopped_snd_prop		= self:get_property_by_name("stopped_snd");
	local blocked_snd_prop		= self:get_property_by_name("blocked_snd");

	self.m_locked_snd			= self:add_sound(self:get_property_value(locked_snd_prop	));
	self.m_move_snd				= self:add_sound(self:get_property_value(move_snd_prop		));
	self.m_stop_snd				= self:add_sound(self:get_property_value(stop_snd_prop		));
	self.m_power_on_snd			= self:add_sound(self:get_property_value(power_on_snd_prop	));
	self.m_power_off_snd		= self:add_sound(self:get_property_value(power_off_snd_prop	));
	self.m_moved_snd			= self:add_sound(self:get_property_value(moved_snd_prop		));
	self.m_stopped_snd			= self:add_sound(self:get_property_value(stopped_snd_prop	));
	self.m_blocked_snd			= self:add_sound(self:get_property_value(blocked_snd_prop	));
end

------------------------------------
-- серверная часть 
sv_lift = utils.inherit(sv_game_object, lift);

function sv_lift:on_init()
	sv_game_object.on_init(self);
	lift.on_init(self);
	self:set_update_enable(false);
end

function sv_lift:OnLocked()
	self:play_sound(self.m_locked_snd);
end

function sv_lift:OnMove()
	self:play_sound(self.m_move_snd);
end

function sv_lift:OnStop()
	self:play_sound(self.m_stop_snd);
end

function sv_lift:OnPowerOn()
	self:play_sound(self.m_power_on_snd);
end

function sv_lift:OnPowerOff()
	self:play_sound(self.m_power_off_snd);
end

function sv_lift:OnMoved()
	self:play_sound(self.m_moved_snd);
end

function sv_lift:OnStopped()
	self:play_sound(self.m_stopped_snd);
end

function sv_lift:OnBlocked()
	self:play_sound(self.m_blocked_snd);
end

------------------------------------
-- клиентская
cl_lift = utils.inherit(cl_game_object, lift);

function cl_lift:on_init()
	cl_game_object.on_init(self);
	lift.on_init(self);
end
