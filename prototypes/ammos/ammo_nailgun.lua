------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Патроны для nailgun
------------------------------------------------------------------------

-- общая часть
ammo_nailgun = {};

ammo_nailgun.guid = {0x2e47291f, 0xbc1a, 0x4af4, 0xa0, 0x6e, 0x9b, 0x6c, 0x4, 0xd5, 0x37, 0x8}

-------------------------------------------	
-- Свойства
-------------------------------------------	
ammo_nailgun.properties_design = utils.merge_arrays(ammo_basic.properties_design, {
	{"model_name",		"itemPatroni"},
	{"ammo_name",		"nailgun ammo"},
	{"ammo_capacity",	33},
	{"ammo_stored",		33},
	{"sound_on_take",	"Player_Take_MaximPatrony.wav"},
	{"pp_on_take",		"add_ammo"},
})

-------------------------------------------
ammo_nailgun.m_holdable_icon_id	= 11	-- Иконка HUD


------------------------------------
-- серверная часть 
sv_ammo_nailgun = utils.inherit(sv_ammo_basic, ammo_nailgun)

------------------------------------
-- клиентская часть 
cl_ammo_nailgun = utils.inherit(cl_ammo_basic, ammo_nailgun)