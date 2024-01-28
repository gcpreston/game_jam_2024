extends CharacterBody2D


@export var SPEED = 300.0
@export var dialogue_json: JSON
@export var state = {}

func _on_ez_dialogue_dialogue_generated(response: DialogueResponse):
	$DIALOGUE_BOX.add_text(response.text)

func _ready():
	($EzDialogue as EzDialogue).start_dialogue(dialogue_json, state)

func _physics_process(_delta):

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

	move_and_slide()
