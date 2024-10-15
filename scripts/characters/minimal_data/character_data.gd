class_name  CharacterData

var character_name: String = ""
var job_id: String = "warrior"
var equipments: EquipmentsData = EquipmentsData.new()
var level: int = 1
var max_health_points: int = 100
var current_health_points: int = 100

var magics: MagicsData = MagicsData.new()

var jobs_skill: Dictionary = {
	"onion_knight": 1,
	"warrior": 1,
	"monk": 1,
	"white_mage": 1,
	"black_mage": 1,
	"red_mage": 1,
	"thief": 1,
	"ranger": 1,
	"knight": 1,
	"scholar": 1,
	"geomancer": 1,
	"dragoon": 1,
	"viking": 1,
	"dark_knight": 1,
	"evoker": 1,
	"bard": 1,
	"black_belt": 1,
	"devout": 1,
	"magus": 1,
	"summoner": 1,
	"sage": 1,
	"ninja": 1
}

func load_character(dict: Dictionary):
	character_name = dict["name"]
	job_id = dict["job_id"]
	level = dict["level"]

	max_health_points = dict["max_health_points"]
	current_health_points = dict["current_health_points"]

	jobs_skill = dict["jobs_skill"]

	if dict.has("equipments"):
		equipments.load_equipments(dict["equipments"])
		
	if dict.has("magics"):
		magics.load_magics(dict["magics"])

func get_properties_dict():
	var properties = {
		"name": character_name,
		"job_id": job_id,
		"level": level,
		"max_health_points": max_health_points,
		"current_health_points": current_health_points,
		"equipments": {
			"left_hand": equipments.left_hand,
			"right_hand": equipments.right_hand,
			"head_armor": equipments.head_armor,
			"body_armor": equipments.body_armor,
			"arm_armor": equipments.arm_armor,
		},
		"jobs_skill": jobs_skill
	}
	
	return properties
