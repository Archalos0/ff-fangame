class_name FileHandler

static func get_json_content(file_path: String) -> Dictionary:
	if not file_path.ends_with(".json"):
		return { "error": "Wrong file extension."}
	
	if not FileAccess.file_exists(file_path):
		return { "error": "File not found."}
	
	var json: JSON = JSON.new()
	
	var file = FileAccess.open(file_path, FileAccess.READ)
	var res = json.parse(file.get_as_text())
	file.close()
	
	if res == OK:
		return json.data
	else:
		return { "error": "Parsing error."}

static func write_json_content(file_path: String, content: Dictionary):
	var json_string: String = JSON.stringify(content, "\t", false)
	
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(json_string)
	file.close()
