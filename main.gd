extends Node


func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()
