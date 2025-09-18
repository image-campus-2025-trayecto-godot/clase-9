class_name Tower
extends Node2D

@onready var area_2d: Area2D = $Area2D
@onready var cannon: Node2D
@onready var shoot_timer: Timer = $ShootTimer
@export var cannon_scene: PackedScene
@onready var base: Sprite2D = $Base
@export var rotation_speed: float = 5.0
@export var time_between_shoots: float = 0.5
@onready var sell_button: Button = $SellButton
@onready var input_area: Area2D = $InputArea

signal sold

var enemies = []
var can_shoot: bool = true

func _ready() -> void:
	input_area.mouse_entered.connect(func():
		sell_button.visible = true
	)
	input_area.mouse_exited.connect(func():
		sell_button.visible = false
	)
	sell_button.visible = false
	sell_button.pressed.connect(sell)
	shoot_timer.wait_time = time_between_shoots
	cannon = cannon_scene.instantiate()
	base.add_child(cannon)
	area_2d.area_entered.connect(on_area_entered)
	area_2d.area_exited.connect(on_area_exited)

func set_cannon(cannon_scene):
	if cannon:
		cannon.queue_free()
	cannon = cannon_scene.instantiate()
	base.add_child(cannon)

func on_area_entered(an_area: Area2D) -> void:
	enemies.push_back(an_area)

func on_area_exited(an_area: Area2D) -> void:
	enemies.erase(an_area)

func shoot() -> void:
	if enemies.is_empty():
		return
	can_shoot = false
	cannon.shoot()
	shoot_timer.start()
	await shoot_timer.timeout
	can_shoot = true

func _process(delta: float) -> void:
	if enemies.is_empty():
		return
	var closest_enemy = _closest_enemy()
	
	var direction_to_enemy: Vector2 = cannon.global_position.direction_to(closest_enemy.global_position)
	var target_rotation: float = direction_to_enemy.angle()
	cannon.global_rotation = rotate_toward(cannon.global_rotation, target_rotation, delta * rotation_speed)
	
	if can_shoot:
		shoot()

func _closest_enemy() -> Node2D:
	var closest_enemy: Node2D = enemies.front()
	for enemy: Node2D in enemies:
		if enemy.global_position.distance_squared_to(global_position) < closest_enemy.global_position.distance_squared_to(global_position):
			closest_enemy = enemy
	return closest_enemy
	
func sell():
	sold.emit()
