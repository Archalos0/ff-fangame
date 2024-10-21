class_name BattleMenu extends Control

signal ability_selected(spell: Spell)
signal characters_selected(charcters: Array[Battler])

@onready var actions_menu: ActionMenu = $ActionsMenu
@onready var targets_menu: TargetsMenu = $TargetsMenu
@onready var player_character_menu: PlayerSelectionMenu = $PlayerCharacterInformations

@onready var magic_spells_menu: MagicSpellsMenu = $MagicSpellsMenu
@onready var items_menu: Panel = $ItemsMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_filter = MOUSE_FILTER_PASS
	actions_menu.focus_mode = Control.FOCUS_NONE
	targets_menu.focus_mode = Control.FOCUS_NONE
	player_character_menu.focus_mode = Control.FOCUS_NONE
	
	actions_menu.action_button_selected.connect(Callable(self, "_on_action_selected"))
	
	#targets_menu.targets_selected.connect(Callable(self, "_on_characters_selected"))
	
	player_character_menu.characters_selected.connect(Callable(self, "_on_characters_selected"))
	
func _on_action_selected(action: Action):
	if action is Action.OpenMenuAction:
		open_menu(action.menu_id)
	else:
		ability_selected.emit(action.spell)

func open_menu(menu_id: String):
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
	actions_menu.load_actions(actions)

func update_spells_menu(magics: Magics):
	magic_spells_menu.load_spells(magics)

func delete_previous_action():
	actions_menu.reset_actions()

func delete_previous_spells():
	pass
	#magic_spells_menu.delete_spells()

func set_focus_on_action_selection():
	actions_menu.set_focus_state(true)
	player_character_menu.set_focus_state(false)
	targets_menu.set_focus_state(false)
	magic_spells_menu.set_focus_state(false)

func set_focus_on_target_selection(p_authorize_multiple_selection: bool = false):
	targets_menu.set_focus_state(true, p_authorize_multiple_selection)
	actions_menu.set_focus_state(false)
	magic_spells_menu.set_focus_state(false)
	player_character_menu.set_focus_state(false)

func set_focus_on_player_character(p_authorize_multiple_selection: bool = false):
	player_character_menu.set_focus_state(true, p_authorize_multiple_selection)
	targets_menu.set_focus_state(false)
	actions_menu.set_focus_state(false)
	magic_spells_menu.set_focus_state(false)

func set_focus_on_magic_spells_menu():
	magic_spells_menu.set_focus_state(true)
	actions_menu.set_focus_state(false)
	player_character_menu.set_focus_state(false)
	targets_menu.set_focus_state(false)
