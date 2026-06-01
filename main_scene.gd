extends Node2D
var score=0
@onready var label: Label = $Label
@onready var timer: Timer = $Timer
@onready var parallax_2d: Parallax2D = $Parallax2D

func _on_timer_timeout() -> void:
	if global.gameRnning:
		score += 1
		label.text = str(score)
