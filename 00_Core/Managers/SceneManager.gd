extends Node

var menu_dict: Dictionary = {
	"main menu": "uid://diuk4drxe2wsi",
	"main game": "uid://dowm5jt4rtx0d",
}

var scene_dict: Dictionary = {
	"bullet": preload("uid://bysnr1qehew8s"),
	"large asteroid": preload("uid://bxhdn14focq2x"),
	"medium asteroid": preload("uid://b1ofkuknf3v2x"),
	"small asteroid": preload("uid://cofp8kyq3vp81"),
}


var large_asteroid_sprites: Dictionary = {
	"Large A": preload("uid://ccxyd3bdcxeoo"),
	"Large B": preload("uid://c607ir1qrfin7"),
	"Large C": preload("uid://b8qbbn6u8qoe2"),
}

var medium_asteroid_sprites: Dictionary = {
	"Medium A": preload("uid://bt8h0y2x4yopt"),
	"Medium B": preload("uid://c11y1xtu81pmk"),
	"Medium C": preload("uid://ch58s7nki6r2w"),
}

var small_asteroid_sprites: Dictionary = {
	"Small A": preload("uid://cc0ud36m1gj76"),
	"Small B": preload("uid://8aylsqyi1gc2"),
	"Small C": preload("uid://jpviwtttonnp"),
}
