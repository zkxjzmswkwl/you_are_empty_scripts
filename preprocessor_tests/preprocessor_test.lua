------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Тест препроцессора
------------------------------------------------------------------------

--console.print("===== PREPROCESSOR TEST (begin)=====")

-- Тест #define
#define  SOME_DEFINE 345
assert(SOME_DEFINE == 345)

#define INCL
#ifdef INCL
	#include "preprocessor_test_include.lua"
	#include "preprocessor_test_include.lua" -- Не будет включен повторно
#else
	#include "preprocessor_test_include2.lua"
#endif

-- Тест #pragma once
-- В preprocessor_test_include2.lua разопределяется ONCE. Повторное включение этого
-- файла вызывает ошибку. Благодаря директиве #pragma once данный файл включается только один раз.
#define ONCE
#include "preprocessor_test_include2.lua"
#include "preprocessor_test_include2.lua" 

-- Тест #pragma error. Если раскомментировать строку ниже, то получим ошибку :)
--#pragma error 'not good'

-- Тест #undef
#undef AVG		-- Определен в "preprocessor_test_include.lua", поэтому ошибка не должна возникать
assert(AVG == nil)

-- Тест define с параметрами
#define	AVG(a, b) (b + a)/2
assert(AVG(1.5, 2.5) == 2)

#define  WIDTH AVG(1,3)*9999
assert(WIDTH == 19998)
#define  WIDTH
#define  WIDTH AVG(2,4)*2 
assert(WIDTH == 6)


#define  LEN WIDTH + AVG(7,9)
assert(LEN == 14)

-- Тест часть идентификатора
#define  MACRO  	0
#define  MACRO1 	MACRO+1
#define  AMACRO 	MACRO+2
#define  AVGMACROWIDTH 888
assert("0128880" == tostring(MACRO)..tostring(MACRO1)..tostring(AMACRO)..tostring(AVGMACROWIDTH)..tostring(MACRO))

-- Тест логических скобок
local pptest_sum = 0
#define aaa
#define zzz
#define mmm
#ifdef aaa
	pptest_sum = pptest_sum + 1
	#ifdef zzz
		pptest_sum = pptest_sum + 2
		#ifdef nnn
			pptest_sum = pptest_sum + 4
		#elif mmm
			pptest_sum = pptest_sum + 16
		#else
			pptest_sum = pptest_sum + 32
		#endif
	#else
		pptest_sum = pptest_sum + 64
	#endif
	pptest_sum = pptest_sum + 128
	pptest_sum = pptest_sum + 256
	#ifndef nnn
		pptest_sum = pptest_sum + 512
	#endif
#else
	pptest_sum = pptest_sum + 1024
#endif
assert(pptest_sum == 915)

#if 2+2 ~= 4
	assert(nil)
#endif

#define TWO 2
#if (TWO+TWO ~= 4) && !(TWO*TWO == 4)
	assert(nil)
#endif

#if ( defined(mmm) || !defined(QWERTY) ) && TWO > 0
	pptest_sum = 999
#else
	pptest_sum = nil
#endif
assert(pptest_sum == 999)

#if defined(QWERTY) && QWERTY >= 555
	assert(nil)
#endif

pptest_sum = nil


-- Тест в составе строки
#undef MACRO
#define MACRO 999
assert("1998la al MACRO lalal asg MACRO " == tostring(MACRO * 2)..'la al MACRO lalal '.."asg MACRO ")

-- Тест однострочный комментарий
#define RRR 888--88888888
assert(RRR == 888)
local comment = "qwerty ------ qwerty" -- Однострочный комментарий в составе строки
comment = nil

-- Тест многострочных макросов
-----------------------------
#define_begin CHUNK_OF_CODE
	assert(2 + 2 == 4)
	assert(math.sqrt(4) == 2)
#define_end

CHUNK_OF_CODE

-----------------------------
#define_begin SWAP(a, b) 
	local tmp = a
	a = b
	b = tmp
#define_end

local var1 = 3
local var2 = 5
SWAP(var1, var2)
assert(var1 == 5 and var2 == 3)
tmp = nil
var1 = nil
var2 = nil

-- Тест символ '.'
#define_begin COROUTINE_ANIMATION_SCENE(MAP, NUMBER1, NUMBER2)
	coroutines.MAP = {}
	local pptest_sum = NUMBER1 + NUMBER2
#define_end

COROUTINE_ANIMATION_SCENE(map1,  1.5, .5)
assert(type(coroutines.map1) == "table")
assert(pptest_sum == 2);
pptest_sum = nil

--console.print("===== PREPROCESSOR TEST (end)=====")