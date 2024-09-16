class_name Character

var character_name: String
var texture: Texture2D
var level: int

var stats: Stats
var actions: Array[Action]

var character_resource: CharacterResource

func load_from_character_resource(p_resource: CharacterResource):
	push_error("The method from_character_resource() has not been implementing in the derived class")

func get_health_points() -> int:
	return stats.health_point

func set_health_points(hp: int):
	stats.health_point = hp
