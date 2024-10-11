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
	var ability: Ability
	
	func _init(action_id: String, p_ability_id: String):
		action_name = action_id
		description = "descr"
		
		ability = Ability.new()
		ability.load(p_ability_id)
		#ability_id = p_ability_id
	
	func use_action():
		print("launch ability : " + ability.ability_name)
	
	func _to_string() -> String:
		return "Ability action : \r\n\tability_name : " + ability.ability_name
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

	if not content["actions"].has(action_id):
		push_error("action : " + action_id + " not found.")
		return
	
	var action: Action
	
	match content["actions"][action_id]["effect"]["type"]:
		"LAUNCH_ABILITY": action = LaunchAbilityAction.new(action_id, content["actions"][action_id]["effect"]["id"])
		"OPEN_MENU": action = OpenMenuAction.new(action_id, content["actions"][action_id]["effect"]["id"])
	
	return action


func use_action():
	push_error("The method use_action() has not been implementing in the derived class")
