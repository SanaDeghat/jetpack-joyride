extends Node2D
var score=0
@onready var label: Label = $Label
@onready var timer: Timer = $Timer
@onready var lose_screen: TextureRect = $TextureRect


func _on_timer_timeout() -> void:
	score += 1
	label.text = str(score)
