extends Area2D
class_name Asteroid

@export var collision_shape: CollisionShape2D
@export var asteroid_sprite: Sprite2D

enum ASTEROID_SIZES{
	LARGE,
	MEDIUM,
	SMALL,
}

enum RADIUS{
	LARGE = 24,
	MEDIUM = 14,
	SMALL = 7,
}

var speed := 0.5
var rotation_factor := 0.02

var size = ASTEROID_SIZES.LARGE
var astroid_dict = AssetManager.astroids_dict
var direction:= Vector2.ZERO
var BigAsteroidSprites = [astroid_dict["Large A"], astroid_dict["Large B"], astroid_dict["Large C"]]
var MediumAsteroidSprites = [astroid_dict["Medium A"], astroid_dict["Medium B"], astroid_dict["Medium C"]]
var SmallAsteroidSprites = [astroid_dict["Small A"], astroid_dict["Small B"], astroid_dict["Small C"]]

func _ready() -> void:
	randomize()
	
	# Set the sprite
	match size:
		ASTEROID_SIZES.LARGE:
			collision_shape.shape.radius = RADIUS.LARGE
			asteroid_sprite.texture = BigAsteroidSprites[randi() % BigAsteroidSprites.size()]
		ASTEROID_SIZES.MEDIUM:
			collision_shape.shape.radius = RADIUS.MEDIUM
			asteroid_sprite.texture = MediumAsteroidSprites[randi() % MediumAsteroidSprites.size()]
		ASTEROID_SIZES.SMALL:
			collision_shape.shape.radius = RADIUS.SMALL
			asteroid_sprite.texture = SmallAsteroidSprites[randi() % SmallAsteroidSprites.size()]
			
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))


func _process(delta: float) -> void:
	# move asteroid around 
	position += direction * speed
	rotation += rotation_factor


func _on_body_entered(body: Node) -> void:
	print_debug("Body Entered Asteroid: ", body)
