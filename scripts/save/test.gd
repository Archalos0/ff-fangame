extends Node2D


func _ready() -> void:
	Game.load_save("res://scripts/save/save.json")
	Game.add_character({ "name": "Refia", "job": "White Mage", "equipments": { "left_hand": "rod_002"}})
	Game.save_game()
