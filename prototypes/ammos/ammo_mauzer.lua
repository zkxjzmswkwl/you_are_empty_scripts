------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Патроны для маузера
------------------------------------------------------------------------

-- общая часть
ammo_mauzer = {};

ammo_mauzer.guid = {0x39ac8338, 0x3f13, 0x4386, 0x81, 0x76, 0xe5, 0x74, 0xd2, 0x6a, 0x97, 0xf5}

-------------------------------------------	
-- Свойства
-------------------------------------------	
ammo_mauzer.properties_design = utils.merge_arrays(ammo_basic.properties_design, {
	{"model_name",		"itemPatroni"},
	{"ammo_name",		"mauzer ammo"},
	{"ammo_capacity",	9},
	{"ammo_stored",		9},
	{"sound_on_take",	"Player_Take_MauzerPatrony.wav"},
	{"pp_on_take",		"add_ammo"},
})

-------------------------------------------
ammo_mauzer.m_holdable_icon_id	= 1	-- Иконка HUD


------------------------------------
-- серверная часть 
sv_ammo_mauzer = utils.inherit(sv_ammo_basic, ammo_mauzer)

------------------------------------
-- клиентская часть 
cl_ammo_mauzer = utils.inherit(cl_ammo_basic, ammo_mauzer)