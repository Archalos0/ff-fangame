class_name Job

const JOBS_STATS_EVOLUTION_FILE: String = "res://ressources/jobs/jobs_stats_evolution.json"

var job_name: String = ""
var level: int = 1

var actions: Array[Action] = []

var animations: SpriteFrames

# Equippable weapons
# var equippable_weapons = Array[WEAPON_TYPE]

func load(job_id: String, job_level: int):
	job_name = job_id
	level = job_level
