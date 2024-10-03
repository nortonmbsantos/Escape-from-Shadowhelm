extends CharacterBody2D

@export var life = 6
const speed = 10000
@onready var flashlight = $Flashlight
var healColor
var colordic : Dictionary = {}

func _ready():
	colordic = {
		"white":100, 
		"red":50, 
		"blue":30,
		"green":70,
		"magenta":0,
		"cyan":0,
		"yellow":0
		}
	Hud.update_colors()
	pass

func get_input(delta):
	var input_direction = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	velocity = input_direction * speed * delta

func _physics_process(delta):
	get_input(delta)
	move_and_slide()

func _process(delta):
	if Input.is_action_pressed("mouse_left"):
		turn_on_flashlight()
	if Input.is_action_just_released("mouse_left"):
		turn_off_flashlight()
	if healColor != null && healColor != "":
		var colorheal = clamp(colordic.get(healColor) + 0.1, 0, 100)
		colordic[healColor] = colorheal
		Hud.update_colors()




func take_damage(damage):
	life -= damage


func turn_on_flashlight():
	if can_consume_flashlight(flashlight.selected_color):
		if colordic[flashlight.selected_color] > 0:
			flashlight.pointlight2d.visible = true
			flashlight.collision.disabled = false
			consume_flashlight(flashlight.selected_color)
	else:
		turn_off_flashlight()

func turn_off_flashlight():
	flashlight.pointlight2d.visible = false
	flashlight.collision.disabled = true


func consume_flashlight(selected_color):
	var colorconsume = colordic.get(selected_color) - 0.1
	colordic[selected_color] = colorconsume
	Hud.update_colors()
	pass



func can_consume_flashlight(selected_color):
	if colordic.get(selected_color) <= 0:
		return false
	return true 
