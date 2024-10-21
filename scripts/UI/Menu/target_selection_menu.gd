class_name TargetsMenu extends Panel

signal targets_selected(targets: Array[Battler])

const TARGET_BUTTON = preload("res://scenes/UI/target_button.tscn")

enum MODE_SELECTION {
	SINGLE,
	MULTIPLE,
}

@onready var buttons: VBoxContainer = $Buttons

var _has_focus: bool = false
var _authorize_multiple_selection: bool = false
var _current_mode_selection: MODE_SELECTION = MODE_SELECTION.SINGLE 

func set_focus_state(p_focus_state: bool, p_authorize_multiple_selection: bool = false):
	_has_focus = p_focus_state
	_authorize_multiple_selection = p_authorize_multiple_selection
	
	if not _has_focus:
		focus_mode = Control.FOCUS_NONE
		buttons.focus_mode = Control.FOCUS_NONE
		for target_button in buttons.get_children():
			target_button.focus_mode = Control.FOCUS_NONE
			
		return
	
	focus_mode = Control.FOCUS_NONE
	buttons.focus_mode = Control.FOCUS_NONE
	for target_button in buttons.get_children():
			target_button.focus_mode = Control.FOCUS_ALL
	
	buttons.get_child(0).grab_focus()

func load_characters(p_enemies: Array[Battler]) -> void:
	for enemy in p_enemies:
		var target_button = TARGET_BUTTON.instantiate()
		target_button.set_character(enemy)
		buttons.add_child(target_button)
		target_button.target_button_selected.connect(Callable(self, "_on_target_selected"))

func _on_target_selected(target: Battler) -> void:
	var arr: Array[Battler] = []
	arr.append(target)
	targets_selected.emit(arr)
