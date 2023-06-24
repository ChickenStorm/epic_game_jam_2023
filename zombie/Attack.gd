extends Node

var rng = RandomNumberGenerator.new()
var zombie
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	await owner.ready
	zombie = owner
	player = Vector3(0, 0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	zombie.look_at(player,Vector3.UP)
	zombie.translate(Vector3(0,0,delta * 5))
	
