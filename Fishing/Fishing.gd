extends Node

@export var mob_scene: PackedScene
@export var cushion_scene: PackedScene
var potential_hook
var cushion_shown = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$MobTimer.start()
	$Hook.start($StartPosition.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("action"):
		game_end(potential_hook && potential_hook.name.match("**Cushion**"))


func game_end(win: bool) -> void:
	if win: 
		$HUD.show_message("You win!")
	else:
		$HUD.show_message("Whoopsie")

	get_tree().paused


func hook_body_entered(body):
	potential_hook = body


func hook_body_exited(body):
	if potential_hook == body:
		potential_hook = null


func cushion_exited_screen():
	cushion_shown = false


func _on_mob_timer_timeout():
	# Choose a random location on Path2D.
	var spawn_options = [$MobPathL/MobSpawnLocationL, $MobPathR/MobSpawnLocationR]
	var spawn_location = spawn_options[randi() % spawn_options.size()]
	spawn_location.progress_ratio = randf()
	
	# Decide if we are spawning a cushion or a fish.
	var should_spawn_cushion: bool = !cushion_shown && randf() <= 0.1
	var mob
	
	if should_spawn_cushion:
		mob = cushion_scene.instantiate()
		mob.get_node("VisibleOnScreenNotifier2D").screen_exited.connect(cushion_exited_screen)
		cushion_shown = true
	else:
		mob = mob_scene.instantiate()

	# Set the mob's direction perpendicular to the path direction.
	var direction = spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = spawn_location.position

	mob.rotation = direction
	mob.get_node("AnimatedSprite2D").flip_h = true
	if direction > 0:
		mob.get_node("AnimatedSprite2D").flip_v = true

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
