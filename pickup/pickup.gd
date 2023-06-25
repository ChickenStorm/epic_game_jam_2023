extends Node3D
class_name Pickup

@export var health: float = 50

# Called when the node enters the scene tree sfor the first time.
func _ready():
	$Area3D.connect("body_entered", _on_entered)


func _on_entered(area):
	if area is Player:
		area.current_health += health
		queue_free()
