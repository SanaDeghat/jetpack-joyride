extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const roof_y=50;

func _physics_process(delta: float) -> void:
	# Add the gravity.

	if Input.is_action_pressed("ui_accept") :
		velocity.y = JUMP_VELOCITY
	elif position.y<600:
		
		velocity += get_gravity() * delta
	else: 
		velocity.y=0
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	print (position.y)

	move_and_slide()
	if position.y < roof_y:
		position.y = roof_y
		velocity.y = 0
