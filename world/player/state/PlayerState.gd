extends State
class_name PlayerState
# Base type for the player's state classes. Contains boilerplate code to get
# autocompletion and type hints.

var player: Player
#var skin: Mannequiny


#-----------------------------------------------------------------------------------------------
#	Initialisation


func _ready() -> void:
	super._ready()
	await owner.ready
	player = owner
	#skin = owner.skin
