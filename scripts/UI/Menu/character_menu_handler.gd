class_name CharacterMenuHandler extends MenuHandler

signal characters_selected(characters: Array[Battler])

var _characters: Array[Battler] = []

func load_characters(p_characters: Array[Battler]):
	_characters = p_characters
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
	var _characters_selected: Array[Battler] = []

	if self is PlayerSelectionMenu:
		for character_button: PlayerCharacterButton in _buttons.get_buttons_selected():
			_characters_selected.append(character_button.character)
	elif self is TargetSelectionMenu:
		for character_button: TargetButton in _buttons.get_buttons_selected():
			_characters_selected.append(character_button.character)
	
	self.characters_selected.emit(_characters_selected)
