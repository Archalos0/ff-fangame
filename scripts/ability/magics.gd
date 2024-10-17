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
