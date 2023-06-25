extends Node3D
class_name Pickup

@export var health: float = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area3D.connect("area_entered", _on_entered)


func _on_entered(area):
	print("a")
	if area is Player:
		print("b")
		area.health += health
		queue_free()
