extends Node2D

var player_character = PlayerCharacter.new()
var enemy_character = Enemy.new()

const ARC = preload("res://ressources/characters/arc.tres")
const GOBLIN = preload("res://ressources/characters/goblin.tres")

func _ready() -> void:
	player_character.load_from_character_resource(ARC)
	enemy_character.load_from_character_resource(GOBLIN)
	print(player_character)
	
