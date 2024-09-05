class_name MenuHandler extends Panel

@onready var v_box_container: VBoxContainer = $VBoxContainer

@export var items: Array[CommandButton]

func _ready() -> void:
	pass

func get_focus():
	if v_box_container.get_child_count() > 0:
		for item in v_box_container.get_children():
			item.focus_mode = Control.FOCUS_ALL
		v_box_container.get_child(0).grab_focus()

func lost_focus():
	for item in v_box_container.get_children():
		item.focus_mode = Control.FOCUS_NONE
