class_name Monster extends Character

const MONSTERS_FILE := "res://ressources/characters/monsters/monsters.json"

var gils: int
var experience: int

var stats: Stats
var combat_stats: CombatStats

var status_on_attack: Enums.STATUS = Enums.STATUS.NONE
var spells: Array[Spell] = []

func load(monster_id: String):
	var content = FileHandler.get_json_content(MONSTERS_FILE)
	
	var monster_data = content[monster_id]
	
	character_name = monster_data["name"]
	level = monster_data["level"]
	experience = monster_data["exp"]
	gils = monster_data["gil"]
	status_on_attack = Enums.status_from_string(monster_data["status_on_attack"])
	
	_sprite_frames = SpriteFrames.new()
	_sprite_frames = load(monster_data["sprite_frames"]) as SpriteFrames
	
	stats = Stats.new()
	stats.current_health_points = monster_data["hp"]
	stats.max_health_points = monster_data["hp"]

	combat_stats = CombatStats.new()	
	combat_stats.attack = monster_data["atk"]
	combat_stats.defense = monster_data["def"]
	
	for spell_id in monster_data["spells"]:
		spells.append(Spell.from_id(spell_id))

func load_stats(p_stats: Dictionary):
	#stats = Stats.from_dictionary(p_stats)
	pass

func get_stats() -> Stats:
	return stats

func get_combat_stats() -> CombatStats:
	return combat_stats

func get_sprite_frames() -> SpriteFrames:
	return _sprite_frames

func get_spells() -> Array[Spell]:
	return spells

func get_attack() -> int:
	return combat_stats.attack
