extends PlayerState

#@export var max_angle = 47
@export var gravity = 1.5
@export var jump_impulse = 25
@export var move_acceleration: = 6.0
@export var move_speed: = 0.0
@export var max_fall_speed: = 50
@export_range(0.1, 20.0, 0.1) var rotation_speed_factor: float = 10.0

var velocity: = Vector3.ZERO


#-----------------------------------------------------------------------------------------------
#	Fonctions de traitement


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		_state_machine.transition_to("Move/Air", { velocity = velocity, jump_impulse = jump_impulse })
	elif event.is_action_pressed("attack"):
		player.attack()

func physics_process(delta: float) -> void:
	var input_direction: = get_input_direction()

	var forwards: Vector3 = player.camera.global_transform.basis.z * input_direction.z
	var right: Vector3 = player.camera.global_transform.basis.x * input_direction.x
	var move_direction: = input_direction
	if move_direction.length() > 1.0:
		move_direction = move_direction.normalized()
	move_direction.y = 0
	#skin.move_direction = move_direction
	

	# Rotation
	if move_direction:
		player.skin.rotation.y = lerp_angle(player.skin.rotation.y, atan2(move_direction.x, move_direction.z), delta * rotation_speed_factor)
	# Movement
	velocity = calculate_velocity(velocity, move_direction, delta)
	#debug
	if abs(velocity.y) >= max_fall_speed:
		get_tree().call_group_flags(2, "debug_color_indicator2", "set_frame_color", Color(1,0,0))
	else:
		get_tree().call_group_flags(2, "debug_color_indicator2", "set_frame_color", Color(1,1,1))
	get_tree().call_group_flags(2, "debug_label_move_acceleration", "set_text", str(snapped(move_acceleration, 0.001)))
	get_tree().call_group_flags(2, "debug_label_move_speed", "set_text", str(snapped(move_speed, 0.001)))
	get_tree().call_group_flags(2, "debug_label_direction", "set_text", str(Vector3(snapped(move_direction.x, 0.001), snapped(move_direction.y, 0.001), snapped(move_direction.z, 0.001))))
	get_tree().call_group_flags(2, "debug_label_velocity", "set_text", str(Vector3(snapped(velocity.x, 0.001), snapped(velocity.y, 0.001), snapped(velocity.z, 0.001))))
	get_tree().call_group_flags(2, "debug_label_velocity", "set_text", str(velocity.round()))
	if round(velocity.x) == 0 and round(velocity.z) == 0:
		get_tree().call_group_flags(2, "debug_color_indicator", "set_frame_color", Color(1,0,0))
	else:
		get_tree().call_group_flags(2, "debug_color_indicator", "set_frame_color", Color(1,1,1))

	player.velocity = velocity
	player.move_and_slide()
	
	#if player.translation.y < -10:
	#	player.translation = get_tree().get_nodes_in_group("respawn")[0].translation


#-----------------------------------------------------------------------------------------------
#	Fonction d'entrée et de sortie d'un state


func enter(_data: Dictionary = {}) -> void:
	pass


func exit() -> void:
	pass


#-----------------------------------------------------------------------------------------------
#	Fonction d'interprétation des inputs


func get_input_direction() -> Vector3:
	var v = Vector3(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			0,
			Input.get_action_strength("move_back") - Input.get_action_strength("move_front")
		) if _state_machine._do_input_delegation else Vector3.ZERO
	#print(v)
	return v


func calculate_velocity(
		velocity_current: Vector3,
		move_direction: Vector3,
		delta: float
	) -> Vector3:
		var velocity_new : Vector3 = lerp(velocity_current, move_direction * move_speed, delta * move_acceleration)
		velocity_new.y = velocity_current.y
		var gravity_resistance = player.get_floor_normal() if player.is_on_floor() else Vector3.UP
		velocity_new -= gravity * gravity_resistance
		if abs(velocity_new.y) > max_fall_speed:
			velocity_new.y = max_fall_speed * sign(velocity_new.y)
		get_tree().call_group_flags(2, "debug_label_gravity_resistance", "set_text", str(Vector3(snapped(gravity_resistance.x, 0.001), snapped(gravity_resistance.y, 0.001), snapped(gravity_resistance.z, 0.001))))
		return velocity_new
