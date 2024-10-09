extends Node2D


func _ready() -> void:
	Game.load_save("res://scripts/save/save.json")
	Game.save_game()
