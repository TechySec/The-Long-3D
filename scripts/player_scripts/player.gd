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

#@export var model:Node3D

func _physics_process(delta: float) -> void:
	if is_fuckign_dead_oh_my_fucking_god_he_died_jesus_christ_he_died_waaa_waaa_waaa:
		return
	
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
	
	# oh my god there is no Y :(
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := Vector3(input.x, 0, input.y).normalized()
	
	direction = direction.rotated(Vector3.UP, camera.global_rotation.y)
	
	direction *= MOVE_SPEED
	velocity.x = move_toward(velocity.x, direction.x, delta * 9999999)
	velocity.z = move_toward(velocity.z, direction.z, delta * 9999999)
	
	move_and_slide()
