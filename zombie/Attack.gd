extends NPCState
class_name NPCAttack

var rng = RandomNumberGenerator.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta):
	var initial_rotation = zombie.rotation
	zombie.look_at(target.global_position)
	zombie.rotation.x = initial_rotation.x
	zombie.rotation.z = initial_rotation.z
	zombie.translate(Vector3(0,0,delta * -5))
