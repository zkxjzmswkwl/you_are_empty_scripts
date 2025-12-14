materials = {}
materials_interactions_infos = {}

-----------------------------------------------
-- список материалов
-----------------------------------------------

-- различные материалы
materials.mat_main = {
	density			= 1.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_main",
}

materials.no_material = {
	density			= 1.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_beton",
}

materials.mat_beton = {
	density			= 1.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_beton",
}

materials.mat_flares = {
	density			= 1.0,
	transparency	= 0,
	piercency		= 0,
	collide			= false,

	inter_info		= "inter_flares",
}


materials.mat_stone = {
	density			= 2.0,
	collide			= true,

	inter_info		= "inter_stone",
}

materials.mat_tile = {
	density			= 2.0,
	collide			= true,

	inter_info		= "inter_tile",
}

materials.mat_stucco = {
	density			= 2.0,
	collide			= true,

	inter_info		= "inter_stucco",
}

materials.mat_ground = {
	density			= 2.0,
	collide			= true,

	inter_info		= "inter_ground",
}

materials.mat_sand = {
	density			= 2.0,
	collide			= true,

	inter_info		= "inter_sand",
}

materials.mat_zerno = {
	density			= 2.0,
	collide			= true,

	inter_info		= "inter_zerno",
}

materials.mat_wood = {
	density			= 2.0,
	transparency		= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_wood",
}

materials.mat_wood_box_big = {
	density			= 2.0,
	transparency		= 1,
	piercency		= 0.3,
	collide			= true,

	inter_info		= "inter_wood",
}

materials.mat_wood_box_small = {
	density			= 0.7,
	transparency	= 1,
	piercency		= 0.3,
	collide			= true,

	inter_info		= "inter_wood",
}

materials.mat_piano = {
	density			= 0.9,
	transparency	= 0,
	piercency		= 0.1,
	collide			= true,

	inter_info		= "inter_wood",
}

materials.mat_graviy = {
	density			= 1.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_graviy",
}

materials.mat_luja = {
	density			= 1.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_luja",
}

materials.mat_trava = {
	density			= 1.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_trava",
}

materials.mat_metal = {
	density			= 2.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_metal",
}

materials.mat_metal_thin = {
	density			= 2.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_metal_thin",
}

materials.mat_metal_barrel = {
	density		= 1.0,
	piercency	= 0.1,
	collide		= true,

	inter_info	= "inter_metal_barrel",
}

materials.mat_metal_serp = {
	density		= 1.0,
	piercency	= 0.1,
	collide		= true,

	inter_info	= "inter_metal_serp",
}

materials.mat_rubber = {
	density			= 2.0,
	transparency	= 0,
	piercency		= 0.1,
	collide			= true,

	inter_info		= "inter_rubber",
}

materials.mat_glass = {
	density		= 1.0,
	piercency	= 0.5,
	collide		= true,
	transparency	= 1,

	inter_info	= "inter_glass",
}

materials.mat_water = {
	density		= 1.0,
	piercency	= 1.0,
	collide		= false,
	transparency	= 1,

	inter_info	= "inter_water",
}

materials.mat_carpet = {
	density		= 1.0,
	piercency	= 1.0,
	collide		= false,
	transparency	= 1,

	inter_info	= "inter_carpet",
}

materials.mat_barrier = {
	density		= 0.0,
	piercency	= 1.0,
	collide		= true,
	transparency	= 1,

	inter_info	= "inter_barrier",
}

materials.mat_metal_ladder = {
	density			= 2.0,
	collide			= true,

	inter_info		= "inter_metal_ladder",
}

-- материал актера-человека (материал его carrier-а)
materials.mat_actor_carrier = {
	density		= 1.0,
	collide		= true,

	inter_info	= "inter_actor_human",
}

-- материал шагов актера-человека
materials.mat_actor_human_steps = {
	inter_info	= "steps_beton",
}

-- материал шагов актера-человека
materials.mat_actor_human_climb = {
	inter_info	= "climb_metal_ladder",
}

-- материал jump актера-человека
materials.mat_actor_human_jump = {
	inter_info	= "jump_main",
}

