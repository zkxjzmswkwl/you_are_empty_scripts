------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Yuri Dobronravin
--				Andrey Frolov
------------------------------------------------------------------------
-- Папка prototypes содержит
-- описания прототипов таблиц, которые будут использованы
-- для создание таблиц для игровых объектов в реальном
-- времени фабрикой объектов
------------------------------------------------------------------------

include("prototypes\\game_object.lua")

-- triggers
include("prototypes\\triggers\\trigger_ai_ctrl.lua")
include("prototypes\\triggers\\trigger_damage.lua")
include("prototypes\\triggers\\trigger_teleport.lua")
include("prototypes\\triggers\\trigger_teleport_target.lua")
include("prototypes\\triggers\\trigger_check_inventory.lua")
include("prototypes\\triggers\\trigger_visible.lua")

include("prototypes\\buttons\\button.lua")
include("prototypes\\buttons\\button_no_model.lua")

include("prototypes\\items\\item_medikit.lua")

--include("prototypes\\doors\\door_sound.lua")

include("prototypes\\items\\item_medikit.lua")
include("prototypes\\items\\item_armor.lua")

include("prototypes\\doors\\door.lua")
include("prototypes\\lifts\\lift.lua")

-- objects
include("prototypes\\objects\\object_counter.lua")
include("prototypes\\objects\\object_case.lua")
include("prototypes\\objects\\object_flare.lua")
include("prototypes\\objects\\object_circuit.lua")
include("prototypes\\objects\\object_spawner.lua")
include("prototypes\\objects\\object_quaker.lua")

-- timers
include("prototypes\\timers\\timer.lua")

-- weapons
include("prototypes\\weapons\\weapon_basic.lua")
include("prototypes\\weapons\\weapon_firearm.lua")
include("prototypes\\weapons\\weapon_automatic.lua")
include("prototypes\\weapons\\weapon_missile.lua")

include("prototypes\\weapons\\ammo_basic.lua")
include("prototypes\\weapons\\ammo_missiles.lua")			

------------------------------
-- actors
------------------------------
include("prototypes\\actors\\actor_basic.lua");
include("prototypes\\actors\\actor_basic_bhv.lua");
include("prototypes\\actors\\actor_basic_states.lua");
include("prototypes\\actors\\actor_basic_actions.lua");

include("prototypes\\actors\\actor_player.lua");
include("prototypes\\actors\\actor_player\\actor_player_hud_ini.lua");

------------------------------
-- AI
------------------------------
include("prototypes\\actors\\ai_controller_basic.lua");
include("prototypes\\actors\\ai_controller_evaluators.lua");
include("prototypes\\actors\\ai_controller_goals.lua");
include("prototypes\\actors\\ai_controller_attack.lua");
include("prototypes\\actors\\ai_controller_anchors.lua");
include("prototypes\\actors\\ai_anchor.lua");

------------------------------
-- Areas
------------------------------
include("prototypes\\areas\\occlusion_area.lua");

