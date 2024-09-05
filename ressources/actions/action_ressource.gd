class_name ActionResource extends Resource

@export var action_name: String
@export var description: String
@export var cost: int = 0
@export var target_type: Action.TARGET_TYPE

func _init(p_name: String = "", p_description: String = "", p_cost: int = 0, p_target_type: Action.TARGET_TYPE = Action.TARGET_TYPE.NONE):
	action_name = p_name
	description = p_description
	cost = p_cost
	target_type = p_target_type
