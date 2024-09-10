class_name BattleMenu extends Control

@onready var action_selection: MenuHandler = $ActionSelection
@onready var target_selection: TargetSelectionMenu = $TargetSelection
@onready var player_character_informations: PlayerSelectionMenu = $PlayerCharacterInformations

const ACTION_BUTTON = preload("res://scenes/UI/action_button.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_filter = MOUSE_FILTER_PASS


func update_actions_buttons(actions):
	
	for action: Action in actions:
		var action_button: ActionButton = ACTION_BUTTON.instantiate()
		action_button.set_action(action)
		action_selection.buttons.add_child(action_button)

func delete_previous_action():
	for action_button: ActionButton in action_selection.buttons.get_children():
		if(action_button.action_resource != null):
			continue
		
		action_selection.buttons.remove_child(action_button)
		action_button.queue_free()

func set_focus_on_target_selection():
	target_selection.get_focus()
	action_selection.lost_focus()
	player_character_informations.lost_focus()
	
func select_all_enemies():
	set_focus_on_target_selection()
	target_selection.select_all()
	
func set_focus_on_action_selection():
	action_selection.get_focus()
	target_selection.lost_focus()
	player_character_informations.lost_focus()	

func set_focus_on_player_character():
	player_character_informations.get_focus()
	target_selection.lost_focus()
	action_selection.lost_focus()
