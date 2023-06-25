@tool
extends Node3D
class_name Weapon

signal attacked(damage)

@export var damage : float = 1
@export var range: float = 1:
	set = set_range
@export var angle: float = 90:
	set = set_angle

@onready var range_area = $Range
@onready var attractor = $GPUParticlesAttractorBox3D

var reloadSpeed = 0.7
var canAttack = true

func _ready():
	scale_range()
	$Range/CSGPolygon3D.polygon = $Range/CollisionPolygon3D.polygon


func _process(delta):
	pass


func attack():
	if canAttack:
		$GPUParticles3D.emitting = true
		for node in range_area.get_overlapping_bodies():
			if node is Zombie:
				node.currentHealth -= damage
		emit_signal("attacked", damage)
		canAttack = false
		$ReloadTime.set_wait_time(reloadSpeed)
		$ReloadTime.start()


func scale_range():
	if range_area:
		range_area.scale = Vector3(range, 1 , range)


func set_range(value):
	if value <=0:
		return
	range = value
	scale_range()


func set_angle(value):
	if value <= 0 || value >= 180:
		return
	angle = value
	scale_range()


func _on_reload_time_timeout():
	canAttack = true
