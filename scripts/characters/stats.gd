class_name Stats

var health_points: int = 0
var max_health_points: int = 0

# Equipment stats
var magic_points: int = 0
var max_magic_points: int = 0
var defense: int = 0
var magic_defense: int = 0

# Job stats
var strength: int = 0
var agility: int = 0
var vitality: int = 0
var intellect: int = 0
var mind: int = 0

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
