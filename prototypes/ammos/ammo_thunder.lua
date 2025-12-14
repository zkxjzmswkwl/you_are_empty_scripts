------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Патроны для плазмогана
------------------------------------------------------------------------

-- общая часть
ammo_thunder = {};

ammo_thunder.guid = {0x9a3ba1d4, 0xfec3, 0x424a, 0xb6, 0x86, 0x18, 0x62, 0xb6, 0x3, 0xd8, 0x7c}

-------------------------------------------	
-- Свойства
-------------------------------------------	
ammo_thunder.properties_design = utils.merge_arrays(ammo_basic.properties_design, {
	{"model_name",		"itemPatroni"},
	{"ammo_name",		"thunder ammo"},
	{"ammo_capacity",	50},
	{"ammo_stored",		50},
	{"sound_on_take",	"Player_Take_PlazmagunPatrony.wav"},
	{"pp_on_take",		"add_ammo"},
})

-------------------------------------------
ammo_thunder.m_holdable_icon_id	= 14	-- Иконка HUD


------------------------------------
-- серверная часть 
sv_ammo_thunder = utils.inherit(sv_ammo_basic, ammo_thunder)

------------------------------------
-- клиентская часть 
cl_ammo_thunder = utils.inherit(cl_ammo_basic, ammo_thunder)