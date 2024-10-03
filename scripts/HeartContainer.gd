extends Control

@export var full_heart_texture: Texture2D
@export var half_heart_texture: Texture2D
#@export var empty_heart_texture: Texture2D
@onready var heart_container_box = $HBoxContainer
@onready var player = get_tree().get_first_node_in_group("player")
func _ready():
	if player != null:
		update_hearts()


func update_hearts():
	clear_hearts()
	var num_hearts = ceil(player.life / 2.0)
	
	for i in range(num_hearts):
		var heart = TextureRect.new()
		
		if player.life >= (i + 1) * 2:
			heart.texture = full_heart_texture
		elif player.life == (i * 2) + 1:
			heart.texture = half_heart_texture
		#else:
			#heart.texture = empty_heart_texture
		
		heart_container_box.add_child(heart)

func _process(delta):
	if player != null:
		update_hearts()

func set_life(new_life):
	#current_life = new_life
	update_hearts()

func clear_hearts():
	for child in heart_container_box.get_children():
		child.queue_free()
