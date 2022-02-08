extends KinematicBody2D

export var MAX_SPEED: int = 120
export var ACCELERATION: int = 1000
export var FRICTION: int = 1000

var velocity = Vector2()
var idle_state = true
var is_attacking = false
var facingDirection = Vector2()

enum {
	MOVE,
	DASH,
	ATTACK
		}
var state = MOVE

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationTreeState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

func _physics_process(delta):
	get_input(delta)

func get_input(delta):
	match state:
		MOVE:
			move_state(delta)
		DASH:
			dash_state(delta)
		ATTACK:
			attack_state(delta)

func move_state(delta):
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

	if Input.is_action_just_pressed("Attack_1"):
		state = ATTACK

	velocity = move_and_slide(velocity)

func dash_state(delta):
	pass 

func attack_state(delta):
	animationTreeState.travel("Attack")

func _attack_animation_finished():
	state = MOVE
