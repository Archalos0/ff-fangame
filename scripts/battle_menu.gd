class_name BattleMenu extends Control

@onready var action_selection: MenuHandler = $ActionSelection
@onready var target_selection: TargetSelectionMenu = $TargetSelection
@onready var player_character_informations: PlayerSelectionMenu = $PlayerCharacterInformations

const ACTION_BUTTON = preload("res://scenes/UI/action_button.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_filter = MOUSE_FILTER_PASS


func update_actions_buttons(actions):
	var previous_button: ActionButton = null
	
	for action: Action in actions:
		var action_button: ActionButton = ACTION_BUTTON.instantiate()
		action_button.set_action(action)
		action_selection.buttons.add_child(action_button)
		if previous_button != null:
			previous_button.focus_next = action_button.get_path()
			action_button.focus_previous = previous_button.get_path()
		previous_button = action_button

func delete_previous_action():
	for action_button: ActionButton in action_selection.buttons.get_children():
		if(action_button.action_resource != null):
			continue
		
		action_selection.buttons.remove_child(action_button)
		action_button.queue_free()

func set_focus_on_target_selection():
	target_selection.set_focus_state(true)
	action_selection.set_focus_state(false)
	player_character_informations.set_focus_state(false)
	
func select_all_enemies():
	target_selection.select_all_character()
	target_selection.set_focus_state(true)
	action_selection.set_focus_state(false)
	player_character_informations.set_focus_state(false)

func select_all_allies():
	player_character_informations.select_all_character()
	player_character_informations.set_focus_state(true)
	target_selection.set_focus_state(false)
	action_selection.set_focus_state(false)

func set_focus_on_action_selection():
	action_selection.set_focus_state(true)
	player_character_informations.set_focus_state(false)
	target_selection.set_focus_state(false)

func set_focus_on_player_character():
	player_character_informations.set_focus(true)
	target_selection.set_focus(false)
	action_selection.set_focus(false)
