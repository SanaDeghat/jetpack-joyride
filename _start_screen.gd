extends Node2D
@onready var sun: Node2D = $sun
@onready var transitioner: CanvasLayer = $transitioner

@onready var canvas_layer: CanvasLayer = $CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transitioner.hide_transition(2)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sun.rotation+=0.001
	if Input.is_action_just_pressed("ui_accept"):
		await transitioner.show_transition(1.5)
		get_tree().change_scene_to_file("res://mainScene.tscn")
	if Input.is_action_just_pressed("s"):
		canvas_layer.showself()
