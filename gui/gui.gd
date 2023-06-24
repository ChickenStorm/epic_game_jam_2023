extends Control

var max_life = 100:
	set(value):
		max_life = value
		if progress:
			progress.max_value = value


var life = 100:
	set(value):
		life = value
		if progress:
			progress.value = value

var zombie_transphormed = 0:
	set(value):
		zombie_transphormed = value
		if label:
			label.text = str(zombie_transphormed)


@onready var progress = $VBoxContainer/VBoxContainer/PanelContainer/MarginContainer/HBoxContainer/ProgressBar
@onready var label = $VBoxContainer/VBoxContainer/PanelContainer/MarginContainer/HBoxContainer/LabelZ

# Called when the node enters the scene tree for the first time.
func _ready():
	progress.max_value = max_life
	progress.value = life
	label.text = str(zombie_transphormed)


