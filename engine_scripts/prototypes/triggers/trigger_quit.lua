------------------------------------------------------------------------
-- Copyright (C) 2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Andrey Frolov
------------------------------------------------------------------------
-- trigger_quit - тригер для выхода из игры
------------------------------------------------------------------------

-- общая часть
trigger_quit = {
	guid = {0x96c2e857, 0x477b, 0x4a4f, 0xb6, 0x63, 0xde, 0xf5, 0xdd, 0x26, 0x6, 0xa6},
};

function trigger_quit:register_properties(prop_registry)
end

------------------------------------
-- серверная часть 
sv_trigger_quit = utils.inherit(sv_game_object, trigger_quit);

function sv_trigger_quit:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry);
	trigger_quit.register_properties(self, prop_registry);
end

function sv_trigger_quit:on_init()
	sv_game_object.on_init(self);
end

-- функции обработчики слотов
function sv_trigger_quit:OnEnter(activator)
	engine.process_command("quit");
end

-----------------------------------------
cl_trigger_quit = utils.inherit(cl_game_object, trigger_quit);

function cl_trigger_quit:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry);
	trigger_quit.register_properties(self, prop_registry);
end
