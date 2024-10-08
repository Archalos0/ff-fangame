extends Node

#--INNER CLASS--#
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
	
	func load_character(dict: Dictionary):
		name = dict["name"]
		job = dict["job"]
	
	func get_properties_dict():
		var properties = {
			"name": name,
			"job": job
		}
		
		return properties
#---------------#

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
	_player.characters.append(character)
