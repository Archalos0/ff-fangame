class_name Character

var character_name: String
var sprite: Sprite2D
var level: int

var stats: Stats
var actions: Array[Action]

func load_actions():
	push_error("The method load_actions() has not been implementing in the derived class")

func load_stats():
	push_error("The method load_stats() has not been implementing in the derived class")
