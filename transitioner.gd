extends CanvasLayer

@onready var transitioner: Sprite2D = $Transitioner
@export var bgmusic: AudioStreamPlayer2D
var audio_tween: Tween

var x= 577.0
var hidden_posy= 1056.0
var normaly= 206.0

var _tween: Tween

func _ready() -> void:
	transitioner.position.x = x
	transitioner.position.y = normaly



func fade_out_audio(duration: float = 1.0) -> void:
	if bgmusic == null:
		bgmusic=_get_bgmusic()

	if is_instance_valid(audio_tween):
		print ("yippidydy")
		audio_tween.kill()

	audio_tween = create_tween()
	print ("yippidydydy")
	audio_tween.tween_property(
		bgmusic,
		"volume_db",
		-30.0,
		duration
	)
	print ("yippidydydydy")
func _get_bgmusic() -> AudioStreamPlayer2D:
	return get_tree().current_scene.get_node_or_null("AudioStreamPlayer2D")

func fade_in_audio(duration: float = 1.0) -> void:
	if bgmusic == null:
		bgmusic=_get_bgmusic()


	if is_instance_valid(audio_tween):
		audio_tween.kill()

	audio_tween = create_tween()
	audio_tween.tween_property(
		bgmusic,
		"volume_db",
		00.0,
		duration
	)
func show_transition(duration: float = 0.6) -> void:
	fade_out_audio(duration)
	self.visible=true
	if is_instance_valid(_tween):
		_tween.kill()

	_tween = create_tween()
	_tween.set_trans(Tween.TRANS_QUINT)
	_tween.set_ease(Tween.EASE_OUT)
	_tween.tween_property(transitioner, "position", Vector2( x,   normaly), duration)
	await _tween.finished

func hide_transition(duration: float = 0.6) -> void:
	fade_in_audio(duration)
	if is_instance_valid(_tween):
		_tween.kill()

	_tween = create_tween()
	_tween.set_trans(Tween.TRANS_QUINT)
	_tween.set_ease(Tween.EASE_IN_OUT)
	_tween.tween_property(transitioner, "position", Vector2( x,   hidden_posy), duration)
