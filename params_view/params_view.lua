----------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
----------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
----------------------------------------------------------------------------
--	Создание таблиц(HTML), отображающих параметры актеров и оружия.
----------------------------------------------------------------------------

include("headers_desc.lua");

HTMLStyles = {
	table			= " border=1 cellpadding=2 cellspacing=0 bordercolor=black",
	tr_col_header	= " style='font-weight:bold; background-color=gold'",
	td_row_header	= " style='font-weight:bold; background-color=gold; width=150'",
	td_corner		= " style='background-color=window'",
	td_data			= " style='text-align=center'",
}

----------------------------------------------------------------------------
function export_design_params()
	
	local html_begin = [[
<html>
<head>
</head>
<body>
]]
		 
	local html_end = [[
</body>
</html>
]]
	
	local tables = ""
	local row_headers
	
	-- Экспорт параметров актеров.
	tables = tables .. export_group("actor", actor_headers, "Параметры актеров")
	
	-- Экспорт параметров атаки актеров.
	tables = tables .. export_group("actor", actor_attack_headers, "Параметры атаки актеров")
	
	-- Экспорт параметров оружия.
	tables = tables .. export_group("weapon", weapon_headers, "Параметры оружия")
	
	-- Экспорт параметров метательного оружия.
	tables = tables .. export_group("ammo_missile", ammo_missile_headers, "Параметры метательного оружия")
	
	return html_begin .. tables .. html_end
	
end

----------------------------------------------------------------------------
-- Экспортирует группу
function export_group(group_prefix, headers_tbl, caption)
	local res = ""
	local row_headers
	local except = {"&nbsp;"}
	local prefix_len = string.len(group_prefix)
	
	res = res .. "<h2>"..caption.."</h2>\n"
	-- Находим и отображаем все специфические элементы группы
	for i, v in pairs(headers_tbl) do
		row_headers = {"&nbsp;"}
		if string.sub(i, 0, prefix_len) == group_prefix then
			table.insert(row_headers, i)
			table.insert(except, i)
			res = res .. create_html_table(row_headers, headers_tbl[i], headers_tbl)
			res = res .. "<br>\n"
		end
	end
	
	-- Отображаем все остальны элементы группы
	row_headers = get_group_names(group_prefix, except) 
	table.insert(row_headers, 1, "&nbsp;")
	res = res .. create_html_table(row_headers, headers_tbl.common, headers_tbl)
	
	res = res .. "<hr>\n"
	
	return res
end

----------------------------------------------------------------------------
-- Возвращает значение свойства по имени
function get_prop_val_by_name(class_tbl, prop_name)
	
	if not class_tbl.properties_design then return nil end
	
	for i, v in pairs(class_tbl.properties_design) do
		if v[1] == prop_name then
			return v[2]
		end
	end
	
	return nil
end

----------------------------------------------------------------------------
-- Возвращает имена классов указанной группы, кроме тех, которые уже есть в except
function get_group_names(group_prefix, except)
	
	local prefix_len = string.len(group_prefix)
	res = {}
	
	-- Ищем имена в таблице прототипов
	for i, v in pairs(prototypes) do
	
		local class_name = v[3]
		if string.sub(class_name, 0, prefix_len) == group_prefix then
			
			-- Пропускаем actor_player'а
			if class_name == "actor_player" then continue end
			
			-- Подходящее имя найдено. Проверим нет ли его среди исключений
			local exeption = false
			for j, v2 in ipairs(except) do
				if class_name == v2 then
					exeption = true
					break
				end
			end
			
			if not exeption then
				table.insert(res, class_name)
			end
			
		end
	end
	
	-- Упорядочивает имена по алфавиту
	table.sort(res)
	
	return res
end

----------------------------------------------------------------------------
-- Создает HTML-таблицу
function create_html_table(row_headers, column_headers, headers_tbl)

	local res = ""
	
	res = res .. "<table"..HTMLStyles.table..">\n"
	
	-- Строки таблицы
	for i, r in pairs(row_headers) do
		
		local rowspan = 1
		local expanded_rows = nil
		-- Стили строки и первых ячеек строки.
		if i == 1 then
			-- Угловая ячейка
			td_style = HTMLStyles.td_corner
			-- Стиль первой строки(заголовки столбцов)
			tr_style = HTMLStyles.tr_col_header
		else
			-- Определим нужно ли расширять строку и на сколько
			local exp_tbl = headers_tbl.expand[r] or headers_tbl.expand.common
			if exp_tbl then
				expanded_rows = {}
				-- Дополнительные строки
				for i, v in pairs(exp_tbl) do
					-- Определяем "путь" к параметру
					local param = _G[r]
					for i, v in pairs(v.key) do
						param = param[v]
					end
					
					if param then
						if v.is_array then
							for i, v in pairs(param) do
								table.insert(expanded_rows, v)
							end
						else
							table.insert(expanded_rows, param)
						end
					end
				end	
			end
			
			if (expanded_rows) and (table.getn(expanded_rows) ~= 0) then
				rowspan = table.getn(expanded_rows)
			end
			
			-- Стиль первого столбца(заголовки строк)
			td_style = HTMLStyles.td_row_header.." rowspan="..rowspan
			-- Стиль ячеек с данными
			tr_style = ""
		end
		
		res = res .. "\t<tr"..tr_style..">\n"
		res = res .. "\t\t<td"..td_style..">" .. r .. "</td>\n"
		
		for row = 1, rowspan do
	
			-- Столбцы таблицы	
			for j, c in pairs(column_headers) do
				res = res .. "\t\t<td"..HTMLStyles.td_data..">"
				
				if i == 1 then
					-- Первая строка в таблице - заголовок.
					res = res .. c.header_name
				else
					-- Если строка не первая, то пишем значение свойства
					if expanded_rows then
						res = res .. format_value(expanded_rows[row][c.prop_name], c.prop_name)
					else
						local prop_val = get_prop_val_by_name(_G["sv_"..r], c.prop_name) or _G[r][c.prop_name] or _G[r].params[c.prop_name]
						res = res .. format_value(prop_val, c.prop_name)
					end
				end
				
				res = res .. "</td>\n"
			end 
			res = res .. "\t</tr>\n"
		
		end
	end
	
	res = res .. "</table>\n"
	
	return res
end

----------------------------------------------------------------------------
-- Преобразовывает заначения в строку
function format_value(val, prop_name)
	local res
	
	local formatted = false
	-- Преобразование числовых значений в известные символические имена
	if val then
		if prop_name == "damage_type" then
			for i, v in pairs(g_damage_type) do
				if v == val then
					res = i
					formatted = true
					break
				end
			end
		end
	end
	
	if not formatted then
		if type(val) == "nil" then
			res = "nil"
		elseif type(val) == "boolean" then
			res = val and "true" or "false"
		else
			res = val
		end
	end
	
	return res	
end