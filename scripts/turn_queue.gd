class_name TurnQueue extends Node2D

signal action_selected(action: Action)
signal target_selected(targets: Array[Battler])

@onready var message_box: MessageBox = %MessageBox
@onready var battle_menu: BattleMenu = %BattleMenu

var characters: Array[Battler] = []
var active_character: Battler = null


func initialize():
	
	active_character = get_child(0)
	for node_character in get_children():
		characters.append(node_character)
		
	battle_menu.target_menu.load_characters(characters.filter(func(character): return not character.is_player))
	battle_menu.player_character_menu.load_characters(characters.filter(func(character): return character.is_player))
	
	
	play_turn()
	
func play_turn():
	
	if is_battle_end():
		if active_character.is_player:
			print("YOU WIN")
			message_box.set_message("YOU WIN")
		else:
			print("YOU LOST")
			message_box.set_message("YOU LOST")
		return
	
	if active_character.get_current_health_points() > 0:
		active_character.initialize_turn()
		
		var action: Action
		var targets: Array[Battler] = []
		
		if active_character.is_player == true:
			battle_menu.update_actions_buttons(active_character.get_actions())
			await get_tree().create_timer(1.5).timeout
		
			var has_select_actions_and_target: bool = false
			while not has_select_actions_and_target:
				
				action = await _select_actions()
				#if action.target_type == Action.TARGET_TYPE.SELF:
					#targets = [active_character]
				#elif action.target_type != Action.TARGET_TYPE.NONE:
					#targets = await get_target(action)
				
				has_select_actions_and_target = is_action_and_target_valid(action, targets)
			
		else:
			await get_tree().create_timer(1.5).timeout
			action = active_character.get_actions()[randi() % active_character.get_actions().size()]
			
			var potential_target: Array[Battler] = _get_targets_list(action)
			match action.target_type:
				#Action.TARGET_TYPE.SINGLE_ALLY, Action.TARGET_TYPE.SINGLE_ENEMY:
					#targets.append(potential_target[randi() % potential_target.size()])
				#Action.TARGET_TYPE.ALL_ALLIES, Action.TARGET_TYPE.ALL_ENEMIES:
					#targets = potential_target
				_:
					targets = potential_target
		
		print_debug_message(action, targets)
		var targets_data: Array[Battler] = []
		for battler: Battler in targets:
			targets_data.append(battler)
		active_character.act(action, targets_data)
	
	end_turn()

func _get_targets_list(action: Action) -> Array[Battler]:
	
	var potential_targets: Array[Battler] = [] 
	
	#match action.target_type:
		#Action.TARGET_TYPE.NONE:
			#pass
		#Action.TARGET_TYPE.SELF:
			#potential_targets.append(active_character)
		#Action.TARGET_TYPE.SINGLE_ENEMY, Action.TARGET_TYPE.ALL_ENEMIES:
			#potential_targets = get_enemies()
		#Action.TARGET_TYPE.SINGLE_ALLY, Action.TARGET_TYPE.ALL_ALLIES:
			#potential_targets = get_allies()
	
	return potential_targets


func is_action_and_target_valid(action: Action, targets: Array[Battler]):
	#return action != null and ( (targets == [] and action.target_type == Action.TARGET_TYPE.NONE) \
		#or (targets != [] and action.target_type != Action.TARGET_TYPE.NONE))
	return true

func end_turn():
	active_character.end_turn()
	battle_menu.delete_previous_action()
	set_next_character()
	play_turn()

func print_debug_message(action: Action, targets: Array[Battler]):
	var debug_message = active_character.to_string() + " is using " + action.to_string()
	if targets != []:
		debug_message += " on "
		for character: Battler in targets:
			debug_message += character.to_string() + " "
	
	print(debug_message)

func _select_actions() -> Action:
	battle_menu.set_focus_on_action_selection()
	
	message_box.set_message("Wait for action....")
	var action: Action = await action_selected
	message_box.set_message("action selected : " + action.to_string())
	return action

func get_target(action: Action):

	var potential_targets: Array[Battler] = _get_targets_list(action)
	
	_set_targets_selectable(potential_targets, true)
	
	#match action.target_type:
		#Action.TARGET_TYPE.SINGLE_ALLY, Action.TARGET_TYPE.ALL_ALLIES:
			#battle_menu.set_focus_on_player_character((action.target_type == Action.TARGET_TYPE.ALL_ALLIES))
		#Action.TARGET_TYPE.SINGLE_ENEMY, Action.TARGET_TYPE.ALL_ENEMIES:
			#battle_menu.set_focus_on_target_selection((action.target_type == Action.TARGET_TYPE.ALL_ENEMIES))
	#
	var targets_selected: Array[Battler] = await _select_targets(potential_targets)
	
	return targets_selected

func _select_targets(targets: Array[Battler]) -> Array[Battler]:

	message_box.set_message("Wait for target...")
	var targets_selected: Array[Battler] = []
	targets_selected.append_array(await target_selected)
	
	var message: String = "Targets selected : "
	for character: Battler in targets_selected:
		message += character.get_character_name() + ", "
	message_box.set_message(message)
	
	
	_set_targets_selectable(targets, false)
	
	return targets_selected

func _set_targets_selectable(targets: Array[Battler], is_selectable: bool):
	for character: Battler in targets:
		character.is_selectable.set_is_selectable(is_selectable)

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

func is_battle_end() -> bool:	
	var all_opponents_dead: bool = true
	for opponent: Battler in characters:
		if active_character.is_player and not opponent.is_player and opponent.get_current_health_points() > 0:
			all_opponents_dead = false
			break
		elif not active_character.is_player and opponent.is_player and opponent.get_current_health_points() > 0:
			all_opponents_dead = false
			break
			
	return all_opponents_dead
