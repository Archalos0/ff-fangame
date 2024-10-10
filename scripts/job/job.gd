class_name Job

const JOBS_FILE: String = "res://ressources/jobs/jobs.json"

var job_name: String = ""
var level: int = 1

var actions: Array[Action] = []

var animations: SpriteFrames

# Equippable weapons
# var equippable_weapons = Array[WEAPON_TYPE]

func load(job_id: String, job_level: int):
	job_name = job_id
	level = job_level

	load_actions()

func load_actions():
	var content: Dictionary = FileHandler.get_json_content(JOBS_FILE)
	
	if content.has("error"):
		return
	
	var job_actions: Array = content[job_name]["actions"]
	
	print("-----------" + job_name + "-----------")
	print("--------------------------------------")
	for action_id in job_actions:
		actions.append(Action.new())
		actions[actions.size() - 1].load(action_id)	
	
	pass
