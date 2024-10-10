class_name PlayerCharacter extends Character

var job: Job
var equipments: Equipments 

func load(character_data: Game.CharacterData):
	character_name = character_data.name

	level = character_data.level

	#Load job
	job = Job.new()
	job.load(character_data.job, character_data.jobs_level[character_data.job])
	
	load_stats()
	
	#Load equipments
	equipments = Equipments.new()
	equipments.load(character_data.equipments)


func load_from_character_resource(p_resource: CharacterResource):
	if p_resource is not PlayerCharacterResource:
		push_error("The resource type is not valid")
		pass
	
	var resource: PlayerCharacterResource = p_resource
	
	character_name	= resource.character_name
	level			= resource.level
	#texture			= resource.texture
	job				= Job.from_resource(resource.job_resource, level)
	
	load_stats()
	stats.max_health_points = p_resource.max_health_points
	stats.health_points = p_resource.current_health_points

	load_actions()
	_load_equipments(resource.equipments_resource)


func load_actions():
	actions = job.actions

func load_stats():
	stats = job.stats

func get_animation() -> SpriteFrames:
	return job.animations

func _load_equipments(p_equipments: EquipmentsResource):
	equipments.left_hand.load_from_resource(p_equipments.left_hand)
