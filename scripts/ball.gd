extends RigidBody2D

const PingSound = preload("res://Assets/Sound/A.ogg")

func _on_body_entered(body: Node) -> void:
    print("Body Entered")
