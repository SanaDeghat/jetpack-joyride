extends Node
@export var obstacle_static: PackedScene
@export var obstacle_rotatice: PackedScene
@export var obstacle_moving: PackedScene
@export var viecle_powerup: PackedScene
@export var spawn_rate = 1.3
@onready var onsticle_timer: Timer = $onsticleTimer
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
	if obstacle.id==1 or obstacle.id==2:
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
#	parallax_2d.autoscroll.x=0
	high_score.text=str(global.highscore)
	your_score.text=str(get_parent().score)
func _on_onsticle_timer_timeout() -> void:
	if global.gameRnning:
		spawn_obstacle()
		if (randf_range(1,5)==5 ):
			print("respect power banana")
			spawn_powerup()
func _on_powerup_impact():
	print("connected")
func _on_restart_pressed() -> void:
	global.speed=400
	global.gameRnning=true
	get_tree().change_scene_to_file("res://mainScene.tscn")
	
func _process(delta: float) -> void:
	if global.gameRnning:
		global.speed+=0.1
#		parallax_2d.autoscroll.x=-global.speed
	
func spawn_powerup():
	var powers = [
		viecle_powerup
	]	
	var powerup = powers.pick_random().instantiate()
	powerup.add_to_group("powerups")
	powerup.global_position.x = 1400
	powerup.global_position.y = randf_range(50, 600)
	powerup.impact.connect(_on_powerup_impact)
	add_child(powerup)

	


func _on_animated_sprite_2d_animation_finished() -> void:
	lose_screen.visible=true
