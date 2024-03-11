extends CharacterBody2D


const SPEED = 300.0
const JUMP_FORCE = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var _animated_sprite = $Anim

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE

	# Get the input direction and handle the movement/dezzceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		_animated_sprite.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		_animated_sprite.play("idle")
	
	if velocity.x > 0:
		_animated_sprite.flip_h = false
	elif velocity.x < 0:
		_animated_sprite.flip_h = true
	
	move_and_slide()
