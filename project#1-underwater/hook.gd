extends AnimatableBody2D

@export var move_distance: float = 100.0
@export var move_speed: float = 2.0
@export var start_offset: float = 0.0

var starting_y: float
var time: float = 0.0


func _ready() -> void:
	starting_y = position.y
	time = start_offset


func _physics_process(delta: float) -> void:
	time += delta * move_speed
	position.y = starting_y + sin(time) * move_distance
