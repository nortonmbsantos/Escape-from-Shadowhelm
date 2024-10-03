extends Control
@onready var red = $Red
@onready var white = $White
@onready var green = $Green
@onready var blue = $Blue 
var player
var color_selected

@onready var options_container = $ColorPicker/VBoxContainer
var options: Array = []
var is_q_pressed: bool = false


func _ready():
	player = get_tree().get_first_node_in_group("player")
	update_colors()
	if not options_container:
		print("Error: options_container path is not set!")
		return
	options = options_container.get_children()
	options_container.visible = false
	pass



func _process(delta):
	if Input.is_action_pressed("colorpicker"):
		is_q_pressed = true
		show_options()
	if Input.is_action_just_released("colorpicker"):
		is_q_pressed = false
		hide_options()
		var player = get_tree().get_first_node_in_group("player")
		if player != null:
			if color_selected != null && color_selected != "":
				player.flashlight.select_color(color_selected)
	pass


func update_colors():
	if player != null:
		if !player.colordic.is_empty():
			red.value = player.colordic["red"]
			white.value = player.colordic["white"]
			green.value = player.colordic["green"]
			blue.value = player.colordic["blue"]

func show_options():
	options_container.visible = true

func hide_options():
	options_container.visible = false


func _on_red_area_mouse_entered():
	color_selected = "red"


func _on_white_area_mouse_entered():
	color_selected = "white"


func _on_blue_area_mouse_entered():
	color_selected = "blue"
