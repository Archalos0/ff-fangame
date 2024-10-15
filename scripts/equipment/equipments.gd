class_name Equipments

var left_hand: EquipableItem = EquipableItem.new()
var right_hand: EquipableItem = EquipableItem.new()
var head_armor: EquipableItem = EquipableItem.new()
var body_armor: EquipableItem = EquipableItem.new()
var arm_armor: EquipableItem = EquipableItem.new()

func load(equipments_data: EquipmentsData):
	left_hand.load(equipments_data.left_hand_id)
	right_hand.load(equipments_data.right_hand_id)
	head_armor.load(equipments_data.head_armor_id)
	body_armor.load(equipments_data.body_armor_id)
	arm_armor.load(equipments_data.arm_armor_id)

func get_stats() -> Dictionary:
	var stats: Dictionary = {
		"strength": 0,
		"agility": 0,
		"vitality": 0,
		"intellect": 0,
		"mind": 0,
		"attack": 0,
		"defense": 0,
		"magic_defense": 0,
		"evade": 0,
	}

	stats["strength"] += left_hand.stats_upgraded.strength + right_hand.stats_upgraded.strength + head_armor.stats_upgraded.strength + body_armor.stats_upgraded.strength + arm_armor.stats_upgraded.strength
	stats["agility"] += left_hand.stats_upgraded.agility + right_hand.stats_upgraded.agility + head_armor.stats_upgraded.agility + body_armor.stats_upgraded.agility + arm_armor.stats_upgraded.agility
	stats["vitality"] += left_hand.stats_upgraded.vitality + right_hand.stats_upgraded.vitality + head_armor.stats_upgraded.vitality + body_armor.stats_upgraded.vitality + arm_armor.stats_upgraded.vitality
	stats["intellect"] += left_hand.stats_upgraded.intellect + right_hand.stats_upgraded.intellect + head_armor.stats_upgraded.intellect + body_armor.stats_upgraded.intellect + arm_armor.stats_upgraded.intellect
	stats["mind"] += left_hand.stats_upgraded.mind + right_hand.stats_upgraded.mind + head_armor.stats_upgraded.mind + body_armor.stats_upgraded.mind + arm_armor.stats_upgraded.mind

	stats["attack"] += left_hand.attack_modifier + right_hand.attack_modifier + head_armor.attack_modifier + body_armor.attack_modifier + arm_armor.attack_modifier
	stats["defense"] += left_hand.defense_modifier + right_hand.defense_modifier + head_armor.defense_modifier + body_armor.defense_modifier + arm_armor.defense_modifier
	stats["magic_defense"] += left_hand.magic_defense_modifier + right_hand.magic_defense_modifier + head_armor.magic_defense_modifier + body_armor.magic_defense_modifier + arm_armor.magic_defense_modifier
	stats["evade"] += left_hand.evade_modifier + right_hand.evade_modifier + head_armor.evade_modifier + body_armor.evade_modifier + arm_armor.evade_modifier
	
	return stats
