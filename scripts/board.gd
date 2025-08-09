extends Node2D

var pin_scene = preload("res://scenes/pin.tscn")
var ball_scene = preload("res://scenes/ball.tscn")

const num_of_pins_per_row: int = 15
const num_of_pin_rows: int = 5
@export var distance_between_rows: int


func create_pin_board() -> void:
	var viewport_size = get_viewport().size

	var distance_between_pins: int = viewport_size.x / num_of_pins_per_row
	var pinx_offset: int = 0
	for row in num_of_pin_rows:
		if row % 2 == 0:
			pinx_offset = distance_between_rows
		else:
			pinx_offset = distance_between_rows / 2

		for x in num_of_pins_per_row:
			var pinx: int = pinx_offset + (x * distance_between_pins)
			var piny: int = distance_between_rows * (4 + row)
			var pin = pin_scene.instantiate()
			pin.position = Vector2(pinx, piny)
			add_child(pin)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	create_pin_board()
	
	var ball1 = ball_scene.instantiate()
	ball1.position = Vector2(100, 100)
	add_child(ball1)
	var ball2 = ball_scene.instantiate()
	ball2.position = Vector2(400, -100)
	add_child(ball2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
