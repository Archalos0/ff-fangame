class_name ActionResource extends Resource

@export var action_class: Action.ACTION_CLASS

@export var action_name: String
@export var description: String
@export var cost: int = 0
@export var target_type: Action.TARGET_TYPE
@export var action_type: Action.ACTION_TYPE
@export var spell_power: int
@export var buffs: Array[Action.BUFF]
@export var debuffs: Array[Action.DEBUFF]
@export var element: Action.ELEMENT

func _init(p_name: String = "", p_description: String = "", p_cost: int = 0, p_target_type: Action.TARGET_TYPE = Action.TARGET_TYPE.NONE, p_action_type: Action.ACTION_TYPE = Action.ACTION_TYPE.PHYSICAL_ATTACK, p_action_class: Action.ACTION_CLASS = Action.ACTION_CLASS.PHYSICAL, p_spell_power: int = 0, p_buffs: Array[Action.BUFF] = [], p_debuffs: Array[Action.DEBUFF] = [], p_element: Action.ELEMENT = Action.ELEMENT.NONE):
	action_name = p_name
	description = p_description
	cost = p_cost
	target_type = p_target_type
	action_type = p_action_type
	action_class = p_action_class
	spell_power = p_spell_power
	buffs = p_buffs
	debuffs = p_debuffs
	element = p_element
