extends Node2D


func _ready() -> void:
	Game.load_save("res://scripts/save/save.json")
	Game.add_character({ "name": "Refia", "job": "White Mage"})
	Game.save_game()
