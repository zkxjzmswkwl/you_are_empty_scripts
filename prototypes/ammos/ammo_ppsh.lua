------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Патроны для ППШ
------------------------------------------------------------------------

-- общая часть
ammo_ppsh = {};

ammo_ppsh.guid = {0x84742de9, 0x6d91, 0x45ea, 0x85, 0xf, 0xa5, 0xae, 0x25, 0xf2, 0x87, 0x2a}

-------------------------------------------	
-- Свойства
-------------------------------------------	
ammo_ppsh.properties_design = utils.merge_arrays(ammo_basic.properties_design, {
	{"model_name",		"itemPatroni"},
	{"ammo_name",		"ppsh ammo"},
	{"ammo_capacity",	70},
	{"ammo_stored",		70},
	{"sound_on_take",	"Player_Take_PpShaPatrony.wav"},
	{"pp_on_take",		"add_ammo"},
})

-------------------------------------------
ammo_ppsh.m_holdable_icon_id	= 2	-- Иконка HUD


------------------------------------
-- серверная часть 
sv_ammo_ppsh = utils.inherit(sv_ammo_basic, ammo_ppsh)

------------------------------------
-- клиентская часть 
cl_ammo_ppsh = utils.inherit(cl_ammo_basic, ammo_ppsh)