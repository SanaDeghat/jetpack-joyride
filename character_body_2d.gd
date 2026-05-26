extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const roof_y=50;
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if global.gameRnning:
		if Input.is_action_pressed("ui_accept") :
			cpu_particles_2d.emitting=true
			velocity.y = JUMP_VELOCITY
		elif position.y<600:
			cpu_particles_2d.emitting=false
			velocity += get_gravity() * delta
		else: 
			velocity.y=0
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED


		move_and_slide()
		if position.y < roof_y:
			position.y = roof_y
			velocity.y = 0
