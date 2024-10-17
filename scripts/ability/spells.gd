class_name Spells

var slot_1: Spell = null
var slot_2: Spell = null
var slot_3: Spell = null

func load(spells_data: SpellsData):
	if spells_data.first_slot_spell_id != "":
		slot_1 = Spell.from_id(spells_data.first_slot_spell_id)
	
	if spells_data.second_slot_spell_id != "":
		slot_2 = Spell.from_id(spells_data.second_slot_spell_id)
	
	if spells_data.third_slot_spell_id != "":
		slot_3 = Spell.from_id(spells_data.third_slot_spell_id)
