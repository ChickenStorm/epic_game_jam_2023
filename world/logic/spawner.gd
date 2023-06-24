extends Area3D
class_name Spawner

signal generated()

@export var range: float = 10
@export var difficulity: int = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _generate(level):
	emit_signal("generated")
