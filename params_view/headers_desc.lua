----------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
----------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
----------------------------------------------------------------------------
--	Заголовки для таблиц, отображающих параметры актеров и оружия.
----------------------------------------------------------------------------
--[[
		В таблицах *_headers описывается какие параметры следует отбражать(prop_name), а 
	также названия заголовков(header_name), соответствующих данным параметрам. Порядок
	перечисления параметров определяет порядок заголовков.
	
		По умолчанию заголовки берутся из таблицы common. Если нужно представить какой-либо
	специфический объект(напр. weapon_spanner) с набором параметров отличающийся от остальных
	объектов его группы, то нужно указать имя его класса вместо common и определить 
	необходимые заголовки. Первыми отображаются таблицы для специфических объектов.
		
		Таблица expand определяет какие пункты нужно раскрыть подробно. Ключем являются 
	имя класса, который нужно раскрыть. Значением являются, элементы которые будут раскрыты. 
--]]


----------------------------------------------------------------------------
-- Заголовки для параметров актера.
actor_headers = {

	common = {
		{prop_name = "mass",					header_name = "Mass"},
		{prop_name = "walk_forward_speed",		header_name = "Walk FWD"},
		{prop_name = "walk_backward_speed",		header_name = "Walk BWD"},
		{prop_name = "walk_strafe_speed",		header_name = "Strafe Walk"},
		{prop_name = "run_forward_speed",		header_name = "Run Fwd"},
		{prop_name = "run_backward_speed",		header_name = "Run Bwd"},
		{prop_name = "run_strafe_speed",		header_name = "Strafe Run"},
		{prop_name = "jump_height",				header_name = "Jump Height"},
		{prop_name = "view_fov",				header_name = "View FOV"},
		{prop_name = "view_dist",				header_name = "View Dist"},
		{prop_name = "vision_fade_in_time",		header_name = "Vsn Fade In"},
		{prop_name = "vision_fade_out_time",	header_name = "Vsn Fade Out"},
		{prop_name = "aggresive_stance_time",	header_name = "Agr Stance Time"},
	},

}

----------------------------------------------------------------------------
-- Заголовки для параметров атаки актера.
actor_attack_headers = {
	
	expand	= {
		common = {
			{key = {"params", "attack_info"}, is_array = true},
		},
	},
	
	common = {
		{prop_name = "id",					header_name = "ID"},
		{prop_name = "dist",				header_name = "Dist"},
		{prop_name = "desired_min_dist",	header_name = "Des Min Dist"},
		{prop_name = "desired_max_dist",	header_name = "Des Max Dist"},
		{prop_name = "max_angle",			header_name = "Max Ang"},
		{prop_name = "stop_during_attack",	header_name = "Stop Atck"},
		{prop_name = "damage_type",			header_name = "Dmg Type"},
		{prop_name = "damage",				header_name = "Dmg"},
		{prop_name = "impulse",				header_name = "Imp"},
	},

}

----------------------------------------------------------------------------
-- Заголовки для параметров оружия.
weapon_headers = {

	expand	= {
		weapon_obrez = {
			{key = {"single"}, is_array = false},
			{key = {"double"}, is_array = false},
		},
	},

	common = {
		{prop_name = "m_ammo_for_shot",		header_name = "Ammo For Shot"},
		{prop_name = "m_bullets_in_shot",	header_name = "Bullets In Shot"},
		{prop_name = "m_bullet_damage",		header_name = "Bullet Damage"},
		{prop_name = "m_bullet_impulse",	header_name = "Bullet Impulse"},
		{prop_name = "m_bullet_min_dist",	header_name = "Bullet Min Dist"},
		{prop_name = "m_bullet_max_dist",	header_name = "Bullet Max Dist"},
		{prop_name = "m_shot_disp",			header_name = "Dispersion"},
		{prop_name = "m_shot_recoil",		header_name = "Recoil"},
	},

	weapon_spanner = {
		{prop_name = "m_fire_damage",		header_name = "Fire Damage"},
		{prop_name = "m_fire_impulse",		header_name = "Fire Impulse"},
		{prop_name = "m_fire_dist",			header_name = "Fire Distance"},
		{prop_name = "m_fire_disp",			header_name = "Fire Disp"},
		{prop_name = "m_recoil_angle",		header_name = "Recoil Angle"},
	},
	
	weapon_grenade = {
		{prop_name = "m_ammo_for_shot",					header_name = "Ammo For Shot"},
		{prop_name = "m_min_velocity",					header_name = "Min velocity"},
		{prop_name = "m_max_velocity",					header_name = "Max velocity"},
		{prop_name = "m_time_to_gain_max_velocity",		header_name = "Time To Get Max Vel"},
	},
		
}

----------------------------------------------------------------------------
-- Заголовки для параметров метательного оружия.
ammo_missile_headers = {

	common = {
		{prop_name = "damage",							header_name = "Damage"},
		{prop_name = "damage_type",						header_name = "Damage type"},
		{prop_name = "mass",							header_name = "Mass"},
		{prop_name = "is_explosive",					header_name = "Is Expl"},
		{prop_name = "is_explode_on_static_impact",		header_name = "Is Expl On Static"},
		{prop_name = "is_explode_on_alive_impact",		header_name = "Is Expl On Alive"},
		{prop_name = "explode_radius",					header_name = "Expl Radius"},
		{prop_name = "explode_damage",					header_name = "Expl Damage"},
		{prop_name = "explode_impulse",					header_name = "Expl Impulse"},
		{prop_name = "explode_time",					header_name = "Expl Time"},
	},
	
}