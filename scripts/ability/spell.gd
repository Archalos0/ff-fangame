class_name Spell

var spell_id: String = ""
var spell_name: String = ""
var level: int = 0
var power: int = 0
var hit_percentage: int = 0
var target: Enums.TARGET
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
	target = Enums.target_from_string(spell_data["target"])
	statuses = Enums.statuses_from_string(spell_data.get("statuses", []))
	elements = Enums.elements_from_string(spell_data.get("elements", []))
	
	cast_by = spell_data["cast_by"]

static func from_id(p_spell_id: String) -> Spell:
	
	if p_spell_id == "":
		return
	
	var content = FileHandler.get_json_content(Files.SPELLS_FILE)
	
	if content.has("error"): 
		return
		
	var spell_data = content[p_spell_id]	
	
	var spell: Spell
	
	match content[p_spell_id]["type"]:
		"PHYSICAL": spell = PhysicalSpell.new()
		"BLACK", "TERRAIN": spell = BlackSpell.new()
		"WHITE": spell = WhiteSpell.new()
		"SUMMON": spell = CallSpell.new()
		
		
	spell.spell_id = p_spell_id
	
	spell.spell_name = spell_data["spell_name"]
	spell.level = spell_data.get("level", 0)
	spell.power = spell_data.get("power", 0)
	spell.hit_percentage = spell_data.get("hit_percentage", 0)
	spell.target = Enums.target_from_string(spell_data["target"])
	spell.statuses = Enums.statuses_from_string(spell_data.get("statuses", []))
	spell.elements = Enums.elements_from_string(spell_data.get("elements", []))
	
	spell.cast_by = spell_data.get("cast_by", [])
	
	return spell

func exec(caster: Battler, targets: Array[Battler]):
	push_error("The method exec() has not been implementing in the derived class")

func is_selecting_allies() -> bool:
	return target == Enums.TARGET.A or target == Enums.TARGET.SA or target == Enums.TARGET.AA

func can_be_used_on_multiple_targets() -> bool:
	return target == Enums.TARGET.E or target == Enums.TARGET.A or target == Enums.TARGET.AE or target == Enums.TARGET.AA
