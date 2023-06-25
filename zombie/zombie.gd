extends CharacterBody3D
class_name Zombie

signal died()

@export var maxHealth: float
@export var damage : float = 10

var is_dead = false

var currentHealth: float:
	set = set_current_health

func _ready():
	currentHealth = maxHealth
	$ZombieForm.visible = true
	$ChrysalidForm.visible = false
	
	# we remove watery zombies
	await get_tree().process_frame
	if $"../../Area3D".overlaps_body(self):
		queue_free()

func _process(delta):
	pass


func death():
	if not is_dead:
		var zombie_transformed = $"../../../CanvasLayer/gui".zombie_transphormed
		zombie_transformed += 1
		if zombie_transformed == get_parent().get_child_count():
			get_tree().change_scene_to_file("res://menu/GameSuccess.tscn")
		$"../../../CanvasLayer/gui".zombie_transphormed = zombie_transformed	
		emit_signal("died")
	is_dead = true
	$ZombieForm.visible = false
	$ChrysalidForm.visible = true

	
func set_current_health(h):
	currentHealth = h
	# TODO zombie animation
	if h <= 0:
		death()


func _on_attack_zone_area_entered(area):
	for node in $AttackZone.get_overlapping_bodies():
		if node is Player:
			node.current_health -= damage
