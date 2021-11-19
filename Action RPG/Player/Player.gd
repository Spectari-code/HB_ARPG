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
# get access to animation tree 
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		# set position for idle (set to blend and equal to input_vector)
		animationTree.set("parameters/Idle/blend_position", input_vector)
		# set position for run
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)
