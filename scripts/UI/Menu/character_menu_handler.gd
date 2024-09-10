class_name CharacterMenuHandler extends MenuHandler

var characters: Array[Character] = []

func load_characters(p_characters: Array[Character]):
	characters = p_characters

func select_all():
	for target_button: TargetButton in buttons.get_children():
		target_button._on_focus_entered()
