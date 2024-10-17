class_name EquipableItem extends Item

var equippable_by: Array[String]
var bonuses: Stats = Stats.new()

var type: Enums.EQUIPMENT_TYPE

# Weapon Data 
var attack_power: int
var hit_percentage: int
var status_inflicted: Enums.STATUS
var elements_inflicted: Array[Enums.ELEMENT]
var spell_on_use: Spell = null

# Armor Data
var defense: int
var evade_percentage: int
var magic_defense: int
var status_immunity: Array[Enums.STATUS]
var elemental_resistances: Array[Enums.ELEMENT]
var elemental_weakness: Enums.ELEMENT

func load(equipment_id: String):
	
	if equipment_id == "": 
		item_id = ""
		item_name = ""
		buy_value = 0
		
		bonuses = Stats.new()
		
		attack_power = 0
		hit_percentage = 0
		status_inflicted = Enums.STATUS.NONE
		elements_inflicted = []
		spell_on_use = null
		
		defense = 0
		magic_defense = 0
		evade_percentage = 0
		status_immunity = []
		elemental_resistances = []
		elemental_weakness = Enums.ELEMENT.NONE
		
		return
	
	var content: Dictionary = FileHandler.get_json_content(Files.EQUIPMENTS_FILE)
	
	if content.has("error"): return
		
	var equipment_data = content[equipment_id]
	
	item_id = equipment_id
	item_name = equipment_data["item_name"]
	buy_value = equipment_data["price"]
	sell_value = equipment_data["value"]
	
	if equipment_data["bonuses"] == null:
		bonuses = Stats.new()
	else:
		bonuses.load_character_stats(equipment_data["bonuses"])
		
	
	# Weapon stats
	attack_power 		= equipment_data.get("attack_power", 0)
	hit_percentage		= equipment_data.get("hit_percentage", 0)
	status_inflicted	= Enums.status_from_string(equipment_data.get("status_inflicted", ""))
	elements_inflicted	= Enums.elements_from_string(equipment_data.get("elements_inflicted", []))
	
	if equipment_data.has("spell_on_use") and equipment_data["spell_on_use"] != "":
		spell_on_use 		= Spell.new()
		spell_on_use.load(equipment_data.get("spell_on_use", ""))
	
	# Armor stats
	defense 				= equipment_data.get("defense", 0)
	magic_defense 			= equipment_data.get("magic_defense", 0)
	evade_percentage 		= equipment_data.get("evade_percentage", 0)
	status_immunity			= Enums.statuses_from_string(equipment_data.get("status_immunity", []))
	elemental_resistances	= Enums.elements_from_string(equipment_data.get("elemental_resistances", []))
	elemental_weakness		= Enums.element_from_string(equipment_data.get("elemental_weakness", ""))
