extends Node


export(Array) var plataforms
export(Array) var special_platforms
onready var player = $Player
onready var score_text = $UI/Score
const MIN_INTERVAL = 100
const MAX_INTERVAL = 250
const INITIAL_PLATAFORM_COUNT = 40
const SPECIAL_PLATFORM_CHANCE = 20

var current_max_interval 
var current_min_interval
var last_spawn_height
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	last_spawn_height = get_viewport().get_viewport().size.y
	current_max_interval = MIN_INTERVAL
	current_min_interval = MIN_INTERVAL
	screen_size = get_viewport().get_visible_rect().size.x
	_spawn_first_plataforms()
	

func _process(delta):
	score_text.text = str(player.score)

func _spawn_first_plataforms():
	for counter in range(INITIAL_PLATAFORM_COUNT):
		_spawn_plataforms()


func _spawn_plataforms():
	randomize()
	var index
	var new_plataform 
	if rand_range(0, 100) > 100 - SPECIAL_PLATFORM_CHANCE:
		index = rand_range(0, special_platforms.size())
		new_plataform = special_platforms[index].instance()
	else:
		index = rand_range(0, plataforms.size())
		new_plataform = plataforms[index].instance()
	add_child(new_plataform)
	var spawn_x = rand_range(0 + new_plataform.sprite_half_width, screen_size - new_plataform.sprite_half_width)
	var spawn_position = Vector2(spawn_x, last_spawn_height)
	new_plataform.position = spawn_position
	last_spawn_height -= rand_range(current_min_interval, current_max_interval)
	current_min_interval += 5
	current_max_interval += 7.5
	current_max_interval = clamp(current_max_interval, MIN_INTERVAL, MAX_INTERVAL)
	current_min_interval = clamp(current_min_interval, MIN_INTERVAL, MAX_INTERVAL / 0.75) 



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_just_jumped():
	for counter in range(3):
		_spawn_plataforms()
