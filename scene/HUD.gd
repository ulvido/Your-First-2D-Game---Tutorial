extends CanvasLayer


signal game_started


func update_score_label(score : int) -> void:
	$UI/ScoreLabel.text = str(score)


func show_temp_message(text: String) -> void:
	$UI/MessageLabel.text = text
	$UI/MessageLabel.show()
	$UI/MessageTimer.start()


func show_game_over() -> void:
	show_temp_message("Oyun Bitti!")
	yield($UI/MessageTimer, "timeout")
	
	$UI/MessageLabel.text = "Canavar\ngeliyor kaç"
	$UI/MessageLabel.show()
	yield(get_tree().create_timer(1), "timeout")
	$UI/StartButton.show()


func _on_MessageTimer_timeout() -> void:
	$UI/MessageLabel.hide()


func _on_StartButton_pressed() -> void:
	$UI/StartButton.hide()
	emit_signal("game_started")
