extends StaticBody2D
var id=3;
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func change_color(color:int):
	animated_sprite_2d.animation=str(color)

signal impact
func _process(delta):
	
	if global.gameRnning:
		global_position.x -= (global.speed+500) * delta
	
	if global_position.x < -100:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	impact.emit()
