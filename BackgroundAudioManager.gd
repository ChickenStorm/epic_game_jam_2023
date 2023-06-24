extends Node

@export var is_attacking: bool = false:
	set = set_is_attacking

@onready var metal = $Metal
@onready var funk = $Funk



func _ready():
	metal.connect("finished", _replay_metal)
	funk.connect("finished", _replay_funk)
	$Timer.connect("timeout", _on_timeout)
	metal.volume_db = -80
	funk.volume_db = -4


func _on_timeout():
	play_funk()

func _replay_metal():
	metal.play()


func _replay_funk():
	funk.play()


func play_funk():
#	await metal.finished
	metal.volume_db = -80
	funk.volume_db = -4


func play_metal():
#	await metal.finished
	metal.volume_db = -4
	funk.volume_db = -80


func set_is_attacking(value):
	is_attacking = value
	if not is_attacking:
		play_funk()
	else:
		play_metal()
		$Timer.start()
	
