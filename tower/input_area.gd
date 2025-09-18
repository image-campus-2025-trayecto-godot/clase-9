extends Area2D

@onready var sell_button: Button = $"../SellButton"

func _ready() -> void:
	mouse_entered.connect(func():
		print("Mouse entered: %s" % get_parent().name)
	)
	mouse_exited.connect(func():
		print("Mouse exited: %s" % get_parent().name)
	)
