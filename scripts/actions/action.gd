class_name Action extends Node


#region Constants
const ACTIONS_FILE : String = "res://ressources/actions/actions.json"
#endregion

enum ACTION_TYPE {
	LAUNCH_ABILITY,
	OPEN_MENU
}

#region Derived class
class OpenMenuAction extends Action:
	var menu_id: String
	
	func _init(action_id: String, p_menu_id: String):
		action_name = action_id
		description = "descr"
		
		menu_id = p_menu_id
	
	func use_action():
		print("Opening menu : " + menu_id)
	
	func _to_string() -> String:
		return "Open menu action action : \r\n\taction_name : " + action_name + "\r\n\tmenu : " + menu_id

class LaunchAbilityAction extends Action:
	#var ability_id: String
	var spell: Spell
	
	func _init(action_id: String, p_spell_id: String):
		action_name = action_id
		description = "descr"
		
		spell = Spell.from_id(p_spell_id)
	
	func use_action():
		print("launch ability : " + spell.spell_name)
	
	func _to_string() -> String:
		return "Ability action : \r\n\tability_name : " + spell.spell_name
#endregion

class ActionEffect:
	var type: ACTION_TYPE 
	var target_id: String


var action_name: String = ""
var description: String = "Description"
var effect: ActionEffect


static func load(action_id: String) -> Action:
	var content = FileHandler.get_json_content(ACTIONS_FILE)

	# Handle error

	if not content.has(action_id):
		push_error("action : " + action_id + " not found.")
		return
	
	var action_data = content[action_id]
	
	var action: Action
	
	match action_data["effect"]["type"]:
		"LAUNCH_SPELL", "LAUNCH_PHYSICAL_ATTACK": 
			action = LaunchAbilityAction.new(action_id, action_data["effect"]["id"])
		"OPEN_MENU": 
			action = OpenMenuAction.new(action_id, action_data["effect"]["id"])
	
	return action


func use_action():
	push_error("The method use_action() has not been implementing in the derived class")
