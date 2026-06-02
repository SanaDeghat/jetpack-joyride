extends Node2D
var score=0
@onready var timer: Timer = $Timer
@onready var parallax_2d: Parallax2D = $Parallax2D
@onready var transitioner: CanvasLayer = $transitioner
@onready var label: Label = $StylishRippedTornPaperTransparentTextureFreePng/Label


func _ready() -> void:
	transitioner.hide_transition(1.5)

func _on_timer_timeout() -> void:
	if global.gameRnning:
		score += 1
		label.text = str(score)+" m"
