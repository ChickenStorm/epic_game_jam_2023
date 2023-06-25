extends Spawner

var rng = RandomNumberGenerator.new()

const WALL = [
		preload("res://world/decoration/wall_1.tscn"),
		preload("res://world/decoration/wall_2.tscn"),
		preload("res://world/decoration/wall_3.tscn"),
		preload("res://world/decoration/wall_4.tscn"),
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	var node = WALL[rng.randi_range(0, WALL.size() - 1)].instantiate()
	add_child(node)
	await get_tree().process_frame
	if not overlaps_area($"../Area3D"):
		queue_free()
		return
	
	rotate_y(rng.randf_range(0.0, 2.0 * PI))
