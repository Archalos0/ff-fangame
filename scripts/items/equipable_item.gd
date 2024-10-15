class_name EquipableItem extends Item

var equippable_by: Array[String]
var bonuses: Stats = Stats.new()

var type: Enums.EQUIPMENT_TYPE

# Weapon Data 
var attack_power: int
var hit_percentage: int
var status_inflicted: Enums.STATUS
var elements_inflicted: Array[Enums.ELEMENT]

# Armor Data
var defense: int
var evade_percentage: int
var magic_defense: int
var status_immunity: Array[Enums.STATUS]
var elemantal_resistances: Array[Enums.ELEMENT]
var elemental_weaknesses: Array[Enums.ELEMENT]

func load(equipment_id: String):
	
	if equipment_id == "": 
		item_name = ""
		bonuses = Stats.new()
		attack_power = 0
		defense = 0
		magic_defense = 0
		evade_percentage = 0
		
		return
	
	var content: Dictionary = FileHandler.get_json_content(Files.EQUIPMENTS_FILE)
	
	if content.has("error"):
		return
		
	var equipment_data = content[equipment_id]
	
	item_name = equipment_data["item_name"]
	
	bonuses.load_character_stats(equipment_data["stats_upgraded"])
	
	attack_power 		= equipment_data.get("attack", 0)
	defense 			= equipment_data.get("defense", 0)
	magic_defense 		= equipment_data.get("magic_defense", 0)
	evade_percentage 	= equipment_data.get("evade", 0)
