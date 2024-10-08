class_name Save extends Node

#--INNER CLASS--#
class CharacterData: 
	var name: String
	var job: String
	
	func _init(dict: Dictionary) -> void:
		for key in dict:
			match key:
				"name": name = dict["name"]
				"job": job = dict["job"]
	
	func _to_string() -> String:
		return "| " + name + " | " + job + " |"
#---------------#

const KEYS := ["characters"]

var characters: Array[CharacterData]

func _init(file_path: String) -> void:
	if not FileAccess.file_exists(file_path):
		return
	
	var json: JSON = JSON.new()
	
	var file = FileAccess.open(file_path, FileAccess.READ)
	var res = json.parse(file.get_as_text())
	
	if res == OK:
		var raw_data = json.data
		
		for key in raw_data.keys():
			match key:
				"characters": _load_characters(raw_data["characters"])
		
		for character in characters:
			print(character._to_string())
	else:
		print("Error")

func _load_characters(data: Array) -> void:
	for dict in data:
		characters.append(CharacterData.new(dict))
