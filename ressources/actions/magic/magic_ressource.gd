class_name MagicResource extends ActionResource

@export var action_type: Array[Action.ACTION_TYPE]

func _init(p_name: String = "", p_description: String = "", p_cost: int = 0, p_target_type: Action.TARGET_TYPE = Action.TARGET_TYPE.NONE, p_action_type: Array[Action.ACTION_TYPE] = []):
	super(p_name, p_description, p_cost, p_target_type)
	action_type = p_action_type
