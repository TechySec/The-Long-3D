class_name Room extends Node3D

@export var room_default_point : Marker3D
@export var room_spawn_positions : Dictionary[int, Marker3D] ## Make sure to rotate the Marker3D to be the rotation you want sade to be in.

@export var camera_mode:CameraHandler.CAMERA_MODE = CameraHandler.CAMERA_MODE.MODE_3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player:Player
	
	for child in get_children():
		if child is Player:
			player = child
			break
			
	player.cameraHandler.camera_mode = camera_mode
	
	if Global.next_room_position in room_spawn_positions:
		player.global_position = room_spawn_positions[Global.next_room_position].global_position
		if camera_mode == CameraHandler.CAMERA_MODE.MODE_3D:
			player.cameraHandler.global_rotation = Global.camera_rotation_pre_room_enter + room_spawn_positions[Global.next_room_position].global_rotation
	else:
		player.global_position = room_default_point.global_position
		if camera_mode == CameraHandler.CAMERA_MODE.MODE_3D:
			player.cameraHandler.global_rotation = room_default_point.global_rotation
		else:
			player.rotation.y = deg_to_rad(-90)
			print(player.rotation)
