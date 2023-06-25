@tool
class_name Player
extends CharacterBody3D

signal died()
signal attacked()


@export var max_health: float


@onready var state_machine:StateMachine = $StateMachine
@onready var weapon: Weapon = $skin/weapon
@onready var skin: = $skin

var current_health: float:
	set = set_current_health

var camera: Camera3D

# Called when the node enters the scene tree for the first time.
func _ready():
	set_current_health(max_health)
	camera = get_node("Camera3D")
	if not camera && Engine.is_editor_hint():
		update_configuration_warnings()
	if $"../../CanvasLayer/gui":
		$"../../CanvasLayer/gui".life = current_health
		$"../../CanvasLayer/gui".max_life = max_health


func _get_configuration_warnings(): 
	if not camera:
		return "missing Camera3D as a children"
	else:
		return []


func death():
	emit_signal("died")
	get_tree().change_scene_to_file("res://menu/GameOver.tscn")


func attack():
	if weapon:
		weapon.attack()
		$attack.play()
		emit_signal("attacked")
	var node = $"../../BackgroundAudioManager"
	node.is_attacking = true


func set_current_health(h):
	var back_health = current_health
	current_health = min(max_health, h)
	var hud = $"../../CanvasLayer/gui"
	if hud:
		hud.life = current_health
		if h < back_health:
			$Camera3D/AnimationPlayer.play("health")
			$DmgReceived.play(0)
	if h <= 0:
		death()
