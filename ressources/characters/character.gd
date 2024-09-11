class_name CharacterResource extends Resource

@export var character_name: String

# Character stats
@export var health_point: int
@export var magic_point: int

@export var strenght: int
@export var agility: int
@export var vitality: int
@export var intellect: int
@export var mind: int
@export var defense: int
@export var magic_defense: int

@export var actions_resources: Array[ActionResource] = []

# Character controls
@export var is_player: bool

# Character design
@export var sprite: Texture2D
