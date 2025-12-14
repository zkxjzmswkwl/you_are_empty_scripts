------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- дверь со звуком
------------------------------------------------------------------------

-- общая часть
door_sound = {
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

function door_sound:register_properties(prop_registry)
	game_object.register_properties(self, prop_registry);
	self:register_property(prop_registry, "open_snd", "DoorWoodenOpen2.wav");
	self:register_property(prop_registry, "close_snd", "DoorWoodenClosed5.wav");
end

------------------------------------
-- серверная часть 
sv_door_sound = utils.inherit(sv_game_object, door_sound);

function sv_door_sound:on_init()
	sv_game_object.on_init(self);
	
	self.health_prop = self:get_property_by_name("health_points");
end

function sv_door_sound:on_use()
	console.print("==============================on use");
end


function sv_door_sound:OnOpen()
	console.print("==============================on open");
	self:play_sound(0);
end

function sv_door_sound:OnClose()
	console.print("==============================on close");
	self:play_sound(1);
end

function sv_door_sound:OnBlocked()
	console.print("==============================on blocked");
end

function sv_door_sound:OnToggle()
	console.print("==============================on toggle");
end

------------------------------------
-- клиентская
cl_door_sound = utils.inherit(cl_game_object, door_sound);

function cl_door_sound:on_init()
	cl_game_object.on_init(self);
	
	local open_snd_prop = self:get_property_by_name("open_snd");
	local close_snd_prop = self:get_property_by_name("close_snd");

	self:add_sound(self:get_property_value(open_snd_prop), false, 0);
	self:add_sound(self:get_property_value(close_snd_prop), false, 0);
end
