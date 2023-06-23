extends CharacterBody3D

@export var maxHealth: float
var currentHealth: float

func _ready():
	print(maxHealth, currentHealth)
	currentHealth = maxHealth

func _process(delta):
	if (currentHealth <= 0):
		death()
	
func death():
	queue_free()
