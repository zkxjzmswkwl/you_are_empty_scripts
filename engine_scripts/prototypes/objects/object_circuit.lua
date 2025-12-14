------------------------------------------------------------------------
-- Copyright (C) 2003-2005 Digital Spray Studios. All Rights Reserved.
------------------------------------------------------------------------
-- Authors: Vyacheslav Korotayev
------------------------------------------------------------------------
-- object_circuit - перенаправл€ет сигнал вход€щего слота на один из
-- выход€щих слотов.  аждый раз вход€щий сигнал перенаправл€етс€ на
-- следующий выход€щий слот. ¬ыход€щие слоты перебираютс€ циклически.
------------------------------------------------------------------------

------------------------------------
-- обща€ часть
object_circuit = {
	guid = {0x71783124, 0x7928, 0x4931, 0xbf, 0xd8, 0x92, 0x60, 0x21, 0x1f, 0xd2, 0x4},
	n_out_slots = 5	
}

function object_circuit:register_properties(prop_registry)
	self.start_with = self:register_property(prop_registry, "start_with", 1);
	self:set_update_enable(false);
end

function object_circuit:on_init()
	
	-- — какого исход€щего слота начинать перебор
	local start_with = self:get_property_value(self.start_with)
	if start_with < 1 or start_with > object_circuit.n_out_slots then
		self.output_to = 1
	else
		self.output_to = start_with
	end
	
end

------------------------------------
-- серверна€ часть 
sv_object_circuit = utils.inherit(sv_game_object, object_circuit)

function sv_object_circuit:register_properties(prop_registry)

	sv_game_object.register_properties(self, prop_registry)
	object_circuit.register_properties(self, prop_registry);

	-- –егистраци€ слотов
	self.input = self:register_input_slot("input", self.input)

	self.out_slots = {}
	for i = 1, object_circuit.n_out_slots do
		table.insert( self.out_slots, self:register_output_slot("output"..i, nil) )
	end
	
end

function sv_object_circuit:move_next_slot()

	-- Ѕерем (по кругу) следующий исход€щий слот 
	if self.output_to == object_circuit.n_out_slots then
		self.output_to = 1
	else
		self.output_to = self.output_to + 1
	end
	
end

function sv_object_circuit:input(sender, activator, input_data)

	local begin_slot	= self.output_to
	local emitted		= false

	-- ѕеребираем все слоты, пока не отправим сигнал на какой-нибудь слот
	repeat
	
		if self:get_links_num( self.out_slots[self.output_to] ) ~= 0 then
			self:emit_signals( self.out_slots[self.output_to] )
			emitted = true
		end	
		
		self:move_next_slot()
		
		if emitted == true then break end
		
	until self.output_to == begin_slot

end

------------------------------------
-- клиентска€ часть 
cl_object_circuit = utils.inherit(cl_game_object, object_circuit)

function cl_object_circuit:register_properties(prop_registry)

	cl_game_object.register_properties(self, prop_registry)
	object_circuit.register_properties(self, prop_registry)
	
end
