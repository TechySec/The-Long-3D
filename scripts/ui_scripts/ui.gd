extends CanvasLayer

var previous_mouse_mode:Input.MouseMode

func _process(delta: float) -> void:
	$GameHud/RichTextLabel.text = Global.timer_text
	if Input.is_action_just_pressed("pause"):
		pause_game()

func pause_game():
	if Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
		previous_mouse_mode = Input.mouse_mode
	
	get_tree().paused = !get_tree().paused
	$PauseMenu.visible = get_tree().paused
	
	$PauseMenu.set_process_input(get_tree().paused)
	
	if get_tree().paused: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else: Input.mouse_mode = previous_mouse_mode
