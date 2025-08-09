extends Node2D

var pin_scene = preload("res://scenes/pin.tscn")
var ball_scene = preload("res://scenes/ball.tscn")
var seperator_scene = preload("res://scenes/seperator.tscn")

@export var num_of_pins_per_row: int = 15
@export var num_of_pin_rows: int = 5
@export var distance_between_rows: int
@export var seconds_per_ball: float
var total_delta: float = 0.0
@export var buckets: int
var midpoint: float = 0
@export var ball_count = 100


func make_buckets(game_width: int, game_height: int) -> void:

	var seperator_y:int = int(game_height * 0.75)
	#warning-ignore:integer_division
	var bucket_width:int = int(game_width / buckets)
	for bucket in (buckets - 1):
		var seperator = seperator_scene.instantiate()
		seperator.position = Vector2((bucket + 1) * bucket_width, seperator_y)
		add_child(seperator)


func create_pin_board(game_width: int) -> void:

	# Center the first row pins
	var distance_between_pins: int = game_width / num_of_pins_per_row
	var pinx_offset: int = 0
	for row in num_of_pin_rows:
		if row % 2 == 0:
			pinx_offset = distance_between_rows
		else:
			pinx_offset = int(distance_between_rows / 2)

		for x in num_of_pins_per_row:
			var pinx: int = pinx_offset + (x * distance_between_pins)
			var piny: int = distance_between_rows * (4 + row)
			var pin = pin_scene.instantiate()
			pin.position = Vector2(pinx, piny)
			add_child(pin)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var viewport_size = get_viewport().size
	midpoint = viewport_size.x/2.0
	
	# Seed random numbers
	randomize()
	
	create_pin_board(viewport_size.x)
	
	make_buckets(viewport_size.x, viewport_size.y)
	
	drop_ball()


func drop_ball() -> void:
	# print("drop ball called")
	var ball = ball_scene.instantiate()
	var bally:int = -50
	
	var fuzz : float = randf()/2.0 - 0.25
	var ballx: float = midpoint + fuzz
	ball.position = Vector2(ballx, bally)
	add_child(ball)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ball_count > 0 :
		total_delta += delta
		# print(total_delta)
		if total_delta > seconds_per_ball:
			total_delta = 0.0
			ball_count += -1
			drop_ball() 
