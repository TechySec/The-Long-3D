class_name Player extends CharacterBody3D

const MOVE_SPEED := 5.0
const ACCELERATION := 25.0
const WEIGHT := 150.0

var can_jump := true
var jump_height := 6.0

var max_jump_amt := 1
var cur_jump_amt := max_jump_amt
var is_fuckign_dead_oh_my_fucking_god_he_died_jesus_christ_he_died_waaa_waaa_waaa := false

@export var camera:Camera3D

@export var cameraHandler:CameraHandler

var layer_hop_destination := 0.0
var original_layer_position := 0.0

var no_wall_check_failed := false
var no_wall_failed_weight := 25.0

func _physics_process(delta: float) -> void:
	if is_fuckign_dead_oh_my_fucking_god_he_died_jesus_christ_he_died_waaa_waaa_waaa:
		if $RESPAWN_TIMER.is_stopped(): $RESPAWN_TIMER.start()
		return
		
	# oh my god there is no Y :(
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := Vector3(input.x, 0, input.y).normalized()
	if cameraHandler.camera_mode == CameraHandler.CAMERA_MODE.MODE_3D:
		direction = direction.rotated(Vector3.UP, camera.global_rotation.y)
		
		direction *= MOVE_SPEED
		velocity.x = move_toward(velocity.x, direction.x, delta * 9999999)
		velocity.z = move_toward(velocity.z, direction.z, delta * 9999999)
	else:
		velocity.x = direction.x * MOVE_SPEED
		
		if Input.is_action_just_pressed("forward_hop") and layer_hop_destination == 0:
			layer_hop_destination = -1
			original_layer_position = position.z
		
		if Input.is_action_just_pressed("backwards_hop") and layer_hop_destination == 0:
			layer_hop_destination = 1
			original_layer_position = position.z
		
		if is_on_wall() and layer_hop_destination != 0.0:
			no_wall_check_failed = true
			layer_hop_destination = 0.0
			
		if not no_wall_check_failed:
			var pos_check = (original_layer_position + layer_hop_destination) - position.z
			if layer_hop_destination < 0: pos_check = position.z - (original_layer_position + layer_hop_destination)
			
			if (pos_check <= 0) and layer_hop_destination != 0:
				layer_hop_destination = 0.0
			
			velocity.z = MOVE_SPEED * layer_hop_destination
		else:
			position.z = lerpf(position.z, original_layer_position, delta * no_wall_failed_weight)
			
			if absf(position.z - original_layer_position) <= 0:
				no_wall_check_failed = false
		
	
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	else:
		cur_jump_amt = max_jump_amt
		can_jump = true
	
	if can_jump and Input.is_action_just_pressed("jump"):
		velocity.y = jump_height
		cur_jump_amt -= 1
		if cur_jump_amt <= 0:
			can_jump = false
			
	if velocity.y > 0 and Input.is_action_just_released("jump"):
		velocity.y /= 2
	
	move_and_slide()
	

func kill():
	is_fuckign_dead_oh_my_fucking_god_he_died_jesus_christ_he_died_waaa_waaa_waaa = true


func _on_respawn_timer_timeout() -> void:
	get_tree().reload_current_scene()
