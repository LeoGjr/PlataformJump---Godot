extends Area2D

export var impulse = 100

onready var animation = $Animation

var height

# Called when the node enters the scene tree for the first time.
func _ready():
	height = animation.frames.get_frame("idle", 0).get_height()
	connect("body_entered", self, "_on_body_entered")
	pass # Replace with function body.

func _on_body_entered(body):
	if body.name == "Player" and body.position.y < position.y and !body.jumpng:
		body.add_impulse(impulse)
		animation.play("spring")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
