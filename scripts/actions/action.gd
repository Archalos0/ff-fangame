class_name Action extends Node

enum TARGET_TYPE {
	SINGLE_ENEMY,
	SINGLE_ALLY,
	ALL_ENEMIES,
	ALL_ALLIES,
	NONE,
	SELF,
}

enum ACTION_CLASS {
	PHYSICAL,
	WHITE_MAGIC,
	BLACK_MAGIC,
}

enum ACTION_TYPE {
	DAMAGE,
	HEAL,
	AFFLICTION,
	ABSORB,
}

enum ELEMENT {
	FIRE,
	ICE,
	LIGHTNING,
	EARTH,
	WIND,
}

enum AFFLICTION {
	POISON,
	SLEEP,
	BLIND,
	PETRIFICATION,
	PARALYSIS,
	CONFUSION,
	SILENCE,
}

class Spell:
	var element: ELEMENT
	var power: int
	var affliction: Array[AFFLICTION]
	var is_offensive: bool

@export var action_name: String = ""
@export var description: String = "Description"
@export var cost: int = 0
@export var target_type: TARGET_TYPE = TARGET_TYPE.SINGLE_ENEMY
@export var action_types: Array[Action.ACTION_TYPE]
@export var spell_power: int

func _init(p_name: String, p_description: String, p_cost: int, p_target_type: TARGET_TYPE, p_action_types: Array[ACTION_TYPE], p_spell_power: int):
	action_name = p_name
	description = p_description
	cost = p_cost
	target_type = p_target_type
	action_types = p_action_types
	spell_power = p_spell_power

static func from_action_resource(action_resource: ActionResource) -> Action:
	var action: Action = Action.new(
		action_resource.action_name,
		action_resource.description,
		action_resource.cost,
		action_resource.target_type,
		action_resource.action_types,
		action_resource.spell_power
	)
	
	return action

func _to_string() -> String:
	return action_name + " - " + description + " - " + str(cost) + " - " + str(target_type)

func is_targeting_enemies() -> bool:
	return true if target_type == TARGET_TYPE.SINGLE_ENEMY or target_type == TARGET_TYPE.ALL_ENEMIES else false

func is_targeting_allies() -> bool:
	return true if target_type == TARGET_TYPE.SINGLE_ALLY or target_type == TARGET_TYPE.ALL_ALLIES else false

func calcul_power(source: Character):
	push_error("La méthode 'calcul_power' doit être redéfinie dans une sous-classe de 'Action'.")

#TODO: Add the element, the weapon, and additional effects
func execute(source: Character, targets: Array[Character]):
	var spell: Spell = Spell.new()
	spell.power = calcul_power(source)
	spell.is_offensive = true if is_targeting_enemies() else false
	
	for target: Character in targets:
		target.receive_spell(spell)
