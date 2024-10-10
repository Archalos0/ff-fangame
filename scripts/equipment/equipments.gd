class_name Equipments

var left_hand: Equipment = Equipment.new()
var right_hand: Equipment = Equipment.new()
var head_armor: Armor = Armor.new()
var body_armor: Armor = Armor.new()
var arm_armor: Armor = Armor.new()

func load(equipments_data: Game.EquipmentsData):
	left_hand.load(equipments_data.left_hand)
	right_hand.load(equipments_data.right_hand)
	head_armor.load(equipments_data.head_armor)
	body_armor.load(equipments_data.body_armor)
	arm_armor.load(equipments_data.arm_armor)
