
extends Spawner
class_name ZombieSpawner

const ZOMB = preload("res://zombie/zombie.tscn")

var rng = RandomNumberGenerator.new()
var zombie_nuber = 1


func _ready():
	await get_tree().process_frame
	if not overlaps_area($"../Area3D"):
		queue_free()
		return
	var array_z = []
	for i in range(0, zombie_nuber):
		var ok_pos = false
		var x
		var y
		while not ok_pos:
			# TODO check to avod infinit loop
			x = rng.randf_range(-range, range)
			y = rng.randf_range(-range, range)
			ok_pos = true
			for z in array_z:
				if z.distance_to(Vector3(x, 1, y)) <= 1.5:
					ok_pos = false
					break
		array_z.append(Vector3(x, 1, y))
	for v in array_z:
		var node = ZOMB.instantiate()
		node.position = position + v
		$"../Zombies".add_child(node)
		check_zombie(node)
	queue_free()


func check_zombie(node: Zombie):
	pass
#	await get_tree().process_frame
#	if not $"../Area3D".overlaps_body(node):
#		node.death()
	

func _generate(level):
	zombie_nuber = rng.randi_range(level + 1, level * 2 + 4)
	difficulity = zombie_nuber
	range = 8 + zombie_nuber
