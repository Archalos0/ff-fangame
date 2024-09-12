class_name CharacterMenuHandler extends MenuHandler

signal characters_selected(characters: Array[Character])

var characters: Array[Character] = []

func load_characters(p_characters: Array[Character]):
	characters = p_characters
	_buttons.initialize()

func _gui_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("Validate"):
			_send_characters()
			_reset_ui()
			return
		
		if event.is_action_pressed("Next") and not _are_all_selected:
			_buttons.select_next_button()
			return
		
		if event.is_action_pressed("Previous") and not _are_all_selected:
			_buttons.select_previous_button()
			return

func _send_characters():
	var characters: Array[Character] = []

	if self is PlayerSelectionMenu:
		for character_button: PlayerCharacterButton in _buttons.get_buttons_selected():
			characters.append(character_button.character)
	elif self is TargetSelectionMenu:
		for character_button: TargetButton in _buttons.get_buttons_selected():
			characters.append(character_button.character)
	
	emit_signal("characters_selected", characters)
	#turn_queue.emit_signal("target_selected", characters)
