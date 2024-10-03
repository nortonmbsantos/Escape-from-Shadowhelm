extends Area2D
@export var scene_to_go: String = ""
var scene_string
# Called when the node enters the scene tree for the first time.
func _ready():
	scene_string = "res://scenes/" + scene_to_go + ".tscn"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file(scene_string)
