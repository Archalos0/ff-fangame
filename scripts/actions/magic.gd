class_name Magic extends Action

func _init(p_name: String, p_description: String, p_cost: int, p_target_type: TARGET_TYPE, p_action_type: Array[Action.ACTION_TYPE], p_spell_power: int):
	super(p_name, p_description, p_cost, p_target_type, p_action_type, p_spell_power)
	
static func from_action_resource(p_action_resource: ActionResource):
	var magic_action: Magic = Magic.new(
		p_action_resource.action_name,
		p_action_resource.description,
		p_action_resource.cost,
		p_action_resource.target_type,
		p_action_resource.action_types,
		p_action_resource.spell_power
	)
	
	return magic_action

func calcul_power(source: Character) -> int:
	return source.stats.magic * spell_power
