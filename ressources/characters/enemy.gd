class_name EnemyResource extends CharacterResource

@export var gils: int = 0
@export var experience: int = 0
@export var actions_resources: Array[ActionResource]

@export var stats: Dictionary = {
	"strength": 0,
	"agility": 0,
	"vitality": 0,
	"intellect": 0,
	"mind": 0
}

#@export var character_name: String
#
## Character stats
#@export var health_point: int
#@export var magic_point: int
#
#@export var strenght: int
#@export var agility: int
#@export var vitality: int
#@export var intellect: int
#@export var mind: int
#@export var defense: int
#@export var magic_defense: int
#
#@export var actions_resources: Array[ActionResource] = []
#
## Character controls
#@export var is_player: bool
#
## Character design
#@export var sprite: Texture2D
