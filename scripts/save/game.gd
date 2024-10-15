extends Node

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
