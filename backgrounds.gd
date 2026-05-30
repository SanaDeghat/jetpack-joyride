extends Node2D

@onready var texture_rect1: TextureRect = $TextureRect
@onready var texture_rect3: TextureRect = $Parallax2D/TextureRect
@onready var texture_rect4: TextureRect = $Parallax2D3/TextureRect
@onready var texture_rect2: TextureRect = $TextureRect2
@onready var texture_rect5: TextureRect = $Parallax2D4/TextureRect


@onready var parallax_2d: Parallax2D = $Parallax2D
@onready var parallax_2d_3: Parallax2D = $Parallax2D3
@onready var character_body_2d: CharacterBody2D = $"../CharacterBody2D"
var bgNum;
@onready var parallax_2d_4: Parallax2D = $Parallax2D4
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bgNum = 6
	if bgNum==3:
		character_body_2d.color=1
	texture_rect1.texture= load("res://backgrounds/"+str(bgNum)+"/1.png")
	texture_rect2.texture= load("res://backgrounds/"+str(bgNum)+"/2.png")
	texture_rect3.texture= load("res://backgrounds/"+str(bgNum)+"/3.png")
	texture_rect4.texture= load("res://backgrounds/"+str(bgNum)+"/4.png")
	if bgNum==6:
		texture_rect5.texture= load("res://backgrounds/"+str(bgNum)+"/5.png")
	else:
		texture_rect5.texture=null;

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
