extends Node2D


func _ready() -> void:
	Game.load_save("res://scripts/save/save.json")
	var character_1: PlayerCharacter = PlayerCharacter.new()
	character_1.load(Game._player.characters.character_1)
	print("-----------" + character_1.job.job_name + "-----------")
	print(character_1.get_stats())
	
	for action in character_1.job.actions:
		print(action.to_string())
	print("------------------------------------------------------")
	
	
