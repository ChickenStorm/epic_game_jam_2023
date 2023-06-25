extends Node

@onready var currentState = get_node('Roam')
@onready var zombie = get_owner()
@onready var angryMaterial = preload("res://zombie/angry.tres")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	currentState.physics_process(delta)

func _on_aggro_zone_body_entered(body):
	zombie.get_node("Aggro").play()
	currentState = get_node('Attack')
	currentState.target = body
	zombie.zombie_form.set_surface_override_material(0, angryMaterial)
	print("agrougrou")


func _on_zombie_died():
	currentState = get_node("Death")
	print("argh")
	zombie.rotation.z = 90.0
	zombie.get_node("Collision").disabled = true
	zombie.get_node("AttackZone").stop_attack()
	zombie.get_node("AttackZone").disconnect("area_exited", Callable(zombie.get_node("AttackZone"), "_on_area_exited"))
	zombie.get_node("AttackZone").monitoring = false
	zombie.get_node("AttackZone").monitorable = false
	zombie.get_node("AggroZone").monitoring = false
	zombie.get_node("AggroZone").monitorable = false
