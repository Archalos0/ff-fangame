class_name Battler extends Node2D

var _character_data: Character
# Character stats
@export var character_resource: CharacterResource

@export var actions: Array[Action] = []

# Character controls
@export var is_player: bool
var is_selectable: ISelectable = ISelectable.new()

# Character UI
@onready var sprite: Sprite2D = $Sprite
@onready var arrow_character_playing: Sprite2D = $arrow_character_playing
@onready var arrow_character_selection: Sprite2D = $arrow_character_selection
@onready var health_bar: ProgressBar = $healthbar

# Reference to the battle manager
@onready var turn_queue: TurnQueue = $"/root/BattleScene/TurnQueue"


func _load_from_resource(p_character_resource: CharacterResource = null):
	if p_character_resource is EnemyResource:
		_character_data = Enemy.new()
		_character_data.load_from_character_resource(p_character_resource)
	elif p_character_resource is PlayerCharacterResource:
		_character_data = PlayerCharacter.new()
		_character_data.load_from_character_resource(p_character_resource)
	
	sprite.texture = p_character_resource.texture

func _ready() -> void:
	_load_from_resource(character_resource)
	
	_place_health_bar()
	_place_selection_arrow()
	
	if not is_player:
		flip_character()
	
	health_bar.max_value = _character_data.stats.health_point
	health_bar.min_value = 0
	health_bar.value = _character_data.stats.health_point
	
	is_selectable.set_is_selectable(false)

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

func act(action: Action, targets: Array[Battler]):
	var power = action.calcul_power(_character_data)
	
	match action.damage_type:
		Action.DAMAGE_TYPE.PHYSICAL:
			for target: Battler in targets:
				target.get_hit(power - target._character_data.stats.defense)
		Action.DAMAGE_TYPE.MAGICAL:
			for target: Battler in targets:
				target.get_hit(target._character_data.stats.magic_defense)
		Action.DAMAGE_TYPE.HEALING:
			for target: Battler in targets:
				target.get_heal(power)

func get_character_name() -> String:
	return _character_data.character_name

func get_current_health_points() -> int:
	return _character_data.stats.health_point

#TODO: Add max_health_points in stats
func get_max_health_points() -> int:
	return _character_data.stats.health_point

func get_actions() -> Array[Action]:
	return _character_data.actions

#TODO: Implement the other effect of the spell
#TODO: Do I have to keep this function ?
#func receive_spell(spell: Action.Spell):
	#if spell.is_offensive == true:
		#get_hit(spell.power - stats.defense)
	#else:
		#get_heal(spell.power)

func get_hit(damage: int):
	_character_data.set_health_points(_character_data.get_health_points() - damage)
	health_bar.value = _character_data.stats.health_point

func get_heal(hp: int):
	_character_data.set_health_points(_character_data.get_health_points() + hp)
	health_bar.value = _character_data.stats.health_point

func get_focus():
	if is_selectable.get_is_selectable():
		arrow_character_selection.visible = true

func lost_focus():
	if is_selectable.get_is_selectable():
		arrow_character_selection.visible = false

func character_selected():
	if is_selectable.get_is_selectable():
		turn_queue.target_selected.emit([self])
		arrow_character_selection.visible = false
