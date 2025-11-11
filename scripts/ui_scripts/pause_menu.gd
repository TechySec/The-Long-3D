extends Control

var settings_open:bool = false

@onready var pause_menu:Control = $Buttons
@onready var settings:Control = $Settings

func _on_resume_button_up() -> void: get_parent().pause_game()

func _on_quit_button_up() -> void: get_tree().quit()

func _on_settings_button_up() -> void: open_settings()

func open_settings() -> void:
	settings_open = not settings_open
	pause_menu.set_process_input(not settings_open)
	settings.set_process_input(settings_open)
	pause_menu.visible = not settings_open
	settings.visible = settings_open
