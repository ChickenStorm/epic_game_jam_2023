extends Node
class_name NPCState

var target: CharacterBody3D
var zombie: CharacterBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	await owner.ready
	zombie = owner
