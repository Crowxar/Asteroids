extends Node

const SAVE_DIR : String = "user://saves/"
const SAVE_FILE_NAME : String = "save.res"
const SETTINGS_FILE_NAME: String = "settings.tres"

var encryption : Encryption
var data : SaveData
var access : FileAccess


func _ready() -> void:
	DirAccess.make_dir_absolute(SAVE_DIR)
	load_game()

func new_game() -> void:
	data = SaveData.new()
	

func save_game() -> void:
	ResourceSaver.save(data, SAVE_DIR + SAVE_FILE_NAME)


func load_game() -> void:
	if ResourceLoader.exists(SAVE_DIR + SAVE_FILE_NAME):
		data = ResourceLoader.load(SAVE_DIR + SAVE_FILE_NAME)
	else:
		new_game()
