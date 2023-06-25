extends Area3D

var take_damage = 0
var area_player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", _on_attack_zone_area_entered)
	connect("area_exited" , _on_area_exited)
	$Timer.connect("timeout", _on_timeout)


func _on_timeout():
	area_player.current_health -= $"..".damage 


func _on_area_exited(_area):
	for node in get_overlapping_bodies():
		if node is Player:
			return
	stop_attack()


func stop_attack():
	area_player = null
	$Timer.stop()

func _on_attack_zone_area_entered(_area):
	for node in get_overlapping_bodies():
		if node is Player:
			node.current_health -= $"..".damage
			if not $"../AudioStreamPlayer3D".is_playing():
				$"../AudioStreamPlayer3D".play()
			area_player = node
			$Timer.start()
