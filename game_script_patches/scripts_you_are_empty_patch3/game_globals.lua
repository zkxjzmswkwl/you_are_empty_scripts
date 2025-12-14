-------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
-- Author: Vyacheslav Korotayev
-------------------------------------------------------------------
-- Глобальные переменные и структуры для конкретной игры
-------------------------------------------------------------------

-- Первый уровень игры
g_first_level = "med1";

-- Типы наносимого damage'а
-- Существуют 4 основных типа DAMAGE_GUNSHOT, DAMAGE_FALL, DAMAGE_KNOCK, DAMAGE_BLAST
-- Добавляя новый damage нужно:
--		1) Присвоить ему уникальный, в пределах этой таблицы, id. Например: ACID = DAMAGE_BLAST + 1.
--		2) Прописать визуализацию повреждения в actor_player_design.lua (если необходимо).
--		3) Прописать множители для уровней сложности в таблице g_diff_levels (если необходимо).
--		4) Внести новый тип повреждения в таблицу g_damage_type_affect_armor (если необходимо).
g_damage_type = 
{
	GUNSHOT = DAMAGE_GUNSHOT,
	FALL	= DAMAGE_FALL,
	KNOCK	= DAMAGE_KNOCK,
	BLAST	= DAMAGE_BLAST,
	BURN	= DAMAGE_BLAST + 1,
	SHPR	= DAMAGE_BLAST + 2,
	TEST	= DAMAGE_BLAST + 3,
	BANG	= DAMAGE_BLAST + 4,
	ELECTRO = DAMAGE_BLAST + 5,	
}
	
-- Типы повреждений, при получении которых повреждается броня			
g_damage_type_affect_armor = 
{
	g_damage_type.GUNSHOT,
	g_damage_type.KNOCK,
	g_damage_type.BLAST,
}

-- Имена слотов для оружия.
g_weapon_slots = 
{ 
	"spanner",
	"mauzer", 
	"obrez",
	"rifle",
	"ppsh",
	"maxim",
	"nailgun",
	"thunder",
	"thunder_fire",
	"grenade",
	"rifle_sniper",	
}				
				 
-- Инициализирует уровни сложности игры
function init_diff_levels()

	-- Уровни сложности игры
	g_diff_levels = 
	{
		--[[***********************************************************]]--
		[0] = -- ID уровня сложности
		{
			-- Название уровня сложности
			name = "NORMAL",
			
			-- Множители для монстров на данном уровне сложности
			ai_controlled_actors = 
			{		
				-- Множители для различных типов damage'а
				damage_multipliers	= 
				{
					[g_damage_type.GUNSHOT]		= 1.2,
					[g_damage_type.KNOCK]		= 1.2,
					[g_damage_type.BLAST]		= 1.2,
					[g_damage_type.BURN]		= 1.2,
					[g_damage_type.BANG]		= 1.2,
					[g_damage_type.ELECTRO]		= 1.2,
					[g_damage_type.SHPR]		= 1.2,
				},
				
				-- Множитель дисперсии
				disp_multiplier			= 1.1,
			},
			
			-- Множители для игроков на данном уровне сложности
			human_controlled_actors = 
			{
				-- Множители для различных типов damage'а
				damage_multipliers	= 
				{
					[g_damage_type.GUNSHOT]		= .8,
					[g_damage_type.KNOCK]		= .8,
					[g_damage_type.BLAST]		= .8,
					[g_damage_type.BURN]		= .8,
					[g_damage_type.BANG]		= .8,
					[g_damage_type.ELECTRO]		= .8 * 4.5,
					[g_damage_type.SHPR]		= .8,
				},
				
				-- Множитель дисперсии
				disp_multiplier			= .9,
			},
		},
		
		--[[***********************************************************]]--
		[1] = -- ID уровня сложности
		{
			-- Название уровня сложности
			name = "EASY",
			
			-- Множители для монстров на данном уровне сложности
			ai_controlled_actors = 
			{		
				-- Множители для различных типов damage'а
				damage_multipliers	= 
				{
					[g_damage_type.GUNSHOT]		= 1,
					[g_damage_type.KNOCK]		= 1,
					[g_damage_type.BLAST]		= 1,
					[g_damage_type.BURN]		= 1,
					[g_damage_type.BANG]		= 1,
					[g_damage_type.ELECTRO]		= 1,
					[g_damage_type.SHPR]		= 1,
				},
				
				-- Множитель дисперсии
				disp_multiplier			= 1,
			},
			
			-- Множители для игроков на данном уровне сложности
			human_controlled_actors = 
			{
				-- Множители для различных типов damage'а
				damage_multipliers	= 
				{
					[g_damage_type.GUNSHOT]		= 1,
					[g_damage_type.KNOCK]		= 1,
					[g_damage_type.BLAST]		= 1,
					[g_damage_type.BURN]		= 1,
					[g_damage_type.BANG]		= 1,
					[g_damage_type.ELECTRO]		= 1 * 4.5,
					[g_damage_type.SHPR]		= 1,
				},
				
				-- Множитель дисперсии
				disp_multiplier			= 1,
			},
		},
	
		--[[***********************************************************]]--
		[2] = -- ID уровня сложности
		{
			-- Название уровня сложности
			name = "HARD",
			
			-- Множители для монстров на данном уровне сложности
			ai_controlled_actors = 
			{		
				-- Множители для различных типов damage'а
				damage_multipliers	= 
				{
					[g_damage_type.GUNSHOT]		= 1.5,
					[g_damage_type.KNOCK]		= 1.5,
					[g_damage_type.BLAST]		= 1.5,
					[g_damage_type.BURN]		= 1.5,
					[g_damage_type.BANG]		= 1.5,
					[g_damage_type.ELECTRO]		= 1.5,
					[g_damage_type.SHPR]		= 1.5,				
				},
				
				-- Множитель дисперсии
				disp_multiplier			= 0.9,
			},
			
			-- Множители для игроков на данном уровне сложности
			human_controlled_actors = 
			{
				-- Множители для различных типов damage'а
				damage_multipliers	= 
				{
					[g_damage_type.GUNSHOT]		= .5,
					[g_damage_type.KNOCK]		= .5,
					[g_damage_type.BLAST]		= .5,
					[g_damage_type.BURN]		= .5,
					[g_damage_type.BANG]		= .5,
					[g_damage_type.ELECTRO]		= .5 * 4.5,
					[g_damage_type.SHPR]		= .5,				
				},
				
				-- Множитель дисперсии
				disp_multiplier			= 1.1,
			},
		},
	}
	
end

-- Эффекты окужающей среды, погодные эффекты.
g_environment_effects = 
{
	["RAIN"]		= "pfx_rain.lua",
	--["SANDSTORM"]	= "pfx_smoke01_blue.lua",
}
						
-- Промежуточные неигровые ролики. Напр. логотипы при старте, вступительный игровой ролик.
--		Ключ - имя видео
--		Значение - таблица: 
--			{пресет_материала, имя_звукового_файла, громкость_звука}
g_intermediate_videos = 
{
	logo	= {"avi_logo", "logo", 0},
	intro	= {"avi_intro", "intro", 0},
	credits = {"avi_credits", "credits", 0},
}