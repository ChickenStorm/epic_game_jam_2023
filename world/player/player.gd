@tool
class_name Player
extends CharacterBody3D

signal died()
signal attacked()


@export var max_health: float

@onready var current_health: float = max_health:
	set = set_current_health
@onready var state_machine:StateMachine = $StateMachine
@onready var weapon: Weapon = $weapon

var camera: Camera3D

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node("Camera3D")
	if not camera && Engine.is_editor_hint():
		update_configuration_warnings()


func _get_configuration_warnings(): 
	if not camera:
		return "missing Camera3D as a children"
	else:
		return []


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func death():
	emit_signal("died")
	# TODO


func attack():
	if weapon:
		weapon.attack()
		emit_signal("attacked")


func set_current_health(h):
	current_health = h
	if h <= 0:
		death()
