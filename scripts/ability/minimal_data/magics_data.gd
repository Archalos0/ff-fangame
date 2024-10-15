class_name MagicsData

var level_1: SpellsData = SpellsData.new()
var level_2: SpellsData = SpellsData.new()
var level_3: SpellsData = SpellsData.new()
var level_4: SpellsData = SpellsData.new()
var level_5: SpellsData = SpellsData.new()
var level_6: SpellsData = SpellsData.new()
var level_7: SpellsData = SpellsData.new()
var level_8: SpellsData = SpellsData.new()

func load_magics(dict: Dictionary):
	level_1.load_spells(dict["1"])
	level_2.load_spells(dict["2"])
	level_3.load_spells(dict["3"])
	level_4.load_spells(dict["4"])
	level_5.load_spells(dict["5"])
	level_6.load_spells(dict["6"])
	level_7.load_spells(dict["7"])
	level_8.load_spells(dict["8"])
		
