extends Node

var rng = RandomNumberGenerator.new()

var win_window_active = false
var cpu_draw_timer: SceneTreeTimer
var cpu_is_dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	start_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("action") && win_window_active:
		player_shoot()


func cpu_shoot():
	if !cpu_is_dead:
		$HUD.show_message("You lose")
		win_window_active = false


func player_shoot():
	cpu_is_dead = true
	$HUD.show_message("You win!")


func draw():
	$HUD.show_message("DRAW!")
	win_window_active = true
	var cpu_draw_time = rng.randf_range(0.2, 0.5)
	cpu_draw_timer = get_tree().create_timer(cpu_draw_time)
	cpu_draw_timer.timeout.connect(cpu_shoot)


func start_game():
	$HUD.show_message("Get ready...")
	var rand_draw_time = rng.randf_range(2.0, 7.0)
	get_tree().create_timer(rand_draw_time).timeout.connect(draw)
