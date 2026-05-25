extends StaticBody2D

@export var speed := 600.0
@export var rotation_speed := 5.0

signal impact

func _process(delta):
	
	if global.gameRnning:
		global_position.x -= speed * delta
		rotation += rotation_speed * delta
	
	if global_position.x < -100:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	impact.emit()
