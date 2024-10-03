extends Node2D

var _smoothed_mouse_pos: Vector2
var selected_color
@onready var collision = $CollisionShape2D
@onready var pointlight2d = $PointLight2D
var rgbdic: Dictionary = {
		"white":Color.WHITE, 
		"red":Color.RED, 
		"blue":Color.BLUE,
		"green":Color.GREEN,
		"magenta":Color.MAGENTA,
		"cyan":Color.CYAN,
		"yellow":Color.YELLOW
		}


func _ready():
	selected_color = "blue"
	pointlight2d.color = rgbdic[selected_color]
	pass 



func _process(delta):
	_smoothed_mouse_pos = lerp(_smoothed_mouse_pos, get_global_mouse_position(), 0.3)
	look_at(_smoothed_mouse_pos)


func _on_area_entered(area):
	if area.is_in_group("enemies") and area != self:
		area.in_flashlight = true
		match(selected_color):
			"white":
				area.stop()
			"blue":
				area.push(global_transform.basis_xform(Vector2.RIGHT) * 100) 
			"red":
				area.take_damage(1)
			"green":
				pass
			"magenta":
				pass
			"yellow":
				pass
			"cyan":
				pass


func _on_area_exited(area):
	if area.is_in_group("enemies") and area != self:
		area.unpush()
		area.in_flashlight = false 

func select_color(color):
	selected_color = color
	pointlight2d.color = rgbdic[color]
