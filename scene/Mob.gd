extends RigidBody2D


func _ready() -> void:
	$AnimatedSprite.playing = true
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]


func _on_VisibilityNotifier2D_viewport_exited(_viewport: Viewport) -> void:
	queue_free()
