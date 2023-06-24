extends CharacterBody3D
class_name  Zombie

signal died

@export var maxHealth: float

var currentHealth: float:
	set = set_current_health

func _ready():
	print(maxHealth, currentHealth)
	currentHealth = maxHealth

func _process(delta):
	pass
	
func death():
	emit_signal("died")
	queue_free()
	
func set_current_health(h):
	currentHealth = h
	# TODO zombie animation
	if h <= 0:
		death()
