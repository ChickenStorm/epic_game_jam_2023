extends CharacterBody3D

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
	if h <= 0:
		death()
