extends Node3D

@onready var animation_player:AnimationPlayer

func _process(delta: float) -> void:
	if get_parent().velocity.length_squared() >= 0.3:
		var look_position = get_parent().global_position + Vector3(get_parent().velocity.x, 0, get_parent().velocity.z)
		if !get_parent().global_position.is_equal_approx(look_position):
			look_at(look_position, Vector3.UP, true)
