------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Andrey Frolov
------------------------------------------------------------------------
-- object_quaker - создает эффект трясения земли с центром в своей позиции
------------------------------------------------------------------------

------------------------------------
-- общая часть
object_quaker = {
	guid = {0x43b42a6f, 0x8fb2, 0x4ea1, 0x8f, 0x4f, 0xc7, 0x3f, 0xe0, 0xf2, 0x75, 0x85},
}

------------------------------------
function object_quaker:register_properties(prop_registry)
	self.m_effector_table_prop	= self:register_property(prop_registry, "effector_table", "camera_quake");
	self.m_min_dist_prop		= self:register_property(prop_registry, "min_dist", 5);
	self.m_max_dist_prop		= self:register_property(prop_registry, "max_dist", 15);
	self:set_update_enable(false);
end

------------------------------------
-- серверная часть 
sv_object_quaker = utils.inherit(sv_game_object, object_quaker)
sv_object_quaker.MSG_ON_EXECUTE = 0;

------------------------------------
function sv_object_quaker:register_properties(prop_registry)
	sv_game_object.register_properties(self, prop_registry)
	object_quaker.register_properties(self, prop_registry);

	-- Регистрация слотов
	self.execute = self:register_input_slot("execute", self.execute)
end

------------------------------------
function sv_object_quaker:execute(sender, activator, input_data)
	self:send_net_message(self.MSG_ON_EXECUTE);
end

------------------------------------
-- клиентская часть 
cl_object_quaker = utils.inherit(cl_game_object, object_quaker)

------------------------------------
function cl_object_quaker:register_properties(prop_registry)
	cl_game_object.register_properties(self, prop_registry)
	object_quaker.register_properties(self, prop_registry)	
end

function cl_object_quaker:on_net_message(msg_id)
	if mgs_id == self.MSG_ON_EXECUTE then
		self:execute()
	end
end

------------------------------------
function cl_object_quaker:execute(sender, activator, input_data)
	local actor = engine.get_actor_player();
	if actor ~= nil then
		local amount = 1
		local dist = math.sqrt(utils.vec3_dist_sqrt(self:get_pos(), actor:get_pos()))
		local min_dist = self:get_property_value(self.m_min_dist_prop)*M2U_K
		local max_dist = self:get_property_value(self.m_max_dist_prop)*M2U_K
		
		if dist > max_dist then
			dist = max_dist
		end
		
		if dist >= min_dist then
			amount = 1 - (dist - min_dist)/(max_dist - min_dist)
		end
		
		actor:apply_effector(EFF_TARGET_CAMERA, self:get_property_value(self.m_effector_table_prop), amount);
		actor:apply_effector(EFF_TARGET_HOLDABLE, self:get_property_value(self.m_effector_table_prop), -0.8*amount);
	end
end
