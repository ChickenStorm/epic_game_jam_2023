extends Spawner

var rng = RandomNumberGenerator.new()

const WALL = [
		preload("res://world/decoration/wall_1.tscn"),
		preload("res://world/decoration/wall_2.tscn"),
		preload("res://world/decoration/wall_3.tscn"),
		preload("res://world/decoration/wall_4.tscn"),
	]

var node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(node)
	node = null
	await get_tree().physics_frame
	if not overlaps_area($"../Area3D"):
		queue_free()
		return
	rotate_y(rng.randf_range(0.0, 2.0 * PI))


func _generate(_level):
	node = WALL[rng.randi_range(0, WALL.size() - 1)].instantiate()
	difficulity = node.difficulty if node else 1
