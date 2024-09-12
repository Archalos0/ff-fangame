class_name BattleMenu extends Control

@onready var action_menu: ActionMenu = $ActionSelection
@onready var target_selection: TargetSelectionMenu = $TargetSelection
@onready var player_character_informations: PlayerSelectionMenu = $PlayerCharacterInformations

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_filter = MOUSE_FILTER_PASS
	action_menu.focus_mode = Control.FOCUS_NONE
	target_selection.focus_mode = Control.FOCUS_NONE
	player_character_informations.focus_mode = Control.FOCUS_NONE

func update_actions_buttons(actions):
	var previous_button: ActionButton = null
	action_menu.load_actions(actions)

func delete_previous_action():
	action_menu.delete_actions()

func set_focus_on_target_selection():
	target_selection.set_focus_state(true)
	action_menu.set_focus_state(false)
	player_character_informations.set_focus_state(false)
	
func select_all_enemies():
	target_selection.select_all_character()
	target_selection.set_focus_state(true)
	action_menu.set_focus_state(false)
	player_character_informations.set_focus_state(false)

func select_all_allies():
	player_character_informations.select_all_character()
	player_character_informations.set_focus_state(true)
	target_selection.set_focus_state(false)
	action_menu.set_focus_state(false)

func set_focus_on_action_selection():
	action_menu.set_focus_state(true)
	player_character_informations.set_focus_state(false)
	target_selection.set_focus_state(false)

func set_focus_on_player_character():
	player_character_informations.set_focus(true)
	target_selection.set_focus(false)
	action_menu.set_focus(false)
