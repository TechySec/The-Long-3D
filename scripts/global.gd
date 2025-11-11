extends Node

var player:Player

var time_remaining := 2629800
var objects := []

var tick := 1.0
var time_remover := 1.0
var time_remover_multiplier := 1.0

var timer_text:String 

var next_room_position : int = -1
var camera_rotation_pre_room_enter:Vector3

var respawn_time:float = 2.5

var respawn_position : int = -99

func _process(delta: float) -> void:
	tick -= delta
	
	if tick <= 0:
		time_remaining -= time_remover * time_remover_multiplier
		
		var seconds = time_remaining % 60
		var minutes = floor(time_remaining / 60) % 60
		var hours = floor(time_remaining / 3600) % 24
		var days = floor(time_remaining / 86400)
		
		timer_text = "%02d days, %02d hours, %02d minutes, %02d seconds"%[days,hours,minutes,seconds]
		
		tick = 1
