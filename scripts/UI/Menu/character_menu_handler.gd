class_name CharacterMenuHandler extends MenuHandler

var characters: Array[Character] = []

@onready var turn_queue: TurnQueue = $"/root/BattleScene/TurnQueue"

func load_characters(p_characters: Array[Character]):
	characters = p_characters

func _gui_input(event: InputEvent) -> void:
	if _are_all_selected:
		if event is InputEventKey and event.is_action_pressed("Validate"):
			var characters: Array[Character] = []
			match name:
				"PlayerCharacterInformations":
					for character_button: PlayerCharacterButton in buttons.get_children():
						characters.append(character_button.character)
				"TargetSelection":
					for character_button: TargetButton in buttons.get_children():
						characters.append(character_button.character)
			turn_queue.emit_signal("target_selected", characters)
		return

func select_all_character():	
	for button in buttons.get_children():
		button.set_disabled(true) # Désactive tous les boutons
	_are_all_selected = true
	for target_button in buttons.get_children():
		target_button.set_is_selected(true)
