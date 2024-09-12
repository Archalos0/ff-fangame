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

enum DAMAGE_TYPE {
	NONE,
	PHYSICAL,
	MAGICAL,
	HEALING,
}

@export var action_name: String = ""
@export var description: String = "Description"
@export var cost: int = 0
@export var target_type: TARGET_TYPE = TARGET_TYPE.SINGLE_ENEMY
#@export var action_type: ACTION_TYPE

@export var spell_power: int
@export var damage_type: DAMAGE_TYPE
@export var buffs: Array[BUFF]
@export var debuffs: Array[DEBUFF]
@export var element: ELEMENT

func _init(
	p_name: String, 
	p_description: String, 
	p_cost: int, 
	p_target_type: TARGET_TYPE, 
	#p_action_type: ACTION_TYPE, 
	p_spell_power: int, p_buffs: Array[Action.BUFF], 
	p_debuffs: Array[Action.DEBUFF], 
	p_element: ELEMENT,
	p_damage_type: DAMAGE_TYPE):
		action_name = p_name
		description = p_description
		cost = p_cost
		target_type = p_target_type
		#action_type = p_action_type
		spell_power = p_spell_power
		buffs = p_buffs
		debuffs = p_debuffs
		element = p_element
		damage_type = p_damage_type

static func from_action_resource(action_resource: ActionResource) -> Action:
	var action: Action = Action.new(
		action_resource.action_name,
		action_resource.description,
		action_resource.cost,
		action_resource.target_type,
		#action_resource.action_type,
		action_resource.spell_power,
		action_resource.buffs,
		action_resource.debuffs,
		action_resource.element,
		action_resource.damage_type
	)
	
	return action

func _to_string() -> String:
	return action_name + " - " + description + " - " + str(cost) + " - " + str(target_type)

func is_targeting_enemies() -> bool:
	return true if target_type == TARGET_TYPE.SINGLE_ENEMY or target_type == TARGET_TYPE.ALL_ENEMIES else false

func is_targeting_allies() -> bool:
	return true if target_type == TARGET_TYPE.SINGLE_ALLY or target_type == TARGET_TYPE.ALL_ALLIES else false

func calcul_power(source: Character):
	var power = 0
	
	match damage_type:
		DAMAGE_TYPE.PHYSICAL:
			power = (source.stats.strenght / 4) + 8
		DAMAGE_TYPE.MAGICAL:
			power = source.stats.intellect * spell_power / 4
		DAMAGE_TYPE.HEALING:
			power = source.stats.mind * spell_power
		_:
			power = 0
	
	return power

#TODO: Add the element, the weapon, and additional effects
func execute(source: Character, targets: Array[Character]):
	var power = calcul_power(source)
	
	match damage_type:
		DAMAGE_TYPE.PHYSICAL:
			for target: Character in targets:
				target.get_hit(power - target.stats.defense)
		DAMAGE_TYPE.MAGICAL:
			for target: Character in targets:
				target.get_hit(power - target.stats.magic_defense)
		DAMAGE_TYPE.HEALING:
			for target: Character in targets:
				target.get_heal(power)
