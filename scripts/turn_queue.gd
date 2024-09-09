class_name TurnQueue extends Node2D

signal action_selected(action: Action)
signal target_selected(target: Character)

@onready var message_box: MessageBox = %MessageBox
@onready var battle_menu: BattleMenu = %BattleMenu

enum ACTIONS {
	ATTACK,
	DEFEND,
	ESCAPE,
}

var characters: Array[Character] = []
var active_character: Character = null

func _ready() -> void:
	
	#TODO : Wait all node loaded at the scene loading
	await message_box.ready
	
	initialize()
	play_turn()

func initialize():
	active_character = get_child(0)
	for node_character in get_children():
		characters.append(node_character)
		#characters[characters.size() - 1]._init()
		
	#battle_menu.target_selection.load_enemies(characters.filter(func(character): return not character.is_player))
	battle_menu.target_selection.load_characters(characters.filter(func(character): return not character.is_player))
	battle_menu.player_character_informations.load_characters(characters.filter(func(character): return character.is_player))

func play_turn():
	if active_character.stats.health > 0:
		active_character.initialize_turn()
		
		battle_menu.update_actions_buttons(active_character.actions)
		
		var action: Action
		var targets: Array[Character]
		
		var has_select_actions_and_target: bool = false
		while not has_select_actions_and_target:
			
			action = await _select_actions()
			targets = await get_target(action)
			
			has_select_actions_and_target = is_action_and_target_valid(action, targets)
		
		print_debug_message(action, targets)
		active_character.act(action, targets)
	
	end_turn()

func is_action_and_target_valid(action: Action, targets: Array[Character]):
	return action != null and ( (targets == [] and action.target_type == Action.TARGET_TYPE.NONE) \
		or (targets != [] and action.target_type != Action.TARGET_TYPE.NONE))

func end_turn():
	active_character.end_turn()
	battle_menu.delete_previous_action()
	set_next_character()
	play_turn()

func print_debug_message(action: Action, targets: Array[Character]):
	var debug_message = active_character.to_string() + " is using " + action.to_string()
	if targets != []:
		debug_message += " on "
		for character: Character in targets:
			debug_message += character.to_string() + " "
	
	print(debug_message)

func _select_actions():
	battle_menu.set_focus_on_action_selection()
	
	message_box.set_message("Wait for action....")
	var action = await action_selected
	message_box.set_message("action selected : " + action.to_string())
	return action

func get_target(action: Action):
	
	var all_targets: Array[Character] = []
	var targets_selected: Array[Character] = []
	
	if action.target_type != Action.TARGET_TYPE.NONE:
		if action.target_type == Action.TARGET_TYPE.SELF:
			targets_selected.append(active_character)
		else:
			if action.is_targeting_enemies():
				all_targets = get_enemies()
				_set_targets_selectable(all_targets, true)
				battle_menu.set_focus_on_target_selection()
			else:
				all_targets = get_allies()
				_set_targets_selectable(all_targets, true)
				battle_menu.set_focus_on_player_character()
			
			targets_selected = await _select_targets(all_targets)
	
	return targets_selected

func _select_targets(targets: Array[Character]) -> Array[Character]:
	
	message_box.set_message("Wait for target...")
	var targets_selected: Array[Character] = []
	targets_selected.append(await target_selected)
	message_box.set_message("target selected : " + targets_selected[0].to_string())
	
	_set_targets_selectable(targets, false)
	
	return targets_selected

func _set_targets_selectable(targets: Array[Character], is_selectable: bool):
	for character: Character in targets:
		character.is_selectable = is_selectable

func get_enemies():
	if active_character.is_player == true:
		return characters.filter(func(character): return not character.is_player)
	else:
		return characters.filter(func(character): return character.is_player)

func get_allies():
	if active_character.is_player == true:
		return characters.filter(func(character): return character.is_player)
	else:
		return characters.filter(func(character): return not character.is_player)

func set_next_character(): 
	var new_index : int = (active_character.get_index() + 1) % get_child_count()
	if(get_child(new_index).name == "Timer"):
		new_index = (new_index + 1) % get_child_count()
	active_character = get_child(new_index)
