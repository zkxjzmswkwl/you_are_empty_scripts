------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Vyacheslav Korotayev
------------------------------------------------------------------------
-- Giver ("давалка") - определяет какой предмет должен быть создан вместо giver'а
------------------------------------------------------------------------

function create_weapon_giver(_guid, _class_name)

	local _common_table = {};
	local _server_table = {};
	local _client_table = {};
								
	_common_table.guid = _guid;
	_server_table = utils.inherit(sv_game_object, _common_table);
	_server_table.register_properties = function(self, prop_registry)
		sv_game_object.register_properties(self, prop_registry);
	end
	_server_table.get_item_class_name = function(self)
		return _class_name
	end

	_client_table = utils.inherit(cl_game_object, _common_table);
	
	return _common_table, _server_table, _client_table;
end