extends Node2D
@onready var sun: Node2D = $sun


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sun.rotation+=0.001
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://mainScene.tscn")
