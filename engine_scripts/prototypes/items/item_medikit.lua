------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Yuri Dobronravin
--				Andrey Frolov
------------------------------------------------------------------------
-- Аптечка
------------------------------------------------------------------------

-- общая часть
item_medikit = {
	guid = {0x19525fe7, 0x578c, 0x4adf, 0x80, 0xc6, 0xb1, 0x3c, 0x9b, 0x55, 0xff, 0xf5},
};
	
function item_medikit:register_properties(prop_registry)
	self:register_property(prop_registry, "health_points", 15);
	self:set_property_value_by_name("model_name", "ItemSpirt")
	self:set_property_value_by_name("pp_on_take", "add_health");
end

------------------------------------
-- серверная часть 
sv_item_medikit = utils.inherit(sv_game_object, item_medikit);

------------------------------------
function sv_item_medikit:on_init()
	sv_game_object.on_init(self);
	self.health_prop = self:get_property_by_name("health_points");
	self:set_property_value_by_name("is_can_take", false);
	self:set_update_enable(false);
end

-- использование аптечки актером
function sv_item_medikit:on_use(activator)
	if(activator.add_health ~= nil) then
		if(activator:get_max_health() > activator:get_health()) then
			local health_to_add = self:get_property_value(self.health_prop);
			if(health_to_add + activator:get_health() > activator:get_max_health()) then
				health_to_add = activator:get_max_health() - activator:get_health();
			end
			activator:add_health(health_to_add);
			self:set_property_value_by_name("is_can_take", true);
		end
	end
end

function sv_item_medikit:on_take(activator)
	-- если мы попали сюда, то аптечку использовали, так что удалимся
	engine.destroy_entity(self)
end

------------------------------------
-- клиентская
cl_item_medikit = utils.inherit(cl_game_object, item_medikit);

function cl_item_medikit:on_post_anims_init()
	self:set_model_gross_cull(0, false);
end