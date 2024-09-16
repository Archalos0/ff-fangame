class_name Stats

@export var health_point: int
@export var magic_point: int

@export var strength: int
@export var agility: int
@export var vitality: int
@export var intellect: int
@export var mind: int
@export var defense: int
@export var magic_defense: int

func _init():
	strength 		= 5
	agility 		= 5
	vitality 		= 5
	intellect 		= 5
	mind 			= 5
	defense 		= 5
	magic_defense 	= 5

static func from_dictionary(data: Dictionary) -> Stats:
	var new_stats = Stats.new()
	
	new_stats.strength 	= data.strength
	new_stats.agility 	= data.agility
	new_stats.vitality	= data.vitality
	new_stats.intellect	= data.intellect
	new_stats.mind		= data.mind
	
	return new_stats
