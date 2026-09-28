extends Node2D

@onready var level_label = $Start/StartScreen/VBoxContainer/Title


func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	
	var tween = create_tween()
	tween.tween_property(level_label, "modulate:a", 0.0, 1.0)
	
	await tween.finished
	
	level_label.hide()


func _on_end_level_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$End/EndScreen.show()
		
func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://assets/scenes/levels/level.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
