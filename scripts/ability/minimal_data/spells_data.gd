class_name SpellsData

var first_slot_spell_id	: String = ""
var second_slot_spell_id: String = ""
var third_slot_spell_id	: String = ""

func load_spells(dict: Dictionary):
	first_slot_spell_id = dict["first_slot"]
	second_slot_spell_id = dict["second_slot"]
	third_slot_spell_id = dict["third_slot"]
	
