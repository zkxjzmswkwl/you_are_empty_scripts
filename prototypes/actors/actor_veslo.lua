------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Actor Veslo - девушка с веслом
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть
actor_veslo.guid = {0xdff2fc7f, 0xabfb, 0x4146, 0x89, 0xb6, 0xf8, 0x79, 0x12, 0x6, 0x39, 0x57};

function actor_veslo:on_init()
end

------------------------------------
-- серверная часть 
sv_actor_veslo = utils.inherit(sv_actor_basic, actor_veslo);

function sv_actor_veslo:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
end

function sv_actor_veslo:on_init()
	sv_actor_basic.on_init(self);
	actor_veslo.on_init(self);
end

-- после атаки с прыжка нужно бежать дальше
function sv_actor_veslo:on_enter_attack_jump_land()
	sv_actor_basic.on_enter_attack_jump_land(self);
	self.m_performed_forward = 1;
end

---------------------------------------------------------------------------
-- клиентская
cl_actor_veslo = utils.inherit(cl_actor_basic, actor_veslo);

function cl_actor_veslo:on_init()
	cl_actor_basic.on_init(self);
	actor_veslo.on_init(self);
end