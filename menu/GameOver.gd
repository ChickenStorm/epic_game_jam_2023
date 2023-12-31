extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Retry.grab_focus()
	$AudioStreamPlayer.connect("finished", _replay_music)


func _replay_music():
	$AudioStreamPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()


func _on_quit_pressed():
	get_tree().quit()


func _on_retry_pressed():
	Global.level = 0
	get_tree().change_scene_to_file("res://main.tscn")
