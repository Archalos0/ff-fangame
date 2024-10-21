class_name PlayerSelectionMenu extends Panel

signal characters_selected(characters: Array[Battler])

@onready var character_1: PlayerCharacterButton = $Buttons/Character1
@onready var character_2: PlayerCharacterButton = $Buttons/Character2
@onready var character_3: PlayerCharacterButton = $Buttons/Character3
@onready var character_4: PlayerCharacterButton = $Buttons/Character4

@onready var buttons: VBoxContainer = $Buttons

enum MODE_SELECTION {
	SINGLE,
	MULTIPLE,
}

var _has_focus: bool = false
var _authorize_multiple_selection: bool = false
var _current_mode_selection: MODE_SELECTION = MODE_SELECTION.SINGLE 

func load_characters(p_player_characters: Array[Battler]) -> void:
	character_1.set_character(p_player_characters[0])
	character_2.set_character(p_player_characters[1])
	character_3.set_character(p_player_characters[2])
	character_4.set_character(p_player_characters[3])
	
func set_focus_state(p_focus_state: bool, p_authorize_multiple_selection: bool = false):
	_has_focus = p_focus_state
	_authorize_multiple_selection = p_authorize_multiple_selection
	
	if not _has_focus:
		character_1.focus_mode = Control.FOCUS_NONE
		character_1.set_is_selected(false)
		character_2.focus_mode = Control.FOCUS_NONE
		character_2.set_is_selected(false)
		character_3.focus_mode = Control.FOCUS_NONE
		character_3.set_is_selected(false)
		character_4.focus_mode = Control.FOCUS_NONE
		character_4.set_is_selected(false)
		return
		
	character_1.focus_mode = Control.FOCUS_ALL
	character_2.focus_mode = Control.FOCUS_ALL
	character_3.focus_mode = Control.FOCUS_ALL
	character_4.focus_mode = Control.FOCUS_ALL
	character_1.grab_focus()

func _switch_selection_mode() -> void:
	if _authorize_multiple_selection == true:
		match _current_mode_selection:
			MODE_SELECTION.SINGLE:
				_current_mode_selection = MODE_SELECTION.MULTIPLE
				focus_mode = Control.FOCUS_ALL
				grab_focus()
				for character_button: PlayerCharacterButton in buttons.get_children():
					character_button.focus_mode = Control.FOCUS_NONE
					character_button.set_is_selected(true)
					
			MODE_SELECTION.MULTIPLE:
				_current_mode_selection = MODE_SELECTION.SINGLE
				focus_mode = Control.FOCUS_NONE
				for character_button: PlayerCharacterButton in buttons.get_children():
					character_button.focus_mode = Control.FOCUS_ALL
					character_button.set_is_selected(false)
				
				buttons.get_child(0).grab_focus()
	else:
		push_error("impossible de changer le mode de selection")

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("Validate") and _current_mode_selection == MODE_SELECTION.MULTIPLE:
			var arr: Array[Battler] = []
			for character_button: PlayerCharacterButton in buttons.get_children():
				arr.append(character_button.character)
			_on_character_selected(arr)
		if event.is_action_pressed("Change_Mode_Selection"):
			_switch_selection_mode()

func _on_character_selected(character: Array[Battler]) -> void:
	characters_selected.emit(character)
