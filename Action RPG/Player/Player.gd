extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

var velocity = Vector2.ZERO

# ref to the path of the node AnimationPlayer
#var animationPlayer = null

#func _ready():
	# ref is set equal to the path of the node
#	animationPlayer = $AnimationPlayer

# onready is better way to get te ref and set it equal to the path of the node
# the ready function is therefore not needed anymore
onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		if input_vector.x > 0:
			animationPlayer.play("RunRight")
		else:
			animationPlayer.play("RunLeft")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationPlayer.play("IdleRight")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)
