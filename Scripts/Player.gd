extends KinematicBody2D

export (int) var speed = 200

onready var _animated_sprite = $AnimatedSprite

var idleAnims = ["Idle_Right", "Idle_Left", "Idle_Up", "Idle_Down"]

var velocity = Vector2()
var facingDirection = Vector2()

func animate_character():
    if velocity.y < 0:
        _animated_sprite.play("Walking_Up") 
    elif velocity.y > 0:
        _animated_sprite.play("Walking_Down") 
    elif velocity.x > 0:
        _animated_sprite.play("Walking_Right")
    elif velocity.x < 0:
        _animated_sprite.play("Walking_Left")

    if velocity == Vector2.ZERO && !idleAnims.has(_animated_sprite.animation):
        match [facingDirection]:
            [Vector2(1,0)]:
                _animated_sprite.play("Idle_Right") 
                print("Right")
            [Vector2(-1,0)]:
                _animated_sprite.play("Idle_Left") 
                print("Left")
            [Vector2(0,1)]:
                _animated_sprite.play("Idle_Up") 
                print("Up")
            [Vector2(0,-1)]:
                _animated_sprite.play("Idle_Down") 
                print("Down")

func get_input():
    velocity = Vector2()
    if Input.is_action_pressed("Right"):
        velocity.x += 1
        facingDirection = Vector2(1, 0)
    if Input.is_action_pressed("Left"):
        velocity.x -= 1
        facingDirection = Vector2(-1, 0)
    if Input.is_action_pressed("Up"):
        velocity.y -= 1
        facingDirection = Vector2(0, 1)
    if Input.is_action_pressed("Down"):
        velocity.y += 1
        facingDirection = Vector2(0, -1)

    velocity = velocity.normalized() * speed

func _physics_process(_delta):
    get_input()
    animate_character()
    velocity = move_and_slide(velocity)
