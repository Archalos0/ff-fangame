class_name Character extends Node2D

@export var character_name: String

# Character stats
@export var character_resource: CharacterResource
@export var stats: Stats

@export var actions: Array[Action] = []
@export var actions_resources: Array[ActionResource] = []

# Character controls
@export var is_player: bool
@export var is_selectable: bool = false

# Character UI
@onready var sprite: Sprite2D = $Sprite
@onready var arrow_character_playing: Sprite2D = $arrow_character_playing
@onready var arrow_character_selection: Sprite2D = $arrow_character_selection
@onready var health_bar: ProgressBar = $healthbar

# Reference to the battle manager
@onready var turn_queue: TurnQueue = $"/root/BattleScene/TurnQueue"


func _load_from_resource(p_character_resource: CharacterResource = null):
	character_name = p_character_resource.character_name
	
	stats = Stats.new()
	
	stats.health		= p_character_resource.health
	stats.magic_point	= p_character_resource.magic_point
	stats.strenght		= p_character_resource.strenght
	stats.magic			= p_character_resource.magic
	stats.defense		= p_character_resource.defense
	stats.magic_defense	= p_character_resource.magic_defense
	stats.agility		= p_character_resource.agility
	stats.accuracy		= p_character_resource.accuracy
	stats.evasion		= p_character_resource.evasion
	stats.luck			= p_character_resource.luck
	
	for action_resource in p_character_resource.actions_resources:
		actions.append(Action.from_action_resource(action_resource))
	
	sprite.texture = p_character_resource.sprite

func _ready() -> void:
	_load_from_resource(character_resource)
	
	_place_health_bar()
	_place_selection_arrow()
	
	if not is_player:
		flip_character()
	
	health_bar.max_value = stats.health
	health_bar.min_value = 0
	health_bar.value = stats.health

func _place_health_bar():
	var sprite_size = sprite.texture.get_width()
	if is_player:
		health_bar.position.x = (sprite_size / 2) + 10
	else:
		health_bar.position.x = -(sprite_size / 2 + health_bar.size.x + 10)

func _place_selection_arrow():
	var sprite_size = sprite.texture.get_width()
	var arrow_sprite_size = arrow_character_selection.texture.get_width() * arrow_character_selection.scale.x
	if is_player:
		arrow_character_selection.position.x = -(sprite_size / 2) - arrow_sprite_size + 10
	else:
		arrow_character_selection.position.x = (sprite_size / 2 + arrow_sprite_size) - 10

func flip_character():
	sprite.flip_h = true
	arrow_character_selection.flip_v = false

func initialize_turn():
	arrow_character_playing.visible = true

func end_turn():
	arrow_character_playing.visible = false
	

func act(action: Action, targets: Array[Character]):
	match action.target_type:
		Action.TARGET_TYPE.SINGLE_ALLY:
			print("single ally")
			
		Action.TARGET_TYPE.ALL_ALLIES:
			print("all allies")
			
		Action.TARGET_TYPE.SINGLE_ENEMY:
			targets[0].get_hit(stats.strenght)
			
		Action.TARGET_TYPE.ALL_ENEMIES:
			for target in targets:
				target.get_hit(stats.strenght)
			
		Action.TARGET_TYPE.NONE:
			print("None")
			
		Action.TARGET_TYPE.SELF:
			print("self")

func attack(target: Character):
	print(name + " is attacking " + target.name)

func defend():
	print(name + " is defending")

func escape():
	print(name + " is escaping")

func play():
	print(name + " is playing")

func get_hit(damage: int):
	stats.health -= damage
	health_bar.value = stats.health

func _on_mouse_entered() -> void:
	get_focus()

func get_focus():
	if is_selectable:
		arrow_character_selection.visible = true

func _on_mouse_exited() -> void:
	lost_focus()

func lost_focus():
	if is_selectable:
		arrow_character_selection.visible = false

func _unhandled_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_pressed():
		character_selected()

func character_selected():
	if is_selectable:
		turn_queue.target_selected.emit(self)
		arrow_character_selection.visible = false
