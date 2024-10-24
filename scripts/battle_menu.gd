class_name BattleMenu extends Control

signal spell_selected(spell: Spell)
signal characters_selected(charcters: Array[Battler])

@onready var actions_menu: ActionMenu = $ActionsMenu
@onready var targets_menu: TargetsMenu = $TargetsMenu
@onready var player_character_menu: PlayerSelectionMenu = $PlayerCharacterInformations

@onready var magic_spells_menu: MagicSpellsMenu = $MagicSpellsMenu
@onready var items_battle_menu: ItemsBattleMenu = $ItemsBattleMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_filter = MOUSE_FILTER_PASS
	actions_menu.focus_mode = Control.FOCUS_NONE
	targets_menu.focus_mode = Control.FOCUS_NONE
	player_character_menu.focus_mode = Control.FOCUS_NONE
	
	actions_menu.action_button_selected.connect(Callable(self, "_on_action_selected"))
	
	#targets_menu.targets_selected.connect(Callable(self, "_on_characters_selected"))
	
	player_character_menu.characters_selected.connect(Callable(self, "_on_characters_selected"))
	
func load_ui(player_characters: Array[Battler], monsters: Array[Battler]):
	player_character_menu.load_characters(player_characters)
	targets_menu.load_characters(monsters)

func _on_action_selected(action: Action):
	if action is Action.OpenMenuAction:
		open_menu(action.menu_id)
	else:
		spell_selected.emit(action.spell)

func open_menu(menu_id: String):
	match menu_id:
		"MAGIC_SPELLS": 
			magic_spells_menu.visible = true
			set_focus_on_magic_spells_menu()
		"ITEMS": 
			items_battle_menu.visible = true
			set_focus_on_items_menu()
			
func close_menu(menu_id: String):
	match menu_id:
		"MAGIC_SPELLS": 
			magic_spells_menu.visible = false
			set_focus_on_action_selection()
		"ITEMS": 
			items_battle_menu.visible = false
			set_focus_on_action_selection()
			
func _on_characters_selected(characters: Array[Battler]):
	characters_selected.emit(characters)

func update_active_character_ui(battler: Battler):
	actions_menu.reset_actions()
	actions_menu.load_actions(battler.get_actions())
	
	magic_spells_menu.load_spells(battler.get_spells())
	
func update_actions_buttons(actions):
	actions_menu.load_actions(actions)

func update_spells_menu(magics: Array[Spell]):
	magic_spells_menu.load_spells(magics)

func update_items_menu(items: Array[Item]):
	items_battle_menu.load_items(items)

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
	items_battle_menu.set_focus_state(false)

func set_focus_on_target_selection(p_authorize_multiple_selection: bool = false):
	targets_menu.set_focus_state(true, p_authorize_multiple_selection)
	actions_menu.set_focus_state(false)
	magic_spells_menu.set_focus_state(false)
	player_character_menu.set_focus_state(false)
	items_battle_menu.set_focus_state(false)

func set_focus_on_player_character(p_authorize_multiple_selection: bool = false):
	player_character_menu.set_focus_state(true, p_authorize_multiple_selection)
	targets_menu.set_focus_state(false)
	actions_menu.set_focus_state(false)
	magic_spells_menu.set_focus_state(false)
	items_battle_menu.set_focus_state(false)

func set_focus_on_magic_spells_menu():
	magic_spells_menu.set_focus_state(true)
	actions_menu.set_focus_state(false)
	player_character_menu.set_focus_state(false)
	targets_menu.set_focus_state(false)
	items_battle_menu.set_focus_state(false)

func set_focus_on_items_menu():
	items_battle_menu.set_focus_state(true)
	magic_spells_menu.set_focus_state(false)
	actions_menu.set_focus_state(false)
	player_character_menu.set_focus_state(false)
	targets_menu.set_focus_state(false)

func _on_spell_seleted(spell: Spell) -> void:
	spell_selected.emit(spell)
	if magic_spells_menu.visible == true:
		magic_spells_menu.set_focus_state(false)
		magic_spells_menu.visible = false

func _on_magic_spells_menu_cancel_action() -> void:
	close_menu("MAGIC_SPELLS")

func _on_items_battle_menu_cancel_item_selection() -> void:
	close_menu("ITEMS")
