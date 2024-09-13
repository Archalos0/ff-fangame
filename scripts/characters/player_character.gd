class_name PlayerCharacter

@export var character_name: String = ""
var job: Job = null

func _init(p_character_name: String):
	character_name = p_character_name
	job = Job.new("warrior", 10)
