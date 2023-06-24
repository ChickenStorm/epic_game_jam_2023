extends NPCState
class_name NPCAttack

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	await owner.ready
	zombie = owner


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta):
	zombie.look_at(target.position,Vector3.UP)
	zombie.translate(Vector3(0,0,delta * 5))
	
