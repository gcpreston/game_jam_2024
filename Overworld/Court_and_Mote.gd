extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func move_to_garden(_body):
	get_tree().call_deferred("change_scene_to_file", "res://Overworld/garden.tscn")