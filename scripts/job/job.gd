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

const JOBS_STATS = preload("res://scripts/job/jobs_stats.json")

@export var jobs_stats: Dictionary = {}

func _init(p_job_name: String, p_level: int):
	job_name = p_job_name
	level = p_level
	
	jobs_stats = JOBS_STATS.data
	var current_job_stats: Array = jobs_stats[job_name]
	for i in range(current_job_stats.size()):
		if current_job_stats[i].level == level:
			stats = Stats.from_dictionary(current_job_stats[i].stats)
			break
			
