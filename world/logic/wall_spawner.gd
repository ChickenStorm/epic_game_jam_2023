extends Spawner

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	if not overlaps_area($"../Area3D"):
		queue_free()
		return
	
	rotate_y(rng.randf_range(0.0, 2.0 * PI))
