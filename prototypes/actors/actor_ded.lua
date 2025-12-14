------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Actor Ded - дед с дробовиком
------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- общая часть
actor_ded.guid = {0xd5ca5eb, 0x96d5, 0x4476, 0xb5, 0xb1, 0x7c, 0x4c, 0x1, 0x67, 0xaa, 0x5f};

------------------------------------
function actor_ded:on_init()
end

------------------------------------
function actor_ded:register_properties(prop_registry) 
	self.m_reload_on_knee = self:register_property(prop_registry, "reload_on_knee", false);
end

------------------------------------
-- серверная часть 
sv_actor_ded = utils.inherit(sv_actor_basic, actor_ded);

------------------------------------
function sv_actor_ded:register_properties(prop_registry)
	sv_actor_basic.register_properties(self, prop_registry);
	actor_ded.register_properties(self, prop_registry);
end

------------------------------------
function sv_actor_ded:on_init()

	sv_actor_basic.on_init(self);
	actor_ded.on_init(self);

end

------------------------------------
function sv_actor_ded:on_enter_reload()
	self.m_reload_ended = false;	
	
	if self:get_property_value(self.m_reload_on_knee) then
		self.io.m_block_movement = true;
		self:stop_movement();
		self:reset_legs_state();
	
		self:visualize_state(self.body_fsm, self.state_visual_info, "reload_on_knee");
	else
		self:visualize_state_torso(self.state_visual_info, "reload");
	end
end

---------------------------------------------------------------------------
-- клиентская
cl_actor_ded = utils.inherit(cl_actor_basic, actor_ded);

------------------------------------
function cl_actor_ded:on_init()
	cl_actor_basic.on_init(self);
	actor_ded.on_init(self);
end

------------------------------------
function cl_actor_ded:register_properties(prop_registry)
	cl_actor_basic.register_properties(self, prop_registry)
	actor_ded.register_properties(self, prop_registry)	
end