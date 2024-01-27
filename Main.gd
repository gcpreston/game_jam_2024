extends Node

@export var mob_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	$MobTimer.start()
	$Hook.start($StartPosition.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func hooked():
	print("Hooked something!")


func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var spawn_options = [$MobPathL/MobSpawnLocationL, $MobPathR/MobSpawnLocationR]
	var mob_spawn_location = spawn_options[randi() % spawn_options.size()]
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
