class_name Job

const JOBS_FILE: String = "res://ressources/jobs/jobs.json"

var job_id: String
var job_name: String = ""

var skill: int

var actions: Array[Action] = []

var _sprite_frames_path: String = ""
var sprite_frames_path = _sprite_frames_path :
	get(): return _sprite_frames_path
	set(value): push_error("You can't modify sprite_frames_path from outside.")

# Equippable weapons
# var equippable_weapons = Array[WEAPON_TYPE]

func load(job_id: String, job_level: int):
	job_name = job_id
	#level = job_level
	
	_load_data()

func _load_data():
	var content: Dictionary = FileHandler.get_json_content(JOBS_FILE)

	if content.has("error"):
		return
	
	var job_data = content[job_name]
	
	_sprite_frames_path = job_data["sprite_frames"]
	
	_load_actions(job_data["actions"])
	
func _load_actions(job_actions: Array):
	
	for action_id in job_actions:
		actions.append(Action.new())
		actions[actions.size() - 1] = Action.load(action_id)
