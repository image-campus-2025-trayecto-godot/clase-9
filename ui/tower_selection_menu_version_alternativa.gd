extends PanelContainer

@export var cannon_types: Dictionary[String, PackedScene] = {
	"Simple": preload("res://tower/cannons/cannon.tscn"),
	"Double": preload("res://tower/cannons/cannon_double.tscn"),
	"Rocket": preload("res://tower/cannons/cannon_rocket.tscn")
}
@onready var buttons_container: VBoxContainer = %ButtonsContainer

const TOWER = preload("res://tower/tower.tscn")
@export var towers_container: Node2D
var tower_spawner: TowerSpawner

func _ready() -> void:
	for button_name in cannon_types.keys():
		var button = Button.new()
		buttons_container.add_child(button)
		button.text = button_name
		button.pressed.connect(func():
			var cannon_scene = cannon_types[button_name]
			spawn_tower(cannon_scene)
		)

func spawn_tower(cannon_scene: PackedScene):
	tower_spawner.cannon_was_chosen(cannon_scene)
	visible = false
