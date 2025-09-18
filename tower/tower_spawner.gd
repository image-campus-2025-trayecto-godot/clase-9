class_name TowerSpawner
extends TextureButton

const TOWER = preload("res://tower/tower.tscn")
@onready var spawner_position: Control = $SpawnerPosition
@export var tower_selection_menu: Control
@onready var menu_position: Control = $MenuPosition
var spawned_tower: Tower

signal cannon_chosen(cannon_scene)

func _pressed() -> void:
	tower_selection_menu.visible = true
	tower_selection_menu.global_position = get_global_mouse_position()
	tower_selection_menu.tower_spawner = self

func cannon_was_chosen(cannon_scene):
	cannon_chosen.emit(cannon_scene)
