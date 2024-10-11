class_name Battler extends Node2D

var _character_data: Character
# Character stats

@export var actions: Array[Action] = []

# Character controls
@export var is_player: bool
var is_selectable: ISelectable = ISelectable.new()

# Character UI
#@onready var sprite: Sprite2D = $Sprite
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var arrow_character_playing: Sprite2D = $arrow_character_playing
@onready var arrow_character_selection: Sprite2D = $arrow_character_selection
@onready var health_bar: ProgressBar = $healthbar

# Reference to the battle manager
@onready var turn_queue: TurnQueue = $"/root/BattleScene/TurnQueue"

func load_battler(p_character_data: Game.CharacterData, p_is_player: bool):
	_character_data = PlayerCharacter.new()
	_character_data.load(p_character_data)
	
	name = _character_data.character_name
	is_player = p_is_player

func load_monster(monster_data: Monster):
	_character_data = monster_data
	name = _character_data.character_name
	is_player = false

func _ready() -> void:	
	animated_sprite_2d.sprite_frames = _character_data.get_sprite_frames()
	
	_place_health_bar()
	_place_selection_arrow()
	
	if is_player:
		flip_character()
	
	health_bar.max_value = _character_data.get_stats()["max_health_points"]
	health_bar.min_value = 0
	health_bar.value = _character_data.get_stats()["current_health_points"]
	
	is_selectable.set_is_selectable(false)

func _place_health_bar():
	var sprite_size = 32 #animated_sprite_2d.texture.get_width()
	if is_player:
		health_bar.position.x = (sprite_size / 2) + 10
	else:
		health_bar.position.x = -(sprite_size / 2 + health_bar.size.x + 10)

func _place_selection_arrow():
	var sprite_size = 32 #animated_sprite_2d.texture.get_width()
	var arrow_sprite_size = arrow_character_selection.texture.get_width() * arrow_character_selection.scale.x
	if is_player:
		arrow_character_selection.position.x = -(sprite_size / 2) - arrow_sprite_size + 10
	else:
		arrow_character_selection.position.x = (sprite_size / 2 + arrow_sprite_size) - 10

func flip_character():
	animated_sprite_2d.flip_h = true
	arrow_character_selection.flip_v = false

func initialize_turn():
	arrow_character_playing.visible = true

func end_turn():
	arrow_character_playing.visible = false

func act(action: Action, targets: Array[Battler]):
	#var power = action.calcul_power(_character_data)
	#
	#match action.damage_type:
		#Action.DAMAGE_TYPE.PHYSICAL:
			#for target: Battler in targets:
				#target.get_hit(power - target._character_data.stats.defense)
		#Action.DAMAGE_TYPE.MAGICAL:
			#for target: Battler in targets:
				#target.get_hit(target._character_data.stats.magic_defense)
		#Action.DAMAGE_TYPE.HEALING:
			#for target: Battler in targets:
				#target.get_heal(power)
	pass

func get_character_name() -> String:
	return "" #_character_data.character_name

func get_current_health_points() -> int:
	return _character_data.stats.current_health_points

#TODO: Add max_health_points in stats
func get_max_health_points() -> int:
	return _character_data.stats.max_health_points

func get_actions() -> Array[Action]:
	return _character_data.get_actions()

#TODO: Implement the other effect of the spell
#TODO: Do I have to keep this function ?
#func receive_spell(spell: Action.Spell):
	#if spell.is_offensive == true:
		#get_hit(spell.power - stats.defense)
	#else:
		#get_heal(spell.power)

func get_hit(damage: int):
	_character_data.set_health_points(_character_data.get_health_points() - damage)
	health_bar.value = _character_data.stats.health_points

func get_heal(hp: int):
	_character_data.set_health_points(_character_data.get_health_points() + hp)
	health_bar.value = _character_data.stats.health_points

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
