class_name PlayerCharacterButton extends CommandButton

@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var turn_queue: TurnQueue = $"/root/BattleScene/TurnQueue"

@onready var character_name: Label = $HBoxContainer/CharacterName
@onready var hp: Label = $HBoxContainer/HP
@onready var action_selected: Label = $HBoxContainer/ActionSelected

@export var character: Character

func _ready() -> void:
	initialize()
	character_name.text = "Hero"
	hp.text = "100 / 100"
	action_selected.text = ""

func set_character(new_character: Character):
	character = new_character
	character_name.text = character.character_name
	hp.text = str(character.stats.health) + " / " + str(character.stats.health)
	action_selected.text = ""

func _on_button_up() -> void:
	character.character_selected()
	
func _on_focus_entered() -> void:
	on_focus_entered()
	character.get_focus()

func _on_focus_exited() -> void:
	on_focus_exited()
	character.lost_focus()
