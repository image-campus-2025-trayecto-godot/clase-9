extends PanelContainer

const CANNON = preload("res://tower/cannons/cannon.tscn")
const CANNON_DOUBLE = preload("res://tower/cannons/cannon_double.tscn")
const CANNON_ROCKET = preload("res://tower/cannons/cannon_rocket.tscn")

@onready var simple: Button = %Simple
@onready var double: Button = %Double
@onready var rocket: Button = %Rocket
const TOWER = preload("res://tower/tower.tscn")
@export var towers_container: Node2D
var spawn_position: Vector2
var tower_spawner: TowerSpawner

func _ready() -> void:
	simple.pressed.connect(func(): spawn_tower(CANNON))
	double.pressed.connect(func(): spawn_tower(CANNON_DOUBLE))
	rocket.pressed.connect(func(): spawn_tower(CANNON_ROCKET))

func spawn_tower(cannon_scene: PackedScene):
	var tower = TOWER.instantiate()
	tower.cannon_scene = cannon_scene
	towers_container.add_child(tower)
	tower.global_position = spawn_position
	visible = false
	tower_spawner.on_tower_spawned()
