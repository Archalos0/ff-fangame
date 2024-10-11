class_name Equipment

const EQUIPMENTS_FILE: String = "res://ressources/equipments/equipments.json"

var equipment_name: String
var stats_upgraded: Stats

var attack_modifier: int
var defense_modifier: int
var magic_defense_modifier: int
var evade_modifier: int

var body_part: BODY_PART 

enum BODY_PART {
	HAND,
	HEAD,
	BODY,
	ARM,
}

enum ELEMENT {
	NONE,
	FIRE,
	ICE,
	LIGHTNING,
	EARTH,
	WIND,
	HOLY,
}

enum STATUS {
	NONE,
	POISON,
	PARALYSIS,
	CONFUSION,
	PETRIFY,
	SLEEP,
	TOAD,
	MINI,
	GRADUAL_PETRIFY,
}


func load(equipment_id: String):
	 
	if equipment_id == "": 
		equipment_name = ""
		stats_upgraded = Stats.new()
		attack_modifier = 0
		defense_modifier = 0
		magic_defense_modifier = 0
		evade_modifier = 0
		return
		
	var content: Dictionary = FileHandler.get_json_content(EQUIPMENTS_FILE)
	
	if content.has("error"):
		return
	
	equipment_name = content[equipment_id]["name"]
	
	stats_upgraded = Stats.new()
	stats_upgraded.load_character_stats(content[equipment_id]["stats_upgraded"])
	
	attack_modifier = content[equipment_id].get("attack", 0)
	defense_modifier = content[equipment_id].get("defense", 0)
	magic_defense_modifier = content[equipment_id].get("magic_defense", 0)
	evade_modifier = content[equipment_id].get("evade", 0)
