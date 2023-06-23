extends PlayerState

@export var move_acceleration: = 10.0
@export var move_speed: = 10.0


#-----------------------------------------------------------------------------------------------
#	Fonctions de traitement


func unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("run"):
	#	_state_machine.transition_to("Move/Run")
	_parent.unhandled_input(event)



func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if player.is_on_floor() or player.is_on_wall():
		if _parent.velocity.length() < 0.001:
			_state_machine.transition_to("Move/Idle")
	else:
		_state_machine.transition_to("Move/Air")


#-----------------------------------------------------------------------------------------------
#	Fonction d'entrée et de sortie d'un state


func enter(data: = {}) -> void:
	#skin.transition_to(skin.States.WALK)
	#skin.is_moving = true
	_parent.move_acceleration = move_acceleration
	_parent.move_speed = move_speed
	_parent.enter()


func exit() -> void:
	#skin.is_moving = false
	_parent.exit()
