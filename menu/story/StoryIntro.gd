extends Control


var messages = [
	"Guchhi is really glad to finally go on vacation (on a really cool island too!) with their libras-who-love-sauerkraut-and-metal online club, only they had a small mishap and had to board on the next flight on their own...", 
	"When Gucchi got on the island, somehow all of the libras-who-love-sauerkraut-and-metal peeps got turned into zombies-who-love-funk-and-nothing-else ?!!",
	"Help Guchhi try and turn them back by playing a really cool guitar riff at them!",
	"Controls: \n WASD - move \n LEFT CLICK - play guitar riff (attack) \n SPACE - jump"
]

var typing_speed = .06
var read_time = 2

var current_message = 0
var display = ""
var current_char = 0


func _ready():
	start_dialogue()
	$Start.hide()
	
	
func start_dialogue():
	current_message = 0
	display = ""
	current_char = 0
	$NextChar.set_wait_time(typing_speed)
	$NextChar.start()


func _on_next_char_timeout():
	if (current_char < len(messages[current_message])):
		var next_char = messages[current_message][current_char]
		display += next_char
		
		$Label.text = display
		current_char += 1
	else:
		$NextChar.stop()
		$NextMsg.one_shot = true
		$NextMsg.set_wait_time(read_time)
		$NextMsg.start()


func _on_next_msg_timeout():
	if (current_message == len(messages) - 1):
		$Start.show()
	else: 
		current_message += 1
		display = ""
		current_char = 0
		$NextChar.start()
		

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()


func _on_start_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
