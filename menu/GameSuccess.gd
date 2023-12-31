extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$NextLevel.grab_focus()
	$AudioStreamPlayer.connect("finished", _replayer_music)
	$NextLevel.connect("pressed", _next_level)
	$HBoxContainer/Control4/GPUParticles2D2.emitting = true
	$HBoxContainer/Control5/GPUParticles2D.emitting = true


func _next_level():
	Global.level += 1
	get_tree().change_scene_to_file("res://main.tscn")
	

func _replayer_music():
	$AudioStreamPlayer.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()


func _on_back_to_main_pressed():
	get_tree().change_scene_to_file("res://menu/MainMenu.tscn")


func _on_quit_pressed():
	get_tree().quit()
