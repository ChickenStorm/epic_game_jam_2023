extends Area3D
class_name Spawner

signal generated()

@export var range: float = 10
@export var difficulity: int = 1


func _generate(_level):
	emit_signal("generated")
