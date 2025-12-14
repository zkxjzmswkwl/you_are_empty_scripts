------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Инициализизация актера указанными параметрами.
------------------------------------------------------------------------

-- Параметры по-умолчанию (если не указана spawn_props у актера)
actor_spawn_props_default = 
{	
	
	med1 = 
	{	
		health		= 60,
		armor		= 0,

		-- Предметы, которые будут находиться в инвентаре у актера.
		--		name 	- имя предмета
		--		count 	- количество предметов
		inventory = 
		{
					
		},
	},

	kolhoz = 
	{	
		health		= 100,
		armor		= 0,

		-- Предметы, которые будут находиться в инвентаре у актера.
		--		name 	- имя предмета
		--		count 	- количество предметов
		inventory = 
		{
			{name = "weapon_spanner",		count = 1},

			{name = "weapon_mauzer",		count = 1},	
			{name = "ammo_mauzer",			count = 1},
			
			{name = "weapon_obrez",			count = 1},	
			{name = "ammo_obrez",			count = 5},
		},
	},

	meat = 
	{	
		health		= 100,
		armor		= 0,

		-- Предметы, которые будут находиться в инвентаре у актера.
		--		name 	- имя предмета
		--		count 	- количество предметов
		inventory = 
		{
			{name = "weapon_spanner",		count = 1},

			{name = "weapon_mauzer",		count = 1},	
			{name = "ammo_mauzer",			count = 5},
			
			{name = "weapon_obrez",			count = 1},	
			{name = "ammo_obrez",			count = 5},
		},
	},

	gor = 
	{	
		health		= 100,
		armor		= 0,

		-- Предметы, которые будут находиться в инвентаре у актера.
		--		name 	- имя предмета
		--		count 	- количество предметов
		inventory = 
		{
			{name = "weapon_spanner",		count = 1},

			{name = "weapon_mauzer",		count = 1},	
			{name = "ammo_mauzer",			count = 1},
		
			{name = "weapon_obrez",			count = 1},	
			{name = "ammo_obrez",			count = 1},
			
			{name = "weapon_machinegun",		count = 1},	
			{name = "ammo_ppsh",			count = 2},

		},
	},

	gorkonec = 
	{	
		health		= 60,
		armor		= 0,

		-- Предметы, которые будут находиться в инвентаре у актера.
		--		name 	- имя предмета
		--		count 	- количество предметов
		inventory = 
		{
			{name = "weapon_spanner",		count = 1},

			{name = "weapon_mauzer",		count = 1},	
			{name = "ammo_mauzer",			count = 1},
			
		},
	},


	poh = 
	{	
		health		= 100,
		armor		= 50,

		-- Предметы, которые будут находиться в инвентаре у актера.
		--		name 	- имя предмета
		--		count 	- количество предметов
		inventory = 
		{
			{name = "weapon_spanner",		count = 1},

			{name = "weapon_mauzer",		count = 1},	
			{name = "ammo_mauzer",			count = 1},
		
			{name = "weapon_obrez",			count = 1},	
			{name = "ammo_obrez",			count = 1},
			
			{name = "weapon_machinegun",		count = 1},	
			{name = "ammo_ppsh",			count = 2},

		},
	},

	wall = 
	{	
		health		= 70,
		armor		= 0,

		-- Предметы, которые будут находиться в инвентаре у актера.
		--		name 	- имя предмета
		--		count 	- количество предметов
		inventory = 
		{
			{name = "weapon_spanner",		count = 1},

			{name = "weapon_mauzer",		count = 1},	
			{name = "ammo_mauzer",			count = 1},
			
		},
	},

	meat = 
	{	
		health		= 70,
		armor		= 0,

		-- Предметы, которые будут находиться в инвентаре у актера.
		--		name 	- имя предмета
		--		count 	- количество предметов
		inventory = 
		{
			{name = "weapon_thunder",		count = 1},	
			{name = "weapon_thunder_fire",	count = 1},	

			{name = "weapon_spanner",		count = 1},

			{name = "weapon_mauzer",		count = 1},	
			{name = "ammo_mauzer",			count = 1},
			
			{name = "weapon_obrez",			count = 1},	
			{name = "ammo_obrez",			count = 1},

		},
	},

	kinostreet = 
	{	
		health		= 70,
		armor		= 0,

		-- Предметы, которые будут находиться в инвентаре у актера.
		--		name 	- имя предмета
		--		count 	- количество предметов
		inventory = 
		{
			{name = "weapon_spanner",		count = 1},

			{name = "weapon_mauzer",		count = 1},	
			{name = "ammo_mauzer",			count = 1},

			
		},
	},

	-- Таблица по умолчанию. Используется если не указана таблица для уровня 
	default = 
	{
		health		= 100,
		armor		= 100,

		-- Предметы, которые будут находиться в инвентаре у актера.
		--		name 	- имя предмета
		--		count 	- количество предметов
		inventory = 
		{
			{name = "weapon_spanner",		count = 1},

			{name = "weapon_mauzer",		count = 1},	
			{name = "ammo_mauzer",			count = 1},
		
			{name = "weapon_obrez",			count = 1},	
			{name = "ammo_obrez",			count = 1},
		
			{name = "weapon_rifle",			count = 1},	
			{name = "ammo_rifle",			count = 1},
			
			{name = "weapon_rifle_sniper",	count = 1},	
			{name = "ammo_rifle",			count = 1},

			{name = "weapon_machinegun",	count = 1},	
			{name = "ammo_ppsh",			count = 1},
		
			{name = "weapon_maxim",			count = 1},	
			{name = "ammo_maxim",			count = 1},
		
			{name = "weapon_nailgun",		count = 1},	
			{name = "ammo_nailgun",			count = 1},

			{name = "weapon_thunder",		count = 1},	
			{name = "ammo_thunder",			count = 1},

	--		{name = "weapon_thunder_fire",		count = 1},	
	--		{name = "ammo_thunder",			count = 1},
			
	--		{name = "weapon_grenade",		count = 1},	
	--		{name = "ammo_grenade",			count = 1},

			{name = "weapon_bottle",		count = 1},	
			{name = "ammo_bottle",			count = 1},
		},
	},
}


