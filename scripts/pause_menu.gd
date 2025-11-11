extends Control

func _on_resume_button_up() -> void: get_parent().pause_game()

func _on_quit_button_up() -> void: get_tree().quit()
