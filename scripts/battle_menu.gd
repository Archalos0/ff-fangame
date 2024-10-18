class_name BattleMenu extends Control

signal ability_selected(spell: Spell)
signal characters_selected(charcters: Array[Battler])

@onready var action_menu: ActionMenu = $ActionSelection
@onready var target_menu: TargetSelectionMenu = $TargetSelection
@onready var player_character_menu: PlayerSelectionMenu = $PlayerCharacterInformations

@onready var magic_spells_menu: MagicSpellsMenu = $MagicSpellsMenu
@onready var items_menu: Panel = $ItemsMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_filter = MOUSE_FILTER_PASS
	action_menu.focus_mode = Control.FOCUS_NONE
	target_menu.focus_mode = Control.FOCUS_NONE
	player_character_menu.focus_mode = Control.FOCUS_NONE
	
	action_menu.ability_selected.connect(Callable(self, "_on_ability_selected"))
	action_menu.open_menu.connect(Callable(self, "_on_open_menu"))
	
	target_menu.characters_selected.connect(Callable(self, "_on_characters_selected"))
	
	player_character_menu.characters_selected.connect(Callable(self, "_on_characters_selected"))
	
func _on_ability_selected(spell: Spell):
	ability_selected.emit(spell)

func _on_open_menu(menu_id: String):
	match menu_id:
		"MAGIC_SPELLS": 
			magic_spells_menu.visible = true
			set_focus_on_magic_spells_menu()
		"ITEMS": items_menu.visible = true

func _on_close_menu(menu_id: String):
	match menu_id:
		"MAGIC_SPELLS": magic_spells_menu.visible = false
		"ITEMS": items_menu.visible = false

func _on_characters_selected(characters: Array[Battler]):
	characters_selected.emit(characters)

func update_actions_buttons(actions):
	action_menu.load_actions(actions)

func update_spells_menu(magics: Magics):
	magic_spells_menu.load_spells(magics)

func delete_previous_action():
	action_menu.delete_actions()

func delete_previous_spells():
	magic_spells_menu.delete_spells()

func set_focus_on_action_selection():
	action_menu.set_focus_state(true)
	player_character_menu.set_focus_state(false)
	target_menu.set_focus_state(false)
	magic_spells_menu.set_focus_state(false)

func set_focus_on_target_selection(p_authorize_multiple_selection: bool = false):
	target_menu.set_focus_state(true, p_authorize_multiple_selection)
	action_menu.set_focus_state(false)
	magic_spells_menu.set_focus_state(false)
	player_character_menu.set_focus_state(false)

func set_focus_on_player_character(p_authorize_multiple_selection: bool = false):
	player_character_menu.set_focus_state(true, p_authorize_multiple_selection)
	target_menu.set_focus_state(false)
	action_menu.set_focus_state(false)
	magic_spells_menu.set_focus_state(false)

func set_focus_on_magic_spells_menu():
	magic_spells_menu.set_focus_state(true)
	action_menu.set_focus_state(false)
	player_character_menu.set_focus_state(false)
	target_menu.set_focus_state(false)
