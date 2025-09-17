class_name TowerSpawner
extends TextureButton

@export var towers_container: Node2D
const TOWER = preload("res://tower/tower.tscn")
@onready var spawner_position: Control = $SpawnerPosition
@export var tower_selection_menu: Control
@onready var menu_position: Control = $MenuPosition

func _pressed() -> void:
	tower_selection_menu.visible = true
	tower_selection_menu.global_position = get_global_mouse_position()
	tower_selection_menu.spawn_position = spawner_position.global_position
	tower_selection_menu.tower_spawner = self

func on_tower_spawned():
	visible = false
