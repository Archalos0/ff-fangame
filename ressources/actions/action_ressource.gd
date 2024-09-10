class_name ActionResource extends Resource

@export var action_class: Action.ACTION_CLASS

@export var action_name: String
@export var description: String
@export var cost: int = 0
@export var target_type: Action.TARGET_TYPE
@export var action_types: Array[Action.ACTION_TYPE]
@export var spell_power: int

func _init(p_name: String = "", p_description: String = "", p_cost: int = 0, p_target_type: Action.TARGET_TYPE = Action.TARGET_TYPE.NONE, p_action_types: Array[Action.ACTION_TYPE] = [], p_action_class: Action.ACTION_CLASS = Action.ACTION_CLASS.PHYSICAL, p_spell_power: int = 0):
	action_name = p_name
	description = p_description
	cost = p_cost
	target_type = p_target_type
	action_types = p_action_types
	action_class = p_action_class
	spell_power = p_spell_power
