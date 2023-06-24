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
	else:
		zombie.rotation.y = lerp_angle(zombie.rotation.y, angle, delta * 30)
		zombie.translate(Vector3(0,0,delta * speed))
	

func set_target():
	angle = rng.randi_range(0, 360)
	speed = rng.randf_range(0, 2) 
