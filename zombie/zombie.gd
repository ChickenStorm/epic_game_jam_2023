extends CharacterBody3D
class_name Zombie

signal died()

@export var maxHealth: float

var is_dead = false

var currentHealth: float:
	set = set_current_health

func _ready():
	currentHealth = maxHealth
	$ZombieForm.visible = true
	$ChrysalidForm.visible = false

func _process(delta):
	pass
	
func death():
	if not is_dead:
		$"../../CanvasLayer/gui".zombie_transphormed += 1
		emit_signal("died")
	is_dead = true
	$ZombieForm.visible = false
	$ChrysalidForm.visible = true

	
func set_current_health(h):
	currentHealth = h
	# TODO zombie animation
	if h <= 0:
		death()
