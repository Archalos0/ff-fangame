extends Node

#----INNER CLASS----#
class PlayerData:
	var characters: Array[CharacterData]

	func load_player(dict: Dictionary):
		for key in dict.keys():
			match key:
				"characters": _load_characters(dict["characters"]) 
				
	func _load_characters(data: Array):
		characters.resize(data.size())
		for i in range(characters.size()):
			characters[i] = CharacterData.new()
			characters[i].load_character(data[i])
		
		
	func get_properties_dict():
		var properties = {
			"characters": []
		}
		
		for character in characters:
			properties["characters"].append(character.get_properties_dict())
		
		return properties

class CharacterData: 
	var name: String
	var job: String
	var equipments: EquipmentsData = EquipmentsData.new()
	
	func load_character(dict: Dictionary):
		name = dict["name"]
		job = dict["job"]
		
		if dict.has("equipments"):
			equipments.load_equipments(dict["equipments"])
	
	func get_properties_dict():
		var properties = {
			"name": name,
			"job": job,
			"equipments": {
				"left_hand": equipments.left_hand.id,
				"right_hand": equipments.right_hand.id,
				"head_armor": equipments.head_armor.id,
				"body_armor": equipments.body_armor.id,
				"arm_armor": equipments.arm_armor.id,
			}
		}
		
		return properties

class EquipmentsData:
	var left_hand: EquipmentData = EquipmentData.new()
	var right_hand: EquipmentData = EquipmentData.new()
	var head_armor: EquipmentData = EquipmentData.new()
	var body_armor: EquipmentData = EquipmentData.new()
	var arm_armor: EquipmentData = EquipmentData.new()
	
	func load_equipments(dict: Dictionary):
		for key in dict:
			if dict[key] == null:
				continue
			
			match key:
				"left_hand": 
					left_hand.load_equipment(dict["left_hand"])
				"right_hand": 
					right_hand.load_equipment(dict["right_hand"])
				"head_armor": 
					head_armor.load_equipment(dict["head_armor"])
				"body_armor": 
					body_armor.load_equipment(dict["body_armor"])
				"arm_armor":
					arm_armor.load_equipment(dict["arm_armor"])

class EquipmentData:
	var name: String
	var id: String
	var type: String
	
	var attack: int
	var defense: int
	var magic_defense: int
	var evade: int
	
	var sprite_path: String
	var stats_upgraded: Array
	
	func load_equipment(equipment_id: String):
		
		var dict: Dictionary = FileHandler.get_json_content("res://ressources/equipments/equipments.json")
		
		if dict.has("error"):
			return
		
		var equipment_data: Dictionary = dict[equipment_id]
		
		id = equipment_id
		
		name = equipment_data["name"]
		type = equipment_data["type"]
		
		attack = equipment_data.get("attack", 0)
		defense = equipment_data.get("defense", 0)
		magic_defense = equipment_data.get("magic_defense", 0)
		evade = equipment_data.get("evade", 0)
		
		sprite_path = equipment_data["sprite_path"]
		stats_upgraded = equipment_data.get("stats_upgraded", null)
#-------------------#

var _save_file_path: String = ""
var _player: PlayerData = PlayerData.new()

func load_save(file_path) -> void:
	_save_file_path = file_path
	
	var res = FileHandler.get_json_content(_save_file_path)
	
	if res.has("error"):
		return
	
	var raw_data = res
	
	for key in raw_data.keys():
		match key:
			"player": 
				_player = PlayerData.new()
				_player.load_player(raw_data["player"])

func save_game():
	if not FileAccess.file_exists(_save_file_path):
		return
	
	var dict_to_save: Dictionary = _get_properties_dict()
	FileHandler.write_json_content(_save_file_path, dict_to_save)

func _get_properties_dict():
	var properties = {
		"player": _player.get_properties_dict()
	}
	
	return properties

func add_character(dict: Dictionary):
	var character: CharacterData = CharacterData.new()
	character.name = dict["name"]
	character.job = dict["job"]
	character.equipments.left_hand.id = dict["equipments"]["left_hand"]
	_player.characters.append(character)
