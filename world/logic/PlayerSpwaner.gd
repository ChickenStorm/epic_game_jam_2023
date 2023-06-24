extends Spawner

signal spawned(node)
signal pre_ready()

const PALYER = preload("res://world/player/player.tscn")

func _generate(level):
	difficulity = 0
	range = 20


func _ready():
	emit_signal("pre_ready")
	difficulity = 0
	range = 20
	var parent = get_parent()
	for node in parent.get_children():
		if node is Player:
			return
	spawn_player()


func spawn_player():
	var player = PALYER.instantiate()
	player.position = position + Vector3.UP
	get_parent().add_child(player)
	emit_signal("spawned", player)
	visible = false	
