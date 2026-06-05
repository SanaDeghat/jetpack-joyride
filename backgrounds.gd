extends Node2D

#bg layer 1
@onready var background_texture: TextureRect = $Parallax2D2/TextureRect
@onready var background_offscreenx_texture: TextureRect = $Parallax2D2/TextureRect/TextureRectx
@onready var background_offscreeny_texture: TextureRect = $Parallax2D2/TextureRect/TextureRecty
@onready var background_offscreenxy_texture: TextureRect = $Parallax2D2/TextureRect/TextureRectxy



@onready var layer_three_background_texture: TextureRect = $Parallax2D/TextureRect
@onready var layer_four_background_texture: TextureRect = $Parallax2D3/TextureRect
@onready var layer_two_background_texture: TextureRect = $TextureRect2
@onready var layer_five_background_texture: TextureRect = $Parallax2D4/TextureRect


#sea textures
@onready var sea_texture: TextureRect = $"../Parallax2D/TextureRect"
@onready var sea_texture_offscreenx: TextureRect = $"../Parallax2D/TextureRectOffscreenx"
@onready var sea_texture_offscreeny: TextureRect = $"../Parallax2D/TextureRectOffscreeny"
@onready var sea_texture_offscreenxy: TextureRect = $"../Parallax2D/TextureRectOffscreenxy"
@onready var wing_particles: CPUParticles2D = $"../CharacterBody2D/CPUParticles2D"



@onready var sea_splash: CPUParticles2D = $"../CharacterBody2D/seaSplash"


@onready var parallax_2d: Parallax2D = $Parallax2D
@onready var parallax_2d_3: Parallax2D = $Parallax2D3
@onready var character_body_2d: CharacterBody2D = $"../CharacterBody2D"
@onready var parallax_2d_4: Parallax2D = $Parallax2D4
var SEA_SPLASH_COLORS = {
	1: Color.html("#556597"),
	2: Color.html("#5386BB"),
	3: Color.html("#97daf9"),
	4: Color.html("#8A9CB4"),
	5: Color.html("#5386BB"),
	6: Color.html("#63848F"),
}
var WING_PARTOICLE_COLORS = {
	1: Color.html("#FF9502"),
	2: Color.html("#FFB700"),
	3: Color.html("#FFCF40"),
	4: Color.html("#FF7D00"),
	5: Color.html("#FFB700"),
	6: Color.html("#FEBF00"),
}

var background= global.background
func _ready() -> void:
	print(background)
	if global.background==0:
		background = randi_range(1,6)
	if sea_splash:
		sea_splash.color = SEA_SPLASH_COLORS.get(background, Color.WHITE)
	if wing_particles:
		wing_particles.color = WING_PARTOICLE_COLORS.get(background, Color.WHITE)
	if background==3:
		
		character_body_2d.color=1
	background_texture.texture= load("res://background/"+str(background)+"/1.png")
	background_offscreenx_texture.texture=background_texture.texture
	background_offscreeny_texture.texture=background_texture.texture
	background_offscreenxy_texture.texture=background_texture.texture
	
	
	layer_two_background_texture.texture= load("res://background/"+str(background)+"/2.png")
	layer_three_background_texture.texture= load("res://background/"+str(background)+"/3.png")
	layer_four_background_texture.texture= load("res://background/"+str(background)+"/4.png")
	if background==6:
		layer_five_background_texture.texture= load("res://background/"+str(background)+"/5.png")
	else:
		layer_five_background_texture.texture=null;
			
	sea_texture.texture= load("res://background/"+str(background)+"/sea.png")
	sea_texture_offscreenx.texture=sea_texture.texture
	sea_texture_offscreeny.texture=sea_texture.texture
	sea_texture_offscreenxy.texture=sea_texture.texture

	
func set_pace(value1: float,value2: float,value3: float):
	parallax_2d.autoscroll.x=value1
	parallax_2d_3.autoscroll.x=value3

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
