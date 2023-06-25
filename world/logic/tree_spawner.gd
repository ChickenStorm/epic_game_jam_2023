extends Spawner

const TREE = preload("res://world/decoration/tree.tscn")

var rng = RandomNumberGenerator.new()
var number_of_tree = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	if not overlaps_area($"../Area3D"):
		queue_free()
		return
	var array_z = []
	for i in range(0, number_of_tree):
		var ok_pos = false
		var x
		var y
		while not ok_pos:
			x = rng.randf_range(-range, range)
			y = rng.randf_range(-range, range)
			ok_pos = true
			for z in array_z:
				if z.distance_to(Vector3(x, 3, y)) <= 1:
					ok_pos = false
					break
		array_z.append(Vector3(x, 3, y))
	for v in array_z:
		var node = TREE.instantiate()
		node.position = position + v
		node.rotate_y(rng.randf_range(0.0, 2.0 * PI))
		get_parent().add_child(node)
#		check_zombie(node)
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _generate(level):
	number_of_tree = rng.randi_range(4, 8)
	range = 4 + number_of_tree / 2
