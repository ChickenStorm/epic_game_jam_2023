@tool
extends Node3D

@export var level: int = 0

@onready var collision_shape: CollisionPolygon3D = $StaticBody3D/CollisionPolygon3D
@onready var mesh: CSGPolygon3D = $CSGPolygon3D
@onready var rect: Rect2 = bounds()

const SPAWNER = [
		preload("res://world/logic/zombie_spawner.tscn"),
		preload("res://world/logic/zombie_spawner.tscn"),
		preload("res://world/logic/TreeSpawner.tscn"),
		preload("res://world/logic/wall_spawner.tscn"),
	]
const PLAYER_SPAWNER = preload("res://world/logic/PlayerSpwaner.tscn")

var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	mesh.polygon = collision_shape.polygon
	$Area3D/CollisionPolygon3D.polygon = collision_shape.polygon
	$CSGCombiner3D/CSGPolygon3D.polygon = collision_shape.polygon
	procedural_generation()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func bounds() -> Rect2:
	var poly = collision_shape.polygon if collision_shape else []
	if poly.size() == 0:
		return Rect2(Vector2(0,0), Vector2(0,0))
	var max = poly[0]
	var min = poly[0]
	for v in poly:
		if v.x > max.x:
			max.x = v.x
		if v.y > max.y:
			max.y = v.y
		if v.x < min.x:
			min.x = v.x
		if v.y < min.y:
			min.y = v.y
	return Rect2(min, max - min)


func difficulity():
	return ((level ** 2) * 2 + level * 4 + 4) * 10


func random_position() -> Vector3:
	var x = rng.randf_range(rect.position.x, rect.position.x + rect.size.x )
	var y = rng.randf_range(rect.position.y, rect.position.y + rect.size.y )
#	print(x, y)
	return Vector3(x, 0, y) 



func is_valid_island_position(node: Spawner) -> bool:
	return true

func is_valid_position(node: Node, spawners: Array) -> bool:
#	if not is_valid_island_position(node):
#		return false
	for spawner in spawners:
		if spawner.position.distance_to(node.position) <= spawner.range + node.range:
			return false
	return true
	

func generate_new_spawner(current_spawner): 
	pass


func procedural_generation():
	var current_difficulty = 0
	var target_diff = difficulity()
	var current_spawner = []
	
	print(rect)
	var p_spawn = PLAYER_SPAWNER.instantiate()
	p_spawn.position = random_position()
	while not is_valid_island_position(p_spawn):
		p_spawn.position = random_position()
	current_spawner.append(p_spawn)
	add_child(p_spawn)
	
	
	
	while current_difficulty < target_diff:
		var node
		if current_spawner.size() < SPAWNER.size():
			node = SPAWNER[current_spawner.size()].instantiate()
		else:
			node = SPAWNER[rng.randi_range(0, SPAWNER.size()-1)].instantiate()
		node._generate(level)
		add_child(node)
		var pos = random_position()
		node.position = pos
		while not is_valid_position(node, current_spawner):
			pos = random_position()
			node.position = pos
		current_difficulty += node.difficulity
		current_spawner.append(node)

	
	await get_tree().process_frame
	
	if not $Area3D.overlaps_area(current_spawner[0]):
		print("in water")
		current_spawner[0].position.x = 0
		current_spawner[0].position.z = -10
		if $Player:
			$Player.position.x = 0
			$Player.position.z = -10
#	await get_tree().process_frame
	$Area3D.monitoring = false
	$Area3D.monitorable = false
	

