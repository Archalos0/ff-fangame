class_name MenuHandler extends Panel

@onready var buttons: VBoxContainer = $VBoxContainer

func _ready() -> void:
	buttons = get_node("Buttons")
	

func get_focus():
	if buttons.get_child_count() > 0:
		for item in buttons.get_children():
			item.focus_mode = Control.FOCUS_ALL
		buttons.get_child(0).grab_focus()

func lost_focus():
	for item in buttons.get_children():
		item.focus_mode = Control.FOCUS_NONE

func select_all():
	#for item: TargetButton in v_box_container.get_children():
		#item._on_focus_entered()
	pass
