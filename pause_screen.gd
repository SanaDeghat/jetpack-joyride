extends Node2D

@onready var transitioner: CanvasLayer = $transitioner
@onready var _21: Sprite2D = $"21"
@onready var _22: Sprite2D = $"22"
@onready var _23: Sprite2D = $"23"
@onready var _24: Sprite2D = $"24"
@onready var _25: Sprite2D = $"25"
@onready var _26: Sprite2D = $"26"

var original_positions: Dictionary = {}


func _process(delta: float) -> void:
	if global.gameRnning:
		if Input.is_action_just_pressed("pause_action") :
			if !get_tree().paused:
				showSelf()
			else:
				hideself()
func _ready() -> void:
	transitioner.hide_transition(0.1)

	# Save starting positions
	var sprites: Array[Sprite2D] = [_26,_25,_24,_23,_22,_21]
	for s in sprites:
		original_positions[s] = s.position



func showSelf() -> void:
	visible = true
	get_tree().paused=true
	var sprites: Array[Sprite2D] = [_26,_25,_24,_23,_22,_21]

	var base_duration := 2
	var duration_jitter := 0.5
	var base_delay := 0.05 
	for i in sprites.size():
		var s := sprites[i]
		if s == null:
			continue

		var delay := i * base_delay
		var duration := base_duration + randf_range(0.0, duration_jitter)

		var t := create_tween()
		t.set_trans(Tween.TRANS_QUINT)
		t.set_ease(Tween.EASE_OUT)

		t.tween_interval(delay)
		if i==5:
			print("here comes the sun dododododo")
			duration-=1
		t.tween_property(s, "position", Vector2.ZERO, duration)


func _on_Restart_button_pressed() -> void:
	global.speed = 400
	get_tree().paused = false
	await transitioner.show_transition(1.5) # fade OUT first
	get_tree().change_scene_to_file("res://mainScene.tscn")

	

func _on_resume_button_pressed() -> void:
	hideself()


func hideself() -> void:
	var sprites: Array[Sprite2D] = [_26,_25,_24,_23,_22,_21]

	for i in sprites.size():
		var s := sprites[i]
		if s == null:
			continue

		var t := create_tween()
		if i==5:
			t.tween_property(
				s,
				"position",
				original_positions[s],
				0.7
			)
		else:
			t.tween_property(
				s,
				"position",
				original_positions[s],
				2
			)

	await get_tree().create_timer(0.7).timeout
	get_tree().paused = false
	visible = false


func _on_button_pressed() -> void:
	hideself()
	get_tree().paused = false
