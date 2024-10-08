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
		return "qqqqq| " + name + " | " + job + " |"
#---------------#

const KEYS := ["characters"]

var characters: Array[CharacterData]

func _init(file_path: String) -> void:
	if not FileAccess.file_exists(file_path):
		return
	
	var json: JSON = JSON.new()
	
	var file = FileAccess.open(file_path, FileAccess.READ)
	var res = json.parse(file.get_as_text())
	file.close()
	
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


static func save():
	var new_save: Save
	
	var data: Dictionary = {
		1: { 
			"name": "Luneth",
			"job": "Thief" 
		},
		2: {
			"name": "Arc",
			"job": "Black Mage" 
		},
		3: {
			"name": "Refia",
			"job": "White Mage" 
		}
	}
	
	var new_dict: Dictionary = {
		"characters": []
	}
	for i in range(data.size()):
		new_dict["characters"].append(data[i+1])
	
	var json_string := JSON.stringify(new_dict, "\t")
	
	var file := FileAccess.open("res://scripts/save/save.json", FileAccess.WRITE)
	
	file.store_string(json_string)
	file.close()
	
	
