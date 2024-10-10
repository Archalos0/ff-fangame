class_name Enemy extends Character

var gils: int
var experience: int

func load_from_character_resource(p_resource: CharacterResource):
	if p_resource is not EnemyResource:
		push_error("The resource type is not valid")
		pass
	
	var resource: EnemyResource = p_resource
	
	character_name	= resource.character_name
	level			= resource.level
	#texture			= resource.texture
	gils			= resource.gils
	experience		= resource.experience
	
	load_stats(resource.stats)
	load_actions(resource.actions_resources)
	

func load_actions(p_actions_resource: Array[ActionResource]):
	for action_resource: ActionResource in p_actions_resource:
		actions.append(Action.from_action_resource(action_resource))

func load_stats(p_stats: Dictionary):
	#stats = Stats.from_dictionary(p_stats)
	pass
