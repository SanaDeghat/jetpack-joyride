extends Node2D

@onready var texture_rect1: TextureRect = $TextureRect
@onready var texture_rect3: TextureRect = $Parallax2D/TextureRect
@onready var texture_rect4: TextureRect = $Parallax2D3/TextureRect
@onready var texture_rect2: TextureRect = $TextureRect2
@onready var texture_rect5: TextureRect = $Parallax2D4/TextureRect
@onready var sea_texture: TextureRect = $"../TextureRect"
@onready var sea_splash: CPUParticles2D = $"../CharacterBody2D/seaSplash"


@onready var parallax_2d: Parallax2D = $Parallax2D
@onready var parallax_2d_3: Parallax2D = $Parallax2D3
@onready var character_body_2d: CharacterBody2D = $"../CharacterBody2D"
@export var bgNum: int;
@onready var parallax_2d_4: Parallax2D = $Parallax2D4
var SEA_SPLASH_COLORS = {
	1: Color.html("#556597"),
	2: Color.html("#5386BB"),
	3: Color.html("#97daf9"),
	4: Color.html("#8A9CB4"),
	5: Color.html("#5386BB"),
	6: Color.html("#63848F"),
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if bgNum==0:
		bgNum = randi_range(1,6)
	if sea_splash:
		sea_splash.color = SEA_SPLASH_COLORS.get(bgNum, Color.WHITE)
	if bgNum==3:
		
		character_body_2d.color=1
	texture_rect1.texture= load("res://background/"+str(bgNum)+"/1.png")
	texture_rect2.texture= load("res://background/"+str(bgNum)+"/2.png")
	texture_rect3.texture= load("res://background/"+str(bgNum)+"/3.png")
	texture_rect4.texture= load("res://background/"+str(bgNum)+"/4.png")
	if bgNum==6:
		texture_rect5.texture= load("res://background/"+str(bgNum)+"/5.png")
	else:
		texture_rect5.texture=null;
	sea_texture.texture= load("res://background/"+str(bgNum)+"/sea.png")

func set_pace(value1: float,value2: float,value3: float):
	parallax_2d.autoscroll.x=value1
	parallax_2d_3.autoscroll.x=value3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global.gameRnning:
		parallax_2d.autoscroll.x=(global.speed-100)*-1
		if parallax_2d_4:
			parallax_2d_4.autoscroll.x=global.speed*-1
			parallax_2d_3.autoscroll.x=(global.speed-50)*-1

		else:
			parallax_2d_3.autoscroll.x=global.speed*-1
	else: 
		parallax_2d.autoscroll.x=0
		
		parallax_2d_4.autoscroll.x=0
		parallax_2d_3.autoscroll.x=0
