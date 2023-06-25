extends Label

const VERSION = preload("res://version.tres")

func _ready():
	text = VERSION.version
