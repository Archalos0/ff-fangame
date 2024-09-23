class_name PlayerCharacter extends Character

var job: Job
#var equipments: Equipments 

func load_from_character_resource(p_resource: CharacterResource):
	if p_resource is not PlayerCharacterResource:
		push_error("The resource type is not valid")
		pass
	
	var resource: PlayerCharacterResource = p_resource
	
	character_name	= resource.character_name
	level			= resource.level
	texture			= resource.texture
	job				= Job.from_resource(resource.job_resource, level)
	load_stats()
	load_actions()


func load_actions():
	actions = job.actions

func load_stats():
	stats = job.stats
	stats.health_points = 100
