extends PlayerState

@export var move_acceleration: = 10.0
@export var move_speed: = 2.0

#-----------------------------------------------------------------------------------------------
#	Fonctions de traitement


func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if player.is_on_floor() and _parent.velocity.length() > 0.01:
		_state_machine.transition_to("Move/Walk")
	elif not player.is_on_floor():
		_state_machine.transition_to("Move/Air")


#-----------------------------------------------------------------------------------------------
#	Fonction d'entrée et de sortie d'un state


func enter(_data: Dictionary = {}) -> void:
	_parent.velocity = Vector3.ZERO
	_parent.move_acceleration = move_acceleration
	_parent.move_speed = move_speed
	#skin.transition_to(skin.States.IDLE)
	player.weapon.attractor.visible = false
	_parent.enter()


func exit() -> void:
	player.weapon.attractor.visible = true
	_parent.exit()
