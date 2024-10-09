class_name PlayerCharacter extends Character

var job: Job
var equipments: Equipments 

func load_character_data(dict: Dictionary) -> void:
	#{
		#"name": "Luneth",
		#"job": "Warrior",
		#"equipments": {
			#"left_hand": "sword_002",
			#"right_hand": "shield_001",
			#"head_armor": "head_armor_006",
			#"body_armor": "body_armor_001",
			#"arm_armor": ""
		#}
	#},
	
	character_name = dict["name"]

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
