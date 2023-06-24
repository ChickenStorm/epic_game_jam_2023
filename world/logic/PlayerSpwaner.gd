extends Spawner

signal spawned(node)

const PALYER = preload("res://world/player/player.tscn")


func _ready():
	var parent = get_parent()
	for node in parent.get_children():
		if node is Player:
			return
	spawn_player()


func spawn_player():
	var player = PALYER.instantiate()
	get_parent().add_child(player)
	emit_signal("spawned", player)
	visible = false	
