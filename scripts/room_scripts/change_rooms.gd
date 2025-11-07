extends Area3D


@export_file("*.tscn") var destination : String
@export var destination_position : int

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		Global.next_room_position = destination_position
		Global.camera_rotation_pre_room_enter = body.cameraHandler.rotation
		get_tree().change_scene_to_file(destination)
