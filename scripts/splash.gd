extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -24.0)


func _on_button_button_down() -> void:
	print("Button Down")
	get_tree().change_scene_to_file("res://scenes/board.tscn")
