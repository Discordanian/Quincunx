extends Node2D

var pin_scene = preload("res://scenes/pin.tscn")
var ball_scene = preload("res://scenes/ball.tscn")

const num_of_pins_per_row: int = 15
const num_of_pin_rows: int = 5
@export var distance_between_rows: int
@export var balls_per_second: int
var total_delta: float = 0.0


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
	
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.autostart = true
	timer.connect("timeout", drop_ball)
	
	drop_ball()
	


func drop_ball() -> void:
	print("drop ball called")
	var ball = ball_scene.instantiate()
	var bally:int = -50
	
	var ballx = randi() % (350 - 250 + 1) + 250
	ball.position = Vector2(ballx, bally)
	add_child(ball)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	total_delta += delta
	print(total_delta)
	if total_delta > 1:
		total_delta = 0.0
		drop_ball() 
