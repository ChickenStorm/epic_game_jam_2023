extends NPCState
class_name NPCDeath

var direction = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta):
	zombie.rotation.x += delta * direction
	if zombie.rotation.x >= deg_to_rad(180) or zombie.rotation.x <= deg_to_rad(0):
		direction *= -1
