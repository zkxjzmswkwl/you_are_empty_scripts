------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Andrey Frolov
------------------------------------------------------------------------
-- Броня
------------------------------------------------------------------------

-- общая часть
item_armor = {
	guid = {0x4774f4f9, 0x1ac9, 0x43ad, 0x8d, 0xd7, 0x2b, 0xee, 0xf3, 0xac, 0x7, 0xf3},
}

function item_armor:register_properties(prop_registry)
	game_object.register_properties(self, prop_registry);
	self:register_property(prop_registry, "armor_points", 0);
end

------------------------------------
-- серверная часть 
sv_item_armor = utils.inherit(sv_game_object, item_armor);

function sv_item_armor:on_init()
	sv_game_object.on_init(self);
	self.armor_prop = self:get_property_by_name("armor_points");
	self:set_property_value_by_name("is_can_take", false);
	self:set_property_value_by_name("pp_on_take", "add_armor");
	self:set_update_enable(false);
end

-- использование брони актером
function sv_item_armor:on_use(activator)
	if(activator.add_armor ~= nil) then
		if(activator:get_max_armor() > activator:get_armor()) then
			local armor_to_add = self:get_property_value(self.armor_prop);
			if(armor_to_add + activator:get_armor() > activator:get_max_armor()) then
				armor_to_add = activator:get_max_armor() - activator:get_armor();
			end
			activator:add_armor(armor_to_add);
			self:set_property_value_by_name("is_can_take", true);
		end
	end
end

function sv_item_armor:on_take(activator)
	-- если мы попали сюда, то броню использовали, так что удалимся
	engine.destroy_entity(self)
end

------------------------------------
-- клиентская
cl_item_armor = utils.inherit(cl_game_object, item_armor);

function cl_item_armor:on_init()
	cl_game_object.on_init(self);
	self:set_update_enable(false);
end

function cl_item_armor:on_post_anims_init()
	self:set_model_gross_cull(0, false);
end
