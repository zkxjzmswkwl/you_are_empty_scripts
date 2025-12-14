------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Патроны для "Максима"
------------------------------------------------------------------------

-- общая часть
ammo_maxim = {};

ammo_maxim.guid = {0x457724b3, 0x9d4a, 0x4f1d, 0x97, 0x3, 0x43, 0x80, 0x1b, 0xb7, 0x40, 0x8d}

-------------------------------------------	
-- Свойства
-------------------------------------------	
ammo_maxim.properties_design = utils.merge_arrays(ammo_basic.properties_design, {
	{"model_name",		"itemPatroni"},
	{"ammo_name",		"maxim ammo"},
	{"ammo_capacity",	100},
	{"ammo_stored",		100},
	{"sound_on_take",	"Player_Take_MaximPatrony.wav"},
	{"pp_on_take",		"add_ammo"},
})

-------------------------------------------
ammo_maxim.m_holdable_icon_id	= 2	-- Иконка HUD


------------------------------------
-- серверная часть 
sv_ammo_maxim = utils.inherit(sv_ammo_basic, ammo_maxim)

------------------------------------
-- клиентская часть 
cl_ammo_maxim = utils.inherit(cl_ammo_basic, ammo_maxim)