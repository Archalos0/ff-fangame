class_name BattleSystem2 extends Node2D

enum BATTLE_STATE {
	# Prepare battle
	LOAD_BATTLE_DATA,
	
	# During battle
	BEGIN_TURN,
	WAIT_FOR_SPELL,
	WAIT_FOR_TARGETS,
	NEXT_CHARACTER,
	
	MONSTERS_TURN,
	
	# Executing all actions
	PLAY_TURN,
	
	# End battle 
	WIN,
	LOST 
}

const BATTLER_OBJECT = preload("res://scenes/character.tscn")
const monsters_id: Array[String] = ["goblin", "goblin", "carbuncle"]

var battle_state: BATTLE_STATE

@onready var battle_menu: BattleMenu = %BattleMenu
@onready var characters: Node2D = $Characters

var player_characters: Array[Battler] = []
var monsters: Array[Battler] = []

var active_character: Battler = null

func _ready() -> void:
	Game.load_save("res://scripts/save/save.json")
	set_battle_state(BATTLE_STATE.LOAD_BATTLE_DATA)

func set_battle_state(new_battle_state: BATTLE_STATE):
	battle_state = new_battle_state
	match battle_state:
		BATTLE_STATE.LOAD_BATTLE_DATA: load_battle_data()
		BATTLE_STATE.BEGIN_TURN: begin_turn()
		BATTLE_STATE.WAIT_FOR_SPELL: waiting_for_spell()
		BATTLE_STATE.WAIT_FOR_TARGETS: waiting_for_targets()
		BATTLE_STATE.NEXT_CHARACTER: select_next_character()
		BATTLE_STATE.MONSTERS_TURN: monsters_turn()
		BATTLE_STATE.PLAY_TURN: play_turn()
		BATTLE_STATE.WIN: win()
		BATTLE_STATE.LOST: lost()
		_: pass

func next_battle_state():
	match battle_state:
		BATTLE_STATE.LOAD_BATTLE_DATA: set_battle_state(BATTLE_STATE.BEGIN_TURN)
		BATTLE_STATE.BEGIN_TURN: set_battle_state(BATTLE_STATE.WAIT_FOR_SPELL)
		BATTLE_STATE.WAIT_FOR_SPELL: set_battle_state(BATTLE_STATE.WAIT_FOR_TARGETS)
		BATTLE_STATE.WAIT_FOR_TARGETS: set_battle_state(BATTLE_STATE.NEXT_CHARACTER)
		BATTLE_STATE.NEXT_CHARACTER: set_battle_state(BATTLE_STATE.WAIT_FOR_SPELL)
		BATTLE_STATE.MONSTERS_TURN: set_battle_state(BATTLE_STATE.PLAY_TURN)
		BATTLE_STATE.PLAY_TURN: set_battle_state(BATTLE_STATE.BEGIN_TURN)
		BATTLE_STATE.WIN: return
		BATTLE_STATE.LOST: return

## STATES FUNCTIONS

func load_battle_data():
	
	# Load all Battlers
	for player_character_data: CharacterData in Game.get_player_characters():
		var battler: Battler = BATTLER_OBJECT.instantiate()
		battler.load_battler(player_character_data, true)
		player_characters.append(battler)
	
	for monster_id: String in monsters_id:
		var battler = BATTLER_OBJECT.instantiate()
		battler.load_monster_by_id(monster_id)
		
		monsters.append(battler)
	
	var cpt := 0
	for player_character: Battler in player_characters:
		player_character.position.x = 200.0
		player_character.position.y = 80.0 + cpt*100
		
		characters.add_child(player_character)
		cpt += 1
	
	cpt = 0
	for monster: Battler in monsters:
		monster.position.x = 900.0
		monster.position.y = 80.0 + cpt*100
		
		characters.add_child(monster)
		cpt += 1
	
	# Load UI
	battle_menu.load_ui(player_characters, monsters)
	
	# Begin state flow
	next_battle_state()
	
func begin_turn():
	active_character = player_characters[0]
	active_character.initialize_turn()
	
	next_battle_state()

func waiting_for_spell():
	battle_menu.actions_menu.load_actions(active_character.get_actions())
	battle_menu.magic_spells_menu.load_spells(active_character.get_spells())
	battle_menu.set_focus_on_action_selection()

func waiting_for_targets():
	if active_character.spell_cast.spell.target == Enums.TARGET.SELF:
		active_character.spell_cast.targets = [active_character]
		active_character.spell_is_cast.emit()
		next_battle_state()
		return
		
	if active_character.spell_cast.spell.is_selecting_allies():
		battle_menu.set_focus_on_player_character(active_character.spell_cast.spell.can_be_used_on_multiple_targets())
	else:
		battle_menu.set_focus_on_target_selection(active_character.spell_cast.spell.can_be_used_on_multiple_targets())

func select_next_character():
	active_character.end_turn()
	var index_active_character := player_characters.find(active_character)
	if index_active_character == player_characters.size() - 1:
		set_battle_state(BATTLE_STATE.MONSTERS_TURN)
	else:
		active_character = player_characters[index_active_character + 1]
		active_character.initialize_turn()
		set_battle_state(BATTLE_STATE.WAIT_FOR_SPELL)

func monsters_turn():
	for monster in monsters:
		monster.spell_cast.spell = monster.get_spells().pick_random()
		monster.spell_cast.targets = player_characters.pick_random()
		
	next_battle_state()

func play_turn():
	
	var all_battlers: Array[Battler] = player_characters
	all_battlers.append_array(monsters)
	
	all_battlers.shuffle()
	
	for battler in all_battlers:
		battler.act()
		
		battler.print_debug_message()
		
		await get_tree().create_timer(1.5).timeout
		
	next_battle_state()

func win():
	pass

func lost():
	pass

# SIGNALS HANDLER

func _on_spell_selected(spell: Spell) -> void:
	if battle_state != BATTLE_STATE.WAIT_FOR_SPELL:
		return
	
	active_character.spell_cast.spell = spell
		
	next_battle_state()

func _on_targets_selected(targets: Array[Battler]) -> void:
	if battle_state != BATTLE_STATE.WAIT_FOR_TARGETS:
		return
	
	active_character.spell_cast.targets = targets
	
	active_character.spell_is_cast.emit()
	
	next_battle_state()
