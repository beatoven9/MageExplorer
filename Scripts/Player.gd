extends KinematicBody2D

export var MAX_SPEED: int = 120
export var ACCELERATION: int = 1000
export var FRICTION: int = 1000

var velocity = Vector2()
var idle_state = true
var is_attacking = false
var facingDirection = Vector2()

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationTreeState = animationTree.get("parameters/playback")

func get_input(delta):
	var input_vector = Vector2.ZERO 
	input_vector.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	input_vector.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Walk/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTreeState.travel("Walk")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationTreeState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	velocity = move_and_slide(velocity)

func _physics_process(delta):
	get_input(delta)
