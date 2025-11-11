extends Node3D

@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var player:Player = $".."

@export var rotation_change_weight := 24.0

var has_grounded := false

func _ready() -> void:
	animation_player.speed_scale = 3.0
	animation_player.play("bounce")

func _process(delta: float) -> void:
	var destined_rotation:float
	
	if player.is_fuckign_dead_oh_my_fucking_god_he_died_jesus_christ_he_died_waaa_waaa_waaa:
		animation_player.stop()
		return
	if player.cameraHandler.camera_mode == CameraHandler.CAMERA_MODE.MODE_2D:
		if player.velocity.x > 0: destined_rotation = deg_to_rad(-115)
		elif player.velocity.x < 0: destined_rotation = deg_to_rad(-245)
		else: destined_rotation = deg_to_rad(-180)

		global_rotation.y = lerp_angle(global_rotation.y, destined_rotation, delta * rotation_change_weight)
	else:
		var look_position:Vector3 = global_position + Vector3(player.velocity.x, 0, player.velocity.z)
		if not global_position.is_equal_approx(look_position):
			look_at(look_position)

	if player.velocity.x != 0 and player.is_on_floor(): 
		animation_player.play("bounce")
	elif not player.is_on_floor(): 
		animation_player.play("animation")
	else:
		animation_player.play("idle")
