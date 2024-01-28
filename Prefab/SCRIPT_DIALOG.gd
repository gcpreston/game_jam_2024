extends Area2D

var entered = false

func _on_body_entered(_body: CollisionObject2D):
	entered = true

const DialogIntro: Array[String] = [
	"Hello JESTERBOT. How are things going?",
	"I have devised a plan that may finally cure our KINGBOT.",
	"But in order to make it work, I will need you to gather a variety of PROPS — assorted objects used to perform HUMOR.",
	"These are the PROPS I still need you to collect."
]

const DialogMissingItems: Array[String] = [
	
	"Bring these back to me and we will use them to create HUMOR for our KINGBOT."
]

func _on_body_exited(_body):
	entered = false

func _physics_process (_delta):
	if entered == true:
		if Input.is_action_just_pressed("ui_accept"):
			DialogueManager.start_dialog(global_position, DialogIntro)
