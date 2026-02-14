extends RigidBody2D

const PING_SOUNDS = [
	preload("res://Assets/Sound/A.ogg"),
	preload("res://Assets/Sound/D.ogg"),
	preload("res://Assets/Sound/F.ogg")
]

var _audio_player: AudioStreamPlayer

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 16
	_audio_player = AudioStreamPlayer.new()
	add_child(_audio_player)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("pin"):
		_play_random_ping()

func _on_body_shape_entered(_body_rid: RID, _body: Node, _body_shape_index: int, _local_shape_index: int) -> void:
	pass

func _play_random_ping() -> void:
	_audio_player.stream = PING_SOUNDS.pick_random()
	_audio_player.play()
