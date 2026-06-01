extends Button


var plain_text := ""

func _ready():
	plain_text = text
	mouse_entered.connect(func():
		text = "[u]%s[/u]" % plain_text
	)
	mouse_exited.connect(func():
		text = plain_text
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
