extends Control

@export_group ("Main Menu Buttons")
@export var new_game_button: Button
@export var options_button: Button
@export var quit_game_button: Button
@export var sprite_background: Sprite2D
@export var high_score_label: Label
@export var rotation_speed: float

func _ready() -> void:
	high_score_label.text = ("High Score: %s" % str(GameManager.original_high_score))

func _process(delta: float) -> void:
	sprite_background.rotation += rotation_speed * delta

func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_file(SceneManager.menu_dict["main game"])

func _on_options_button_pressed() -> void:
	print_debug("Options Button Pressed")

func _on_quit_game_button_pressed() -> void:
	print_debug("Quit Button Pressed")
	get_tree().quit()
