class_name Action extends Node

enum TARGET_TYPE {
	SINGLE_ENEMY,
	SINGLE_ALLY,
	ALL_ENEMIES,
	ALL_ALLIES,
	NONE,
	SELF,
}

@export var action_name: String = ""
@export var description: String = "Description"
@export var cost: int = 0
@export var target_type: TARGET_TYPE = TARGET_TYPE.SINGLE_ENEMY

func _init(p_name: String, p_description: String, p_cost: int, p_target_type: TARGET_TYPE):
	action_name = p_name
	description = p_description
	cost = p_cost
	target_type = p_target_type

static func from_action_resource(action_resource: ActionResource) -> Action:
	var action: Action = Action.new(
		action_resource.action_name,
		action_resource.description,
		action_resource.cost,
		action_resource.target_type
	)
	
	return action

func _to_string() -> String:
	return action_name + " - " + description + " - " + str(cost) + " - " + str(target_type)

func is_targeting_enemies() -> bool:
	return true if target_type == TARGET_TYPE.SINGLE_ENEMY or target_type == TARGET_TYPE.ALL_ENEMIES else false

func is_targeting_allies() -> bool:
	return true if target_type == TARGET_TYPE.SINGLE_ALLY or target_type == TARGET_TYPE.ALL_ALLIES else false

#TODO: EXECUTE THIS FUCKING SHIT
func execute(source: Character, target: Character):
	pass
