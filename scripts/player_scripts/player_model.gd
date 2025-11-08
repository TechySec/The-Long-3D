extends Node3D

@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var player:Player = $".."

@export var rotation_change_weight := 24.0

var needs_to_idle:bool = true
var idled:bool = true
var has_grounded := false

func _ready() -> void:
	animation_player.speed_scale = 3.0
	animation_player.play("bounce")

func _process(delta: float) -> void:
	var destined_rotation:float
	
	if player.velocity.x > 0: destined_rotation = deg_to_rad(-115)
	elif player.velocity.x < 0: destined_rotation = deg_to_rad(-245)
	else: destined_rotation = deg_to_rad(-180)
	
	if player.velocity.x != 0 and player.is_on_floor(): 
		animation_player.play("bounce")
		idled = false
	elif not player.is_on_floor(): 
		animation_player.play("animation")
	else:
		animation_player.play("idle")
		
	global_rotation.y = lerp_angle(global_rotation.y, destined_rotation, delta * rotation_change_weight)
