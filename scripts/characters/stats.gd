class_name Stats

var current_health_points: int = 0
var max_health_points: int = 0

var strength: int = 0
var agility: int = 0
var vitality: int = 0
var intellect: int = 0
var mind: int = 0

var attack: int
var defense: int
var magic_defense: int
var evade: int

var number_of_hits: int
var crit_chance: float
var physical_damage: int
var black_magic_damage: int
var white_magic_recovery: int
var summon_damage: int
var monk_attack_power: int
var job_mastery_item: bool

func load_character_stats(data: Dictionary):
	if data.has("all_stats"):
		strength 	= data["all_stats"]
		agility 	= data["all_stats"]
		vitality	= data["all_stats"]
		intellect	= data["all_stats"]
		mind		= data["all_stats"]
	else:
		strength 	= data.get("strength", 0)
		agility 	= data.get("agility", 0)
		vitality	= data.get("vitality", 0)
		intellect	= data.get("intellect", 0)
		mind		= data.get("mind", 0)

func get_properties_dict():
	return {
		"max_health_points": max_health_points,
		"current_health_points": current_health_points,
		"strength": strength,
		"agility": agility,
		"vitality": vitality,
		"intellect": intellect,
		"mind": mind
	}
