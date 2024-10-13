class_name PlayerCharacter extends Character

var job: Job
var equipments: Equipments
var stats: Stats
var magics: Magics

func load(character_data: Game.CharacterData):
	character_name = character_data.name

	level = character_data.level

	#Load job
	job = Job.new()
	job.load(character_data.job, character_data.jobs_level[character_data.job])
	
	_sprite_frames = SpriteFrames.new()
	_sprite_frames = load(job.sprite_frames_path) as SpriteFrames
	
	#Load equipments
	equipments = Equipments.new()
	equipments.load(character_data.equipments)
	
	load_stats()
	stats.current_health_points = character_data.current_health_points
	stats.max_health_points = character_data.max_health_points

func load_actions():
	#actions = job.actions
	pass

func load_stats():
	var content = FileHandler.get_json_content("res://ressources/jobs/jobs.json")
	
	if content.has("error"):
		return
	
	stats = Stats.new()
	stats.load_character_stats(content[job.job_name]["stats"][str(level)])

func get_animation() -> SpriteFrames:
	return job.animations

func get_stats() -> Stats:
	return stats

func get_actions() -> Array[Action]:
	return job.actions

func get_combat_stats() -> CombatStats:
	var combat_stats := CombatStats.new()
	
	combat_stats.attack = equipments.get_damage() + (stats.strength / 4)
	combat_stats.attack_multiplier = (stats.agility / 16) + (level / 16) + 1
	combat_stats.hit_percentage = equipments.get_hit_percentage() + (stats.agility / 4) + (job.skill / 4)
	combat_stats.defense = equipments.get_defense() + (stats.vitality / 2)
	if equipments.get_number_shields() > 0:
		combat_stats.defense_multiplier = (stats.agility / 16) + (level / 16) + 1 * equipments.get_number_shields()
	else:
		combat_stats.defense_multiplier = (stats.agility / 32) + (level / 32)
	
	combat_stats.evade_percentage = equipments.get_evade_percentage() + (stats.agility / 4)
	combat_stats.magic_defense = equipments.get_magic_defense()
	combat_stats.magic_evade_percentage = (stats.intellect / 2) + (stats.mind / 2)
	
	return combat_stats
	
func get_sprite_frames() -> SpriteFrames:
	return _sprite_frames
