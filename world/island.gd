@tool
extends Node3D

@export var level: int = 0

@onready var collision_shape: CollisionPolygon3D = $StaticBody3D/CollisionPolygon3D
@onready var mesh: CSGPolygon3D = $CSGPolygon3D
@onready var rect: Rect2 = bounds()

const SPAWNER = []
const PLAYER_SPAWNER = preload("res://world/logic/PlayerSpwaner.tscn")

var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	mesh.polygon = collision_shape.polygon
	$Area3D/CollisionPolygon3D.polygon = collision_shape.polygon
	$CSGCombiner3D/CSGPolygon3D.polygon = collision_shape.polygon
	if collision_shape.polygon.size() == 0:
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
	(level ** 2) * 2 + level * 4 + 4


func random_position() -> Vector3:
	var x = rng.randf_range(rect.position.x, rect.position.x + rect.size.x )
	var y = rng.randf_range(rect.position.y, rect.position.y + rect.size.y )
	return Vector3(x, 0 , y)



func is_valid_island_position(v: Vector3) -> bool:
	return true #todo

func is_valid_position(v: Vector3, scene, spawners: Array) -> bool:
	if not is_valid_island_position(v):
		return false
	for spawner in spawners:
		if spawner.position.distance_to(v) <= spawner.RADIUS + scene.RADIUS:
			return false
	return true
	

func generate_new_spawner(current_spawner): 
	pass


func procedural_generation():
	var current_difficulty = 0
	var target_diff = difficulity()
	var current_spawner = []
	
	var pos_p_spawner = random_position()
	while not is_valid_island_position(pos_p_spawner):
		pos_p_spawner = random_position()
	var p_spawn = PLAYER_SPAWNER.instantiate()
	p_spawn.position = pos_p_spawner
	current_spawner.append(p_spawn)
	while current_difficulty < target_diff:
		var pos = random_position()
		while not is_valid_position(pos,null, current_spawner):
			pos = random_position()
		

	
	for node in current_spawner:
		add_child(node)
	$Area3D.monitoring = false
	$Area3D.monitorable = false
	
	
