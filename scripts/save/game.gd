extends Node

#----INNER CLASS----#
class PlayerData:
	var characters: CharactersData = CharactersData.new()
	var capacity_points: int = 0
	
	func load_player(dict: Dictionary):
		for key in dict.keys():
			match key:
				"characters": characters.load_characters(dict["characters"])
				"capacity_points": capacity_points =  dict["capacity_points"]
				
		
	func get_properties_dict():
		var properties = {
			"characters": characters.get_properties_dict(),
			"capacity_points": capacity_points,
		}
		
		return properties

class CharactersData:
	var character_1: CharacterData = CharacterData.new()
	var character_2: CharacterData = CharacterData.new()
	var character_3: CharacterData = CharacterData.new()
	var character_4: CharacterData = CharacterData.new()
	
	#Set up the default name of the characters
	func _init() -> void:
		character_1.character_name = "Luneth" 
		character_2.character_name = "Arc" 
		character_3.character_name = "Refia" 
		character_4.character_name = "Ingus" 
	
	func load_characters(characters: Array):
		characters.resize(4)
		for character in characters:
			if character == null:
				character = CharacterData.new()
				
		if characters[0] != null : character_1.load_character(characters[0])
		if characters[1] != null : character_2.load_character(characters[1])
		if characters[2] != null : character_3.load_character(characters[2])
		if characters[3] != null : character_4.load_character(characters[3])

	func get_properties_dict():
		var properties = [
			character_1.get_properties_dict(),
			character_2.get_properties_dict(),
			character_3.get_properties_dict(),
			character_4.get_properties_dict(),
		]
		
		return properties

class CharacterData: 
	var character_name: String = ""
	var job_id: String = "warrior"
	var equipments: EquipmentsData = EquipmentsData.new()
	var level: int = 1
	var max_health_points: int = 100
	var current_health_points: int = 100
	
	var magics: MagicsData = MagicsData.new()
	
	var jobs_skill: Dictionary = {
		"onion_knight": 1,
		"warrior": 1,
		"monk": 1,
		"white_mage": 1,
		"black_mage": 1,
		"red_mage": 1,
		"thief": 1,
		"ranger": 1,
		"knight": 1,
		"scholar": 1,
		"geomancer": 1,
		"dragoon": 1,
		"viking": 1,
		"dark_knight": 1,
		"evoker": 1,
		"bard": 1,
		"black_belt": 1,
		"devout": 1,
		"magus": 1,
		"summoner": 1,
		"sage": 1,
		"ninja": 1
	}
	
	func load_character(dict: Dictionary):
		character_name = dict["name"]
		job_id = dict["job_id"]
		level = dict["level"]

		max_health_points = dict["max_health_points"]
		current_health_points = dict["current_health_points"]

		jobs_skill = dict["jobs_skill"]

		if dict.has("equipments"):
			equipments.load_equipments(dict["equipments"])
			
		if dict.has("magics"):
			magics.load_magics(dict["magics"])
	
	func get_properties_dict():
		var properties = {
			"name": character_name,
			"job_id": job_id,
			"level": level,
			"max_health_points": max_health_points,
			"current_health_points": current_health_points,
			"equipments": {
				"left_hand": equipments.left_hand,
				"right_hand": equipments.right_hand,
				"head_armor": equipments.head_armor,
				"body_armor": equipments.body_armor,
				"arm_armor": equipments.arm_armor,
			},
			"jobs_skill": jobs_skill
		}
		
		return properties

class EquipmentsData:
	var left_hand_id	: String = ""
	var right_hand_id	: String = ""
	var head_armor_id	: String = ""
	var body_armor_id	: String = ""
	var arm_armor_id	: String = ""
	
	func load_equipments(dict: Dictionary):
		for key in dict:
			if dict[key] == null:
				continue
			
			match key:
				"left_hand": left_hand_id = dict["left_hand"]
				"right_hand": right_hand_id = dict["right_hand"]
				"head_armor": head_armor_id = dict["head_armor"]
				"body_armor": body_armor_id = dict["body_armor"]
				"arm_armor": arm_armor_id = dict["arm_armor"]


#class EquipmentData:
	#var name: String
	#var id: String
	#var type: String
	#
	#var attack: int
	#var defense: int
	#var magic_defense: int
	#var evade: int
	#
	#var sprite_path: String
	#var stats_upgraded: Array
	#
	#func load_equipment(equipment_id: String):
		#var dict: Dictionary = FileHandler.get_json_content("res://ressources/equipments/equipments.json")
		#
		#if dict.has("error"):
			#return
		#
		#var equipment_data: Dictionary = dict[equipment_id]
		#
		#id = equipment_id
		#
		#name = equipment_data["name"]
		#type = equipment_data["type"]
		#
		#attack = equipment_data.get("attack", 0)
		#defense = equipment_data.get("defense", 0)
		#magic_defense = equipment_data.get("magic_defense", 0)
		#evade = equipment_data.get("evade", 0)
		#
		#sprite_path = equipment_data["sprite_path"]
		#stats_upgraded = equipment_data.get("stats_upgraded", null)

class MagicsData:
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
		

class SpellsData:
	var first_slot_spell_id	: String = ""
	var second_slot_spell_id: String = ""
	var third_slot_spell_id	: String = ""
	
	func load_spells(dict: Dictionary):
		first_slot_spell_id = dict["first_slot"]
		second_slot_spell_id = dict["second_slot"]
		third_slot_spell_id = dict["third_slot"]
		
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

func get_player_characters() -> Array[CharacterData]:
	return [
		_player.characters.character_1,
		_player.characters.character_2,
		_player.characters.character_3,
		_player.characters.character_4
	]
