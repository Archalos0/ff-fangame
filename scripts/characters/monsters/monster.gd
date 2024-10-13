class_name Monster extends Character

const MONSTERS_FILE := "res://ressources/characters/monsters/monsters.json"

var gils: int
var experience: int

var attack: int
var defense: int

func load(monster_id: String):
	var content = FileHandler.get_json_content(MONSTERS_FILE)
	
	var monster_data = content[monster_id]
	
	character_name = monster_data["name"]
	level = monster_data["level"]
	experience = monster_data["exp"]
	gils = monster_data["gil"]
	
	_sprite_frames = SpriteFrames.new()
	_sprite_frames = load(monster_data["sprite_frames"]) as SpriteFrames
	
	stats = Stats.new()
	stats.current_health_points = monster_data["hp"]
	stats.max_health_points = monster_data["hp"]
	attack = monster_data["atk"]
	defense = monster_data["def"]

func load_stats(p_stats: Dictionary):
	#stats = Stats.from_dictionary(p_stats)
	pass

func get_stats() -> Dictionary:
	var full_stats: Dictionary = {
		"max_health_points": 0,
		"current_health_points": 0,
		"strength": 0,
		"agility": 0,
		"vitality": 0,
		"intellect": 0,
		"mind": 0,
		"attack": 0,
		"defense": 0,
		"magic_defense": 0,
		"evade": 0,
	}
	
	full_stats["current_health_points"] = stats.current_health_points
	full_stats["max_health_points"] = stats.max_health_points
	full_stats["attack"] = attack
	full_stats["defense"] = defense
	
	return full_stats

func get_sprite_frames() -> SpriteFrames:
	return _sprite_frames
