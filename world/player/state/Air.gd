extends PlayerState
# State for when the player is jumping and falling.

@export var move_acceleration: = 5.0
@export var move_speed: = 15.0



#-----------------------------------------------------------------------------------------------
#	Fonctions de traitement


func physics_process(delta: float) -> void:
	_parent.physics_process(delta)

	if player.is_on_floor():
		_state_machine.transition_to("Move/Walk")
	elif player.is_on_ceiling():
		_parent.velocity.y = 0


#-----------------------------------------------------------------------------------------------
#	Fonction d'entrée et de sortie d'un state


func enter(data: Dictionary = {}) -> void:
	match data:
		{"velocity": var v, "jump_impulse": var ji}:
			_parent.velocity = Vector3(v.x, ji, v.z) # TODO
			#print(v)
	_parent.move_acceleration = move_acceleration
	_parent.move_speed = move_speed
	#skin.transition_to(skin.States.AIR)
	_parent.enter()


func exit() -> void:
	_parent.exit()
