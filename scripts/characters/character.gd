class_name Character

var character_name: String
#var texture: Texture2D
var level: int

var stats: Stats
var actions: Array[Action]

var character_resource: CharacterResource

func load_from_character_resource(p_resource: CharacterResource):
	push_error("The method from_character_resource() has not been implementing in the derived class")

func get_health_points() -> int:
	return stats.health_points

func set_health_points(hp: int):
	stats.health_points = hp

func get_animation():
	push_error("The method get_animation() has not been implementing in the derived class")

func get_stats() -> Dictionary:
	push_error("The method get_stats() has not been implementing in the derived class")
	return {}
	
func get_actions() -> Array[Action]:
	push_error("The method get_actions() has not been implementing in the derived class")
	return []
