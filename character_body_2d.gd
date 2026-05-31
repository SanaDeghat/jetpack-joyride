extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -500.0
const roof_y := 50.0
@onready var sea_splash: CPUParticles2D = $seaSplash

# ---------------------------
# Majestic death arc (left fall)
# ---------------------------
const DEAD_THROW_UP := -320.0          # gentle lift (more negative = higher)
const DEAD_THROW_LEFT := -140.0        # drift left
const DEAD_GRAVITY_MULT := 0.55        # floatier than normal
const DEAD_AIR_DRAG := 3.5             # smooth velocity changes
const DEAD_MAX_FALL_SPEED := 1050.0

const DEAD_POSE_TILT_SPEED := 8.0      # how fast rotation eases to target pose

@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var viecle := false
var color := 0

var _was_running := true
var _dead_time := 0.0

func _physics_process(delta: float) -> void:
	if global_position.y>640.0:
		sea_splash.emitting=true
	if global.gameRnning:
		_was_running = true
		_dead_time = 0.0

		# --- movement / flapping ---
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

		# keep upright while alive

		move_and_slide()

		# roof clamp
		if position.y < roof_y:
			position.y = roof_y
			velocity.y = 0

	else:
		# one-time death start: graceful lift + drift left
		if _was_running:
			_was_running = false
			_dead_time = 0.0
			cpu_particles_2d.emitting = false

			# gentle pop upward + drift left (majestic, not violent)
			velocity.y = min(velocity.y, DEAD_THROW_UP)
			velocity.x = DEAD_THROW_LEFT

		animated_sprite_2d.animation = "falling" + str(color)

		_dead_time += delta

		# gravity + smoothing
		velocity += get_gravity() * DEAD_GRAVITY_MULT * delta
		velocity = velocity.lerp(Vector2(velocity.x, velocity.y), 1.0 - exp(-DEAD_AIR_DRAG * delta))
		velocity.y = min(velocity.y, DEAD_MAX_FALL_SPEED)

		# pose-based rotation to match your falling sprite frames (looks cinematic)
		var f := animated_sprite_2d.frame
		var pose_angles := [
			deg_to_rad(0),     # frame 0
			deg_to_rad(-10),   # frame 1
			deg_to_rad(-25),   # frame 2
			deg_to_rad(-50),   # frame 3
			deg_to_rad(-80),   # frame 4
			deg_to_rad(-115),  # frame 5
			deg_to_rad(-140),  # frame 6
		]
		var target_rot = pose_angles[clamp(f, 0, pose_angles.size() - 1)]

		# tiny flourish at the start (quickly fades out)
		target_rot += deg_to_rad(-12.0) * exp(-6.0 * _dead_time)


		move_and_slide()
