class_name Job

class JobStat:
	var level: int
	var stats: Stats

var job_name: String = ""
var level: int = 1

var stats: Stats
# Stats evolution when level up

var actions: Array[Action] = []

# Equippable weapons
# var equippable_weapons = Array[WEAPON_TYPE]

@export var stats_evolution: Dictionary

#func _init(p_job_name: String, p_level: int):
	#job_name = p_job_name
	#level = p_level
	#
	#jobs_stats = JOBS_STATS.data
	#var current_job_stats: Array = jobs_stats[job_name]
	#for i in range(current_job_stats.size()):
		#if current_job_stats[i].level == level:
			#stats = Stats.from_dictionary(current_job_stats[i].stats)
			#break
			#

static func from_resource(job_resource: JobResource, character_level: int):
	var new_job = Job.new()
	new_job.job_name = job_resource.job_name
	
	for action_resource: ActionResource in job_resource.actions_resources:
		new_job.actions.append(Action.from_action_resource(action_resource))
		
	new_job.stats_evolution = job_resource.stats_evolution.data
	new_job.stats = Stats.from_dictionary(new_job.stats_evolution[str(character_level)])
	
	return new_job
