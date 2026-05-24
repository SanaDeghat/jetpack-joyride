extends Node

@export var obstacle_scene: PackedScene
@export var spawn_rate := 1.3
@onready var onsticle_timer: Timer = $onsticleTimer
@onready var lose_screen: TextureRect = $"../TextureRect"

func _ready():
	onsticle_timer.wait_time = spawn_rate
	onsticle_timer.start()



func spawn_obstacle():
	var obstacle = obstacle_scene.instantiate()
	
	obstacle.global_position.x = 1400
	obstacle.global_position.y = randf_range(50, 550)

	obstacle.impact.connect(_on_obstacle_impact)

	add_child(obstacle)
func _on_obstacle_impact():
	print("touching")
	lose_screen.visible = true

func _on_onsticle_timer_timeout() -> void:
	print(onsticle_timer.wait_time)
	spawn_obstacle()
