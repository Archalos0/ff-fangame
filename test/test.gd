extends Node2D

var player_character = PlayerCharacter.new()

const ARC = preload("res://ressources/characters/arc.tres")
func _ready() -> void:
	player_character.load_from_character_resource(ARC)
	print(player_character)
	
