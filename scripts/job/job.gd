class_name Job

class JobStat:
	var level: int
	var stats: Stats

const JOBS_STATS_EVOLUTION_FILE: String = "res://ressources/jobs/jobs_stats_evolution.json"

var job_name: String = ""
var level: int = 1

var stats: Stats
# Stats evolution when level up

var actions: Array[Action] = []

var animations: SpriteFrames

# Equippable weapons
# var equippable_weapons = Array[WEAPON_TYPE]

func load(job_id: String, job_level: int):
	job_name = job_id
	level = job_level

	var content: Dictionary = FileHandler.get_json_content(JOBS_STATS_EVOLUTION_FILE)
	
	if content.has("error"):
		return
	
	stats = Stats.from_dictionary(content[job_id][str(job_level)])

static func from_resource(job_resource: JobResource, character_level: int) -> Job:
	var new_job = Job.new()
	new_job.job_name = job_resource.job_name
	
	for action_resource: ActionResource in job_resource.actions_resources:
		new_job.actions.append(Action.from_action_resource(action_resource))
		
	new_job.stats_evolution = job_resource.stats_evolution.data
	new_job.stats = Stats.from_dictionary(new_job.stats_evolution[str(character_level)])
	new_job.animations = job_resource.job_animation
	return new_job
