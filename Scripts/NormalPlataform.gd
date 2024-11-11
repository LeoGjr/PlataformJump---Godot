extends Area2D

onready var sprte = $Sprite
const SPRING_CHANCE = 5
var spring_path = "res://Scenes/Spring.tscn"
var sprite_half_width


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	connect("body_entered", self, "_on_body_entered")
	sprite_half_width = sprte.texture.get_size().x / 2 * scale.x
	if rand_range(0, 100) > 100 - SPRING_CHANCE:
		var new_spring = load(spring_path).instance()
		add_child(new_spring)
		new_spring.position = Vector2(0, -new_spring.height)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_body_entered(body):
	if body.name == "Player":
		if body.position.y < position.y:
			body.jump()
