extends NPCState
class_name NPCRoam

var time_since_action = 0
var action_interval = 3
var angle = 0
var speed = 0
var rng = RandomNumberGenerator.new()

func physics_process(delta):
	time_since_action += delta
	if time_since_action >= action_interval:
		time_since_action = 0
		set_target()
		zombie.velocity = Vector3.ZERO if zombie.is_on_floor() else Vector3.DOWN
	else:
		zombie.rotation.y = lerp_angle(zombie.rotation.y, angle, delta * 30)
		zombie.velocity = Vector3(0, 0, - speed).rotated(Vector3.UP, zombie.rotation.y) \
			+ (Vector3.ZERO if zombie.is_on_floor() else Vector3.DOWN)
	zombie.move_and_slide()


func set_target():
	var node = zombie.get_node("AudioStreamPlayer3D2")
	if not node.is_playing():
		node.play()
	angle = rng.randi_range(0, 360)
	speed = rng.randf_range(0, 2) 
