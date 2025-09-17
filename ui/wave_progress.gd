extends ProgressBar

@onready var label: Label = $Label

func _ready() -> void:
	changed.connect(self.update_progress_as_text)
	value_changed.connect(func(_value):
		self.update_progress_as_text()
	)

func update_progress_as_text():
	label.text = "%d / %d" % [value, max_value]
