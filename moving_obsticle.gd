extends StaticBody2D
var id=3;



signal impact
func _process(delta):
	
	if global.gameRnning:
		global_position.x -= (global.speed+500) * delta
	
	if global_position.x < -100:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	impact.emit()
