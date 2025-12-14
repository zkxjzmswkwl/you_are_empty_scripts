------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Патроны для винтовки
------------------------------------------------------------------------

-- общая часть
ammo_rifle = {};

ammo_rifle.guid = {0x318efdcd, 0x8a5d, 0x4b0d, 0xa4, 0x74, 0xc, 0xea, 0x1f, 0xc1, 0x7d, 0x3e}

-------------------------------------------	
-- Свойства
-------------------------------------------	
ammo_rifle.properties_design = utils.merge_arrays(ammo_basic.properties_design, {
	{"model_name",		"itemAmmoMosin"},
	{"ammo_name",		"rifle ammo"},
	{"ammo_capacity",	5},
	{"ammo_stored",		5},
	{"sound_on_take",	"Player_Take_MauzerPatrony.wav"},
	{"pp_on_take",		"add_ammo"},
})

-------------------------------------------
ammo_rifle.m_holdable_icon_id	= 18	-- Иконка HUD


------------------------------------
-- серверная часть 
sv_ammo_rifle = utils.inherit(sv_ammo_basic, ammo_rifle)

------------------------------------
-- клиентская часть 
cl_ammo_rifle = utils.inherit(cl_ammo_basic, ammo_rifle)