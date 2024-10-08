class_name BattleMenu extends Control

signal action_selected(action: Action)
signal characters_selected(charcters: Array[Character])

@onready var action_menu: ActionMenu = $ActionSelection
@onready var target_menu: TargetSelectionMenu = $TargetSelection
@onready var player_character_menu: PlayerSelectionMenu = $PlayerCharacterInformations

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_filter = MOUSE_FILTER_PASS
	action_menu.focus_mode = Control.FOCUS_NONE
	target_menu.focus_mode = Control.FOCUS_NONE
	player_character_menu.focus_mode = Control.FOCUS_NONE
	
	action_menu.action_selected.connect(Callable(self, "_on_action_selected"))
	target_menu.characters_selected.connect(Callable(self, "_on_characters_selected"))
	player_character_menu.characters_selected.connect(Callable(self, "_on_characters_selected"))
	
func _on_action_selected(action: Action):
	action_selected.emit(action)

func _on_characters_selected(characters: Array[Character]):
	characters_selected.emit(characters)

func update_actions_buttons(actions):
	action_menu.load_actions(actions)

func delete_previous_action():
	action_menu.delete_actions()

func set_focus_on_target_selection():
	target_menu.set_focus_state(true)
	action_menu.set_focus_state(false)
	player_character_menu.set_focus_state(false)
	
func select_all_enemies():
	target_menu.set_are_all_selected(true)
	target_menu.set_focus_state(true)
	action_menu.set_focus_state(false)
	player_character_menu.set_focus_state(false)

func select_all_allies():
	player_character_menu.set_are_all_selected(true)
	player_character_menu.set_focus_state(true)
	target_menu.set_focus_state(false)
	action_menu.set_focus_state(false)

func set_focus_on_action_selection():
	action_menu.set_focus_state(true)
	player_character_menu.set_focus_state(false)
	target_menu.set_focus_state(false)

func set_focus_on_player_character():
	player_character_menu.set_focus_state(true)
	target_menu.set_focus_state(false)
	action_menu.set_focus_state(false)
