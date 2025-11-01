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

@export var ball_count = 100

const game_width:int  = 720
const game_height:int = 1280

const midpoint: float = game_width/2.0


func make_buckets() -> void:

    var seperator_y:int = int(game_height * 0.6)
    #warning-ignore:integer_division
    var bucket_width:int = int(game_width / buckets)
    for bucket in (buckets - 1):
        var seperator = seperator_scene.instantiate()
        seperator.position = Vector2((bucket + 1) * bucket_width, seperator_y)
        add_child(seperator)


func create_pin_board() -> void:
    print("create_pin_board(", game_width, ")")
    # Center the first row pins
    var distance_between_pins: float = float(game_width) / float(num_of_pins_per_row)
    print("Distance between pins: ", distance_between_pins)
    var pinx_offset: float = 0
    for row in num_of_pin_rows:
        if row % 2 == 0:
            pinx_offset = midpoint
        else:
            pinx_offset = midpoint + distance_between_pins/2.0
        
        var piny: int = distance_between_rows * (4 + row)
        var midpin = pin_scene.instantiate()
        midpin.position = Vector2(pinx_offset, piny)
        add_child(midpin)

        # Start in the middle and work out.  Given that we need half the points
        var half_pin_count:int = int(num_of_pins_per_row / 2)
        for x in num_of_pins_per_row:
            var x_delta: float = (x+1) * distance_between_pins
            var pin_pos_x: float = pinx_offset + x_delta
            var pin_neg_x: float = pinx_offset - x_delta
            var pinA = pin_scene.instantiate()
            var pinB = pin_scene.instantiate()
            pinA.position = Vector2(pin_pos_x, piny)
            add_child(pinA)
            pinB.position = Vector2(pin_neg_x, piny)
            add_child(pinB)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    
    
    # Seed random numbers
    randomize()
    $CountDown.text = str(ball_count)
    add_camera()
    
    print("_ready create pin board")
    create_pin_board()
    
    print("_ready make buckets")
    make_buckets()
    # drop_ball_test()
    # print("_ready() drop ball")
    drop_ball(0.0)

func drop_ball(delta: float) -> void:
    # print("drop ball called")
    var ball = ball_scene.instantiate()
    var bally:int = -50
    
    var fuzz : float = randf()/1.0 - 0.5
    var ballx: float = midpoint + fuzz
    ball.position = Vector2(ballx, bally)
    ball.angular_velocity = delta + (fuzz * 6.0)
    add_child(ball)

func add_camera() -> void:
    var cam = Camera2D.new()
    # cam.current = true
    cam.position = Vector2(360,640) # Center of 720x1280
    add_child(cam)
    
    var screen_size = get_viewport().size
    var target_size = Vector2i(game_width, game_height)
    cam.zoom = target_size/screen_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if ball_count > 0 :
        total_delta += delta
        # print(total_delta)
        if total_delta > seconds_per_ball:
            total_delta = 0.0
            ball_count += -1
            $CountDown.text = str(ball_count)
            # print(ball_count)
            drop_ball(delta) 
