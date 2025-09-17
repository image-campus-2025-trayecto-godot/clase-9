extends Button

@export var menu: Control

func _toggled(toggled_on: bool) -> void:
	menu.visible = toggled_on
