class_name Character extends Node2D

@export var character_name: String

# Character stats
@export var character_resource: CharacterResource
@export var stats: Stats

@export var actions: Array[Action] = []

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
	
	stats.health_point	= p_character_resource.health_point
	stats.magic_point	= p_character_resource.magic_point
	stats.strenght		= p_character_resource.strenght
	stats.agility		= p_character_resource.agility
	stats.vitality		= p_character_resource.vitality
	stats.intellect		= p_character_resource.intellect
	stats.mind			= p_character_resource.mind
	
	#actions.append(Action.new("Attack", "Attack an  enemy", 0, Action.TARGET_TYPE.SINGLE_ENEMY, Action.ACTION_TYPE.BASIC_ATTACK, 1, [], [], Action.ELEMENT.NONE))
	#actions.append(Action.new("Run Away", "Try to run away from the battle", 0, Action.TARGET_TYPE.SELF, Action.ACTION_TYPE.PHYSICAL_ATTACK, 0, [Action.BUFF.RUNNING], [Action.DEBUFF.DEFENSE_NONE], Action.ELEMENT.NONE))
	for action_resource in p_character_resource.actions_resources:
		actions.append(Action.from_action_resource(action_resource))
	
	sprite.texture = p_character_resource.sprite

func _ready() -> void:
	_load_from_resource(character_resource)
	
	_place_health_bar()
	_place_selection_arrow()
	
	if not is_player:
		flip_character()
	
	health_bar.max_value = stats.health_point
	health_bar.min_value = 0
	health_bar.value = stats.health_point

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
	action.execute(self, targets)

#TODO: Implement the other effect of the spell
#TODO: Do I have to keep this function ?
#func receive_spell(spell: Action.Spell):
	#if spell.is_offensive == true:
		#get_hit(spell.power - stats.defense)
	#else:
		#get_heal(spell.power)

func get_hit(damage: int):
	stats.health_point -= damage
	health_bar.value = stats.health_point

func get_heal(hp: int):
	stats.health_point += hp
	health_bar.value = stats.health_point
	
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
		turn_queue.target_selected.emit([self])
		arrow_character_selection.visible = false
