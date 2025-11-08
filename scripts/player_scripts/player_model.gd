extends Node3D

@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var player:Player = $".."

@export var rotation_change_weight := 12.0

var needs_to_idle:bool = true
var idled:bool = true

func _ready() -> void:
	animation_player.speed_scale = 3.0
	animation_player.play("bounce")

func _process(delta: float) -> void:
	var destined_rotation := deg_to_rad(-90)
	
	if player.velocity.x > 0: destined_rotation = deg_to_rad(-25)
	elif player.velocity.x < 0: destined_rotation = deg_to_rad(-155)
	else: destined_rotation = deg_to_rad(-90)
	
	if player.velocity.x != 0 and player.is_on_floor(): 
		animation_player.play("bounce")
		position.y = -0.45
		idled = false
	elif not player.is_on_floor(): 
		animation_player.play("animation")
		position.y = 0.0
	else:
		needs_to_idle = true
		if not idled:
			animation_player.play("bounce")
			position.y = -0.45
	rotation.y = lerpf(rotation.y, destined_rotation, delta * rotation_change_weight)
