extends Control

@export_group ("Main Menu Buttons")
@export var new_game_button: Button
@export var options_button: Button
@export var quit_game_button: Button

func _on_new_game_button_pressed() -> void:
	print_debug("New Game Button Pressed")

func _on_options_button_pressed() -> void:
	print_debug("Options Button Pressed")

func _on_quit_game_button_pressed() -> void:
	print_debug("Quit Button Pressed")
	get_tree().quit()
