extends Area2D


signal hit


export var move_speed : int = 400


var screen_size : Vector2


func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()


func _process(delta: float) -> void:
	var direction : Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x = 1
	if Input.is_action_pressed("move_left"):
		direction.x = -1
	if Input.is_action_pressed("move_down"):
		direction.y = 1
	if Input.is_action_pressed("move_up"):
		direction.y = -1
	
	if direction != Vector2.ZERO:
		position += direction.normalized() * delta * move_speed
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 0, screen_size.y)
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	if direction.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = direction.x < 0
		$AnimatedSprite.flip_v = false
	elif direction.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = direction.y > 0


func init_player(pos : Vector2) -> void:
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_Player_body_entered(_body: Node) -> void:
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
