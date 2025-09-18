extends Node2D

@export var tower_selection_menu: Control
@onready var tower_spawner: TowerSpawner = $TowerSpawner
@onready var tower: Tower = $Tower

func _ready():
	tower_spawner.tower_selection_menu = tower_selection_menu
	tower_spawner.cannon_chosen.connect(on_cannon_chosen)
	tower.sold.connect(on_tower_sold)

func on_cannon_chosen(cannon_scene):
	tower_spawner.visible = false
	tower.visible = true
	tower.set_cannon(cannon_scene)
	tower.process_mode = Node.PROCESS_MODE_INHERIT

func on_tower_sold():
	tower.visible = false
	tower.process_mode = Node.PROCESS_MODE_DISABLED
	tower_spawner.visible = true