prototypes = 
{
  	------------------------------------------------------------------------------------------------------------------------------------------------
  	-- server_guid,						client_guid,					"lua_class_name",			"entity_desc",				"cpp class name",			"lua_table_server",				"lua_table_client",				is_editable}
  	------------------------------------------------------------------------------------------------------------------------------------------------
	{button.guid,						button.guid,					"button",					"button 'rubilnik'",		"UsableObject",				"sv_button",					"cl_button",					true},
	{button_no_model.guid,				button_no_model.guid,			"button_no_model",			"button without model",		"Barrier",					"sv_button_no_model",			"cl_button_no_model",			true},
	{door.guid,							door.guid,						"door_sound",				"door",						"DoorBase",					"sv_door",						"cl_door",						true},
	{door.guid,							door.guid,						"door",						"door",						"DoorBase",					"sv_door",						"cl_door",						true},
	{lift.guid,							lift.guid,						"lift",						"lift",						"LiftBase",					"sv_lift",						"cl_lift",						true},

	-- items
	{item_medikit.guid,					item_medikit.guid,				"item_medikit",				"item_medikit",				"InventoryItem",			"sv_item_medikit",				"cl_item_medikit",				true},
	{item_armor.guid,					item_armor.guid,				"item_armor",				"item_armor",				"InventoryItem",			"sv_item_armor",				"cl_item_armor",				true},
	
	-- triggers
	{trigger_ai_ctrl.guid,				trigger_ai_ctrl.guid,			"trigger_ai_ctrl",			"trigger_ai_ctrl",			"Trigger",					"sv_trigger_ai_ctrl",			"cl_trigger_ai_ctrl",			true},
	{trigger_damage.guid,				trigger_damage.guid,			"trigger_damage",			"trigger damage",			"Trigger",					"sv_trigger_damage",			"cl_trigger_damage",			true},
	{trigger_check_inventory.guid,		trigger_check_inventory.guid,	"trigger_check_inventory",	"trigger check inventory",	"Trigger",					"sv_trigger_check_inventory",	"cl_trigger_check_inventory",	true},
	{trigger_visible.guid,				trigger_visible.guid,			"trigger_visible",			"trigger visible",			"StaticVisualObject",		"sv_trigger_visible",			"cl_trigger_visible",			true},

	-- teleport
	{trigger_teleport.guid,				trigger_teleport.guid,			"trigger_teleport",			"trigger teleport",			"Trigger",					"sv_trigger_teleport",			"cl_trigger_teleport",			true},
	{trigger_teleport_target.guid,		trigger_teleport_target.guid,	"trigger_teleport_target",	"trigger teleport target",	"TagPoint",					"sv_trigger_teleport_target",	"cl_trigger_teleport_target",	true},

	-- objects
	{object_counter.guid,				object_counter.guid,			"object_counter",			"object_counter",			"GameObject",				"sv_object_counter",			"cl_object_counter",			true},
	{object_case.guid,					object_case.guid,				"object_case",				"object_case",				"GameObject",				"sv_object_case",				"cl_object_case",				true},
	{object_flare.guid,					object_flare.guid,				"object_flare",				"object_flare",				"VisualGameObject",			"sv_object_flare",				"cl_object_flare",				true},
	{object_circuit.guid,				object_circuit.guid,			"object_circuit",			"object_circuit",			"GameObject",				"sv_object_circuit",			"cl_object_circuit",			true},
	{object_spawner.guid,				object_spawner.guid,			"object_spawner",			"object_spawner",			"WorldGameObject",			"sv_object_spawner",			"cl_object_spawner",			true},
	{object_quaker.guid,				object_quaker.guid,				"object_quaker",			"object_quaker",			"WorldGameObject",			"sv_object_quaker",				"cl_object_quaker",				true},
	
	-- timer
	{timer.guid,						timer.guid,						"timer",					"timer",					"GameObject",				"sv_timer",						"cl_timer",						true},

	-- actor for player
	{actor_player.guid,					actor_player.guid,	  			"actor_player",				"actor player",				"ActorBody",				"sv_actor_player",				"cl_actor_player",				false},
	
	-- AI
	{ai_controller_basic.guid,			ai_controller_basic.guid,	  	"ai_controller_basic",		"ai_controller_basic",		"AI_Controller",			"sv_ai_controller_basic",		"cl_ai_controller_basic",		false},
	{ai_anchor.guid,					ai_anchor.guid,	  				"ai_anchor",				"ai anchor",				"Anchor",					"sv_ai_anchor",					"cl_ai_anchor",					true},
	
	-- Areas
	{occlusion_area.guid,				occlusion_area.guid,			"occlusion_area",			"occlusion_area",			"VisualGameObject",			"sv_occlusion_area",			"cl_occlusion_area",			true},
}; 