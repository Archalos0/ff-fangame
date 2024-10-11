class_name Monster extends Character

const MONSTERS_FILE := "res://ressources/characters/monsters/monsters.json"

var gils: int
var experience: int
var sprite_frames: SpriteFrames

#func load_from_character_resource(p_resource: CharacterResource):
	#if p_resource is not EnemyResource:
		#push_error("The resource type is not valid")
		#pass
	#
	#var resource: EnemyResource = p_resource
	#
	#character_name	= resource.character_name
	#level			= resource.level
	##texture			= resource.texture
	#gils			= resource.gils
	#experience		= resource.experience
	#
	#load_stats(resource.stats)
	#load_actions(resource.actions_resources)

func load(monster_id: String):
	var content = FileHandler.get_json_content(MONSTERS_FILE)
	
	var monster_data = content[monster_id]
	
	character_name = monster_data["name"]
	level = monster_data["level"]
	experience = monster_data["exp"]
	gils = monster_data["gil"]
	
	sprite_frames = SpriteFrames.new()
	sprite_frames = load(monster_data["sprite_frames"]) as SpriteFrames

#func load_actions(p_actions_resource: Array[ActionResource]):
	##for action_resource: ActionResource in p_actions_resource:
		##actions.append(Action.from_action_resource(action_resource))
	#pass
	
func load_stats(p_stats: Dictionary):
	#stats = Stats.from_dictionary(p_stats)
	pass

func get_stats() -> Dictionary:
	return {
		"max_health_points": 100,
		"current_health_points": 50
	}

func get_sprite_frames() -> SpriteFrames:
	return sprite_frames
