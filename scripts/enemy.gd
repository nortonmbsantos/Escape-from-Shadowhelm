extends Area2D
@onready var player = get_tree().get_first_node_in_group("player")
@onready var attackCollision = $AttackArea/AttackColision
@onready var attackTimer = $AttackTimer
@onready var walkTimer = $WalkTimer

const speed = 100
var stop_distance = 30
var walk_to_player = true
var can_walk = true
var life = 3
var in_flashlight = false

func _ready():
	pass



func _process(delta):
	if player != null:
		if can_walk:
			move_towards_player(delta)
	pass


func move_towards_player(delta):
	var direction = player.global_position - global_position
	var distance = direction.length()
	
	if distance > stop_distance:
		direction = direction.normalized()
		if walk_to_player:
			global_position += direction * speed * delta
		else:
			global_position -= direction * speed * delta
	elif distance <= stop_distance && !walk_to_player:
		global_position -= direction * speed * delta
	pass


func push(direction):
	walk_to_player = false


func unpush():
	walk_to_player = true

func take_damage(damage):
	life -= damage
	if life <= 0:
		queue_free()
	pass


func _on_attack_area_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(1)
		attackCollision.disabled = true
		attackTimer.start()



func _on_attack_timer_timeout():
	attackCollision.disabled = false
	pass 

func stop():
	if can_walk:
		can_walk = false
		walkTimer.start()
	pass

func _on_walk_timer_timeout():
	if !in_flashlight:
		can_walk = true
	pass # Replace with function body.
