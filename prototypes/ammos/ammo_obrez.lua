------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Патроны для обреза
------------------------------------------------------------------------

-- общая часть
ammo_obrez = {};

ammo_obrez.guid = {0xfebb6af, 0x7550, 0x45af, 0xbd, 0x35, 0x5c, 0xc9, 0xcc, 0x13, 0x9b, 0x61}

-------------------------------------------	
-- Свойства
-------------------------------------------	
ammo_obrez.properties_design = utils.merge_arrays(ammo_basic.properties_design, {
	{"model_name",		"itemPatroni"},
	{"ammo_name",		"obrez ammo"},
	{"ammo_capacity",	12},
	{"ammo_stored",		12},
	{"sound_on_take",	"Player_Take_DrobovikPatrony.wav"},
	{"pp_on_take",		"add_ammo"},
})

-------------------------------------------
ammo_obrez.m_holdable_icon_id	= 0	-- Иконка HUD


------------------------------------
-- серверная часть 
sv_ammo_obrez = utils.inherit(sv_ammo_basic, ammo_obrez)

------------------------------------
-- клиентская часть 
cl_ammo_obrez = utils.inherit(cl_ammo_basic, ammo_obrez)