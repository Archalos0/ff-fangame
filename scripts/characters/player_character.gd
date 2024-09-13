class_name PlayerCharacter

@export var character_name: String = ""
var job: Job = null
var level: int

#func _init(p_character_name: String):
	#character_name = p_character_name
	#job = Job.new(, 10)
	

static func from_player_character_resource(player_character_resource: PlayerCharacterResource) -> PlayerCharacter:
	var new_character = PlayerCharacter.new()
	new_character.character_name = player_character_resource.character_name
	new_character.level = player_character_resource.level
	new_character.job = Job.from_resource(player_character_resource.job_resource, new_character.level)
	
	return new_character
