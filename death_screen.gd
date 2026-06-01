extends Node2D

@onready var _1: Sprite2D = $"1"
@onready var _2: Sprite2D = $"2"
@onready var _3: Sprite2D = $"3"
@onready var _4: Sprite2D = $"4"
@onready var _5: Sprite2D = $"5"
@onready var _6: Sprite2D = $"6"
@onready var _7: Sprite2D = $"7"
@onready var _8: Sprite2D = $"8"
@onready var _9: Sprite2D = $"9"
@onready var _10: Sprite2D = $"10"
@onready var _11: Sprite2D = $"11"
@onready var _12: Sprite2D = $"12"
@onready var _13: Sprite2D = $"13"
@onready var _14: Sprite2D = $"14"
@onready var _15: Sprite2D = $"15"

@onready var highscore: Label = $"4/highscore"
@onready var score: Label = $"4/score"

var _idle_tweens: Array[Tween] = []

func _ready() -> void:
	visible = false
	showSelf(0)

func showSelf(playerScore: int) -> void:
	highscore.text = str(global.highscore)
	score.text = str(playerScore)
	visible = true
	_stop_idle_tweens()

	var sprites: Array[Sprite2D] = [_1,_2,_3,_4,_5,_6,_7,_8,_9,_10,_11,_12,_13,_14,_15]

	var base_duration := 1.8
	var duration_jitter := 0.9
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
		t.tween_property(s, "position", Vector2.ZERO, duration)

		t.tween_callback(Callable(self, "_start_idle_for").bind(s))

func _start_idle_for(s: Sprite2D) -> void:
	if s == null:
		return

	match s:
		_10:
			_idle_sun(s)
		_9:
			_idle_waves(s)
		_12, _13, _14, _15:
			_idle_cloud(s)
		_:
			pass 
			
func _idle_sun(s: Sprite2D) -> void:
	var t := create_tween()
	_idle_tweens.append(t)
	t.set_loops() # infinite
	t.set_trans(Tween.TRANS_SINE)
	t.set_ease(Tween.EASE_IN_OUT)

	t.tween_property(s, "rotation", s.rotation + deg_to_rad(360.0), 18.0)

	var t2 := create_tween()
	_idle_tweens.append(t2)
	t2.set_loops()
	t2.set_trans(Tween.TRANS_SINE)
	t2.set_ease(Tween.EASE_IN_OUT)
	t2.tween_property(s, "scale", s.scale * 1.03, 1.8)
	t2.tween_property(s, "scale", s.scale, 1.8)

func _idle_waves(s: Sprite2D) -> void:
	var base_pos := s.position

	var t := create_tween()
	_idle_tweens.append(t)
	t.set_loops()
	t.set_trans(Tween.TRANS_SINE)
	t.set_ease(Tween.EASE_IN_OUT)

	t.tween_property(s, "position", base_pos + Vector2(10, 2), 1.4)
	t.tween_property(s, "position", base_pos + Vector2(-10, -2), 1.4)

func _idle_cloud(s: Sprite2D) -> void:
	var base_pos := s.position
	var drift := randf_range(8.0, 18.0) * (-1.0 if randf() < 0.5 else 1.0)
	var bob := randf_range(2.0, 5.0)
	var dur := randf_range(2.5, 4.5)

	var t := create_tween()
	_idle_tweens.append(t)
	t.set_loops()
	t.set_trans(Tween.TRANS_SINE)
	t.set_ease(Tween.EASE_IN_OUT)

	t.tween_property(s, "position", base_pos + Vector2(drift, bob), dur)
	t.tween_property(s, "position", base_pos + Vector2(-drift, -bob), dur)

func _stop_idle_tweens() -> void:
	for t in _idle_tweens:
		if is_instance_valid(t):
			t.kill()
	_idle_tweens.clear()

func _on_Restart_button_pressed() -> void:
	global.gameRnning = true
	get_tree().change_scene_to_file("res://mainScene.tscn")

func _on_mainmenu_button_pressed() -> void:
	global.gameRnning = true
	get_tree().change_scene_to_file("res:// startScreen.tscn")
