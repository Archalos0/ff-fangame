class_name TargetSelectionMenu extends CharacterMenuHandler

const TARGET_BUTTON = preload("res://scenes/UI/target_button.tscn")

func load_characters(p_enemies: Array[Character]):
	super(p_enemies)
	for enemy in characters:
		var target_button = TARGET_BUTTON.instantiate()
		target_button.set_character(enemy)
		self.buttons.add_child(target_button)
