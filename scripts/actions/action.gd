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
	BASIC_ATTACK,
	PHYSICAL_ATTACK,
	MAGICAL_ATTACK,
}

enum ELEMENT {
	FIRE,
	ICE,
	LIGHTNING,
	EARTH,
	WIND,
	NONE,
}

enum BUFF {
	REMOVE_POISON,
	REMOVE_SILENCE,
	REMOVE_SLEEP,
	REMOVE_BLIND,
	REMOVE_TOAD,
	REMOVE_SHRINK,
	MAGIC_BARRIER,
	DEFENSE_UP,
	RUNNING,
}

enum DEBUFF {
	POISON,
	SLEEP,
	BLIND,
	PETRIFICATION,
	PARALYSIS,
	CONFUSION,
	SILENCE,
	TOAD,
	SHRINK,
	DEFENSE_NONE
}

class Spell:
	var element: ELEMENT
	var power: int
	var buffs: Array[BUFF]
	var debuffs: Array[DEBUFF]
	var is_offensive: bool

@export var action_name: String = ""
@export var description: String = "Description"
@export var cost: int = 0
@export var target_type: TARGET_TYPE = TARGET_TYPE.SINGLE_ENEMY
@export var action_type: ACTION_TYPE

@export var spell_power: int
@export var buffs: Array[BUFF]
@export var debuffs: Array[DEBUFF]
@export var element: ELEMENT

func _init(
	p_name: String, 
	p_description: String, 
	p_cost: int, 
	p_target_type: TARGET_TYPE, 
	p_action_type: ACTION_TYPE, 
	p_spell_power: int, p_buffs: Array[Action.BUFF], 
	p_debuffs: Array[Action.DEBUFF], 
	p_element: ELEMENT):
		action_name = p_name
		description = p_description
		cost = p_cost
		target_type = p_target_type
		action_type = p_action_type
		spell_power = p_spell_power
		buffs = p_buffs
		debuffs = p_debuffs
		element = p_element

static func from_action_resource(action_resource: ActionResource) -> Action:
	var action: Action = Action.new(
		action_resource.action_name,
		action_resource.description,
		action_resource.cost,
		action_resource.target_type,
		action_resource.action_type,
		action_resource.spell_power,
		action_resource.buffs,
		action_resource.debuffs,
		action_resource.element
	)
	
	return action

func _to_string() -> String:
	return action_name + " - " + description + " - " + str(cost) + " - " + str(target_type)

func is_targeting_enemies() -> bool:
	return true if target_type == TARGET_TYPE.SINGLE_ENEMY or target_type == TARGET_TYPE.ALL_ENEMIES else false

func is_targeting_allies() -> bool:
	return true if target_type == TARGET_TYPE.SINGLE_ALLY or target_type == TARGET_TYPE.ALL_ALLIES else false

func calcul_power(source: Character):
	var spell_power = 0
	
	match action_type:
		ACTION_TYPE.BASIC_ATTACK:
			spell_power = (source.stats.strenght / 4) + 8 #+8 = temp # need to add after : + (source.skill / 4) + source.weapon.damage
		ACTION_TYPE.PHYSICAL_ATTACK:
			spell_power = source.stats.strenght * spell_power
		ACTION_TYPE.MAGICAL_ATTACK:
			spell_power = source.stats.intellect * spell_power
	
	return spell_power

#TODO: Add the element, the weapon, and additional effects
func execute(source: Character, targets: Array[Character]):
	var spell: Spell = Spell.new()
	spell.power = calcul_power(source)
	spell.buffs = buffs
	spell.debuffs = debuffs
	spell.element = element
	spell.is_offensive = true if is_targeting_enemies() else false
	
	for target: Character in targets:
		target.receive_spell(spell)
