extends CanvasLayer

const CENTER = Vector2(560.04, 465.43)
const LEFT = Vector2(370, 465.43)
const RIGHT = Vector2(750.72, 465.43)
@onready var settings: Node2D = $settings
@onready var h_slider: HSlider = $settings/HSlider

var currentSky
var leftSky
var rightSky


func _ready():
	update_skies()


func _process(_delta):
	if Input.is_action_just_pressed("ui_left")&&visible:
		move_right()
	if Input.is_action_just_pressed("ui_right")&&visible:
		move_left()


func update_skies():
	print("bg before" + str(global.background))

	currentSky = get_node("settings/"+str(global.background))
	leftSky = get_node("settings/"+str((global.background - 1 + 7) % 7))
	rightSky = get_node("settings/"+str((global.background + 1) % 7))
	print("bg after" + str(global.background))

	currentSky.position = CENTER
	leftSky.position = LEFT
	rightSky.position = RIGHT


func move_left():
	var t = create_tween()
	t.set_trans(Tween.TRANS_QUINT)
	t.set_ease(Tween.EASE_OUT)

	t.tween_property(currentSky, "position", LEFT, 0.5)
	t.parallel().tween_property(rightSky, "position", CENTER, 0.5)

	await t.finished
	print("why are you here?")

	global.background = (global.background + 1) % 7
	update_skies()


func move_right():
	var t = create_tween()
	t.set_trans(Tween.TRANS_QUINT)
	t.set_ease(Tween.EASE_OUT)

	t.tween_property(currentSky, "position", RIGHT, 0.5)
	t.parallel().tween_property(leftSky, "position", CENTER, 0.5)

	await t.finished
	print("or here")

	global.background = (global.background - 1 + 7) % 7
	update_skies()


func _on_next_pressed() -> void:
	move_left()


func _on_before_pressed() -> void:
	move_right()


func _on_h_slider_drag_ended(value_changed: bool) -> void:
	global.volume= HSlider.value
	
func showself():

	visible=true
	var t = create_tween()
	t.set_trans(Tween.TRANS_QUINT)
	t.set_ease(Tween.EASE_OUT)

	t.tween_property(settings, "position", Vector2(0,-50), 2)

	await t.finished

func hideself():

	var t = create_tween()
	t.set_trans(Tween.TRANS_QUINT)
	t.set_ease(Tween.EASE_OUT)

	t.tween_property(settings, "position", Vector2(0,653), 1.5)

	await t.finished
	visible=false


func _on_back_pressed() -> void:
	hideself()
