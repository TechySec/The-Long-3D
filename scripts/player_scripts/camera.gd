class_name CameraHandler extends Node3D

enum CAMERA_MODE {
	MODE_2D = 0,
	MODE_3D = 1
}

@export var sensitivity := 0.005

@export_range(-90, 0, 0.1, "radians_as_degrees") var min_vertical_angle:float = -PI/2
@export_range(0.0, 90, 0.1, "radians_as_degrees") var max_vertical_angle:float = PI/4

var camera_mode:CAMERA_MODE = CAMERA_MODE.MODE_3D

@export var top_down_camera:Camera3D

@export var top_down_camera_weight := 12

@export var top_down_camera_distance := 2.0

@onready var main_camera:Camera3D = $SpringArm3D/Camera3D

func _init():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	var player:Player = get_parent()
	
	var player_vel_norm:Vector3 = player.velocity.normalized()
	if camera_mode == CAMERA_MODE.MODE_2D:
		top_down_camera.make_current()
		var camera_pos = Vector3 (
			player.global_position.x + player_vel_norm.x*top_down_camera_distance, 
			player.global_position.y + 2, 
			3
		)
		top_down_camera.global_position = lerp(top_down_camera.global_position, camera_pos, delta * top_down_camera_weight)
	else:
		main_camera.make_current()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if camera_mode == CAMERA_MODE.MODE_3D:
			rotation.y -= event.relative.x * sensitivity
			rotation.y = wrapf(rotation.y, 0.0, TAU)
			
			rotation.x -= event.relative.y * sensitivity
			rotation.x = clampf(rotation.x, min_vertical_angle, max_vertical_angle)
		
	if event is InputEventKey:
		if event.keycode == KEY_TAB and event.is_pressed():
			if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED: Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			else: Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
