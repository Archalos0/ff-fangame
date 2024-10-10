class_name Stats

var health_points: int
var max_health_points: int
var magic_points: int
var max_magic_points: int
var strength: int
var agility: int
var vitality: int
var intellect: int
var mind: int
var defense: int
var magic_defense: int

static func from_dictionary(data: Dictionary) -> Stats:
	var new_stats = Stats.new()
	
	if data.has("all_stats"):
		new_stats.strength 	= data["all_stats"]
		new_stats.agility 	= data["all_stats"]
		new_stats.vitality	= data["all_stats"]
		new_stats.intellect	= data["all_stats"]
		new_stats.mind		= data["all_stats"]
	else:
		new_stats.strength 	= data.get("strength", 0)
		new_stats.agility 	= data.get("agility", 0)
		new_stats.vitality	= data.get("vitality", 0)
		new_stats.intellect	= data.get("intellect", 0)
		new_stats.mind		= data.get("mind", 0)
	
	return new_stats
