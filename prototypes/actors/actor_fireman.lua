------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Fireman - монстр пожарник
------------------------------------------------------------------------



---------------------------------------------------------------------------------
-- общая часть

actor_fireman.guid = {0x2104cd62, 0xe4c6, 0x4aa5, 0x96, 0x4a, 0x5e, 0x55, 0x2c, 0xb3, 0x23, 0x2d};

function actor_fireman:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_fireman = utils.inherit(sv_actor_basic, actor_fireman);

function sv_actor_fireman:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

function sv_actor_fireman:on_init()
	sv_actor_basic.on_init(self);
	actor_fireman.on_init(self);
end

-- пожарник после атаки с прыжка
-- должен бежать дальше
function sv_actor_fireman:on_enter_attack_jump_land()
	sv_actor_basic.on_enter_attack_jump_land(self);
	self.m_performed_forward = 1;
end

---------------------------------------------------------------------------
-- клиентская
cl_actor_fireman = utils.inherit(cl_actor_basic, actor_fireman);

function cl_actor_fireman:on_init()
	cl_actor_basic.on_init(self);
	actor_fireman.on_init(self);
end