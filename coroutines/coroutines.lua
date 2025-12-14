------------------------------------------------------------------------
-- Copyright (C) 2003-2006 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Сопрограммы для игры YAE
------------------------------------------------------------------------

#include "coroutines_common.lua"
#include "coroutines_prototypes.lua"


coroutines.aitest1			= utils.inherit(coroutines.levels_common)
coroutines.vitia			= utils.inherit(coroutines.levels_common)

coroutines.med1				= utils.inherit(coroutines.levels_common)
coroutines.med2				= utils.inherit(coroutines.levels_common)

coroutines.kolhoz			= utils.inherit(coroutines.levels_common)
coroutines.kolhoz_part2		= utils.inherit(coroutines.levels_common)

coroutines.meat				= utils.inherit(coroutines.levels_common)
coroutines.meat_part2		= utils.inherit(coroutines.levels_common)

coroutines.wall				= utils.inherit(coroutines.levels_common)

coroutines.gor				= utils.inherit(coroutines.levels_common)
coroutines.gor_part_2		= utils.inherit(coroutines.levels_common)
coroutines.grsvt			= utils.inherit(coroutines.levels_common)
coroutines.gorKonec			= utils.inherit(coroutines.levels_common)

coroutines.poh				= utils.inherit(coroutines.levels_common)

coroutines.kinostreet		= utils.inherit(coroutines.levels_common)
coroutines.kinostreet2		= utils.inherit(coroutines.levels_common)

coroutines.metro			= utils.inherit(coroutines.levels_common)
coroutines.met6				= utils.inherit(coroutines.levels_common)

coroutines.theatre			= utils.inherit(coroutines.levels_common)

coroutines.krovli			= utils.inherit(coroutines.levels_common)

coroutines.parall			= utils.inherit(coroutines.levels_common)
coroutines.parall_part2		= utils.inherit(coroutines.levels_common)
coroutines.parall_part3		= utils.inherit(coroutines.levels_common)

coroutines.lastlevel		= utils.inherit(coroutines.levels_common)

coroutines.futur			= utils.inherit(coroutines.levels_common)

coroutines.lastzlo			= utils.inherit(coroutines.levels_common)

-------------------------------------------------------------------------------
-- включаемые файлы для уровней
-------------------------------------------------------------------------------
--#include "coroutines_aitest1.lua"

#include "coroutines_med1.lua"
#include "coroutines_med2.lua"
#include "coroutines_kolhoz.lua"
#include "coroutines_kolhoz_part2.lua"
#include "coroutines_meat.lua"
#include "coroutines_meat_part2.lua"
#include "coroutines_wall.lua"
#include "coroutines_gor.lua"
#include "coroutines_gor_part_2.lua"
#include "coroutines_grsvt.lua"	
#include "coroutines_gorKonec.lua"		
#include "coroutines_poh.lua"	
#include "coroutines_kinostreet.lua"
#include "coroutines_kinostreet2.lua"
#include "coroutines_metro.lua"
#include "coroutines_met6.lua"
#include "coroutines_theatre.lua"	
#include "coroutines_krovli.lua"
#include "coroutines_parall.lua"
#include "coroutines_parall_part2.lua"
#include "coroutines_parall_part3.lua"
#include "coroutines_lastlevel.lua"
#include "coroutines_futur.lua"
#include "coroutines_lastzlo.lua"

-- Игровые видеоролики
#include "coroutines_video.lua"