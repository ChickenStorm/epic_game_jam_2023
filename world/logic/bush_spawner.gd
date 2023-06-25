extends Spawner

const BUSH = preload("res://world/decoration/bushes.tscn")

var rng = RandomNumberGenerator.new()
var number_of_bush = 10
var range_spawning = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().physics_frame
	if not overlaps_area($"../Area3D"):
		queue_free()
		return
	var array_z = []
	for i in range(0, number_of_bush):
		var ok_pos = false
		var x
		var y
		while not ok_pos:
			# TODO check to avod infinit loop
			x = rng.randf_range(-range_spawning, range_spawning)
			y = rng.randf_range(-range_spawning, range_spawning)
			ok_pos = true
			for z in array_z:
				if z.distance_to(Vector3(x, 0, y)) <= 0.3:
					ok_pos = false
					break
		array_z.append(Vector3(x, 0, y))
	for v in array_z:
		var node = BUSH.instantiate()
		node.position = position + v
		node.rotate_y(rng.randf_range(0.0, 2.0 * PI))
		get_parent().add_child(node)
#		check_zombie(node)
	queue_free()


func _generate(_level):
	number_of_bush = rng.randi_range(4, 10)
	range = 1
	difficulity = 0
