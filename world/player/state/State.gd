extends Node
class_name State

@onready var _state_machine := _get_state_machine(self)

var _parent = null


#-----------------------------------------------------------------------------------------------
#	Initialisation


func _ready() -> void:
	await owner.ready
	var parent = get_parent()
	if not parent.is_in_group("state_machine"):
		_parent = parent
	print(_parent)


#-----------------------------------------------------------------------------------------------
#	Fonctions de traitemet


func unhandled_input(event: InputEvent) -> void:
	pass


func process(delta: float) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


#-----------------------------------------------------------------------------------------------
#	Fonction d'entrée et de sortie d'un state


func enter(data := {}) -> void:
	pass


func exit() -> void:
	pass


#-----------------------------------------------------------------------------------------------
#	Fonction setget


func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node
