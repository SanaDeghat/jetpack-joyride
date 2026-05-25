extends Node

@export var obstacle_static: PackedScene
@export var obstacle_rotatice: PackedScene
@export var spawn_rate := 1.3
@onready var onsticle_timer: Timer = $onsticleTimer
@onready var parallax_2d: Parallax2D = $"../Parallax2D"
@onready var lose_screen: CanvasLayer = $"../CanvasLayer"

func _ready():
	onsticle_timer.wait_time = spawn_rate
	onsticle_timer.start()



func spawn_obstacle():
	var scenes = [
	obstacle_static,
	obstacle_static,
	obstacle_rotatice
	]	
	var obstacle = scenes.pick_random().instantiate()
	obstacle.add_to_group("obstacles")
	obstacle.global_position.x = 1400
	obstacle.global_position.y = randf_range(50, 550)
	obstacle.impact.connect(_on_obstacle_impact)

	add_child(obstacle)
func _on_obstacle_impact():
	global.gameRnning=false
	parallax_2d.autoscroll.x=0
	lose_screen.visible = true

func _on_onsticle_timer_timeout() -> void:
	print(onsticle_timer.wait_time)
	if global.gameRnning:
		spawn_obstacle()


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://mainScene.tscn")
	global.gameRnning=true
