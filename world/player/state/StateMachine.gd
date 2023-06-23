extends Node
class_name StateMachine

signal transitioned(state_path)

export var initial_state := NodePath()

onready var state: State = get_node(initial_state) setget set_state
onready var _state_name := state.name

var _do_input_delegation = true


#-----------------------------------------------------------------------------------------------
#	Initialisation


func _init() -> void:
	add_to_group("state_machine")


func _ready() -> void:
	yield(owner, "ready")
	state.enter()


#-----------------------------------------------------------------------------------------------
#	Délégation des fonctions de traitement au state actuel


func _unhandled_input(event: InputEvent) -> void:
	if _do_input_delegation:
		state.unhandled_input(event)


func _process(delta: float) -> void:
	state.process(delta)


func _physics_process(delta: float) -> void:
	state.physics_process(delta)


#-----------------------------------------------------------------------------------------------
#	Passage d'un state a un autre


func transition_to(target_state_path: String, data: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		return

	var target_state := get_node(target_state_path)

	state.exit()
	self.state = target_state
	state.enter(data)
	emit_signal("transitioned", target_state_path)
	get_tree().call_group_flags(2, "debug_label_state", "set_text", _state_name)


#-----------------------------------------------------------------------------------------------
#	Fonction setget


func set_state(value: State) -> void:
	state = value
	_state_name = state.name
