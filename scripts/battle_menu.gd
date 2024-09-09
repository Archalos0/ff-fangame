class_name BattleMenu extends Control

@onready var attack_button: ActionButton = $ActionSelection/VBoxContainer/AttackButton
@onready var defend_button: ActionButton = $ActionSelection/VBoxContainer/DefendButton
@onready var escape_button: ActionButton = $ActionSelection/VBoxContainer/EscapeButton
@onready var heal_button: ActionButton = $ActionSelection/VBoxContainer/HealButton

@onready var action_selection: MenuHandler = $ActionSelection
@onready var target_selection: MenuHandler = $TargetSelection
@onready var player_character_informations: PlayerSelectionMenu = $PlayerCharacterInformations


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_filter = MOUSE_FILTER_PASS 

func update_actions_buttons(actions: Array[Action]):
	attack_button.set_action(actions[0])
	defend_button.set_action(actions[1])
	escape_button.set_action(actions[2])
	heal_button.set_action(actions[3])

func set_focus_on_target_selection():
	target_selection.get_focus()
	action_selection.lost_focus()
	player_character_informations.lost_focus()
	
func set_focus_on_action_selection():
	action_selection.get_focus()
	target_selection.lost_focus()
	player_character_informations.lost_focus()	

func set_focus_on_player_character():
	player_character_informations.get_focus()
	target_selection.lost_focus()
	action_selection.lost_focus()
