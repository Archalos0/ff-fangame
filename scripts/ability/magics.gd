class_name Magics

var level_1: Spells = Spells.new()
var level_2: Spells = Spells.new()
var level_3: Spells = Spells.new()
var level_4: Spells = Spells.new()
var level_5: Spells = Spells.new()
var level_6: Spells = Spells.new()
var level_7: Spells = Spells.new()
var level_8: Spells = Spells.new()

func load(magics_data: MagicsData):
	level_1.load(magics_data.level_1)
	level_2.load(magics_data.level_2)
	level_3.load(magics_data.level_3)
	level_4.load(magics_data.level_4)
	level_5.load(magics_data.level_5)
	level_6.load(magics_data.level_6)
	level_7.load(magics_data.level_7)
	level_7.load(magics_data.level_8)

func get_all_spells() -> Array[Spell]:
	return [
		level_1.slot_1,
		level_1.slot_2,
		level_1.slot_3,
		level_2.slot_1,
		level_2.slot_2,
		level_2.slot_3,
		level_3.slot_1,
		level_3.slot_2,
		level_3.slot_3,
		level_4.slot_1,
		level_4.slot_2,
		level_4.slot_3,
		level_5.slot_1,
		level_5.slot_2,
		level_5.slot_3,
		#level_6.slot_1,
		#level_6.slot_2,
		#level_6.slot_3,
		#level_7.slot_1,
		#level_7.slot_2,
		#level_7.slot_3,
		#level_8.slot_1,
		#level_8.slot_2,
		#level_8.slot_3
	]
