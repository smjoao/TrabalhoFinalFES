extends KinematicBody2D


export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.
var velocity = Vector2()
var face_direction = Vector2.DOWN

onready var animSprite = $AnimatedSprite

func _ready():
	screen_size = get_viewport_rect().size
	

func get_velocity_from_input():
	var vel = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		face_direction = Vector2.RIGHT
		vel.x += 1
	if Input.is_action_pressed("ui_left"):
		face_direction = Vector2.LEFT
		vel.x -= 1
	if Input.is_action_pressed("ui_down"):
		face_direction = Vector2.DOWN
		vel.y += 1
	if Input.is_action_pressed("ui_up"):
		face_direction = Vector2.UP
		vel.y -= 1

	return vel

func get_direction_string():
	if face_direction == Vector2.RIGHT: return "R"
	if face_direction == Vector2.LEFT: return "L"
	if face_direction == Vector2.UP: return "U"
	return "D"

func _process(_delta):
	velocity = get_velocity_from_input()
	
	
	var dir_str = get_direction_string()
	animSprite.play("Walk" + dir_str)
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		animSprite.play("Idle" + dir_str)

func _physics_process(_delta):
	move_and_slide( velocity, Vector2.UP)
	position.x = (floor(position.x) if velocity.x > 0 else ceil(position.x))
	position.y = (floor(position.y) if velocity.y > 0 else ceil(position.y))
	
	
