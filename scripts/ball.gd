extends RigidBody2D

const PingSound = preload("res://Assets/Sound/A.ogg")

func _on_body_entered(_body: Node) -> void:
    print("Body Entered")


func _on_body_shape_entered(_body_rid: RID, _body: Node, _body_shape_index: int, _local_shape_index: int) -> void:
    print("on_body_shape_entered")
