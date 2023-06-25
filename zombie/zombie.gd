extends CharacterBody3D
class_name Zombie

signal died()

@export var maxHealth: float
@export var damage : float = 10

var is_dead = false
var is_in_water = false

var currentHealth: float:
	set = set_current_health



func _ready():
	currentHealth = maxHealth
	$ZombieForm.visible = true
	$ChrysalidForm.visible = false
	
	# we remove watery zombies
	await get_tree().process_frame

	if not $"../../Area3D".overlaps_body(self):
		is_in_water = true
		queue_free()
		print("ploof")
		check_win_game()


func check_win_game():
	var zombie_transformed = $"../../../CanvasLayer/gui".zombie_transphormed
	var count = 0
	for node in get_parent().get_children():
		if node is Zombie && not node.is_in_water:
			count += 1
	if zombie_transformed == count:
		get_tree().change_scene_to_file("res://menu/GameSuccess.tscn")


func death():
	if not is_dead:
		var zombie_transformed = $"../../../CanvasLayer/gui".zombie_transphormed
		zombie_transformed += 1
		check_win_game()
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
