extends Node

@export var obstacle_static: PackedScene
@export var obstacle_rotatice: PackedScene
@export var obstacle_moving: PackedScene
@export var spawn_rate = 1.3
@onready var onsticle_timer: Timer = $onsticleTimer
@onready var parallax_2d: Parallax2D = $"../Parallax2D"
@onready var lose_screen: CanvasLayer = $"../CanvasLayer"
@onready var character_body_2d: CharacterBody2D = $"../CharacterBody2D"
@onready var high_score: Label = $"../CanvasLayer/TextureRect/lost/scores/highScore"
@onready var your_score: Label = $"../CanvasLayer/TextureRect/lost/scores/YourScore"

func _ready():
	
	onsticle_timer.wait_time = spawn_rate
	onsticle_timer.start()



func spawn_obstacle():
	onsticle_timer.wait_time = randf_range(0.2,2)
	var scenes = [
		obstacle_static,
		obstacle_static,
		obstacle_rotatice,
		obstacle_moving
	]	
	var obstacle = scenes.pick_random().instantiate()
	obstacle.add_to_group("obstacles")
	obstacle.global_position.x = 1400
	if obstacle==obstacle_static or obstacle==obstacle_rotatice:
		obstacle.rotation=randf_range(0,360)
		obstacle.global_position.y = randf_range(50, 600)
	else:
		obstacle.global_position.y =character_body_2d.global_position.y 
	obstacle.impact.connect(_on_obstacle_impact)
	add_child(obstacle)
func _on_obstacle_impact():
	if get_parent().score >global.highscore:
		global.highscore= get_parent().score
	
	global.gameRnning=false
	parallax_2d.autoscroll.x=0
	lose_screen.visible = true
	high_score.text=str(global.highscore)
	your_score.text=str(get_parent().score)
func _on_onsticle_timer_timeout() -> void:
	print(onsticle_timer.wait_time)
	if global.gameRnning:
		spawn_obstacle()


func _on_restart_pressed() -> void:
	global.speed=400
	global.gameRnning=true
	get_tree().change_scene_to_file("res://mainScene.tscn")
	
func _process(delta: float) -> void:
	if global.gameRnning:
		global.speed+=0.1
		parallax_2d.autoscroll.x=-global.speed
	
	
