------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Yuri Dobronravin
--			Andrey Frolov
------------------------------------------------------------------------
-- прототипы классов для You Are Empty
------------------------------------------------------------------------

--
include("ammo_missiles_YAE.lua")
include("ammo_obrez_drop.lua")

include("weapon_spanner.lua")
include("weapon_spanner.lua")
include("weapon_mauzer.lua")
include("weapon_obrez.lua")
include("weapon_rifle.lua")
include("weapon_rifle_sniper.lua")
include("weapon_machinegun.lua")
include("weapon_maxim.lua")
include("weapon_nailgun.lua")
include("weapon_thunder.lua")
include("weapon_thunder_fire.lua")
include("weapon_grenade.lua")
include("weapon_bottle.lua")

------------------------------
-- items
------------------------------

include("prototypes\\items\\item_health.lua");
include("prototypes\\items\\items_medikits.lua");

------------------------------
-- actors
------------------------------

-- fireman
include("prototypes\\actors\\design\\actor_fireman_design.lua");
include("prototypes\\actors\\actor_fireman.lua");
-- madman
include("prototypes\\actors\\design\\actor_madman_design.lua");
include("prototypes\\actors\\actor_madman.lua");
-- nurse
include("prototypes\\actors\\design\\actor_nurse_design.lua");
include("prototypes\\actors\\actor_nurse.lua");
-- zhlob
include("prototypes\\actors\\design\\actor_zhlob_design.lua");
include("prototypes\\actors\\actor_zhlob.lua");
-- stalevar
include("prototypes\\actors\\design\\actor_stalevar_design.lua");
include("prototypes\\actors\\actor_stalevar.lua");
-- hen
include("prototypes\\actors\\design\\actor_hen_design.lua");
include("prototypes\\actors\\actor_hen.lua");
-- dog
include("prototypes\\actors\\design\\actor_dog_design.lua");
include("prototypes\\actors\\actor_dog.lua");
-- budyonovets
include("prototypes\\actors\\design\\actor_budyonovets_design.lua");
include("prototypes\\actors\\actor_budyonovets.lua");
-- protivogaz
include("prototypes\\actors\\design\\actor_protivogaz_design.lua");
include("prototypes\\actors\\actor_protivogaz.lua");
-- ded
include("prototypes\\actors\\design\\actor_ded_design.lua");
include("prototypes\\actors\\actor_ded.lua");
-- worker
include("prototypes\\actors\\design\\actor_worker_design.lua");
include("prototypes\\actors\\actor_worker.lua");
-- kolhoz
include("prototypes\\actors\\design\\actor_kolhoz_design.lua");
include("prototypes\\actors\\actor_kolhoz.lua");
-- sportsman
include("prototypes\\actors\\design\\actor_sportsman_design.lua");
include("prototypes\\actors\\actor_sportsman.lua");
-- gomnoed
include("prototypes\\actors\\design\\actor_gomnoed_design.lua");
include("prototypes\\actors\\actor_gomnoed.lua");
-- butcher
include("prototypes\\actors\\design\\actor_butcher_design.lua");
include("prototypes\\actors\\actor_butcher.lua");
-- vodolaz
include("prototypes\\actors\\design\\actor_vodolaz_design.lua");
include("prototypes\\actors\\actor_vodolaz.lua");
-- electro
include("prototypes\\actors\\design\\actor_electro_design.lua");
include("prototypes\\actors\\actor_electro.lua");
-- karl
include("prototypes\\actors\\design\\actor_karl_design.lua");
include("prototypes\\actors\\actor_karl.lua");
-- bumper
include("prototypes\\actors\\design\\actor_bumper_design.lua");
include("prototypes\\actors\\actor_bumper.lua");
-- soldier
include("prototypes\\actors\\design\\actor_soldier_design.lua");
include("prototypes\\actors\\actor_soldier.lua");
-- prima
include("prototypes\\actors\\design\\actor_prima_design.lua");
include("prototypes\\actors\\actor_prima.lua");
-- pig parent
include("prototypes\\actors\\design\\actor_pig_parent_design.lua");
include("prototypes\\actors\\actor_pig_parent.lua");
-- pig
include("prototypes\\actors\\design\\actor_pig_design.lua");
include("prototypes\\actors\\actor_pig.lua");
-- sniper
include("prototypes\\actors\\design\\actor_sniper_design.lua");
include("prototypes\\actors\\actor_sniper.lua");
-- veslo
include("prototypes\\actors\\design\\actor_veslo_design.lua");
include("prototypes\\actors\\actor_veslo.lua");
-- flamethrower
include("prototypes\\actors\\design\\actor_flamethrower_design.lua");
include("prototypes\\actors\\actor_flamethrower.lua");
-- nail
include("prototypes\\actors\\design\\actor_nail_design.lua");
include("prototypes\\actors\\actor_nail.lua");
-- kulibin
include("prototypes\\actors\\design\\actor_kulibin_design.lua");
include("prototypes\\actors\\actor_kulibin.lua");
-- rat
include("prototypes\\actors\\design\\actor_rat_design.lua");
include("prototypes\\actors\\actor_rat.lua");
-- balerun
include("prototypes\\actors\\design\\actor_balerun_design.lua");
include("prototypes\\actors\\actor_balerun.lua");
-- moto
include("prototypes\\actors\\design\\actor_moto_design.lua");
include("prototypes\\actors\\actor_moto.lua");


