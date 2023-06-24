extends MeshInstance3D

var time = 0

func _ready():
	pass


func _process(delta):
	time += delta
	position.y = -0.2 + 0.19 * sin(time  * PI)
