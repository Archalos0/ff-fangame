extends Node2D

var player_character = PlayerCharacter.new()
const LUNETH = preload("res://ressources/characters/luneth.tres")

func _ready() -> void:
	player_character = PlayerCharacter.from_player_character_resource(LUNETH)
	
