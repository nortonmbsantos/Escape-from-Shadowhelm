extends Node2D

@export var spotlightcolor: String = ""
var rgbdic: Dictionary = {
		"white":Color.WHITE, 
		"red":Color.RED, 
		"blue":Color.BLUE,
		"green":Color.GREEN,
		"magenta":Color.MAGENTA,
		"cyan":Color.CYAN,
		"yellow":Color.YELLOW
		}
@onready var pointlight2d = $PointLight2D
func _ready():
	pointlight2d.color = rgbdic.get(spotlightcolor)
	pass

func _process(delta):
	pass


func _on_collision_area_area_entered(area):
	if area.is_in_group("enemies") and area != self:
		area.take_damage(1)

func _on_collision_area_body_entered(body):
	if body.is_in_group("player") and body != self:
		body.healColor = spotlightcolor


func _on_collision_area_body_exited(body):
	if body.is_in_group("player") and body != self:
		body.healColor = ""
		pass
