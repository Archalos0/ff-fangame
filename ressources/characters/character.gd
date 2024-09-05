class_name CharacterResource extends Resource

@export var character_name: String

# Character stats
@export var health: int
@export var magic_point: int
@export var strenght: int
@export var magic: int
@export var defense: int
@export var magic_defense: int
@export var agility: int
@export var accuracy: int
@export var evasion: int
@export var luck: int

@export var actions_resources: Array[ActionResource] = []

# Character controls
@export var is_player: bool
@export var is_selectable: bool = false

# Character design
@export var sprite: Texture2D
