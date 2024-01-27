extends Area2D

signal hit


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_hit():
	print("Hit something!")


func _on_body_entered(body):
	hit.emit()
