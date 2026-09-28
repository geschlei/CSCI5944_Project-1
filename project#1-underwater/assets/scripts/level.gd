extends Node2D


func _ready() -> void:
	if NewScript.game_started:
		$Start/StartScreen.hide()
	else:
		$Start/StartScreen.show()
		get_tree().paused = true
	


func _on_start_button_pressed() -> void:
	NewScript.game_started = true
	get_tree().paused = false
	$Start/StartScreen.hide()
