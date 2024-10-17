class_name Spells

var slot_1: Spell = null
var slot_2: Spell = null
var slot_3: Spell = null

func load(spells_data: SpellsData):
	if spells_data.first_slot_spell_id != "":
		slot_1 = Spell.new()
		slot_1.load(spells_data.first_slot_spell_id)
	
	if spells_data.second_slot_spell_id != "":
		slot_2 = Spell.new()
		slot_2.load(spells_data.second_slot_spell_id)
	
	if spells_data.third_slot_spell_id != "":
		slot_3 = Spell.new()
		slot_3.load(spells_data.third_slot_spell_id)
