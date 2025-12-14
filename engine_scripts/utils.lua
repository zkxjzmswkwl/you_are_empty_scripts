-------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
-- Author: Yuri Dobronravin
-------------------------------------------------------------------
-- Набор функций утилит для Lua
-------------------------------------------------------------------

-- вспомогательный объект
o = {};

-- namespace utils
utils = {};
-------------------------------------------------------
-- debug
-------------------------------------------------------
original_assert = assert;

function assert(cond, msg)
	if(cond == nil or cond == false) then console.print(utils.traceback()); end
	if(msg == nil) then msg = "" end
	msg = msg.." see log file for additional info";
		
	original_assert(cond, msg);
end

function utils.traceback()
	console.print("====================================================");
	console.print("   LUA  Call Stack:");
	console.print("====================================================");
	console.print("  Line  Source File");
	console.print("====================================================");
	local result = "";
	local level = 1
	while true do
		local info = debug.getinfo(level, "Sl")
        if not info then break end
		local local_result = "";
		if info.what == "C" then   -- is a C function?
			local_result = string.format("%5d  C function", level);
        else   -- a Lua function
			local_result = string.format("%5d  %s", info.currentline, info.source);
		end
		result = result..local_result;
		console.print(" "..local_result);
		level = level + 1
	end
	console.print("====================================================");
	return result;
end

-------------------------------------------------------
-- механизм наследования
-------------------------------------------------------
-- возможно осуществление множественного наследования
-- параметры - родители, наследуют всю функциональность 
-- (данные + функции) при помощи слияния таблиц
-------------------------------------------------------
function utils.inherit(...)

	local result_table = {};
	
	for i=1,arg.n do 
		local parent = arg[i];

		assert(parent ~= nil, "utils.inherit: nil parent");
		utils.merge_with_functions(result_table, parent, true);
	end

	return result_table;	
end


-------------------------------------------------------
-- merge arrays
-------------------------------------------------------
function utils.merge_arrays(...)
	
	local result_array = {};
	
	for i=1,arg.n do 
		local parent = arg[i];
		utils.insert_array(result_array, parent);
	end

	return result_array;	
end

function utils.insert_array(dest, source)
	assert(source);
	for i,v in ipairs(source) do 
		table.insert(dest, v);
	end
end

-------------------------------------------------------
-- clone a table
-------------------------------------------------------
function utils.clone(table_to_clone)
	if(type(table_to_clone)=="table") then
		local new_table={};
		for i,field in table_to_clone do
			if(type(field)=="table") then
				new_table[i]=utils.clone(field);
			else
				new_table[i]=field;
			end
		end
		return new_table;
	else
		return table_to_clone;
	end
end

-------------------------------------------------------
-- клонировать объект и удалить оригинал
-------------------------------------------------------
function utils.assign(obj)
	local new_obj = utils.inherit(obj);
	obj = {};
	return new_obj;
end

-------------------------------------------------------
--copy table source into the table dest skipping functions
-------------------------------------------------------
function utils.merge(dest,source,recursive)
	for i,v in source do
		if(type(v)~="function") then
			if(recursive) then
				if(type(v)=="table")then
					dest[i] = dest[i] or {};
					utils.merge(dest[i],v,recursive);
				else
					dest[i]=v;
				end
			else
				dest[i]=v;
			end
		end
	end
end

-------------------------------------------------------
--copy table source into the table dest with functions
-------------------------------------------------------
function utils.merge_with_functions(dest,source,recursive)
	for i,v in source do
		if(recursive) then
			if(type(v)=="table")then
				dest[i]= dest[i] or {};
				utils.merge_with_functions(dest[i],v,recursive);
			else
				dest[i]=v;
			end
		else
			dest[i]=v;
		end
	end
end

-------------------------------------------------------
--кол-во эл-тов в таблице
-------------------------------------------------------
function utils.count(_table)
	local count=0;
	for index,i in _table do
		count = count+1;
	end
	return count;
end

-------------------------------------------------------
-- квадрат расстояния между векторами
-------------------------------------------------------
function utils.vec3_dist_sqrt(v1, v2)
	local d1 = v2[1] - v1[1];
	local d2 = v2[2] - v1[2];
	local d3 = v2[3] - v1[3];
	return d1*d1 + d2*d2 + d3*d3;
end

-------------------------------------------------------
-- создание таблицы по строке
-------------------------------------------------------
function utils.create_table_from_string(str)
	local result = {};
    
    string.gsub(str, "([%w_]+)", function (w)
			if(tostring(tonumber(w)) == w) then
				table.insert(result, tonumber(w));
			else
				table.insert(result, w);
			end
		end)
    
	return result;
end

-------------------------------------------------------
-- аналог include в CPP
-------------------------------------------------------
function include(name)
	is_opened = engine.load_script(name);
	assert(is_opened, "file '"..name.."' not found");
end

function include_from_path(path, name)
	is_opened = engine.load_script_from_path(path, name);
	assert(is_opened, "file '"..name.."' not found");
end

-------------------------------------------------------------------------------
function wait(ms)
	return coroutine.yield(ms)
end

-------------------------------------------------------------------------------
function signal_entity(ent_name, singal_name)
	local ent = engine.get_entities_by_name(ent_name)[1]
	ent:signal(singal_name, nil, nil)
	return ent
end

-------------------------------------------------------------------------------
function execute_coroutine(coroutine_name)
	g_world_props:signal("execute_coroutine", nil, {name = ""..coroutine_name})
end

-------------------------------------------------------------------------------
function create_object_state_element(parent, name, value)
	local element = {}
	if value ~= nil then
		element.__val = value
	end
	if parent.m_object_state_elements ~= nil then 
		parent.m_object_state_elements[name] = element
	else
		parent[name] = element
	end
	return element
end
