class_name Spell

var spell_id: String = ""
var spell_name: String = ""
var level: int = 0
var power: int = 0
var hit_percentage: int = 0
var target: Array#[String]
var statuses: Array[Enums.STATUS] = []
var elements: Array[Enums.ELEMENT] = []

var cast_by: Array#[String] = []

func _init():
	pass
	#load(p_spell_id)

func load(p_spell_id: String):
	if p_spell_id == "":
		return
	
	var content = FileHandler.get_json_content(Files.SPELLS_FILE)
	
	if content.has("error"): 
		return
		
	spell_id = p_spell_id
	
	var spell_data = content[spell_id]
	
	spell_name = spell_data["spell_name"]
	level = spell_data["level"]
	power = spell_data["power"]
	hit_percentage = spell_data["hit_percentage"]
	target = spell_data["target"]
	statuses = Enums.statuses_from_string(spell_data.get("statuses", []))
	elements = Enums.elements_from_string(spell_data.get("elements", []))
	
	cast_by = spell_data["cast_by"]
	
