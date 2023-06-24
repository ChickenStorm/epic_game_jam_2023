extends Node3D

@export var level: int = 0

@onready var collision_shape: CollisionPolygon3D = $StaticBody3D/CollisionPolygon3D



# Called when the node enters the scene tree for the first time.
func _ready():
	if collision_shape.polygon.size() == 0:
		generate_poly()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func generate_poly():
	var array = PackedVector2Array([])
	# todo


func procedural_generation():
	pass
	# todo
