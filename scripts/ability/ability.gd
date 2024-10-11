class_name Ability extends Node

const ABILITY_FILE := "res://ressources/spells/spells.json"

var ability_name: String
var element: Enums.ELEMENT
var hit_percentage: int
var target: Enums.TARGET
var type: Enums.ABILITY_TYPE

func load(ability_id: String):
	
	var content: Dictionary = FileHandler.get_json_content(ABILITY_FILE)
	if content.has("error"):
		push_error("Error reading ability file.")
		return
	
	var ability_data = content[ability_id]
	
	ability_name = ability_data["name"]
	hit_percentage = ability_data["hit_percentage"]
	
	element = Enums.element_from_string(ability_data["element"])
	target = Enums.target_from_string(ability_data["target"])
	type = Enums.ability_type_from_string(ability_data["type"])
