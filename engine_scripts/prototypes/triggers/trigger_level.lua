------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Yuri Dobronravin
--				Andrey Frolov
------------------------------------------------------------------------
-- trigger_level - тригер для смены уровня
------------------------------------------------------------------------

-- общая часть
trigger_level = {
	guid = {0xe108ce1e, 0xe3e8, 0x481e, 0xab, 0x1a, 0x73, 0xd7, 0x8a, 0xc5, 0xb5, 0xea},
};

function trigger_level:register_properties(prop_registry)
	self.next_level_prop = self:register_property(prop_registry, "next_level", "no name");
end

------------------------------------
-- серверная часть 
sv_trigger_level = utils.inherit(sv_game_object, trigger_level);

function sv_trigger_level:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry);
	trigger_level.register_properties(self, prop_registry);
end

function sv_trigger_level:on_init()
	sv_game_object.on_init(self);
end

-- функции обработчики слотов
function sv_trigger_level:OnEnter(activator)
	engine.process_command("disconnect");
	engine.process_command("map", self:get_property_value(self.next_level_prop));
end

-----------------------------------------
cl_trigger_level = utils.inherit(cl_game_object, trigger_level);

function cl_trigger_level:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	trigger_level.register_properties(self, prop_registry);
end
