extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !global.played_before:
		stream=load("res://music/gameMusic1.mp3")
		global.played_before=true
		playing=true
	else:
		stream=load("res://music/gameMusic"+str(randi_range(1,8))+".mp3")
		playing=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_finished() -> void:
	stream=load("res://music/gameMusic"+str(randi_range(2,8))+".mp3")
	playing=true
