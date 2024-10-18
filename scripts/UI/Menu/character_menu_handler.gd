class_name CharacterMenuHandler extends MenuHandler

signal characters_selected(characters: Array[Battler])

var _characters: Array[Battler] = []

func _ready() -> void:
	var container = get_node("Buttons")
	_buttons_list._containers.append(container)

func load_characters(p_characters: Array[Battler]) -> void:
	_characters = p_characters
	#_buttons.initialize()

func _gui_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("Validate"):
			_send_characters()
			_reset_ui()
			return
		
		if event.is_action_pressed("Next") and _current_mode_selection == MODE_SELECTION.SINGLE:
			_buttons_list.select_next_button()
			return
		
		if event.is_action_pressed("Previous") and _current_mode_selection == MODE_SELECTION.SINGLE:
			_buttons_list.select_previous_button()
			return
		
		if event.is_action_pressed("Change_Mode_Selection") and _authorize_multiple_selection == true:
			switch_selection_mode()

func _send_characters() -> void:
	var _characters_selected: Array[Battler] = []

	if self is PlayerSelectionMenu:
		for character_button: PlayerCharacterButton in _buttons_list.get_buttons_selected():
			_characters_selected.append(character_button.character)
	elif self is TargetSelectionMenu:
		for character_button: TargetButton in _buttons_list.get_buttons_selected():
			_characters_selected.append(character_button.character)
	
	self.characters_selected.emit(_characters_selected)
