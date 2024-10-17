class_name TurnQueue extends Node2D

signal ability_selected(spell: Spell)
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
		
		var targets: Array[Battler] = []
		
		if active_character.is_player == true:
			battle_menu.update_actions_buttons(active_character.get_actions())
			await get_tree().create_timer(1.5).timeout
		
			var has_select_actions_and_target: bool = false
			while not has_select_actions_and_target:
				
				active_character.spell_cast.spell = await _select_actions()
				if active_character.spell_cast.spell.target == Enums.TARGET.SELF:
					active_character.spell_cast.targets = [active_character]
				else:
					active_character.spell_cast.targets = await get_target(active_character.spell_cast.spell)
				
				has_select_actions_and_target = true #is_action_and_target_valid(spell, targets)
			
		else:
			await get_tree().create_timer(1.5).timeout
			#ability = active_character.get_actions()[randi() % active_character.get_actions().size()]
			
			#var potential_target: Array[Battler] = _get_targets_list(ability)
			#match action.target_type:
				#Action.TARGET_TYPE.SINGLE_ALLY, Action.TARGET_TYPE.SINGLE_ENEMY:
					#targets.append(potential_target[randi() % potential_target.size()])
				#Action.TARGET_TYPE.ALL_ALLIES, Action.TARGET_TYPE.ALL_ENEMIES:
					#targets = potential_target
				#_:
					#targets = potential_target
		
		active_character.print_debug_message()
		#print_debug_message(spell, targets)
		#var targets_data: Array[Battler] = []
		#for battler: Battler in targets:
			#targets_data.append(battler)
		#active_character.act(spell, targets_data)
	
	end_turn()

func _get_targets_list(spell: Spell) -> Array[Battler]:
	
	var potential_targets: Array[Battler] = [] 
	
	match spell.target:
		Enums.TARGET.SE, Enums.TARGET.AE, Enums.TARGET.E:
			potential_targets = get_enemies()
		Enums.TARGET.SA, Enums.TARGET.AA, Enums.TARGET.A:
			potential_targets = get_allies()
	
	return potential_targets


func is_action_and_target_valid(spell: Spell, targets: Array[Battler]):
	#return action != null and ( (targets == [] and action.target_type == Action.TARGET_TYPE.NONE) \
		#or (targets != [] and action.target_type != Action.TARGET_TYPE.NONE))
	return true

func end_turn():
	active_character.end_turn()
	battle_menu.delete_previous_action()
	set_next_character()
	play_turn()

func print_debug_message(spell: Spell, targets: Array[Battler]):
	var debug_message = active_character.to_string() + " is using " + spell.to_string()
	if targets != []:
		debug_message += " on "
		for character: Battler in targets:
			debug_message += character.to_string() + " "
	
	print(debug_message)

func _select_actions() -> Spell:
	battle_menu.set_focus_on_action_selection()
	
	message_box.set_message("Wait for action....")
	var spell: Spell = await ability_selected
	message_box.set_message("action selected : " + spell.to_string())
	return spell

func get_target(spell: Spell):
	var potential_targets: Array[Battler] = _get_targets_list(spell)
	
	_set_targets_selectable(potential_targets, true)
	
	match spell.target:
		Enums.TARGET.SA, Enums.TARGET.AA, Enums.TARGET.A:
			battle_menu.set_focus_on_player_character((spell.target == Enums.TARGET.AA))
		Enums.TARGET.SE, Enums.TARGET.AE, Enums.TARGET.E:
			battle_menu.set_focus_on_target_selection((spell.target == Enums.TARGET.AE))
		
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
