extends Node


export var MobScene : PackedScene


var score : int


func _ready() -> void:
	randomize()


func new_game() -> void:
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$HUD.update_score_label(score)
	$HUD.show_temp_message("Hazır ol!")
	$Player.init_player($Position2D.position)
	$StartTimer.start()
	$Music.play()


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$Deathsound.play()


func _on_StartTimer_timeout() -> void:
	$ScoreTimer.start()
	$MobTimer.start()


func _on_ScoreTimer_timeout() -> void:
	score += 1
	$HUD.update_score_label(score)


func _on_MobTimer_timeout() -> void:
	var mob = MobScene.instance()
	mob.add_to_group("mobs")
	
	$MobPath/MobSpawnLocation.unit_offset = randf()
	mob.position = $MobPath/MobSpawnLocation.position
	
	var direction = $MobPath/MobSpawnLocation.rotation + PI/2
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	
	var velocity : Vector2 = Vector2(rand_range(150, 250), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)


func _on_HUD_game_started() -> void:
	new_game()


func _on_Player_hit() -> void:
	game_over()
