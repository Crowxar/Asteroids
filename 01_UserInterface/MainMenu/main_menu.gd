extends Control

@export_group ("Main Menu Buttons")
@export var main_menu_vbox: VBoxContainer
@export var new_game_button: Button
@export var quit_game_button: Button
@export var sprite_background: Sprite2D
@export var high_score_label: Label
@export var rotation_speed: float
@export var button_rollover_sound: AudioStreamPlayer2D
@export var button_click_sound: AudioStreamPlayer2D

@export var new_game_vbox: VBoxContainer

func _ready() -> void:
	high_score_label.text = ("High Score: %s" % str(GameManager.original_high_score))
	main_menu_vbox.visible = true
	new_game_vbox.visible = false

func _process(delta: float) -> void:
	sprite_background.rotation += rotation_speed * delta

func _on_new_game_button_pressed() -> void:
	button_click_sound.play()
	main_menu_vbox.visible = false
	new_game_vbox.visible = true

func _on_quit_game_button_pressed() -> void:
	button_click_sound.play()
	print_debug("Quit Button Pressed")
	get_tree().quit()



func _on_easy_pressed() -> void:
	button_click_sound.play()
	GameManager.game_difficulty = GameManager.DIFFICULTY.EASY
	get_tree().change_scene_to_file(SceneManager.menu_dict["main game"])


func _on_medium_pressed() -> void:
	button_click_sound.play()
	GameManager.game_difficulty = GameManager.DIFFICULTY.NORMAL
	get_tree().change_scene_to_file(SceneManager.menu_dict["main game"])

func _on_hard_pressed() -> void:
	button_click_sound.play()
	GameManager.game_difficulty = GameManager.DIFFICULTY.HARD
	get_tree().change_scene_to_file(SceneManager.menu_dict["main game"])


func _on_back_pressed() -> void:
	button_click_sound.play()
	main_menu_vbox.visible = true
	new_game_vbox.visible = false


func _on_reset_score_pressed() -> void:
	button_click_sound.play()
	GameManager.config_handler.save_high_score(0)
	GameManager.original_high_score = GameManager.config_handler.load_high_score()
	GameManager.player_high_score = GameManager.original_high_score
	high_score_label.text = ("High Score: %s" % str(GameManager.original_high_score))


func _on_back_mouse_entered() -> void:
	button_rollover_sound.play()


func _on_reset_score_mouse_entered() -> void:
	button_rollover_sound.play()


func _on_hard_mouse_entered() -> void:
	button_rollover_sound.play()


func _on_medium_mouse_entered() -> void:
	button_rollover_sound.play()


func _on_easy_mouse_entered() -> void:
	button_rollover_sound.play()


func _on_quit_game_button_mouse_entered() -> void:
	button_rollover_sound.play()


func _on_new_game_button_mouse_entered() -> void:
	button_rollover_sound.play()