-----------------------------------------------------------------------
prototypes = utils.merge_arrays(prototypes, 
{
  	------------------------------------------------------------------------------------------------------------------------------------------------
  	-- server_guid,						client_guid,					"lua_class_name",			"entity_desc",				"cpp class name",			"lua_table_server",				"lua_table_client",			is_editable}
  	------------------------------------------------------------------------------------------------------------------------------------------------

	-- weapons 
	{weapon_spanner.guid,				weapon_spanner.guid,			"weapon_spanner",			"weapon spanner",			"Weapon",					"sv_weapon_spanner",			"cl_weapon_spanner",		true},
	{weapon_mauzer.guid,				weapon_mauzer.guid,				"weapon_mauzer",			"weapon mauzer",			"Weapon",					"sv_weapon_mauzer",				"cl_weapon_mauzer",			true},
	{weapon_obrez.guid,					weapon_obrez.guid,				"weapon_obrez",				"weapon obrez",				"Weapon",					"sv_weapon_obrez",				"cl_weapon_obrez",			true},
	{weapon_rifle.guid,					weapon_rifle.guid,				"weapon_rifle",				"weapon rifle",				"Weapon",					"sv_weapon_rifle",				"cl_weapon_rifle",			true},
	{weapon_rifle_sniper.guid,			weapon_rifle_sniper.guid,		"weapon_rifle_sniper",		"weapon rifle_sniper",		"Weapon",					"sv_weapon_rifle_sniper",		"cl_weapon_rifle_sniper",	true},
	{weapon_machinegun.guid,			weapon_machinegun.guid,			"weapon_machinegun",		"weapon machinegun",		"Weapon",					"sv_weapon_machinegun",			"cl_weapon_machinegun",		true},
	{weapon_maxim.guid,					weapon_maxim.guid,				"weapon_maxim",				"weapon maxim",				"Weapon",					"sv_weapon_maxim",				"cl_weapon_maxim",			true},
	{weapon_nailgun.guid,				weapon_nailgun.guid,			"weapon_nailgun",			"weapon nailgun",			"Weapon",					"sv_weapon_nailgun",			"cl_weapon_nailgun",		true},
	{weapon_thunder.guid,				weapon_thunder.guid,			"weapon_thunder",			"weapon thunder",			"Weapon",					"sv_weapon_thunder",			"cl_weapon_thunder",		true},
	{weapon_thunder_fire.guid,			weapon_thunder_fire.guid,		"weapon_thunder_fire",		"weapon thunder_fire",		"Weapon",					"sv_weapon_thunder_fire",		"cl_weapon_thunder_fire",	true},
	{weapon_grenade.guid,				weapon_grenade.guid,			"weapon_grenade",			"weapon grenade",			"Weapon",					"sv_weapon_grenade",			"cl_weapon_grenade",		true},
	{weapon_bottle.guid,				weapon_bottle.guid,				"weapon_bottle",			"weapon bottle",			"Weapon",					"sv_weapon_bottle",				"cl_weapon_bottle",			true},
	
	-- ammo boxes
	{ammo_obrez.guid,					ammo_obrez.guid,				"ammo_obrez",				"ammo for obrez",			"AmmoStore",				"sv_ammo_obrez",				"cl_ammo_obrez",			true},
	{ammo_obrez_drop.guid,				ammo_obrez_drop.guid,			"ammo_obrez_drop",			"ammo for obrez_drop",		"AmmoStore",				"sv_ammo_obrez_drop",			"cl_ammo_obrez_drop",		true},
	{ammo_mauzer.guid,					ammo_mauzer.guid,				"ammo_mauzer",				"ammo for mauzer",			"AmmoStore",				"sv_ammo_mauzer",				"cl_ammo_mauzer",			true},
	{ammo_rifle.guid,					ammo_rifle.guid,				"ammo_rifle",				"ammo for rifle",			"AmmoStore",				"sv_ammo_rifle",				"cl_ammo_rifle",			true},
	{ammo_ppsh.guid,					ammo_ppsh.guid,					"ammo_ppsh",				"ammo for ppsh",			"AmmoStore",				"sv_ammo_ppsh",					"cl_ammo_ppsh",				true},
	{ammo_maxim.guid,					ammo_maxim.guid,				"ammo_maxim",				"ammo for maxim",			"AmmoStore",				"sv_ammo_maxim",				"cl_ammo_maxim",			true},
	{ammo_nailgun.guid,					ammo_nailgun.guid,				"ammo_nailgun",				"ammo for nailgun",			"AmmoStore",				"sv_ammo_nailgun",				"cl_ammo_nailgun",			true},
	{ammo_thunder.guid,					ammo_thunder.guid,				"ammo_thunder",				"ammo for thunder",			"AmmoStore",				"sv_ammo_thunder",				"cl_ammo_thunder",			true},
	{ammo_grenade.guid,					ammo_grenade.guid,				"ammo_grenade",				"ammo grenade",				"AmmoStore",				"sv_ammo_grenade",				"cl_ammo_grenade",			true},
	{ammo_bottle.guid,					ammo_bottle.guid,				"ammo_bottle",				"ammo bottle",				"AmmoStore",				"sv_ammo_bottle",				"cl_ammo_bottle",			true},

	-- ammo missiles
	{ammo_missile_squirt.guid,			ammo_missile_squirt.guid,		"ammo_missile_squirt",		"squirts for nurse",		"Missile",					"sv_ammo_missile_squirt",		"cl_ammo_missile_squirt",	false},
	{ammo_missile_fireball.guid,		ammo_missile_fireball.guid,		"ammo_missile_fireball",	"fireball for electro",		"Missile",					"sv_ammo_missile_fireball",		"cl_ammo_missile_fireball",	false},
	{ammo_missile_disk.guid,			ammo_missile_disk.guid,			"ammo_missile_disk",		"disks for sportsman",		"Missile",					"sv_ammo_missile_disk",			"cl_ammo_missile_disk",		false},
	{ammo_missile_grenade.guid,			ammo_missile_grenade.guid,		"ammo_missile_grenade",		"grenades",					"Missile",					"sv_ammo_missile_grenade",		"cl_ammo_missile_grenade",	false},
	{ammo_missile_bottle.guid,			ammo_missile_bottle.guid,		"ammo_missile_bottle",		"molotov coctail",			"Missile",					"sv_ammo_missile_bottle",		"cl_ammo_missile_bottle",	false},
	{ammo_missile_bottle_bot.guid,		ammo_missile_bottle_bot.guid,	"ammo_missile_bottle_bot",	"molotov coctail",			"Missile",					"sv_ammo_missile_bottle_bot",	"cl_ammo_missile_bottle_bot",	false},
	{ammo_missile_song.guid,			ammo_missile_song.guid,			"ammo_missile_song",		"song for prima",			"Missile",					"sv_ammo_missile_song",			"cl_ammo_missile_song",		false},
	{ammo_missile_spit.guid,			ammo_missile_spit.guid,			"ammo_missile_spit",		"spit of gomnoed",			"Missile",					"sv_ammo_missile_spit",			"cl_ammo_missile_spit",		false},

	-- items
	{item_medikit_small.guid,			item_medikit_small.guid,		"item_medikit_small",		"item_medikit_small",		"InventoryItem",			"sv_item_medikit_small",		"cl_item_medikit_small",	true},
	{item_medikit_medium.guid,			item_medikit_medium.guid,		"item_medikit_medium",		"item_medikit_medium",		"InventoryItem",			"sv_item_medikit_medium",		"cl_item_medikit_medium",	true},
	{item_medikit_large.guid,			item_medikit_large.guid,		"item_medikit_large",		"item_medikit_large",		"InventoryItem",			"sv_item_medikit_large",		"cl_item_medikit_large",	true},

	-- actors for AI
	{actor_fireman.guid,				actor_fireman.guid,	  			"actor_fireman",			"actor fireman",			"ActorBody",				"sv_actor_fireman",				"cl_actor_fireman",			true},
	{actor_madman.guid,					actor_madman.guid,	  			"actor_madman",				"actor madman",				"ActorBody",				"sv_actor_madman",				"cl_actor_madman",			true},
	{actor_nurse.guid,					actor_nurse.guid,	  			"actor_nurse",				"actor nurse",				"ActorBody",				"sv_actor_nurse",				"cl_actor_nurse",			true},
	{actor_zhlob.guid,					actor_zhlob.guid,	  			"actor_zhlob",				"actor zhlob",				"ActorBody",				"sv_actor_zhlob",				"cl_actor_zhlob",			true},
	{actor_stalevar.guid,				actor_stalevar.guid,	  		"actor_stalevar",			"actor stalevar",			"ActorBody",				"sv_actor_stalevar",			"cl_actor_stalevar",		true},
	{actor_hen.guid,					actor_hen.guid,	  				"actor_hen",				"actor hen",				"ActorBody",				"sv_actor_hen",					"cl_actor_hen",				true},
	{actor_dog.guid,					actor_dog.guid,	  				"actor_dog",				"actor dog",				"ActorBody",				"sv_actor_dog",					"cl_actor_dog",				true},
	{actor_budyonovets.guid,			actor_budyonovets.guid,			"actor_budyonovets",		"actor budyonovets",		"ActorBody",				"sv_actor_budyonovets",			"cl_actor_budyonovets",		true},
	{actor_protivogaz.guid,				actor_protivogaz.guid,	  		"actor_protivogaz",			"actor protivogaz",			"ActorBody",				"sv_actor_protivogaz",			"cl_actor_protivogaz",		true},
	{actor_ded.guid,					actor_ded.guid,	  				"actor_ded",				"actor ded",				"ActorBody",				"sv_actor_ded",					"cl_actor_ded",				true},
	{actor_worker.guid,					actor_worker.guid,	  			"actor_worker",				"actor worker",				"ActorBody",				"sv_actor_worker",				"cl_actor_worker",			true},
	{actor_kolhoz.guid,					actor_kolhoz.guid,	  			"actor_kolhoz",				"actor kolhoz",				"ActorBody",				"sv_actor_kolhoz",				"cl_actor_kolhoz",			true},
	{actor_sportsman.guid,				actor_sportsman.guid,	  		"actor_sportsman",			"actor sportsman",			"ActorBody",				"sv_actor_sportsman",			"cl_actor_sportsman",		true},
	{actor_gomnoed.guid,				actor_gomnoed.guid,	  			"actor_gomnoed",			"actor gomnoed",			"ActorBody",				"sv_actor_gomnoed",				"cl_actor_gomnoed",			true},
	{actor_butcher.guid,				actor_butcher.guid,	  			"actor_butcher",			"actor butcher",			"ActorBody",				"sv_actor_butcher",				"cl_actor_butcher",			true},
	{actor_vodolaz.guid,				actor_vodolaz.guid,	  			"actor_vodolaz",			"actor vodolaz",			"ActorBody",				"sv_actor_vodolaz",				"cl_actor_vodolaz",			true},
	{actor_electro.guid,				actor_electro.guid,	  			"actor_electro",			"actor electro",			"ActorBody",				"sv_actor_electro",				"cl_actor_electro",			true},
	{actor_karl.guid,					actor_karl.guid,	  			"actor_karl",				"actor karl",				"ActorBody",				"sv_actor_karl",				"cl_actor_karl",			true},
	{actor_bumper.guid,					actor_bumper.guid,	  			"actor_bumper",				"actor bumper",				"ActorBody",				"sv_actor_bumper",				"cl_actor_bumper",			true},
	{actor_soldier.guid,				actor_soldier.guid,	  			"actor_soldier",			"actor soldier",			"ActorBody",				"sv_actor_soldier",				"cl_actor_soldier",			true},
	{actor_prima.guid,					actor_prima.guid,	  			"actor_prima",				"actor prima",				"ActorBody",				"sv_actor_prima",				"cl_actor_prima",			true},
	{actor_pig_parent.guid,				actor_pig_parent.guid,			"actor_pig_parent",			"actor pig_parent",			"ActorBody",				"sv_actor_pig_parent",			"cl_actor_pig_parent",		true},
	{actor_pig.guid,					actor_pig.guid,	  				"actor_pig",				"actor pig",				"ActorBody",				"sv_actor_pig",					"cl_actor_pig",				true},
	{actor_sniper.guid,					actor_sniper.guid,	  			"actor_sniper",				"actor sniper",				"ActorBody",				"sv_actor_sniper",				"cl_actor_sniper",			true},
	{actor_veslo.guid,					actor_veslo.guid,	  			"actor_veslo",				"actor veslo",				"ActorBody",				"sv_actor_veslo",				"cl_actor_veslo",			true},
	{actor_flamethrower.guid,			actor_flamethrower.guid,	  	"actor_flamethrower",		"actor flamethrower",		"ActorBody",				"sv_actor_flamethrower",		"cl_actor_flamethrower",	true},
	{actor_nail.guid,					actor_nail.guid,	  			"actor_nail",				"actor nail",				"ActorBody",				"sv_actor_nail",				"cl_actor_nail",			true},
	{actor_kulibin.guid,				actor_kulibin.guid,	  			"actor_kulibin",			"actor kulibin",			"ActorBody",				"sv_actor_kulibin",				"cl_actor_kulibin",			true},
	{actor_rat.guid,					actor_rat.guid,		 			"actor_rat",				"actor rat",				"ActorBody",				"sv_actor_rat",					"cl_actor_rat",				true},
	{actor_balerun.guid,				actor_balerun.guid,		 		"actor_balerun",			"actor balerun",			"ActorBody",				"sv_actor_balerun",				"cl_actor_balerun",			true},
	{actor_moto.guid,					actor_moto.guid,		 		"actor_moto",				"actor moto",				"ActorBody",				"sv_actor_moto",				"cl_actor_moto",			true},
}); 