extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

		


func _on_resume_pressed() -> void:
	self.visible=false
	get_tree().paused = false


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://mainScene.tscn")
	global.speed=400
