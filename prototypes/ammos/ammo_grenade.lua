------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Граната (патроны)
------------------------------------------------------------------------

-- общая часть
ammo_grenade = {};

ammo_grenade.guid = {0xce576c90, 0x2815, 0x43b4, 0xb7, 0x99, 0x25, 0x5f, 0xf1, 0x85, 0x70, 0x3e}

-------------------------------------------	
-- Свойства
-------------------------------------------	
ammo_grenade.properties_design = utils.merge_arrays(ammo_basic.properties_design, {
	{"model_name",		"itemPatroni"},
	{"ammo_name",		"grenade ammo"},
	{"ammo_capacity",	1},
	{"ammo_stored",		1},
	{"sound_on_take",	"Player_Take_MaximPatrony.wav"},
	{"pp_on_take",		"add_ammo"},
})

-------------------------------------------
ammo_grenade.m_holdable_icon_id	= 13	-- Иконка HUD


------------------------------------
-- серверная часть 
sv_ammo_grenade = utils.inherit(sv_ammo_basic, ammo_grenade)

------------------------------------
-- клиентская часть 
cl_ammo_grenade = utils.inherit(cl_ammo_basic, ammo_grenade)