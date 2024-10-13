class_name Monster extends Character

const MONSTERS_FILE := "res://ressources/characters/monsters/monsters.json"

var gils: int
var experience: int

var stats: Stats
var combat_stats: CombatStats

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

	combat_stats = CombatStats.new()	
	combat_stats.attack = monster_data["atk"]
	combat_stats.defense = monster_data["def"]

func load_stats(p_stats: Dictionary):
	#stats = Stats.from_dictionary(p_stats)
	pass

func get_stats() -> Stats:
	return stats

func get_combat_stats() -> CombatStats:
	return combat_stats

func get_sprite_frames() -> SpriteFrames:
	return _sprite_frames
