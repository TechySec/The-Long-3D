class_name CameraHandler extends Node3D

enum CAMERA_MODE {
	MODE_2D,
	MODE_3D
}

@export var sensitivity := 0.005

@export_range(-90, 0, 0.1, "radians_as_degrees") var min_vertical_angle:float = -PI/2
@export_range(0.0, 90, 0.1, "radians_as_degrees") var max_vertical_angle:float = PI/4

var camera_mode:CAMERA_MODE = CAMERA_MODE.MODE_3D

func _init():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	if camera_mode == CAMERA_MODE.MODE_2D:
		pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and camera_mode == CAMERA_MODE.MODE_3D:
		rotation.y -= event.relative.x * sensitivity
		rotation.y = wrapf(rotation.y, 0.0, TAU)
		
		rotation.x -= event.relative.y * sensitivity
		rotation.x = clampf(rotation.x, min_vertical_angle, max_vertical_angle)
		
	if event is InputEventKey:
		if event.keycode == KEY_TAB and event.is_pressed():
			if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED: Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			else: Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
