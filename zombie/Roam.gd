extends Node

var time_since_action = 0
@export var action_interval = 3
var angle = 0
var speed = 0
var rng = RandomNumberGenerator.new()
var zombie 

# Called when the node enters the scene tree for the first time.
func _ready():
	await owner.ready
	zombie = owner
	time_since_action = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
