extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func move_camera() -> void:
	enabled = true

	# start state (where you want it to begin)
	global_position = Vector2(576, 324)

	# (optional) pick a starting zoom; change if you want
	# zoom = Vector2(1, 1)

	# smooth move + zoom in 3 seconds
	var t := create_tween()
	t.set_parallel(true)
	t.set_trans(Tween.TRANS_SINE)
	t.set_ease(Tween.EASE_IN_OUT)

	t.tween_property(self, "position", Vector2(0, -40), 0.25)
	t.tween_property(self, "zoom", Vector2(2, 2), 0.25)
