@tool
class_name Player
extends CharacterBody3D

signal died()
signal attacked()


@export var max_health: float

@onready var current_health: float = max_health:
	set = set_current_health
@onready var state_machine:StateMachine = $StateMachine

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func death():
	emit_signal("died")
	# TODO


func attack():
	#
	emit_signal("attack")

func set_current_health(h):
	current_health = h
	if h <= 0:
		death()
