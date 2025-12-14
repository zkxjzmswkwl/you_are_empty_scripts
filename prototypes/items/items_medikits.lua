------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Andrey Frolov
------------------------------------------------------------------------
-- Аптечки
------------------------------------------------------------------------

-- общая часть
item_medikit_small = {
	guid = {0x675a34df, 0x6193, 0x4d73, 0x97, 0x2c, 0xc8, 0x45, 0xfc, 0xa0, 0xe2, 0xf3},
};
item_medikit_medium = {
	guid = {0x1b7c8b6e, 0xd207, 0x4198, 0x95, 0x7d, 0xf5, 0x99, 0xe9, 0xe5, 0xa0, 0x71},
};
item_medikit_large = {
	guid = {0xaa3fd5d0, 0xbf46, 0x4ebd, 0xb2, 0xf5, 0xa0, 0xed, 0x27, 0x8e, 0xc0, 0xbe},
};

------------------------------------
sv_item_medikits = utils.inherit(sv_item_medikit);

------------------------------------
function sv_item_medikits:register_properties(prop_registry)
	sv_item_medikit.register_properties(self, prop_registry);
	self:set_property_value_by_name("model_name",		"ItemSpirt")
	self:set_property_value_by_name("material_default",	"mat_glass")
	self:set_property_value_by_name("pp_on_take",		"add_health")
	self:set_property_value_by_name("sound_on_take",	"Player_Take_Butilo4ka")
    self:set_property_value_by_name("debris_model",		"botl_debris")
    self:set_property_value_by_name("debris_scattering", 200000)
    self:set_property_value_by_name("mass",				1)
    self:set_property_value_by_name("damage_level",		0)
    self:set_property_value_by_name("damage_limit",		10)
    self:set_property_value_by_name("auto_fall_apart",	true)
end

------------------------------------
-- серверная часть 
sv_item_medikit_small	= utils.inherit(sv_item_medikits, item_medikit_small);
sv_item_medikit_medium	= utils.inherit(sv_item_medikits, item_medikit_medium);
sv_item_medikit_large	= utils.inherit(sv_item_medikits, item_medikit_large);

------------------------------------
function sv_item_medikit_small:register_properties(prop_registry)
	sv_item_medikits.register_properties(self, prop_registry);
	self:set_property_value_by_name("health_points", 15);
end
function sv_item_medikit_medium:register_properties(prop_registry)
	sv_item_medikits.register_properties(self, prop_registry);
	self:set_property_value_by_name("health_points", 25);
end
function sv_item_medikit_large:register_properties(prop_registry)
	sv_item_medikits.register_properties(self, prop_registry);
	self:set_property_value_by_name("health_points", 50);
end

------------------------------------
-- клиентская
cl_item_medikit_small	= utils.inherit(cl_item_medikit, item_medikit_small);
cl_item_medikit_medium	= utils.inherit(cl_item_medikit, item_medikit_medium);
cl_item_medikit_large	= utils.inherit(cl_item_medikit, item_medikit_large);
