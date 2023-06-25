extends Node


func _ready():
	$VBoxContainer/Start.grab_focus()
	$AudioStreamPlayer.connect("finished", _replay_music)


func _replay_music():
	$AudioStreamPlayer.play()


func _on_start_pressed():
	get_tree().change_scene_to_file("res://menu/story/StoryIntro.tscn")


func _on_quit_pressed():
	get_tree().quit()
	
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()