-- материал шагов актера-человека
materials.mat_actor_human_land = {
	inter_info	= "land_beton",
}

-- материал тела (хитбоксов и полигонов модели)
materials.mat_actor_body = {
	density		= 1.0,
	collide		= true,
	piercency	= 0.7,
}

materials.mat_trigger_alive = {
	density			= 1.0,
	piercency		= 1,
	collide			= true,
	transparency	= 1,
}

-- тестовый материал	
materials.mat_test_example = {
	
	-- плотность материала (меньше 1 - плавает, больше 1 - тонет, 1 - вода)
	density			= 1.0,
	
	-- прозрачность (0 - непрозрачно, 1 - полностью прозрачно)
	transparency	= 0,
	
	-- пробиваемость (0 - непробиваемо, 1 - полностью пробиваемо)
	piercency		= 0,
	
	-- наличие collision для материала
	collide			= true,

	inter_info		= "inter_test_example",
}

--------------------------------------------
-- Custom materials
--------------------------------------------

materials.mat_metal_slider = {
	density			= 2.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_metal_slider",
}

materials.mat_fence = {
	density			= 2.0,
	transparency	= 1,
	piercency		= 0.9,
	collide			= true,

	inter_info		= "inter_fence",
}

materials.mat_chaynik = {
	density			= 0.7,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_chaynik",
}

materials.mat_keramics = {
	density			= 2.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_keramics",
}

materials.mat_grenade = {
	density			= 2.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_grenade",
}

materials.mat_firestuff = {
	density			= 0.7,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_firestuff",
}

materials.mat_urna = {
	density			= 2.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_urna",
}

materials.mat_metal_luk = {
	density			= 2.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_metal_luk",
}

materials.mat_metal_bidon = {
	density			= 0.7,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_metal_bidon",
}

materials.mat_katalka = {
	density			= 2.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_katalka",
}

materials.mat_kolyaska = {
	density			= 2.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_kolyaska",
}

materials.mat_vehicle = {
	density			= 2.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_vehicle",
}

materials.mat_phone = {
	density			= 2.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_phone",
}

materials.mat_canister = {
	density			= 0.7,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_canister",
}

materials.mat_taburet = {
	density			= 0.7,
	transparency	= 1,
	piercency		= 0.3,
	collide			= true,

	inter_info		= "inter_taburet",
}

materials.mat_kreslo = {
	density			= 0.7,
	transparency	= 1,
	piercency		= 0.3,
	collide			= true,

	inter_info		= "inter_kreslo",
}

materials.mat_wood_barrel = {
	density			= 0.7,
	transparency	= 1,
	piercency		= 0.3,
	collide			= true,

	inter_info		= "inter_wood_barrel",
}

materials.mat_metal_bucket = {
	density		= 1.0,
	piercency	= 0.5,
	collide		= true,
	transparency	= 0,

	inter_info	= "inter_metal_bucket",
}

materials.mat_vedro = {
	density			= 2.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_metal_bucket",
}

materials.mat_palma = {
	density			= 0.3,
	transparency	= 1,
	piercency		= 0.9,
	collide			= true,

	inter_info		= "inter_palma",
}

materials.mat_protivogaz_legs = {
	density		= 1.0,
	collide		= true,
	piercency	= 0.7,
	
	inter_info	= "inter_protivogaz_legs_beton",
}

materials.mat_rat_body = {
			-- материал тела (хитбоксов и полигонов модели)
	density		= 1.0,
	collide		= true,
	piercency		= 0.7,

	inter_info	= "inter_rat_body",
}

materials.mat_paper = {
	density			= 1.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_paper",
}

materials.mat_konveer = {
	density			= 2.0,
	transparency	= 0,
	piercency		= 0,
	collide			= true,

	inter_info		= "inter_konveer",
}
------------------------------------------------------------------------------------
-- includes
------------------------------------------------------------------------------------
include("materials_weapons.lua")
include("materials_pairs.lua")
include("materials_interactions_collisions.lua")
include("materials_interactions_carrier.lua")
include("materials_interactions_weapons.lua")
include("materials_interactions_default.lua")
include("materials_interactions_steps.lua")
