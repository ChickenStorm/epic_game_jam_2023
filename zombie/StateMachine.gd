extends Node

@onready var currentState = get_node('Roam')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	currentState.physics_process(delta)

func _on_aggro_zone_body_entered(body):
	currentState = get_node('Attack')
	currentState.target = body
	print("agrougrou")
