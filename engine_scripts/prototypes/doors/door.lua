------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Yuri Dobronravin
--				Andrey Frolov
------------------------------------------------------------------------
-- дверь со звуком
------------------------------------------------------------------------

-- общая часть
door = {
	guid = {0xdd345c53, 0x1326, 0x4190, 0xa8, 0xee, 0x9, 0xc7, 0x66, 0xae, 0xc4, 0x0},
};

--[[
	InOpen
	OnOpen
	InClose
	OnClose
	InToggle
	OnToggle
	OnOpened
	OnClosed
	OnBlocked
	InLock
	InUnlock
	OnLocked
--]]


door.properties_design = {
--	{ "material_default",		"mat_derevo"	},
};


function door:register_properties(prop_registry)
	game_object.register_properties(self, prop_registry);
	self:register_property(prop_registry, "open_snd", "DoorOpen");
	self:register_property(prop_registry, "close_snd", "DoorClosed");
	self:register_property(prop_registry, "locked_snd", "DyorganieDveri3");
	self:register_property(prop_registry, "lock_snd", "DoorLock");
	self:register_property(prop_registry, "unlock_snd", "DoorUnlock");
	self:register_property(prop_registry, "health_points", 100);
end

function door:on_init()
	local open_snd_prop = self:get_property_by_name("open_snd");
	local close_snd_prop = self:get_property_by_name("close_snd");
	local locked_snd_prop = self:get_property_by_name("locked_snd");
	local lock_snd_prop = self:get_property_by_name("lock_snd");
	local unlock_snd_prop = self:get_property_by_name("unlock_snd");
	
	self.m_open_snd = self:add_sound(self:get_property_value(open_snd_prop));
	self.m_close_snd = self:add_sound(self:get_property_value(close_snd_prop));
	self.m_locked_snd = self:add_sound(self:get_property_value(locked_snd_prop));
	self.m_lock_snd = self:add_sound(self:get_property_value(lock_snd_prop));
	self.m_unlock_snd = self:add_sound(self:get_property_value(unlock_snd_prop));
end

------------------------------------
-- серверная часть 
sv_door = utils.inherit(sv_game_object, door);

function sv_door:on_init()
	sv_game_object.on_init(self);
	door.on_init(self);
	
	self.health_prop = self:get_property_by_name("health_points");
	
	self:init_properties_from_table(door.properties_design);
	self:set_update_enable(false);
end

function sv_door:on_use()
	--console.print("==============================on use");
end

function sv_door:OnOpen()
	--console.print("==============================on open");
	self:play_sound(self.m_open_snd);
end

function sv_door:OnClose()
	--console.print("==============================on close");
	self:play_sound(self.m_close_snd);
end

function sv_door:OnBlocked()
	--console.print("==============================on blocked");
	self:stop_sound(self.m_open_snd);
	self:stop_sound(self.m_close_snd);
end

function sv_door:OnToggle()
	--console.print("==============================on toggle");
end

function sv_door:OnLocked()
	--console.print("==============================on is_locked");
	self:play_sound(self.m_locked_snd);
end

------------------------------------
-- клиентская
cl_door = utils.inherit(cl_game_object, door);

function cl_door:on_init()
	cl_game_object.on_init(self);
	door.on_init(self);
end
