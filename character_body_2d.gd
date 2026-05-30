extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -500.0
const roof_y := 50.0

# Majestic backward fall tuning (NO SPIN)
const DEAD_GRAVITY_MULT := 0.3        # slightly heavier than normal (try 1.0–1.2)
const DEAD_MAX_FALL_SPEED := 1100.0      # terminal velocity clamp
const DEAD_AIR_DRAG := 2.0               # slows velocity changes a bit (try 0–4)

const DEAD_BACKWARD_TILT := deg_to_rad(-120) # backward fall angle (tweak -90 to -140)
const DEAD_TILT_SPEED := 5.0                 # how quickly it tilts

@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var viecle := false
var color := 0

var _was_running := true

func _physics_process(delta: float) -> void:
	if global.gameRnning:
		_was_running = true

		# --- your existing movement ---
		if Input.is_action_just_pressed("ui_accept") and viecle:
			cpu_particles_2d.emitting = true
			velocity.y = JUMP_VELOCITY
		elif Input.is_action_pressed("ui_accept") and !viecle:
			animated_sprite_2d.animation = "flying" + str(color)
			cpu_particles_2d.emitting = true
			velocity.y = JUMP_VELOCITY
		elif position.y < 600:
			animated_sprite_2d.animation = "descent" + str(color)
			cpu_particles_2d.emitting = false
			velocity += get_gravity() * delta
		else:
			animated_sprite_2d.animation = "flying" + str(color)
			velocity.y = 0

		# optional: keep upright while alive
		rotation = lerp_angle(rotation, 0.0, 10.0 * delta)

		move_and_slide()

		if position.y < roof_y:
			position.y = roof_y
			velocity.y = 0

	else:
		# one-time "impact" feel when you first die (tiny pop + stop thrust)
		if _was_running:
			_was_running = false
			cpu_particles_2d.emitting = false
			# small upward bump so it feels dramatic/majestic (optional)
			velocity.y = min(velocity.y, -220.0)

		animated_sprite_2d.animation = "falling" + str(color)

		# gravity + a little air drag for a floaty majestic drop
		velocity += get_gravity() * DEAD_GRAVITY_MULT * delta
		velocity = velocity.lerp(Vector2(velocity.x, velocity.y), 1.0 - exp(-DEAD_AIR_DRAG * delta))

		velocity.y = min(velocity.y, DEAD_MAX_FALL_SPEED)

		# tilt backward smoothly (NO spin)
		rotation = lerp_angle(rotation, DEAD_BACKWARD_TILT, DEAD_TILT_SPEED * delta)

		move_and_slide()
