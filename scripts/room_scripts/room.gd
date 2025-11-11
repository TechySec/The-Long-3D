class_name Room extends Node3D

@export_group("Spawn positions")
@export var checkpoint_room:bool ## Ensure one of the spawn points are -99 for respawning.
@export var room_default_point : Marker3D
@export var room_spawn_positions : Dictionary[int, Marker3D] ## Make sure to rotate the Marker3D to be the rotation you want sade to be in.

## Changes the way how Sade and the camera work in this specific room.
@export var camera_mode:CameraHandler.CAMERA_MODE = CameraHandler.CAMERA_MODE.MODE_3D

@export_group("Lock camera position (2D ONLY!!!)")

## Sets the side view camera to a fixed position in the room instead of following Sade.
@export_custom(PROPERTY_HINT_GROUP_ENABLE, '')  var lock_camera:bool = false

## Position camera will be placed once locked.
@export var camera_position:Marker3D

## Makes the camera rotate towards the rotation that the marker has been set to in the Transform.
@export var inherit_marker_rotation:bool = false

@export_group("Room Music")
@export_custom(PROPERTY_HINT_GROUP_ENABLE, '') var set_song:bool = false
@export var song:AudioHandler.Music

var player:Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Player:
			player = child
			break
	
	Global.player = player
	
	player.cameraHandler.lock_camera = lock_camera
	
	player.cameraHandler.camera_mode = camera_mode
	
	if Global.next_room_position in room_spawn_positions:
		player.global_position = room_spawn_positions[Global.next_room_position].global_position
		if camera_mode == CameraHandler.CAMERA_MODE.MODE_3D:
			player.cameraHandler.global_rotation = Global.camera_rotation_pre_room_enter + room_spawn_positions[Global.next_room_position].global_rotation
	else:
		player.global_position = room_default_point.global_position
		if camera_mode == CameraHandler.CAMERA_MODE.MODE_3D:
			player.cameraHandler.global_rotation = room_default_point.global_rotation
			
	if set_song:
		AudioHandler.change_music(song)
		
func _process(delta: float) -> void:
	# i am not allowing you fucks to break this
	if lock_camera and camera_mode == CameraHandler.CAMERA_MODE.MODE_2D:
		player.cameraHandler.top_down_camera.global_position = camera_position.global_position
