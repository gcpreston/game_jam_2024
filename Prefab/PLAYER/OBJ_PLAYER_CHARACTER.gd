extends CharacterBody2D

@export var SPEED = 200.0
var prev_direction = null

func _ready():
	$AnimationPlayer.play("Idle_front");
		
func _physics_process(_delta):
	#if Input.is_action_just_pressed("ui_down"):
		#$AnimationPlayer.play("Idle_front");
	#elif Input.is_action_just_pressed("ui_right"):
		#$AnimationPlayer.play("Idle_right");
	#elif Input.is_action_just_pressed("ui_up"):
		#$AnimationPlayer.play("Idle_back");
	#elif Input.is_action_just_pressed("ui_left"):
		#$AnimationPlayer.play("Idle_left");

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var xDirection = Input.get_axis("ui_left", "ui_right")
	var yDirection = Input.get_axis("ui_up", "ui_down")

	if xDirection:
		velocity.x = xDirection * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if yDirection:
		velocity.y = yDirection * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if velocity.x < 0:
		$AnimationPlayer.play("Walk_left")
		prev_direction = "left"
	elif velocity.x > 0:
		$AnimationPlayer.play("Walk_right")
		prev_direction = "right"
	elif velocity.y < 0:
		$AnimationPlayer.play("Walk_back")
		prev_direction = "up"
	elif velocity.y > 0:
		$AnimationPlayer.play("Walk_front")
		prev_direction = "down"
	else:
		if prev_direction == "left":
			$AnimationPlayer.play("Idle_left")
		elif prev_direction == "right":
			$AnimationPlayer.play("Idle_right")
		elif prev_direction == "up":
			$AnimationPlayer.play("Idle_back")
		elif prev_direction == "down":
			$AnimationPlayer.play("Idle_front")
	
	
	move_and_slide()
