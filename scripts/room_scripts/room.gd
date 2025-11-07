class_name Room extends Node3D

@export var room_default_point : Marker3D
@export var room_spawn_positions : Dictionary[int, Marker3D] ## Make sure to rotate the Marker3D to be the rotation you want sade to be in.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player:Player
	
	for child in get_children():
		if child is Player:
			player = child
			break
	
	if Global.next_room_position in room_spawn_positions:
		player.global_position = room_spawn_positions[Global.next_room_position].global_position
		player.global_rotation = room_spawn_positions[Global.next_room_position].global_rotation
	else:
		player.global_position = room_default_point.global_position
		player.global_rotation = room_default_point.global_rotation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
