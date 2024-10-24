class_name BattleSystem extends Node2D

signal changing_active_character()
signal loading_complete()

signal wait_for_spell()
signal wait_for_targets()

signal spell_selected(spell: Spell)
signal targets_selected(targets: Array[Battler])

enum BATTLE_STATE {
	# Prepare battle
	LOAD_BATTLE_DATA,
	
	# During battle
	WAIT_FOR_SPELL,
	WAIT_FOR_TARGETS,
	NEXT_CHARACTER,
	
	# Executing all actions
	PLAY_TURN,
	
	# End battle 
	WIN,
	LOST 
}

const BATTLER_OBJECT = preload("res://scenes/character.tscn")

const monsters_id: Array[String] = ["goblin", "goblin", "carbuncle"]

var battle_state: BATTLE_STATE

var characters: Array[Battler] = []
var active_character: Battler = null

#func _ready() -> void:
	#Game.load_save("res://scripts/save/save.json")
	#
	#var monsters_data: Array[Monster] = []
	#for monster_id: String in monsters_id:
		#var monster_data: Monster = Monster.new()
		#monster_data.load(monster_id)
		#monsters_data.append(monster_data)
	#
	#load_battle_data(Game.get_player_characters(), monsters_data)

func set_battle_state(new_battle_state: BATTLE_STATE) -> void:
	battle_state = new_battle_state
	match battle_state:
		BATTLE_STATE.LOAD_BATTLE_DATA: pass
		
		BATTLE_STATE.WAIT_FOR_SPELL: _update_to_spell_selection()
		BATTLE_STATE.WAIT_FOR_TARGETS: _update_to_targets_selection()
		BATTLE_STATE.NEXT_CHARACTER: _select_next_character()
		
		BATTLE_STATE.PLAY_TURN: pass
		
		BATTLE_STATE.WIN: pass
		BATTLE_STATE.LOST: pass

func _next_battle_state() -> void:
	match battle_state:
		BATTLE_STATE.LOAD_BATTLE_DATA: set_battle_state(BATTLE_STATE.WAIT_FOR_SPELL)
		
		BATTLE_STATE.WAIT_FOR_SPELL: set_battle_state(BATTLE_STATE.WAIT_FOR_TARGETS)
		BATTLE_STATE.WAIT_FOR_TARGETS: 
			if characters.find(active_character) == characters.size() - 1:
				set_battle_state(BATTLE_STATE.PLAY_TURN)
			else:
				set_battle_state(BATTLE_STATE.NEXT_CHARACTER)
				
		BATTLE_STATE.NEXT_CHARACTER: set_battle_state(BATTLE_STATE.WAIT_FOR_SPELL)
		
		BATTLE_STATE.PLAY_TURN: 
			active_character = characters[0]
			set_battle_state(BATTLE_STATE.WAIT_FOR_SPELL)
		
		BATTLE_STATE.WIN: pass
		BATTLE_STATE.LOST: pass

func load_battle_data(player_characters: Array[CharacterData], monsters: Array[Monster]) -> void:
	set_battle_state(BATTLE_STATE.LOAD_BATTLE_DATA)
	
	characters.append_array(player_characters.map(
		func(character): 
			var battler: Battler = BATTLER_OBJECT.instantiate()
			battler.load_battler(character, true)
			return battler
			)
		)
	
	characters.append_array(monsters.map(
		func(monster): 
			var battler: Battler = BATTLER_OBJECT.instantiate()
			battler.load_monster(monster)
			return battler
			)
		)
		
	loading_complete.emit()
	
	active_character = characters[0]
	changing_active_character.emit()
	
	set_battle_state(BATTLE_STATE.WAIT_FOR_SPELL)

func _update_to_spell_selection():
	wait_for_spell.emit()

func _on_spell_selected(spell_selected: Spell) -> void:
	if battle_state != BATTLE_STATE.WAIT_FOR_SPELL:
		push_error("The battle system does not wait for spell")
		return
		
	active_character.spell_cast.spell = spell_selected
	set_battle_state(BATTLE_STATE.WAIT_FOR_TARGETS)

func _update_to_targets_selection():
	wait_for_targets.emit()

func _on_targets_selected(targets_selected: Array[Battler]) -> void:
	if battle_state != BATTLE_STATE.WAIT_FOR_TARGETS:
		push_error("The battle system does not wait for targets")
		return
		
	active_character.spell_cast.targets = targets_selected
	set_battle_state(BATTLE_STATE.NEXT_CHARACTER)

func _select_next_character():
	active_character = characters[characters.find(active_character) + 1]
	if active_character.is_player:
		changing_active_character.emit()
		wait_for_spell.emit()
