------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Author: Yuri Dobronravin
------------------------------------------------------------------------
-- Метательное оружие (ракеты, камни и т.д.)
------------------------------------------------------------------------

function create_ammo_missile(_guid, _model, _properties_table)
	
	local _common_table = {};
	local _server_table = {};
	local _client_table = {};
					
	-- Общая часть			
	_common_table.guid = _guid;
	_common_table.properties_design = _properties_table;
	
	-- Серверная часть
	_server_table = utils.inherit(sv_game_object, _common_table);
	_server_table.register_properties = function(self, prop_registry)
		sv_game_object.register_properties(self, prop_registry);
		
		self:init_properties_from_table(self.properties_design);
		self:set_property_value_by_name("model_name",	_model);
	end	
	
	_server_table.on_init = function(self)
		sv_game_object.on_init(self);
	end

	-- Клиентская часть
	_client_table = utils.inherit(cl_game_object, _common_table);
	
	_client_table.on_post_anims_init = function(self)
		self:set_model_gross_cull(0, false);
	end
	
	return _common_table, _server_table, _client_table;
end