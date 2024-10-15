class_name EquipmentsData

var left_hand_id	: String = ""
var right_hand_id	: String = ""
var head_armor_id	: String = ""
var body_armor_id	: String = ""
var arm_armor_id	: String = ""

func load_equipments(dict: Dictionary):
	for key in dict:
		if dict[key] == null:
			continue
		
		match key:
			"left_hand": left_hand_id = dict["left_hand"]
			"right_hand": right_hand_id = dict["right_hand"]
			"head_armor": head_armor_id = dict["head_armor"]
			"body_armor": body_armor_id = dict["body_armor"]
			"arm_armor": arm_armor_id = dict["arm_armor"]
