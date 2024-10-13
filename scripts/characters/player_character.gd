class_name PlayerCharacter extends Character

var job: Job
var equipments: Equipments 

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
	
	var equipments_stats: Dictionary = equipments.get_stats()
	
	full_stats["current_health_points"] = stats.current_health_points
	full_stats["max_health_points"] = stats.max_health_points
	
	full_stats["strength"] 	+= stats.strength 	+ equipments_stats["strength"]
	full_stats["agility"] 	+= stats.agility 	+ equipments_stats["agility"]
	full_stats["vitality"] 	+= stats.vitality 	+ equipments_stats["vitality"]
	full_stats["intellect"] += stats.intellect 	+ equipments_stats["intellect"]
	full_stats["mind"] 		+= stats.mind 		+ equipments_stats["mind"]

	full_stats["attack"] 		+= equipments_stats["attack"]
	full_stats["defense"] 		+= equipments_stats["defense"]
	full_stats["magic_defense"] += equipments_stats["magic_defense"]
	full_stats["evade"] 		+= equipments_stats["evade"]

	return full_stats

func get_actions() -> Array[Action]:
	return job.actions

func get_sprite_frames() -> SpriteFrames:
	return _sprite_frames
