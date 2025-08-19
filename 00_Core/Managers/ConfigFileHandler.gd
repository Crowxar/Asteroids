extends Node

func _ready() -> void:
	GameManager.config_handler = self


func save_high_score(score):
	var config = ConfigFile.new()
	config.set_value("Scores", "high_score", score)
	config.save("user://save_data.cfg")


func load_high_score():
	var config = ConfigFile.new()
	var err = config.load("user://save_data.cfg")
	if err == OK:
		return config.get_value("Scores", "high_score", 0)
	else:
		return 0
