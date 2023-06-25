extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.connect("finished", _replayer_music)
	$NextLevel.connect("pressed", _next_level)


func _next_level():
	Global.level += 1
	print("t")
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
